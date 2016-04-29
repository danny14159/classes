package com.clz.party.bean;

/**
 * 返回查询结果的临时bean
 * 
 * @author Administrator
 *
 */
public class PartyDetail {

	/**
	 * 点击量
	 */
	private Integer visit;

	/**
	 * 心动数
	 */
	private Integer love;
	/**
	 * 是否心动过
	 */
	private Boolean blove; 
	/**
	 * 赞数
	 */
	private Integer praise;
	private Boolean bpraise; 

	/**
	 * 鲜花数
	 */
	private Integer flower;
	private Boolean bflower; 

	private String name;

	private String no;

	private Character sex;

	private String avatar;

	private String hobbies;

	private String fromProvince;

	private String fromCity;

	private String clzName;
	private String profName;
	private String collegeName;
	private String univName;

	private Integer clzId;
	private Integer profId;
	private Integer collegeId;
	private Integer univId;
	private Integer count;
	public Integer getVisit() {
		return visit;
	}
	public void setVisit(Integer visit) {
		this.visit = visit;
	}
	public Integer getLove() {
		return love;
	}
	public void setLove(Integer love) {
		this.love = love;
	}
	public Integer getPraise() {
		return praise;
	}
	public void setPraise(Integer praise) {
		this.praise = praise;
	}
	public Integer getFlower() {
		return flower;
	}
	public void setFlower(Integer flower) {
		this.flower = flower;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public Character getSex() {
		return sex;
	}
	public void setSex(Character sex) {
		this.sex = sex;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getHobbies() {
		return hobbies;
	}
	public void setHobbies(String hobbies) {
		this.hobbies = hobbies;
	}
	public String getFromProvince() {
		return fromProvince;
	}
	public void setFromProvince(String fromProvince) {
		this.fromProvince = fromProvince;
	}
	public String getFromCity() {
		return fromCity;
	}
	public void setFromCity(String fromCity) {
		this.fromCity = fromCity;
	}
	public String getClzName() {
		return clzName;
	}
	public void setClzName(String clzName) {
		this.clzName = clzName;
	}
	public String getProfName() {
		return profName;
	}
	public void setProfName(String profName) {
		this.profName = profName;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	public String getUnivName() {
		return univName;
	}
	public void setUnivName(String univName) {
		this.univName = univName;
	}
	public Integer getClzId() {
		return clzId;
	}
	public void setClzId(Integer clzId) {
		this.clzId = clzId;
	}
	public Integer getProfId() {
		return profId;
	}
	public void setProfId(Integer profId) {
		this.profId = profId;
	}
	public Integer getCollegeId() {
		return collegeId;
	}
	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}
	public Integer getUnivId() {
		return univId;
	}
	public void setUnivId(Integer univId) {
		this.univId = univId;
	}
	public Boolean getBlove() {
		return blove;
	}
	public void setBlove(Boolean blove) {
		this.blove = blove;
	}
	public Boolean getBpraise() {
		return bpraise;
	}
	public void setBpraise(Boolean bpraise) {
		this.bpraise = bpraise;
	}
	public Boolean getBflower() {
		return bflower;
	}
	public void setBflower(Boolean bflower) {
		this.bflower = bflower;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
}
