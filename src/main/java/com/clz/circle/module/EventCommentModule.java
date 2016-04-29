package com.clz.circle.module;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.circle.bean.TEvent;
import com.clz.circle.bean.TEventComment;
import com.clz.circle.service.EventCommentService;
import com.clz.circle.service.EventService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.AntiXSS;
import com.clz.core.extend.Mapper;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/evtcmt")
public class EventCommentModule extends BasicModule<TEventComment> {
	@Autowired
	private EventCommentService eventCommentService;
	@Autowired
	private EventService eventService;

	@Override
	protected BaseService<TEventComment> getService() {
		return eventCommentService;
	}
	
	/**评论函数
	 * @param comment
	 * @return
	 */
	@RequestMapping("/comment")
	@ResponseBody
	public Object comment( TEventComment comment){
		
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "403");
		
		//判断事件是否是公开的
		TEvent evt  = eventService.load(Mapper.make("id", comment.getEvtid()).toHashMap());
		if(evt.getAutho()!='G'){
			return new AjaxReturn(false, "无法评论！");
		}
		
		comment.setContent(AntiXSS.antiXSS(comment.getContent()));
		comment.setTime(new Date());
		comment.setStuClz(s.getClassId());
		comment.setStuNo(s.getNo());
		
		return AjaxReturn.ok((Integer)super.insert(comment, null),null,"系统繁忙，请稍后重试！");
	}
	
	/**加载指定事件的所有评论，包括回复
	 * @param evtid
	 * @return
	 */
	@RequestMapping("/loadcmt")
	@ResponseBody
	public Object loadCommentsOfEvent(
			@RequestParam String evtid){
		//判断该事件是否是公开的，或者是本班的
		TEvent evt = eventService.load(Mapper.make("id", evtid).toHashMap());
		if(evt.getAutho()=='P'){
			TStu s = SystemModule.getLoginStu(request);
			if(s.getClassId()!= evt.getPublisherClz()){
				return new AjaxReturn(false, "403");
			}
		}
		
		return eventCommentService.list(Mapper.make("evtid", evtid).toHashMap());
	}
}