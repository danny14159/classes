package com.clz.party.service;

import java.util.List;

import com.clz.core.service.BaseService;
import com.clz.party.bean.PartyDetail;
import com.clz.party.bean.TParty;

public interface PartyService extends BaseService<TParty>{

	public List<PartyDetail> show(Object param);
	public int visit(Object param);
	public int counttotal(Object params);
	public List<TParty> history(Object params);
}