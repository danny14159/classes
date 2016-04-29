package com.clz.core.module;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.AntiXSS;
import com.clz.core.extend.MD5;
import com.clz.core.extend.Mapper;
import com.clz.core.service.BaseService;
import com.clz.core.service.StuService;

@Controller
@RequestMapping("/stu")
public class StuModule extends BasicModule<TStu> {
	
	@Autowired
	private StuService stuService;

	@Override
	protected BaseService<TStu> getService() {
		return stuService;
	}

	/**普通信息的修改，不包括密码
	 * @param obj
	 * @param br
	 * @return
	 */
	@Override
	public Object update(TStu obj,BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		//obj.signature是富文本，要过滤
		obj.setSignature(AntiXSS.antiXSS(obj.getSignature()));
		obj.setClassId(s.getClassId());
		obj.setNo(s.getNo());
		if((Integer)super.update(obj,null) > 0){
			SystemModule.validateUser(stuService, request);
			return new AjaxReturn(true, null);
		}
		return new AjaxReturn(false,"系统繁忙，请稍后再试。");
	}
	
	/**修改密码
	 * @param origin
	 * @param newOne
	 * @return
	 */
	@RequestMapping("/pwdupd")
	@ResponseBody
	public Object mpdofyPassword(
			@RequestParam("o") String origin,
			@RequestParam("n") String newOne){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		if(newOne.length()<6)
			return new AjaxReturn(false, "密码长度不小于6位。");
		
		String _origin = s.getPassword();
		if(_origin.equals(MD5.encrypt(origin))){
			s.setPassword(MD5.encrypt(newOne));
			int ret = stuService.update(s);
			return AjaxReturn.ok(ret, null, "密码修改失败。");
		}
		return new AjaxReturn(false, "原始密码不正确。");
	}
	
	/**查看同一专业所有班级同学的联系方式。
	 * @return
	 */
	@RequestMapping("/connections")
	@ResponseBody
	public Object connections(){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		return stuService.connections(s.getClassId());
	}

	@Override
	public Object insert(TStu obj, BindingResult br) {
		obj.setPassword(MD5.encrypt("123123"));
		obj.setDeleted('N');
		return super.insert(obj, br);
	}
	
	@RequestMapping("/brief")
	@ResponseBody
	public Object brief(
			@RequestParam String no,
			@RequestParam Integer classId){
		return stuService.brief(Mapper.make("no", no).put("classId", classId).toHashMap());
	}
}
