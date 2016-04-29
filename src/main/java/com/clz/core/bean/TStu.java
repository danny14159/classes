package com.clz.core.bean;

import java.sql.Date;

import javax.validation.constraints.Null;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

/**学生
 * @author denglei
 *
 */
public class TStu {

	/**
	 * 学号
	 */
	private String no;

	/**
	 * 班级ID
	 */
	private Integer classId;

	/**
	 * 姓名
	 */
	private String name;

	/**
	 * 性别
	 */
	private Character sex;

	/**
	 * 电话
	 */
	@Pattern(regexp="\\d*")
	private String phone;

	/**
	 * 电子邮箱
	 */
	@Email
	private String email;

	/**
	 * 头像
	 */
	private String avatar;

	/**
	 * 密码
	 */
	@Null
	private String password;

	/**
	 * 联系方式
	 */
	private String connection;

	/**
	 * 信息门户密码
	 */
	private String pwPortral;

	/**
	 * 账号状态
	 * Normal:正常;Frozen:冻结
	 */
	private Character state;

	/**
	 * 自我介绍
	 */
	private String signature;

	/**
	 * 生日
	 */
	private Date birth;

	/**
	 * 兴趣爱好
	 */
	private String hobbies;

	/**
	 * 来自省份
	 */
	private String fromProvince;

	/**
	 * 来自市
	 */
	private String fromCity;
	
	private Character deleted;
	
	/**
	 * 学会身份
	 * Common:普通学生
	 * Manager:管理员
	 */
	private Character type;

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Character getSex() {
		return sex;
	}

	public void setSex(Character sex) {
		this.sex = sex;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConnection() {
		return connection;
	}

	public void setConnection(String connection) {
		this.connection = connection;
	}

	public String getPwPortral() {
		return pwPortral;
	}

	public void setPwPortral(String pwPortral) {
		this.pwPortral = pwPortral;
	}

	public Character getState() {
		return state;
	}

	public void setState(Character state) {
		this.state = state;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
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

	public Character getDeleted() {
		return deleted;
	}

	public void setDeleted(Character deleted) {
		this.deleted = deleted;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}

}