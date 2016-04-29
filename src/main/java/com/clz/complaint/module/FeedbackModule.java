package com.clz.complaint.module;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.clz.complaint.bean.TFeedback;
import com.clz.complaint.service.FeedbackService;
import com.clz.core.bean.TStu;
import com.clz.core.extend.Strings;
import com.clz.core.module.BasicModule;
import com.clz.core.module.SystemModule;
import com.clz.core.service.BaseService;

@Controller
@RequestMapping("/feed")
public class FeedbackModule extends BasicModule<TFeedback>{
	@Autowired
	private FeedbackService feedbackService;

	@Override
	protected BaseService<TFeedback> getService() {
		return feedbackService;
	}

	@Override
	public Object insert(TFeedback obj, BindingResult br) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s || Strings.isBlank(obj.getContent())) return 0;
		obj.setClassId(s.getClassId());
		obj.setNo(s.getNo());
		return super.insert(obj, br);
	}

}
