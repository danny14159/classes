package com.clz.party.service;

import java.util.List;

import com.clz.core.service.BaseService;
import com.clz.party.bean.PartyDetail;
import com.clz.party.bean.TPartyInteract;

public interface PartyInteractService extends BaseService<TPartyInteract>{

	public List<PartyDetail> who(Object params);
	public List<PartyDetail> ilove(Object params);
}