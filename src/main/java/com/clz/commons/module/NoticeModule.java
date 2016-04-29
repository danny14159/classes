package com.clz.commons.module;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.commons.bean.TNotice;
import com.clz.commons.service.NoticeService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.Mapper;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/notice")
public class NoticeModule extends BasicModule<TNotice>{
	
	@Autowired
	private NoticeService noticeService;
	
	@Override
	protected BaseService<TNotice> getService() {
		return noticeService;
	}

	@Override
	public Object insert(TNotice obj, BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		
		obj.setTime(new Date());
		obj.setClassId(s.getClassId());
		return super.insert(obj, br);
	}

	@Override
	public Object delete(@PathVariable Integer id) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		return noticeService.deletex(Mapper.make("id", id).put("classId", s.getClassId()).toHashMap());
	}

}
