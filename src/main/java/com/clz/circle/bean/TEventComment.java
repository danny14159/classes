
package com.clz.circle.bean;

import java.util.Date;

/**
 * @author dl
 *
 */
public class TEventComment  {

    /**
     * 
     */
    private String stuNo;

    /**
     * 
     */
    private Integer stuClz;
    
    private String stuName;

    /**
     * 
     */
    private String content;

    /**
     * 
     */
    private Date time;

    /**
     * 
     */
    private Integer evtid;

    /**
     * 
     */
    private String replyNo;

    /**
     * 
     */
    private Integer replyClz;

    /**
     * 
     */
    private Integer id;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getEvtid() {
		return evtid;
	}

	public void setEvtid(Integer evtid) {
		this.evtid = evtid;
	}

	public String getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(String replyNo) {
		this.replyNo = replyNo;
	}

	public Integer getReplyClz() {
		return replyClz;
	}

	public void setReplyClz(Integer replyClz) {
		this.replyClz = replyClz;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStuName() {
		return stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}

}