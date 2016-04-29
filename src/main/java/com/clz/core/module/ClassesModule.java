package com.clz.core.module;

import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.TClasses;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.AntiXSS;
import com.clz.core.extend.Mapper;
import com.clz.core.service.BaseService;
import com.clz.core.service.ClassesService;

@Controller
@RequestMapping("/classes")
public class ClassesModule extends BasicModule<TClasses> {
	
	@Autowired
	private ClassesService classesService;
	@Override
	protected BaseService<TClasses> getService() {
		return classesService;
	}

	/**班级设置接口，只支持POST请求方式
	 * @return
	 */
	@RequestMapping(value="/settings")
	@ResponseBody
	public Object settings(String logo,String intro,Float balance,String weibo){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		if(logo==null && intro==null && balance==null)
			return new AjaxReturn(false,"设置失败。");
		
		//设置修改，intro中是富文本，在这里进行XSS过滤
		if(Strings.isNotEmpty(intro))
			intro = AntiXSS.antiXSS(intro);
		
		int ret = classesService.update(Mapper
				.make("balance", balance)
				.put("intro", intro)
				.put("id", s.getClassId())
				.put("logo", logo)
				.put("weibo", weibo)
				.toHashMap());
		return AjaxReturn.ok(ret, null, "设置失败。");
	}
}
