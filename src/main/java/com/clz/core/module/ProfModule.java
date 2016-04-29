package com.clz.core.module;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.core.bean.TProf;
import com.clz.core.service.BaseService;
import com.clz.core.service.ProfService;

@Controller
@RequestMapping("/prof")
public class ProfModule extends BasicModule<TProf>{

	@Autowired
	private ProfService profService;

	@Override
	protected BaseService<TProf> getService() {
		return profService;
	}
}
