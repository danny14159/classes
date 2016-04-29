package com.clz.msg.bean;

import java.util.Date;

/**消息
 * @author denglei
 *
 */
public class TMessage {

	/**
	 * id
	 */
	private Integer id;

	/**
	 * 消息类型
	 * System:系统消息
	 * Common:普通消息
	 */
	private Character type;

	/**
	 * 消息内容
	 */
	private String content;
	
	/**
	 * 发件人学号
	 */
	private String fromNo;
	
	/**
	 * 发件人班级
	 */
	private Integer fromClz;
	
	/**
	 * 收件人学号
	 */
	private String toNo;
	
	/**
	 * 收件人班级
	 */
	private Integer toClz;

	/**
	 * 发送时间
	 */
	private Date sendTime;

	/**
	 * 消息状态
	 * Unread:未读
	 * Read:已读
	 */
	private Character state;
	
	/**
	 * 删除标记
	 * N:两者都未删除
	 * Fd:发送人删除
	 * Td:收件人删除
	 * D:两者都删除
	 */
	private Character deleted;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public Character getState() {
		return state;
	}

	public void setState(Character state) {
		this.state = state;
	}

	public Character getDeleted() {
		return deleted;
	}

	public void setDeleted(Character deleted) {
		this.deleted = deleted;
	}

	public String getFromNo() {
		return fromNo;
	}

	public void setFromNo(String fromNo) {
		this.fromNo = fromNo;
	}

	public Integer getFromClz() {
		return fromClz;
	}

	public void setFromClz(Integer fromClz) {
		this.fromClz = fromClz;
	}

	public String getToNo() {
		return toNo;
	}

	public void setToNo(String toNo) {
		this.toNo = toNo;
	}

	public Integer getToClz() {
		return toClz;
	}

	public void setToClz(Integer toClz) {
		this.toClz = toClz;
	}

}