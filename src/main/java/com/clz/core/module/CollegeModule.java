package com.clz.core.module;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.core.bean.TCollege;
import com.clz.core.service.BaseService;
import com.clz.core.service.CollegeService;

@Controller
@RequestMapping("/college")
public class CollegeModule extends BasicModule<TCollege>{

	@Autowired
	private CollegeService collegeService;

	@Override
	protected BaseService<TCollege> getService() {
		return collegeService;
	}
}
