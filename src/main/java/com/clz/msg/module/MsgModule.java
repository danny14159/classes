package com.clz.msg.module;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.Mapper;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;
import com.clz.core.service.StuService;
import com.clz.msg.bean.TMessage;
import com.clz.msg.service.MessageService;

@Controller
@RequestMapping("/msg")
public class MsgModule extends BasicModule<TMessage>{
	@Autowired
	private MessageService messageService;
	@Autowired
	private StuService stuService;
	@Override
	protected BaseService<TMessage> getService() {
		return messageService;
	}
	
	/**发送消息
	 * @param toNo
	 * @return
	 */
	@RequestMapping("/sndmsg")
	@ResponseBody
	public Object sendMsg(
			@RequestParam String toNo,
			@RequestParam Integer toClz,
			@RequestParam String content){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		if(s.getNo().equals(toNo) && s.getClassId()==toClz){
			return new AjaxReturn(false, "您不能发消息给自己。");
		}
		
		TMessage msg=new TMessage();
		msg.setToNo(toNo);
		msg.setToClz(toClz);
		msg.setDeleted('N');
		msg.setSendTime(new Date());
		msg.setContent(content);
		msg.setState('U');
		msg.setType('C');
		msg.setFromClz(s.getClassId());
		msg.setFromNo(s.getNo());
		
		return AjaxReturn.ok(messageService.insert(msg), null, "发送失败");
	}
	/**阅读消息
	 * @param id
	 * @return 消息
	 */
	@RequestMapping("/read")
	@ResponseBody
	public Object read(@RequestParam Integer id){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		
		//判断消息是不是发给自己的
		TMessage msg = messageService.load(Mapper.make("id", id).toHashMap());
		
		//如果是自己发的，可以查看，但不修改状态
		if(msg.getFromClz() == s.getClassId() && msg.getFromNo().equals(s.getNo())){
			return msg;
		}
		if(null == msg || msg.getToClz()!= s.getClassId() || !msg.getToNo().equals(s.getNo())){
			return new AjaxReturn(false, "no access");
		}
		int f = messageService.update(Mapper.make("id", id).put("state",'R').toHashMap());
		if(f>0) return msg;
		else 
		return new AjaxReturn(false  ,"状态修改失败");
	}
	
	/**查看自己发送的消息，分页
	 * @return
	 */
	@RequestMapping("/lists")
	@ResponseBody
	public Object listSent(
			@RequestParam Integer ps,
			@RequestParam Integer pn,
			Character state
			){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		
		Map<String,Object> psp=Mapper
				.make("offset", ps*(pn-1))
				.put("rows", ps)
				.put("state", state)
				.put("deleted", "('N','T')")
				.put("fromNo", s.getNo())
				.put("fromClz", s.getClassId())
				.toHashMap();
		List<TMessage> msgs = messageService.listByPage(psp);
		
		List<Map<String,Object>> ress = new ArrayList<Map<String,Object>>();
		for(TMessage tm:msgs){
			Map<String,Object> msgex = new HashMap<String, Object>();
			msgex.put("msg", tm);
			msgex.put("stu", stuService.brief(Mapper.make("no", tm.getToNo()).put("classId", tm.getToClz()).toHashMap()));
			ress.add(msgex);
		}
		return ress;
	}
	
	/**查看收到的消息，分页
	 * @param state
	 * @return
	 */
	@RequestMapping("/listr")
	@ResponseBody
	public Object listReceived(
			@RequestParam Integer ps,
			@RequestParam Integer pn,
			Character state){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		
		Map<String,Object> psp=Mapper
				.make("offset", ps*(pn-1))
				.put("rows", ps)
				.put("state", state)
				.put("deleted", "('N','F')")
				.put("toNo", s.getNo())
				.put("toClz", s.getClassId())
				.toHashMap();
		
		List<TMessage> msgs = messageService.listByPage(psp);
		
		List<Map<String,Object>> ress = new ArrayList<Map<String,Object>>();
		for(TMessage tm:msgs){
			Map<String,Object> msgex = new HashMap<String, Object>();
			msgex.put("msg", tm);
			msgex.put("stu", stuService.brief(Mapper.make("no", tm.getFromNo()).put("classId", tm.getFromClz()).toHashMap()));
			ress.add(msgex);
		}
		return ress;
	}
	
	/**发送人将消息记录删除，收件人依然可以看到消息
	 * @param id
	 * @return
	 */
	@RequestMapping("/dels")
	@ResponseBody
	public Object deletedSent(@RequestParam Integer id){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		//判断消息是不是自己发的
		TMessage msg = messageService.load(Mapper.make("id", id).toHashMap());
		if (null == msg || msg.getFromClz() != s.getClassId()
				|| !msg.getFromNo().equals(s.getNo())) {
			return new AjaxReturn(false, "no access");
		}
		char mc = msg.getDeleted()=='T'?'D':'F';
		return AjaxReturn.ok(messageService.update(Mapper.make("id", id).put("deleted",mc).toHashMap()) ,null ,"状态修改失败");
	}
	
	/**收件人将消息删除
	 * @param id
	 * @return
	 */
	@RequestMapping("/delr")
	@ResponseBody
	public Object deletedReceived(@RequestParam Integer id){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s){
			return new AjaxReturn(false, "please login");
		}
		//判断消息是不是发给自己的
		TMessage msg = messageService.load(Mapper.make("id", id).toHashMap());
		if (null == msg || msg.getToClz() != s.getClassId()
				|| !msg.getToNo().equals(s.getNo())) {
			return new AjaxReturn(false, "no access");
		}
		char mc = msg.getDeleted()=='F'?'D':'T';
		return AjaxReturn.ok(messageService.update(Mapper.make("id", id).put("deleted",mc).toHashMap()) ,null ,"状态修改失败");
	}
}

