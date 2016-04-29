package com.clz.party.bean;
/**派对交互
 * @author denglei
 *
 */
public class TPartyInteract {

	/**
	 * 发送方学号
	 */
	private String fromNo;
	
	/**
	 * 发送方班级
	 */
	private Integer fromClz;

	/**
	 * 接收方学号
	 */
	private String toNo;
	
	/**
	 * 接收方班级
	 */
	private Integer toClz;

	/**
	 * 是否送鲜花
	 */
	private Character flower;

	/**
	 * 是否点赞
	 */
	private Character praise;

	/**
	 * 是否心动
	 */
	private Character love;

	public Character getFlower() {
		return flower;
	}

	public void setFlower(Character flower) {
		this.flower = flower;
	}

	public Character getPraise() {
		return praise;
	}

	public void setPraise(Character praise) {
		this.praise = praise;
	}

	public Character getLove() {
		return love;
	}

	public void setLove(Character love) {
		this.love = love;
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