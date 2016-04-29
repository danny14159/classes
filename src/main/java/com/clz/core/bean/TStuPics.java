package com.clz.core.bean;
/**学生照片存放
 * @author denglei
 *
 */
public class TStuPics {
	private Integer id;

	/**
	 * 学生学号
	 */
	private String stuNo;
	
	/**
	 * 学生班级
	 */
	private Integer stuClz;

	/**
	 * 图片路径
	 */
	private String picPath;

	/**
	 * 图片类型
	 * for Party:派对用
	 */
	private Character type;

	public String getPicPath() {
		return picPath;
	}

	public void setPicPath(String picPath) {
		this.picPath = picPath;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}