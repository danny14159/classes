package com.clz.core.extend;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.omg.CORBA.portable.ApplicationException;

public class HttpClientHelper {
	/**
	 * cookie存储
	 */
	private  Map<String,ArrayList<String>> cookieStore = new HashMap<String, ArrayList<String>>();
	
	
	 CloseableHttpClient httpclient = HttpClients.createDefault();

	/**从 response中提取cookie，存入cookieStore
	 * @param response
	 */
	private  void getCookieFromResponse(String no,CloseableHttpResponse response) {
		Header h = response.getFirstHeader("Set-Cookie");
		if (h != null) {
			String cookie = h.getValue();
			if (cookie != null){
				ArrayList<String> cookies = new ArrayList<String>();// cookie
				cookies.add(cookie.substring(0, cookie.indexOf(";")));
				cookieStore.put(no, cookies);
			}
		}
	}

	private  String cookie2String(String no) {
		ArrayList<String> cookies = cookieStore.get(no);
		String _s_cookie = "";
		if(cookies!=null)
			for (String s : cookies) {
				_s_cookie += s + ";";
			}
		System.out.println(_s_cookie);
		return _s_cookie;
	}

	/**
	 * login
	 * 
	 * @param url
	 * @throws ApplicationException
	 */
	public  String login(String url, List<NameValuePair> nvps, String host,
			String referer,String no) throws ApplicationException {

		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Connection", "keep-alive");
		httpPost.setHeader("Accept",
				"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
		httpPost.setHeader(
				"User-Agent",
				"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36");
		httpPost.setHeader("Host", host);
		httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded");
		httpPost.setHeader("Accept-Encoding", "gzip,deflate");
		httpPost.setHeader("Accept-Language", "zh-CN,zh;q=0.8");
		httpPost.setHeader("Referer", referer);

		CloseableHttpResponse response = null;
		try {
			httpPost.setEntity(new UrlEncodedFormEntity(nvps));

			response = httpclient.execute(httpPost);

			// print response
			try {
				HttpEntity entity = response.getEntity();
				getCookieFromResponse(no, response);
				if (entity != null) {
					//System.out.println("--------------------------------------");
					//System.out.println("Response content: "+ EntityUtils.toString(entity, "UTF-8"));
					//System.out.println("--------------------------------------");
				}
				return  EntityUtils.toString(entity, "UTF-8");
			} catch (Exception e) {
				e.printStackTrace();
			}

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (response != null)
					response.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		return "";
	}

	/**
	 * @param no
	 * @param password
	 * @return 返回成绩表格的tbody字符串
	 * @throws Exception
	 */
	public synchronized  String getGrade(String no, String password) throws Exception {

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		List<NameValuePair> nvpsGrade = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("encoding", "UTF-8"));
		nvps.add(new BasicNameValuePair(
				"__VIEWSTATE",
				"dDw4MTI3MTI0O3Q8O2w8aTwxPjs+O2w8dDw7bDxpPDc+Oz47bDx0PHA8O3A8bDxvbmNsaWNrOz47bDx3aW5kb3cuY2xvc2UoKVw7Oz4+Pjs7Pjs+Pjs+Pjs+q61CNSVKQnWAQm04Yk9t0hOxUrs="));
		nvps.add(new BasicNameValuePair("tbYHM", no));
		nvps.add(new BasicNameValuePair("tbPSW", password));
		nvps.add(new BasicNameValuePair("Button1", "+%B5%C7+%C2%BC+"));

		login("http://xk1.ujs.edu.cn/default_ldap.aspx", nvps,
				"xk1.ujs.edu.cn", "",no);
		String content = get(
				"http://xk1.ujs.edu.cn/xscjcx.aspx?xh="+no+"&xm=%B5%CB%C0%D7&gnmkdm=N121615",
				"http://xk1.ujs.edu.cn/xs_main_zzjk.aspx?xh="+no,no);
		Document doc = Jsoup.parse(content);
		//System.out.println(content);
		String __VIEWSTATE = doc.getElementById("Form1").child(2).attr("value");

		//System.out.println(__VIEWSTATE);

		nvpsGrade.add(new BasicNameValuePair("__EVENTTARGET", ""));
		nvpsGrade.add(new BasicNameValuePair("__EVENTARGUMENT", ""));
		nvpsGrade.add(new BasicNameValuePair("__VIEWSTATE", __VIEWSTATE));
		nvpsGrade.add(new BasicNameValuePair("ddlXN", "2014-2015"));
		nvpsGrade.add(new BasicNameValuePair("ddlXQ", "1"));
		nvpsGrade.add(new BasicNameValuePair("btn_xq",
				"%D1%A7%C6%DA%B3%C9%BC%A8"));
		nvpsGrade.add(new BasicNameValuePair("hidLanguage", ""));
		nvpsGrade.add(new BasicNameValuePair("ddl_kcxz", ""));

		String gradeHTML = login("http://xk1.ujs.edu.cn/xscjcx.aspx?xh="+no+"&xm=%B5%CB%C0%D7&gnmkdm=N121615",
				nvpsGrade,
				"xk1.ujs.edu.cn",
				"http://xk1.ujs.edu.cn/xscjcx.aspx?xh="+no+"&xm=%B5%CB%C0%D7&gnmkdm=N121615",no);
		
		Document docGrade = Jsoup.parse(gradeHTML);
		String ret = docGrade.getElementById("Datagrid1").html();
		return ret;
	}

	/**获取一卡通信息*/
	public String getSchoolCardInfo(String no,String password) throws Exception{
		
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("encoding", "UTF-8"));

		nvps.add(new BasicNameValuePair("Login.Token1", no));
		nvps.add(new BasicNameValuePair("Login.Token2", password));
		nvps.add(new BasicNameValuePair("goto", "http://my.ujs.edu.cn/loginSuccess.portal"));
		nvps.add(new BasicNameValuePair("gotoOnFail", "http://my.ujs.edu.cn/loginFailure.portal"));
		
		login("http://my.ujs.edu.cn/userPasswordValidate.portal",nvps,"my.ujs.edu.cn",null,null);
		
		return get("http://my.ujs.edu.cn/pnull.portal?.f=f1346&.pmn=view&action=informationCenterAjax&.ia=false&.pen=pe570","http://my.ujs.edu.cn/index.portal","");
	}
	
