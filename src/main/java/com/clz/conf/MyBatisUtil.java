package com.clz.conf;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

/**
 * @author denglei
 */
public class MyBatisUtil {
	private static SqlSessionFactory sqlSessionFactory = null;
/*	private static final String resource="com/clz/conf/mybatis-config.xml";
*/	
	
	private static MyBatisUtil instance=new MyBatisUtil();
	private MyBatisUtil(){		
	}
	public static MyBatisUtil getInstance(){
		return instance;
	}
	
	/**
	 * @return 获取SqlSession实例。使用request相似的生命周期。注意：在try-catch块中调用session的相关函数，在finally块中调用session.close();
	 */
	public static SqlSession getSession(){
		SqlSession session = null;
		if (sqlSessionFactory == null) {		
			try {
				//InputStream inputStream = Resources.getResourceAsStream(resource);
				//sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
				//sqlSessionFactory = (SqlSessionFactory)SpringContextHolder.getBean("sqlSessionFactory");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		session = sqlSessionFactory.openSession();				
		return session;
	}
}
