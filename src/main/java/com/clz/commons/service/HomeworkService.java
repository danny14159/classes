package com.clz.commons.service;


import java.util.List;

import com.clz.commons.bean.THomework;
import com.clz.core.service.BaseService;

public interface HomeworkService extends BaseService<THomework>{
	
	public List<THomework> test(Object params);
}
