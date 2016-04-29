package com.clz.core.service;

import java.util.List;

import com.clz.core.bean.StuBrief;
import com.clz.core.bean.StuConnections;
import com.clz.core.bean.TStu;

public interface StuService extends BaseService<TStu>{

	public List<StuConnections> connections(int id);
	public StuBrief brief(Object params);
}