package com.clz.party.module;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.clz.party.bean.TPartyInteract;
import com.clz.party.service.PartyInteractService;
import com.clz.party.service.PartyService;

@Controller
@RequestMapping("/partyi")
public class PartyInteractModule extends BasicModule<TPartyInteract> {
	@Autowired
	private PartyInteractService partyInteractService;
	@Autowired
	private PartyService partyService;
	@Override
	protected BaseService<TPartyInteract> getService() {
		return partyInteractService;
	}

	/**内部操作函数
	 * @param toClz
	 * @param toNo
	 * @param opt 操作类型1:love;2:praise;3:flower
	 * @param cancel 是否为取消操作
	 * @return
	 */
	private Object internOpt(Integer toClz, String toNo, int opt,
			boolean cancel) {
		// 1.登录检查
		TStu s = SystemModule.getLoginStu(request);
		if (null == s)
			return new AjaxReturn(false, "请先登录");
		
		// 2.如果没有这条交互记录，则创建
		TPartyInteract inp = new TPartyInteract();
		inp.setFromClz(s.getClassId());
		inp.setFromNo(s.getNo());
		inp.setToClz(toClz);
		inp.setToNo(toNo);
		if (0 == partyInteractService.count(inp)) {
			if (0 == partyInteractService.insert(inp))
				return new AjaxReturn(false, "系统繁忙，稍后再试");
		}

		// 3.修改交互记录
		switch(opt){
		case 1:
			if(!s.getNo().equals(toNo) || s.getClassId()!=toClz)inp.setLove(cancel?'N':'Y');
			else return new AjaxReturn(false, "你不能对自己心动。。。");
		break; //不能喜欢自己
		case 2:inp.setPraise(cancel?'N':'Y');break;
		case 3:inp.setFlower(cancel?'N':'Y');break;
		}
		if (0 < partyInteractService.update(inp)) {
			return new AjaxReturn(true, "");
		}
		return new AjaxReturn(false, "系统繁忙，稍后再试");
	}

	/**
	 * 心动
	 * 
	 * @return
	 */
	@RequestMapping("/love")
	@ResponseBody
	public Object love(@RequestParam() Integer toClz,
			@RequestParam() String toNo,
			@RequestParam() Boolean cancel) {

		return internOpt(toClz,toNo,1,cancel);
	}

	/**
	 * 赞
	 * 
	 * @return
	 */
	@RequestMapping("/praise")
	@ResponseBody
	public Object praise(@RequestParam() Integer toClz,
			@RequestParam() String toNo,
			@RequestParam() Boolean cancel) {
		
		return internOpt(toClz,toNo,2,cancel);
	}

	/**
	 * 鲜花
	 * 
	 * @return
	 */
	@RequestMapping("/flower")
	@ResponseBody
	public Object flower(@RequestParam() Integer toClz,
			@RequestParam() String toNo,
			@RequestParam() Boolean cancel) {

		return internOpt(toClz,toNo,3,cancel);
	}
	
	/** 查看谁攒了，谁送了鲜花，谁对我心动
	 * @param tpwho 1:love;2:praise;3:flower
	 * @return
	 */
	@RequestMapping("/who_{tpwho}")
	@ResponseBody
	public Object who(@PathVariable(value="tpwho") Integer tpwho,
			Integer ps,
			Integer pn){
		//过滤不符合的操作类型
		if(null == tpwho || tpwho<1 || tpwho>3)
			return new AjaxReturn(false, "参数类型错误。");
		
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
		Map<String,Object> psp= Mapper.make("offset", ps*(pn-1))
					.put("rows", ps)
					.put("toClz", s.getClassId())
					.put("toNo", s.getNo())
					.toHashMap();
		switch(tpwho){
		case 1:psp.put("love", 'Y');break;
		case 2:psp.put("praise", 'Y');break;
		case 3:psp.put("flower", 'Y');break;
		}
		
		List<PartyDetail> pds = partyInteractService.who(psp);
		// 4.计算交互，赞等数量
		for (PartyDetail pd : pds) {
			int cflower, cpraise, clove;
			Map<String, Object> ctp = Mapper.make("toClz", pd.getClzId())
					.put("toNo", pd.getNo()).put("flower", 'Y').toHashMap();
			cflower = partyInteractService.count(ctp);
			ctp.put("flower", null);
			ctp.put("praise", 'Y');
			cpraise = partyInteractService.count(ctp);
			ctp.put("praise", null);
			ctp.put("love", 'Y');
			clove = partyInteractService.count(ctp);

			pd.setLove(clove);
			pd.setPraise(cpraise);
			pd.setFlower(cflower);
		}
		return pds;
	}
	
	@RequestMapping("/i_love")
	@ResponseBody
	public Object ilove(
			Integer ps,
			Integer pn){
		
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
		// 3.按条件查询
		Map<String, Object> psp = Mapper
				.make("offset", ps * (pn - 1))
				.put("rows", ps)
				.put("fromClz", s.getClassId())
				.put("fromNo", s.getNo())
				.put("love", 'Y')
				.toHashMap();
		
		List<PartyDetail> pds = partyInteractService.ilove(psp);
		// 4.计算交互，赞等数量
		for (PartyDetail pd : pds) {
			int cflower, cpraise, clove;
			Map<String, Object> ctp = Mapper.make("toClz", pd.getClzId())
					.put("toNo", pd.getNo()).put("flower", 'Y').toHashMap();
			cflower = partyInteractService.count(ctp);
			ctp.put("flower", null);
			ctp.put("praise", 'Y');
			cpraise = partyInteractService.count(ctp);
			ctp.put("praise", null);
			ctp.put("love", 'Y');
			clove = partyInteractService.count(ctp);

			pd.setLove(clove);
			pd.setPraise(cpraise);
			pd.setFlower(cflower);
		}
		return pds;
	}
}