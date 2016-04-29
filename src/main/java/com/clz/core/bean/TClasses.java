package com.clz.core.bean;
/**班级
 * @author denglei
 *
 */
public class TClasses {

	/**
	 * 班级ID
	 */
	private Integer id;

	/**
	 * 名称
	 */
	private String name;

	/**
	 * 专业ID
	 */
	private Integer profId;

	/**
	 * LOGO图片地址
	 */
	private String logo;
	
	/**
	 * 班级介绍
	 */
	private String intro;

	/**
	 * 班费余额
	 */
	private Double balance;
	
	/**
	 * 班级微博
	 */
	private String weibo;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getProfId() {
		return profId;
	}

	public void setProfId(Integer profId) {
		this.profId = profId;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getWeibo() {
		return weibo;
	}

	public void setWeibo(String weibo) {
		this.weibo = weibo;
	}

}