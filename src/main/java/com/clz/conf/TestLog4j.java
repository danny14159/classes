package com.clz.conf;


import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.config.ConfigurationSource;
import org.apache.logging.log4j.core.config.Configurator;

import com.clz.core.bean.TUniv;


public class TestLog4j {
	static Logger logger ;
    public static boolean hello() {
        logger.entry();   //trace级别的信息，单独列出来是希望你在某个方法或者程序逻辑开始的时候调用，和logger.trace("entry")基本一个意思
        logger.error("Did it again!");   //error级别的信息，参数就是你输出的信息
        logger.info("我是info信息");    //info级别的信息
        logger.debug("我是debug信息");
        logger.warn("我是warn信息");
        logger.fatal("我是fatal信息");
        logger.log(Level.DEBUG, "我是debug信息");   //这个就是制定Level类型的调用：谁闲着没事调用这个，也不一定哦！
        logger.exit();    //和entry()对应的结束方法，和logger.trace("exit");一个意思
        return false;
    }
    
    public static void init(){
    	String config=System.getProperty("user.dir");
    	ConfigurationSource source=null;
		try {
			source = new ConfigurationSource(new FileInputStream(config+"\\src\\main\\java\\com\\clz\\conf\\log4j2.xml"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
        Configurator.initialize(null, source);
        logger = LogManager.getLogger(TestLog4j.class.getName());
    }

	public static void main(String[] args) {
		init();
		
		TUniv u=new TUniv();
		u.setId(1);
		u.setName("江苏大学2");
		
	}

}
