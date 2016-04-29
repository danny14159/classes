package com.clz.commons.bean;

import java.sql.Date;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;


/**作业
 * @author denglei
 *
 */
public class THomework {

	/**
	 *id
	 */
	private Integer id;

	/**
	 * 交作业日期
	 */
	@Future(message="交作业日期应大于当前日期")
	private Date expire;

	/**
	 * 补充说明
	 */
	private String expireAdd;

	/**
	 * 科目
	 */
	@NotEmpty
	private String subject;

	/**
	 * 作业内容
	 */
	private String content;

	/**
	 * 可选图片
	 */
	private String pics;

	/**
	 * 访问量
	 */
	private Integer visit;

	/**
	 * 班级ID
	 */
	private Integer classId;

	/**
	 * 是否删除
	 */
	private Character deleted;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getExpire() {
		return expire;
	}

	public void setExpire(Date expire) {
		this.expire = expire;
	}

	public String getExpireAdd() {
		return expireAdd;
	}

	public void setExpireAdd(String expireAdd) {
		this.expireAdd = expireAdd;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPics() {
		return pics;
	}

	public void setPics(String pics) {
		this.pics = pics;
	}

	public Integer getVisit() {
		return visit;
	}

	public void setVisit(Integer visit) {
		this.visit = visit;
	}

	public Integer getClassId() {
		return classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}

	public Character getDeleted() {
		return deleted;
	}

	public void setDeleted(Character deleted) {
		this.deleted = deleted;
	}
}