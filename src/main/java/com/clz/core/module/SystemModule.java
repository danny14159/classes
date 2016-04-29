package com.clz.core.module;

import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.clz.circle.bean.TEvent;
import com.clz.circle.service.EventCommentService;
import com.clz.circle.service.EventPraiseService;
import com.clz.circle.service.EventService;
import com.clz.commons.service.HomeworkService;
import com.clz.commons.service.MoneyRecordService;
import com.clz.commons.service.NoticeService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.MD5;
import com.clz.core.extend.Mapper;
import com.clz.core.service.ClassesService;
import com.clz.core.service.StuPicsService;
import com.clz.core.service.StuService;
import com.clz.msg.bean.TMessage;
import com.clz.msg.service.MessageService;
import com.clz.party.bean.TPartyInteract;
import com.clz.party.module.PartyModule;
import com.clz.party.service.PartyInteractService;
import com.clz.party.service.PartyService;

/**页面跳转总控制器
 * @author denglei
 *
 */
@Controller
public class SystemModule {
	@Autowired
	private StuService stuService;
	@Autowired  
	private HttpServletRequest request;
	@Autowired
	private MessageService messageService;
	@Autowired
	private HomeworkService homeworkService;
	@Autowired
	private ClassesService classesService;
	@Autowired
	private PartyService partyService;
	@Autowired
	private StuPicsService stuPicsService;
	@Autowired
	private PartyInteractService partyInteractService;
	@Autowired
	private PartyModule partyModule;
	@Autowired
	private MoneyRecordService moneyRecordService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private EventService eventService;
	@Autowired
	private EventCommentService eventCommentService;
	@Autowired
	private EventPraiseService eventPraiseService;
	
	private static final String SF="/f";
	private static final String SB="/b";
	private static final String ME_SES="me.ses";
	
	//----------工具函数
	public static TStu getLoginStu(HttpServletRequest request){
		return (TStu)WebUtils.getSessionAttribute(request, ME_SES);
	}
	/**重新读取数据库中的STU并返回
	 * @param request
	 * @return
	 */
	public static TStu validateUser(StuService stuService,HttpServletRequest request){
		TStu u = getLoginStu(request);
		if(null == u) return null;
		TStu newUser = stuService.load(Mapper.make("no", u.getNo())
				.put("classId", u.getClassId())
				.toHashMap());
		WebUtils.setSessionAttribute(request, ME_SES, newUser);
		return newUser;
	}

	//-----------后台页面跳转
	@RequestMapping(SB+"/ptl")
	public String portral(){
		return "backstage/portral.jsp";
	}
	
	//-----------后台接口
	
	//-----------前台页面
	@RequestMapping("/")
	public String welcomePage(){
		return "redirect:/index-p";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(String err,String _r,Model model){
		model.addAttribute("err", err);
		model.addAttribute("_r", _r);
		return "login.jsp";
	}
	@RequestMapping(value="/exhibition",method=RequestMethod.GET)
	public String exhibition(String err,Model model){
		model.addAttribute("err", err);
		return "exhibition.jsp";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/login";
	}
	
	/**include页面，如页头和页尾
	 * @return
	 */
	@RequestMapping("/include_{page}")
	public String include(@PathVariable("page") String page){
		return "frontend/include/"+page+".jsp";
	}
	/**首页
	 * @return
	 */
	@RequestMapping("/index-p")
	public String index(Model model){
		//check login 
		TStu s = getLoginStu(request);
		if(null == s) return "redirect:/login";
		injectHeader(s,model);
		
		//inject homework
		Map<String,Object> ph = Mapper
				.make("classId", s.getClassId())
				.put("expire", new Date())
				.put("deleted", 'N')
				.toHashMap();
		model.addAttribute("cuhomew", homeworkService.count(ph));
		
		return "index.jsp";
	}
	/**登录页面跳转，成功跳到首页。失败调回登录页面
	 * @param no
	 * @param pwd
	 * @param classId
	 * @return [err]1:用户名不存在 2:密码错误
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(
			@RequestParam("no") String no,
			@RequestParam("pwd") String pwd,
			@RequestParam("classId") Integer classId,
			String _r,
			Model model){
		TStu s = stuService.load(Mapper.make("no", no)
				/*.put("classId", classId)*/
				.toHashMap());
		if(null == s){
			return "redirect:/login?err=1";
		}
		if(!s.getPassword().equals(MD5.encrypt(pwd))) {
			return "redirect:/login?err=2";
		}
		
