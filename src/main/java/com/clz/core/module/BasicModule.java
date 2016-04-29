package com.clz.core.module;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clz.core.extend.Mapper;
import com.clz.core.extend.Pager;
import com.clz.core.extend.QueryResult;
import com.clz.core.service.BaseService;

public abstract class BasicModule<T> {
	@Autowired
	protected HttpServletRequest request;
	
	static{
		org.apache.ibatis.logging.LogFactory.useLog4J2Logging();
	}
	public BasicModule() {
		
	}

	private Logger logger = null;
	/**获取logger对象
	 * @return
	 */
	protected Logger getLogger(){
		if(logger==null)logger = LogManager.getLogger(this.getClass().getName());
		return logger;
	}
	
	/**获取基础服务类
	 * @return
	 */
	protected abstract BaseService<T> getService();
	
	@RequestMapping("/load/{id}")
	@ResponseBody
	public Object load(@PathVariable(value="id") Integer id){
		Object obj = null;
		try{
			obj = getService().load(Mapper.make("id", id).toHashMap());
			return obj;
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return obj;
	}
	
	@RequestMapping("/ins")
	@ResponseBody
	public Object insert(T obj,BindingResult br){
		if(br!=null && br.hasErrors()){
			return 0;
		}
		try{
			return getService().insert(obj);
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}
	
	@RequestMapping("/del/{id}")
	@ResponseBody
	public Object delete(@PathVariable("id")Integer id){
		try{
			return getService().delete(Mapper.make("id", id).toHashMap());
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}
	
	@RequestMapping("/upd")
	@ResponseBody
	public Object update(@ModelAttribute  T obj,BindingResult br){
		/*for(FieldError fe:br.getFieldErrors()){
			System.out.println(fe.getField());
			System.out.println(fe.getRejectedValue());
		}*/
		if(br!=null && br.hasErrors()) return 0;
		try{
			return getService().update(obj);
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}
	
	@RequestMapping("/lst")
	@ResponseBody
	public Object list(T obj){
		try{
			return getService().list(obj);
		}
		catch(Exception e){
			e.printStackTrace();
			return new ArrayList<T>();
		}
	}
	
	@RequestMapping("/lstp")
	@ResponseBody
	public Object listByPage(T obj,
			@RequestParam("ps")Integer ps,
			@RequestParam("pn")Integer pn){
		if(null==ps) ps=20;
		if(null==pn) pn=1;
		Pager pager = new Pager();
		pager.setPageNumber(pn);
		pager.setPageSize(ps);
		try{
			List<T> list = getService().listByPage(
					Mapper.make("offset", ps*(pn-1)).put("rows", ps).joinBean(obj).toHashMap()
					);
			pager.setRecordCount(getService().count(obj));
			QueryResult qr = new QueryResult(list, pager);
			
			return qr;
		}
		catch(Exception e){
			e.printStackTrace();
			return new QueryResult(new ArrayList<T>(), pager);
		}
	}
	
	@RequestMapping("/cnt")
	@ResponseBody
	public Object count(Object obj){
		try{
			return getService().count(obj);
		}
		catch(Exception e){
			e.printStackTrace();
			return 0;
		}
	}
}
