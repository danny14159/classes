package com.clz.commons.bean;

import java.util.Date;

/**
 * @author 
 *
 */
public class TNotice  {

	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 
	 */
	private Integer classId;

	/**
	 * 
	 */
	private String content;

	/**
	 * 
	 */
	private Date time;

	/**
	 * 
	 */
	private String title;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getClassId() {
		return classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}