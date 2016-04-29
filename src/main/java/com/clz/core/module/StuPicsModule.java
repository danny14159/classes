package com.clz.core.module;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.bean.PhotoJson;
import com.clz.core.bean.TStu;
import com.clz.core.bean.TStuPics;
import com.clz.core.extend.Mapper;
import com.clz.core.service.BaseService;
import com.clz.core.service.StuPicsService;

@Controller
@RequestMapping("/stupics")
public class StuPicsModule extends BasicModule<TStuPics> {
	
	@Autowired
	private StuPicsService stuPicsService;

	@Override
	protected BaseService<TStuPics> getService() {
		return stuPicsService;
	}

	@RequestMapping("/photo.json")
	@ResponseBody
	public Object photosJSON(
			@RequestParam() String stuNo,
			@RequestParam() String clzId,
			@RequestParam() Integer start
			){
		List<TStuPics> pics = stuPicsService.list(Mapper.make("no", stuNo).put("classId", clzId).toHashMap());
		List<PhotoJson> picsjson = new ArrayList<PhotoJson>();
		for(TStuPics pic:pics){
			PhotoJson photojson = new PhotoJson();
			photojson.setArea(new Integer[]{638,851});
			photojson.setSrc(pic.getPicPath());
			picsjson.add(photojson);
		}
		return Mapper.make("start", start)
				.put("title", "查看图片")
				.put("data", picsjson)
				.put("status", 1)
				.toHashMap();
		
	}

	@Override
	public Object delete(@PathVariable("id") Integer id) {
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return 0;
		TStuPics pic = stuPicsService.load(id);
		if(null == pic || !pic.getStuNo().equals(s.getNo()) || pic.getStuClz()!=s.getClassId()){
			return 0;
		}
		return super.delete(id);
	}
}
