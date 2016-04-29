package com.clz.commons.module;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.commons.bean.THomework;
import com.clz.commons.service.HomeworkService;
import com.clz.commons.service.MoneyRecordService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/homework")
public class HomeworkModule extends BasicModule<THomework>{
	
	@Autowired
	private HomeworkService homeworkService;
	@Autowired
	private MoneyRecordService moneyRecordService;
	

	@Override
	protected BaseService<THomework> getService() {
		return homeworkService;
	}


	@Override
	public Object listByPage(THomework obj, Integer ps, Integer pn) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false,"请登录。");
		obj.setClassId(s.getClassId());
		obj.setDeleted('N');
		return super.listByPage(obj, ps, pn);
	}


	@Override
	public Object insert(@Valid THomework obj,BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false,"请登录。");
		
		//TODO 权限
		obj.setClassId(s.getClassId());
		obj.setVisit(0);
		obj.setDeleted('N');
		return AjaxReturn.ok((Integer)super.insert(obj,br), null, "");
	}
	
}
