package com.clz.commons.module;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.commons.bean.TMoneyRecord;
import com.clz.commons.service.MoneyRecordService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.Mapper;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;
import com.clz.core.service.ClassesService;

@Controller
@RequestMapping("/money")
public class MoneyRecordModule extends BasicModule<TMoneyRecord>{
	
	@Autowired
	private MoneyRecordService moneyRecordService;
	@Autowired
	private ClassesService classesService;

	@Override
	protected BaseService<TMoneyRecord> getService() {
		return moneyRecordService;
	}


	@Override
	public Object insert(@Valid TMoneyRecord obj, BindingResult br) {
		if(br.hasErrors()) return new AjaxReturn(false, "参数不正确");
		
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		classesService.update(Mapper.make("id", s.getClassId()).put("balance", obj.getAmount()).toHashMap());
		double balance = classesService.getBalance(s.getClassId());
		
		obj.setPayNo(sdf.format(now)+ s.getClassId());
		obj.setBalance(balance);
		obj.setClassId(s.getClassId());
		obj.setPayTime(now);
		
		
		return super.insert(obj, br);
	}


	@Override
	public Object listByPage(TMoneyRecord obj, Integer ps, Integer pn) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		obj.setClassId(s.getClassId());
		return super.listByPage(obj, ps, pn);
	}
}