	public String getBookBorrowing(String no,String password) throws Exception{
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("encoding", "UTF-8"));
		nvps.add(new BasicNameValuePair("number", no));
		nvps.add(new BasicNameValuePair("passwd", password));
		nvps.add(new BasicNameValuePair("select", "cert_no"));
		nvps.add(new BasicNameValuePair("returnUrl", ""));
		login("http://huiwen.ujs.edu.cn:8080/reader/redr_verify.php",nvps,"huiwen.ujs.edu.cn:8080","http://huiwen.ujs.edu.cn:8080/reader/login.php",no);
		String cont = get("http://huiwen.ujs.edu.cn:8080/reader/book_lst.php","",no);
		String utfstr = new String(cont.getBytes("ISO-8859-1"),"UTF-8");
		Document doc = Jsoup.parse(utfstr);
		
		return doc.getElementsByTag("table").html();
	}
	
	public String getTimeTable(String no,String password) throws Exception{
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("encoding", "UTF-8"));
		nvps.add(new BasicNameValuePair(
				"__VIEWSTATE",
				"dDw4MTI3MTI0O3Q8O2w8aTwxPjs+O2w8dDw7bDxpPDc+Oz47bDx0PHA8O3A8bDxvbmNsaWNrOz47bDx3aW5kb3cuY2xvc2UoKVw7Oz4+Pjs7Pjs+Pjs+Pjs+q61CNSVKQnWAQm04Yk9t0hOxUrs="));
		nvps.add(new BasicNameValuePair("tbYHM", no));
		nvps.add(new BasicNameValuePair("tbPSW", password));
		nvps.add(new BasicNameValuePair("Button1", "+%B5%C7+%C2%BC+"));

		login("http://xk1.ujs.edu.cn/default_ldap.aspx", nvps,
				"xk1.ujs.edu.cn", "",no);
		
		String kebiao = get("http://xk1.ujs.edu.cn/xskbcx.aspx?xh="+no+"&gnmkdm=N121602", "http://xk1.ujs.edu.cn/xs_main_zzjk1.aspx?xh="+no+"&type=1", no);
		System.out.println(kebiao);
		Document doc = Jsoup.parse(kebiao);
		String timetable = doc.getElementById("Table1").html();
		return timetable;
	}
	public static void main(String[] args) throws Exception {
		System.out.println(new HttpClientHelper().getTimeTable("3120608021", "931112"));
	}
	/**
	 * 发送 get请求
	 */
	public  String get(String url, String referer,String no) {
		//CloseableHttpClient httpclient = HttpClients.createDefault();
		String body = "No data response from:" + url + "!";
		try {
			// 创建httpget.
			HttpGet httpget = new HttpGet(url);
			httpget.setHeader("Cookie", cookie2String(no));
			httpget.setHeader("Connection", "keep-alive");
			httpget.setHeader("Accept",
					"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
			httpget.setHeader(
					"User-Agent",
					"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36");
			httpget.setHeader("Content-Type",
					"application/x-www-form-urlencoded");
			httpget.setHeader("Accept-Encoding", "gzip,deflate,sdch");
			httpget.setHeader("Accept-Language", "zh-CN,zh;q=0.8");
			httpget.setHeader("Referer", referer);

			//System.out.println("executing request " + httpget.getURI());
			// 执行get请求.
			CloseableHttpResponse response = httpclient.execute(httpget);
			try {
				// 获取响应实体
				HttpEntity entity = response.getEntity();
				//System.out.println("--------------------------------------");
				// 打印响应状态
				//System.out.println(response.getStatusLine());
				if (entity != null) {
					// 打印响应内容长度
					//System.out.println("Response content length: "+ entity.getContentLength());
					// 打印响应内容
					body = EntityUtils.toString(entity);
					//System.out.println("Response content: " + body);
				}
				//System.out.println("------------------------------------");
				getCookieFromResponse(no, response);
			} finally {
				response.close();
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// 关闭连接,释放资源
			/*try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}*/
		}
		return body;
	}
}
