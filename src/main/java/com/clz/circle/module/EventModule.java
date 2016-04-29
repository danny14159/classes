package com.clz.circle.module;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.circle.bean.TEvent;
import com.clz.circle.service.EventCommentService;
import com.clz.circle.service.EventPraiseService;
import com.clz.circle.service.EventService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.Mapper;
import com.clz.core.extend.QueryResult;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/evt")
public class EventModule extends BasicModule<TEvent> {
	@Autowired
	private EventService eventService;
	@Autowired
	private EventCommentService eventCommentService;
	@Autowired
	private EventPraiseService eventPraiseService;

	@Override
	protected BaseService<TEvent> getService() {
		return eventService;
	}

	@Override
	public Object listByPage(TEvent obj, Integer ps, Integer pn) {
		if(null == obj.getAutho() || obj.getAutho()!='P'){
			obj.setAutho('G');
		}
		else{
			TStu s = SystemModule.getLoginStu(request);
			if(null == s) return new AjaxReturn(false, null);
			
			obj.setAutho(null);
			obj.setPublisherClz(s.getClassId());
		}
		QueryResult qr = (QueryResult) super.listByPage(obj, ps, pn);
		for(TEvent evt:qr.getList(TEvent.class)){
			Map<String,Object> params = Mapper.make("evtid", evt.getId()).toHashMap();
			evt.setNpraise(eventPraiseService.count(params));
			evt.setNcomment(eventCommentService.count(params));
		}
		return qr;
	}

	@Override
	public Object insert(TEvent obj, BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		
		obj.setPublisherClz(s.getClassId());
		obj.setPublisherNo(s.getNo());
		obj.setAct_time(new Date());
		return super.insert(obj, br);
	}
}