package com.clz.core.module;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.core.bean.TUniv;
import com.clz.core.service.BaseService;
import com.clz.core.service.UnivService;

@Controller
@RequestMapping("/univ")
public class UnivModule extends BasicModule<TUniv> {
	
	@Autowired
	private UnivService univService;

	@Override
	protected BaseService<TUniv> getService() {
		return univService;
	}

}
