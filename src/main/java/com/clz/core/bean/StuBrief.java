package com.clz.core.bean;

/**学生的简要信息，用于消息中心
 * @author Administrator
 *
 */
public class StuBrief {

	private String name;//姓名
	private String avatar;
	private String no;
	private Integer classId;
	/**
	 * 学校名+班级名称
	 */
	private String univName;
	private String collegeName;
	private String profName;
	private String clzName;
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public Integer getClassId() {
		return classId;
	}
	public void setClassId(Integer classId) {
		this.classId = classId;
	}
	public String getUnivName() {
		return univName;
	}
	public void setUnivName(String univName) {
		this.univName = univName;
	}
	public String getClzName() {
		return clzName;
	}
	public void setClzName(String clzName) {
		this.clzName = clzName;
	}
	public String getCollegeName() {
		return collegeName;
	}
	public void setCollegeName(String collegeName) {
		this.collegeName = collegeName;
	}
	public String getProfName() {
		return profName;
	}
	public void setProfName(String profName) {
		this.profName = profName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
