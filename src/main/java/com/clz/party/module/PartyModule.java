package com.clz.party.module;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.TStu;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.Mapper;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;
import com.clz.party.bean.PartyDetail;
import com.clz.party.bean.TParty;
import com.clz.party.bean.TPartyInteract;
import com.clz.party.service.PartyInteractService;
import com.clz.party.service.PartyService;


@Controller
@RequestMapping("/party")
public class PartyModule extends BasicModule<TParty>{
	@Autowired
	private PartyService partyService;
	@Autowired
	private PartyInteractService partyInteractService;
	@Override
	protected BaseService<TParty> getService() {
		return partyService;
	}
	
	/**
	 * 加入派对
	 */
	@RequestMapping("/enter")
	@ResponseBody
	public Object enterParty(
			@RequestParam String expect){
		//1.登录检查
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false,"请先登录");
		
		//2.是否已经加入派对检查
		if(partyService.count(Mapper
				.make("exit", 'N')
				.put("stuNo", s.getNo())
				.put("stuClz", s.getClassId())
				.toHashMap()) > 0){
			return new AjaxReturn(false,"你在派对中");
		}
		
		TParty p = new TParty();
		p.setEnterTime(new Date());
		p.setExit('N');
		p.setExpect(expect);
		p.setStuClz(s.getClassId());
		p.setStuNo(s.getNo());
		p.setVisit(0);
		
