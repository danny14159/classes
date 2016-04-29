package com.clz.circle.bean;

import java.util.Date;

/**事件
 * @author dl
 *
 */
public class TEvent  {

	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 活动时间
	 */
	private Date act_time;

	/**
	 * 事件描述
	 */
	private String desc;

	/**
	 * 事件标题
	 */
	private String title;

	/**
	 * 活动图片，分号分割
	 */
	private String pics;

	/**
	 * 发布人学号
	 */
	private String publisherNo;

	/**
	 * 发布人班级
	 */
	private Integer publisherClz;

	/**
	 * I:个人 G:集体
	 */
	private Character type;

	/**
	 * 浏览权限
	 * Ground:
	 * Private:
	 */
	private Character autho;
	
	/**
	 * 赞数
	 */
	private Integer npraise;
	
	/**
	 * 评论数
	 */
	private Integer ncomment;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getAct_time() {
		return act_time;
	}

	public void setAct_time(Date act_time) {
		this.act_time = act_time;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPics() {
		return pics;
	}

	public void setPics(String pics) {
		this.pics = pics;
	}

	public String getPublisherNo() {
		return publisherNo;
	}

	public void setPublisherNo(String publisherNo) {
		this.publisherNo = publisherNo;
	}

	public Integer getPublisherClz() {
		return publisherClz;
	}

	public void setPublisherClz(Integer publisherClz) {
		this.publisherClz = publisherClz;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}

	public Character getAutho() {
		return autho;
	}

	public void setAutho(Character autho) {
		this.autho = autho;
	}

	public Integer getNcomment() {
		return ncomment;
	}

	public void setNcomment(Integer ncomment) {
		this.ncomment = ncomment;
	}

	public Integer getNpraise() {
		return npraise;
	}

	public void setNpraise(Integer npraise) {
		this.npraise = npraise;
	}

}