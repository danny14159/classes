package com.clz.core.extend;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.config.ConfigurationSource;
import org.apache.logging.log4j.core.config.Configurator;

import com.clz.conf.TestLog4j;

public class LogContext {
	static{
		init();
	}
	
	private static Logger logger;

	public static void init() {
		String config = System.getProperty("user.dir");
		ConfigurationSource source = null;
		try {
			source = new ConfigurationSource(new FileInputStream(config
					+ "\\src\\main\\java\\com\\clz\\conf\\log4j2.xml"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Configurator.initialize(null, source);
		logger = LogManager.getLogger(TestLog4j.class.getName());
	}
	
	public static Logger getLogger(){
		return logger;
	}
}
