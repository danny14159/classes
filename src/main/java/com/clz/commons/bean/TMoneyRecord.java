package com.clz.commons.bean;

import java.util.Date;

import javax.validation.constraints.Digits;
import javax.validation.constraints.Size;

/**班费收支记录
 * @author denglei
 *
 */
public class TMoneyRecord {

	/**
	 * 支付流水号
	 */
	private String payNo;

	/**
	 * 收支时间
	 */
	private Date payTime;

	/**
	 * 理由
	 */
	@Size(min=1,max=255)
	private String reason;

	/**
	 * 金额
	 */
	@Digits(integer=8,fraction=2)
	private Double amount;
	
	/**
	 * 余额
	 */	
	private Double balance;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 班级ID
	 */
	private Integer classId;

	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getClassId() {
		return classId;
	}

	public void setClassId(Integer classId) {
		this.classId = classId;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

} 