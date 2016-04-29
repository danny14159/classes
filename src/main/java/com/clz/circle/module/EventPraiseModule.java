package com.clz.circle.module;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.circle.bean.TEventPraise;
import com.clz.circle.service.EventPraiseService;
import com.clz.core.bean.TStu;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/evtp")
public class EventPraiseModule extends BasicModule<TEventPraise> {
	@Autowired
	private EventPraiseService eventPraiseService;

	@Override
	protected BaseService<TEventPraise> getService() {
		return eventPraiseService;
	}

	@Override
	public Object insert(TEventPraise obj, BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		obj.setStuClz(s.getClassId());
		obj.setStuNo(s.getNo());
		return super.insert(obj, br);
	}
}
