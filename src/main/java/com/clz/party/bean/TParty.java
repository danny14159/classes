package com.clz.party.bean;

import java.util.Date;

/**派对
 * @author denglei
 *
 */
public class TParty {

	/**
	 * 学号
	 */
	private String stuNo;
	
	/**
	 * 班级
	 */
	private Integer stuClz;

	/**
	 * 期望的TA
	 */
	private String expect;

	/**
	 * 访问数
	 */
	private Integer visit;

	/**
	 * 进入时间
	 */
	private Date enterTime;

	/**
	 * 退出时间
	 */
	private Date exitTime;
	
	/**
	 * 是否已经退出
	 * Yes;No
	 */
	private Character exit;
	/**
	 * 鲜花数
	 */
	private Integer flower;

	/**
	 * 点赞数
	 */
	private Integer praise;

	/**
	 * 心动数
	 */
	private Integer love;

	public String getExpect() {
		return expect;
	}

	public void setExpect(String expect) {
		this.expect = expect;
	}

	public Integer getVisit() {
		return visit;
	}

	public void setVisit(Integer visit) {
		this.visit = visit;
	}

	public Date getEnterTime() {
		return enterTime;
	}

	public void setEnterTime(Date enterTime) {
		this.enterTime = enterTime;
	}

	public Date getExitTime() {
		return exitTime;
	}

	public void setExitTime(Date exitTime) {
		this.exitTime = exitTime;
	}

	public String getStuNo() {
		return stuNo;
	}

	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}

	public Integer getStuClz() {
		return stuClz;
	}

	public void setStuClz(Integer stuClz) {
		this.stuClz = stuClz;
	}

	public Character getExit() {
		return exit;
	}

	public void setExit(Character exit) {
		this.exit = exit;
	}

	public Integer getFlower() {
		return flower;
	}

	public void setFlower(Integer flower) {
		this.flower = flower;
	}

	public Integer getPraise() {
		return praise;
	}

	public void setPraise(Integer praise) {
		this.praise = praise;
	}

	public Integer getLove() {
		return love;
	}

	public void setLove(Integer love) {
		this.love = love;
	}

}