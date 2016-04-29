package com.clz.core.module;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.HttpClientHelper;
import com.clz.core.extend.Strings;

@Controller
@RequestMapping("/iq")
public class InfoQueryModule {

	@Autowired
	private HttpServletRequest request;
	
	/**在校成绩查询
	 * @return
	 */
	@RequestMapping("/qg")
	@ResponseBody
	public Object queryGrade(){
		TStu u = SystemModule.getLoginStu(request);
		if(null == u) return new AjaxReturn(false, "请先登录");
		String pwportral = u.getPwPortral();
		if(Strings.isBlank(pwportral)){
			return new AjaxReturn(false, "请到 个人中心 -> 个人资料 -> 基础资料 中绑定信息门户的密码：）");
		}
		try {
			HttpClientHelper helper = new HttpClientHelper();
			String msg = helper.getGrade(u.getNo(), pwportral);
			return new AjaxReturn(true, msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxReturn(false, "系统繁忙，请稍后再试！");
		}
	}
	/**查询一卡通
	 * @return
	 */
	@RequestMapping("/qsci")
	@ResponseBody
	public Object getSchoolCardInfo(){
		TStu u = SystemModule.getLoginStu(request);
		if(null == u) return new AjaxReturn(false, "请先登录");
		String pwportral = u.getPwPortral();
		if(Strings.isBlank(pwportral)){
			return new AjaxReturn(false, "请在个人中心绑定信息门户的密码：）");
		}
		try {
			HttpClientHelper helper = new HttpClientHelper();
			String msg = helper.getSchoolCardInfo(u.getNo(), pwportral);
			return new AjaxReturn(true, msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxReturn(false, "系统繁忙，请稍后再试！");
		}
	}
	/**查询借书情况
	 * @return
	 */
	@RequestMapping("/qbb")
	@ResponseBody
	public Object getBookBorrowing(){
		TStu u = SystemModule.getLoginStu(request);
		if(null == u) return new AjaxReturn(false, "请先登录");
		try {
			HttpClientHelper helper = new HttpClientHelper();
			String msg = helper.getBookBorrowing(u.getNo(),u.getNo());
			return new AjaxReturn(true, msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxReturn(false, "系统繁忙，请稍后再试！");
		}
	}
	/**课表查询
	 * @return
	 */
	@RequestMapping("/qtt")
	@ResponseBody
	public Object getTimeTable(){
		TStu u = SystemModule.getLoginStu(request);
		if(null == u) return new AjaxReturn(false, "请先登录");
		String pwportral = u.getPwPortral();
		if(Strings.isBlank(pwportral)){
			return new AjaxReturn(false, "请在个人中心绑定信息门户的密码：）");
		}
		try {
			HttpClientHelper helper = new HttpClientHelper();
			String msg = helper.getTimeTable(u.getNo(),pwportral);
			return new AjaxReturn(true, msg);
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxReturn(false, "系统繁忙，请稍后再试！");
		}
	}

}
