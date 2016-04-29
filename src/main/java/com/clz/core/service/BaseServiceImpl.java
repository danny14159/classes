package com.clz.core.service;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.clz.conf.MyBatisUtil;

abstract public class BaseServiceImpl<T> implements BaseService<T> {
	/**
	 * CRUD对应的接口
	 */
	protected Class<?> interf=null;
	
	/**修改的通用操作
	 * @param optName
	 * @param obj
	 * @return
	 */
	protected int exeModify(String optName,Object... obj){
		SqlSession session = MyBatisUtil.getSession();
		int ret=0;
		try{
			Object mapper = session.getMapper(interf);
			
			ret = (Integer)getMethod(interf,optName,obj).invoke(mapper, obj);
			
			session.commit();
		}
		catch(Exception e){
			e.printStackTrace();
			session.rollback();
		}
		finally{
			session.close();
		}
		return ret;
	}
	
	/**查询的通用操作
	 * @param optName
	 * @param params
	 * @return
	 */
	protected Object exeQuery(String optName,Object... params){
		Object list=null;
		SqlSession session = MyBatisUtil.getSession();
		try{
			Object mapper = session.getMapper(interf);
			
			list = getMethod(interf,optName,params).invoke(mapper, params);

		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<T>();
		} 
		finally{
			session.close();
		}
		return list;
	}
	
	/**获取某类中的指定方法，支持重载方法
	 * @param clz
	 * @param name
	 * @param params
	 * @return
	 * @throws Exception 
	 */
	private Method getMethod(Class<?> clz,String name,Object... params) throws Exception{
		for(Method method:clz.getMethods()){
			if(method.getName().equals(name)){
				Class<?>[] types = method.getParameterTypes();
				
				if(params.length!=types.length) continue;
				for(int i =0,len = params.length;i<len;i++){
					if(params[i].getClass()!=types[i]) continue;
				}
				return method; 
			}
		}
		throw new Exception("Mehod Not Found!");
	}

	public int insert(T obj) {
		return exeModify("insert", obj);
	}

	public int delete(Object params) {
		return exeModify("delete", params);
	}

	@SuppressWarnings("unchecked")
	public T load(Object params) {
		return (T)exeQuery("load", params);
	}

	public int count(Object params) {
		return (Integer) exeQuery("count", params);
	}

	@SuppressWarnings("unchecked")
	public List<T> list(Object params) {
		
		return (List<T>)exeQuery("list", params);
	}

	@SuppressWarnings("unchecked")
	public List<T> listByPage(Object params) {
		
		return (List<T>)exeQuery("listByPage", params);
	}

	public int update(Object params){
		return exeModify("update", params);
	}
}