		//将登录信息保存至session
		WebUtils.setSessionAttribute(request, ME_SES, s);
		
		if(Strings.isNotBlank(_r)){
			return "redirect:"+_r;
		}
		return "redirect:/index-p";
	}
	
	/**发生异常之后的前台显示
	 * @param e
	 * @return
	 */
/*	@ExceptionHandler
	public String ExceptionHandler(Exception e){
		e.printStackTrace();
		return "errorpage/500.jsp";
	}*/
	
	/**个人中心
	 * @return
	 */
	@RequestMapping("/icenter_{column}")
	public String individual_center(@PathVariable("column") String col,Model model,String no,Integer classId){
		TStu s = getLoginStu(request);
		if(null == s) return "redirect:/login?_r=/icenter_"+col;
		injectHeader(s,model);
		
		if("newmsg".equals(col)){
			model.addAttribute("no", no);
			model.addAttribute("classId",classId);
			model.addAttribute("className", classesService.load(Mapper.make("id", classId).toHashMap()).getName());
		}
		return "frontend/individual_center/"+col+".jsp";
	}
	
	
	//-----------前台接口
	/**ajax方式 验证 登录
	 * @param no
	 * @param pwd
	 * @param classId
	 * @return
	 */
	@RequestMapping(value="/loginajax",method=RequestMethod.POST) 
	@ResponseBody
	public Object loginAjax(@RequestParam("no") String no,
			@RequestParam("pwd") String pwd,
			@RequestParam("classId") Integer classId){
		TStu s = stuService.load(Mapper.make("no", no)
				.put("classId", classId).toHashMap());
		if(null == s) return new AjaxReturn(false,"用户名不存在，请检查。");
		if(!s.getPassword().equals(pwd)) return new AjaxReturn(false, "密码有误，请检查。");
		
		return new AjaxReturn(true,null);
	}
	
	//TODO login和loginAjax两个接口在失败3此之后要输入验证码
	
	
	/**派对页面
	 * @return
	 */
	@RequestMapping("/iparty/{column}")
	public String party(@PathVariable("column") String col,Model model){
		TStu s = getLoginStu(request);
		
		if(null == s) return "redirect:/login?_r=/iparty/"+col;
		injectHeader(s,model);
		model.addAttribute("isInParty",partyService.count(Mapper.make("exit", 'N').put("stuNo", s.getNo())
				.put("stuClz", s.getClassId()).toHashMap()) != 0);
		
		if(col.startsWith("show")){
			//将TA的信息注入到页面
			try{
			String[] noclz = col.substring(4).split("-");
			Map<String,Object> paramstu = Mapper.make("no", noclz[0]).put("classId", noclz[1]).toHashMap();
			TStu ta = stuService.load(paramstu);
			if(null==ta) return "errorpage/500.jsp";
			
			model.addAttribute("ta", ta);
			//model.addAttribute("taclz", stuService.brief(paramstu));
			partyService.visit(Mapper.make("stuClz", noclz[1]).put("stuNo", noclz[0]).toHashMap());
			
			model.addAttribute("tap", partyModule.calInter(s, partyService.show(paramstu)).get(0));
			paramstu.put("exit", 'N');
			model.addAttribute("taexp", partyService.load(paramstu)); //expect
			model.addAttribute("tapho", stuPicsService.list(paramstu)); //photos
			
			//如果对方对你心动，你可以查看TA的联系方式
			TPartyInteract tpi = new TPartyInteract();
			tpi.setFromClz(Integer.parseInt(noclz[1]));
			tpi.setFromNo(noclz[0]);
			tpi.setToClz(s.getClassId());
			tpi.setToNo(s.getNo());
			tpi.setLove('Y');
			if(partyInteractService.count(tpi)==0){
				ta.setConnection("NA");
			}
			col = "show";
			}
			catch(Exception e){
				return "/errorpage/500.jsp";
			}
		}
		else if("myhistory".equals(col)){
			model.addAttribute("history", partyService.history(
					Mapper.make("stuNo", s.getNo())
					.put("stuClz", s.getClassId())
					.toHashMap()
					));
		}
		else if("my".equals(col)){
			Map<String,Object> paramstu = Mapper.make("no", s.getNo()).put("classId",s.getClassId()).toHashMap();
			paramstu.put("exit", 'N');
			model.addAttribute("myexp", partyService.load(paramstu));// my expect
			model.addAttribute("myparty", partyService.show(paramstu).get(0));
			model.addAttribute("mypho", stuPicsService.list(paramstu)); //photos
		}
		return "frontend/party/"+col+".jsp";
	}
	
	@RequestMapping("/publics/{column}")
	public String publicInfo(
			@PathVariable("column") String col,
			String param,
			Model model,
			 Integer ps,
			 Integer pn){
		TStu s = getLoginStu(request);
		if(null == s) return "redirect:/login?_r=/publics/"+col+"?param="+param;
		injectHeader(s,model);
		
		if("fee".equals(col)){
			if(ps==null) ps=20;
			if(null == pn) pn=1;
			model.addAttribute("balance", classesService.getBalance(s.getClassId()));
			model.addAttribute("iorecord", moneyRecordService.listByPage(Mapper
					.make("classId", s.getClassId())
					.put("offset", ps*(pn-1))
					.put("rows", ps)
					.toHashMap()));
		}
		else if("telbook".equals(col)){
			model.addAttribute("connections", stuService.connections(s.getClassId()));
		}
		else if("nhomework".equals(col)){
			if(!Strings.isBlank(param)){
				model.addAttribute("hw", homeworkService.load(Integer.parseInt(param)));
			}
		}
		else if("notice".equals(col)){
			model.addAttribute("notices", noticeService.list(Mapper.make("classId", s.getClassId()).toHashMap()));
		}
		return "frontend/publicInfo/"+col+".jsp";
	}
	
	@RequestMapping("/weibo")
	public String weibo(Model model){
		TStu s = getLoginStu(request);
		if(null == s) return "redirect:/login?_r=/weibo";
		injectHeader(s,model);
		return "frontend/weibo.jsp";
	}
	@RequestMapping("/circle/{column}")
	public String circle(
			@PathVariable("column") String col,
			Model model,
			String param){
		TStu s = getLoginStu(request);
		if(null == s) return "redirect:/login?_r=/circle/"+col+"?param="+param;
		injectHeader(s,model);
		if("evtdetail".equals(col)){
			
			TEvent evt = eventService.load(Mapper.make("id", param).toHashMap());
			
			if(null == evt) return "/errorpage/500.jsp";
			Map<String,Object> params = Mapper.make("evtid", evt.getId()).toHashMap();
			evt.setNpraise(eventPraiseService.count(params));
			evt.setNcomment(eventCommentService.count(params));
			model.addAttribute("evt", evt);
			
			model.addAttribute("publisher", stuService.brief(Mapper
					.make("no", evt.getPublisherNo())
					.put("classId", evt.getPublisherClz())
					.toHashMap()
					)
				);
		}
		
		return "frontend/circle/"+col+".jsp";
	}
	
	/**注入header中的信息，如user，未读消息数，班级信息
	 * @param s
	 * @param model
	 */
	private void injectHeader(TStu s,Model model){
		if(s==null || model==null) return;
		model.addAttribute("me", s);
		
		//inject unread message
		TMessage msg = new TMessage();
		msg.setToClz(s.getClassId());
		msg.setToNo(s.getNo());
		msg.setState('U');
		model.addAttribute("cumsg", messageService.count(Mapper.make("deleted", "('N','F')").joinBean(msg).toHashMap()));
				
		//inject class info
		model.addAttribute("clz", classesService.load(Mapper.make("id", s.getClassId()).toHashMap()));
		
		model.addAttribute("mebrief", stuService.brief(Mapper.make("no", s.getNo()).put("classId", s.getClassId()).toHashMap()));
		
	}
	
}
