package com.clz.core.extend;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.clz.core.bean.Authority;
import com.google.gson.Gson;

/**
 * 判断用户是否有权限
 * 
 * @author Administrator
 *
 */
public class AuthorityUtils {

	private static Authority autho = null;
	static {
		// 读取json配置文件
		Resource rs = new ClassPathResource("com/clz/conf/reqfilter.json");
		try {
			String confstr = readTextFile(rs.getFile());
			Gson gson = new Gson();
			autho = gson.fromJson(confstr, Authority.class);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		// File f = new File();
	}

	public static boolean hasAuthority(char type,String reqURI) {
		if(type =='S') return true;
		if(null == autho) return false;
		try{
			if('C'==type){
				String[] C=autho.getC();
				for(String eachC:C){
					if(reqURI.matches(eachC)){
						return true;
					}
				}
				return false;
			}
			else if('M'==type){
				String[] C=autho.getC();
				String[] M=autho.getM();
				for(String eachC:C){
					if(reqURI.matches(eachC)){
						return true;
					}
				}
				for(String eachM:M){
					if(reqURI.matches(eachM)){
						return true;
					}
				}
				return false;
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return false;
	}

	public static String readTextFile(File file) {
		String content = "";
		try {
			String encoding = "UTF-8";
			if (file.isFile() && file.exists()) { // 判断文件是否存在
				InputStreamReader read = new InputStreamReader(
						new FileInputStream(file), encoding);// 考虑到编码格式
				BufferedReader bufferedReader = new BufferedReader(read);
				String lineTxt = null;
				while ((lineTxt = bufferedReader.readLine()) != null) {
					content += lineTxt;
				}
				read.close();
			} else {
				System.out.println("找不到指定的文件");
			}
		} catch (Exception e) {
			System.out.println("读取文件内容出错");
			e.printStackTrace();
		}
		return content;
	}
}
