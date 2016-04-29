package com.clz.core.bean;
/**专业
 * @author denglei
 *
 */
public class TProf {

	/**
	 * ID
	 */
	private Integer id;

	/**
	 * 专业名字
	 */
	private String name;

	/**
	 * 学院ID
	 */
	private Integer collegeId;

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

	public Integer getCollegeId() {
		return collegeId;
	}

	public void setCollegeId(Integer collegeId) {
		this.collegeId = collegeId;
	}

}