		if(partyService.insert(p) == 1){
			return new AjaxReturn(true,"");
		};
		return new AjaxReturn(false,"加入失败，请稍后再试！");
	}
	
	/**退出派对。最后一此计算赞鲜花心动数，并把这些记录清除。
	 * @return
	 */
	@RequestMapping("/exit")
	@ResponseBody
	public Object exitParty(){
		//1.登录检查
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false,"请先登录");
		
		int attence = partyService.count(Mapper
				.make("exit", 'N')
				.put("stuNo", s.getNo())
				.put("stuClz", s.getClassId())
				.toHashMap()) ;
		if(0 == attence)
			return new AjaxReturn(false, "未加入派对");
		
		int cflower,cpraise,clove;
		Map<String,Object> ctp = Mapper.make("toClz", s.getClassId())
				.put("toNo", s.getNo()).put("flower", 'Y').toHashMap();
		cflower  = partyInteractService.count(ctp);
		ctp.put("flower", null);
		ctp.put("praise", 'Y');
		cpraise  = partyInteractService.count(ctp);
		ctp.put("praise", null);
		ctp.put("love", 'Y');
		clove  = partyInteractService.count(ctp);
		
		//清除关于我的交互记录
		ctp.put("love", 'N');
		ctp.put("praise", 'N');
		ctp.put("flower", 'N');
		partyInteractService.update(ctp);
		
		TParty p = new TParty();
		p.setExit('Y');
		p.setFlower(cflower);
		p.setPraise(cpraise);
		p.setLove(clove);
		p.setExitTime(new Date());
		p.setStuClz(s.getClassId());
		p.setStuNo(s.getNo());
		if(0 < partyService.update(p)) 
			return new AjaxReturn(true, null);
		return new AjaxReturn(false, "系统繁忙，稍后再试");
	}
	
	/**派对展示。分页
	 * @return
	 */
	@RequestMapping("/show")
	@ResponseBody
	public Object show(
			Integer ps,
			Integer pn,
			Integer clzId,
			Integer profId,
			Integer univId,
			Integer collegeId,
			String hobbies,
			Integer fromAge,
			Integer toAge,
			String fromProvince,
			String fromCity,
			Character sex,
			Integer visit){
		if(null == ps) ps=20;
		if(null == pn) pn=1;
		
		// 1.登录检查
		TStu s = SystemModule.getLoginStu(request);
		if (null == s)
			return new AjaxReturn(false, "请先登录");
		// 2.是否已经加入派对检查
		if (partyService.count(Mapper.make("exit", 'N').put("stuNo", s.getNo())
				.put("stuClz", s.getClassId()).toHashMap()) == 0) {
			return new AjaxReturn(false, "未加入派对。");
		}
		
		//3.按条件查询
		if(Strings.isBlank(fromProvince)) fromProvince = null;
		if(Strings.isBlank(hobbies)) hobbies = null;
		if(Strings.isBlank(fromCity)) fromCity = null;
		
		Map<String,Object> psp= Mapper.make("offset", ps*(pn-1))
				.put("rows", ps)
				.put("clzId", clzId)
				.put("profId", profId)
				.put("collegeId", collegeId)
				.put("univId", univId)
				.put("hobbies", hobbies)
				.put("fromProvince", fromProvince)
				.put("fromCity", fromCity)
				.put("sex", sex)
				.put("visit", visit)
				.toHashMap();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(null!=fromAge){
			Date toBirth = new Date(new Date().getTime() - fromAge*365L*24*3600*1000);
			psp.put("toBirth",sdf.format(toBirth) );
		}
		if(null!=toAge){
			Date fromBirth = new Date(new Date().getTime() - toAge*365L*24*3600*1000);
			psp.put("fromBirth",sdf.format(fromBirth) );
		}
		
		List<PartyDetail> pds = partyService.show(psp);
		
		return calInter(s,pds);
	}
	
	/**4.计算交互，赞等数量，和是否已交互过
	 * @param s
	 * @param pds
	 */
	public List<PartyDetail> calInter(TStu s,List<PartyDetail> pds){
		
				for(PartyDetail pd:pds){
					int cflower = 0,cpraise = 0,clove = 0;
					boolean bflower = false,bpraise = false,blove = false;
					Map<String,Object> ctp = Mapper.make("toClz", pd.getClzId())
							.put("toNo", pd.getNo())
							.put("flower", 'Y')
							.toHashMap();
					cflower  = partyInteractService.count(ctp);
					ctp.put("flower", null);
					ctp.put("praise", 'Y');
					cpraise  = partyInteractService.count(ctp);
					ctp.put("praise", null);
					ctp.put("love", 'Y');
					clove  = partyInteractService.count(ctp);
					
					pd.setLove(clove);
					pd.setPraise(cpraise);
					pd.setFlower(cflower);
					
					Map<String,Object> ctpb = Mapper.make("toClz", pd.getClzId())
							.put("toNo", pd.getNo())
							.put("fromNo", s.getNo())
							.put("fromClz", s.getClassId())
							.toHashMap();
					TPartyInteract inter = partyInteractService.load(ctpb);
					if(null!=inter){
						bflower = inter.getFlower()!=null && inter.getFlower()=='Y';
						bpraise = inter.getPraise()!=null && inter.getPraise()=='Y';
						blove = inter.getLove()!=null && inter.getLove()=='Y';
					}
					pd.setBlove(blove);
					pd.setBflower(bflower);
					pd.setBpraise(bpraise);
				}
		return pds;
	}

	@RequestMapping("/count")
	@ResponseBody
	public Object counttotal(
			Integer ps,
			Integer pn,
			Integer clzId,
			Integer profId,
			Integer univId,
			Integer collegeId,
			String hobbies,
			Integer fromAge,
			Integer toAge,
			String fromProvince,
			String fromCity,
			Character sex,
			Integer visit) {
		if(null == ps) ps=20;
		if(null == pn) pn=1;
		Map<String,Object> psp= Mapper.make("offset", ps*(pn-1))
				.put("rows", ps)
				.put("clzId", clzId)
				.put("profId", profId)
				.put("collegeId", collegeId)
				.put("univId", univId)
				.put("hobbies", hobbies)
				.put("fromProvince", fromProvince)
				.put("fromCity", fromCity)
				.put("sex", sex)
				.put("visit", visit)
				.toHashMap();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(null!=fromAge){
			Date toBirth = new Date(new Date().getTime() - fromAge*365L*24*3600*1000);
			psp.put("toBirth",sdf.format(toBirth) );
		}
		if(null!=toAge){
			Date fromBirth = new Date(new Date().getTime() - toAge*365L*24*3600*1000);
			psp.put("fromBirth",sdf.format(fromBirth) );
		}
		return partyService.counttotal(psp);
	}

	@Override
	public Object update(TParty obj, BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		obj.setStuNo(s.getNo());
		obj.setStuClz(s.getClassId());
		return super.update(obj, br);
	}
	
}