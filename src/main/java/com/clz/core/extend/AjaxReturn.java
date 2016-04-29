package com.clz.core.extend;

public class AjaxReturn {

	private Boolean ok;
	
	private String msg;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Boolean getOk() {
		return ok;
	}

	public void setOk(Boolean ok) {
		this.ok = ok;
	}

	public AjaxReturn(Boolean ok, String msg) {
		super();
		this.ok = ok;
		this.msg = msg;
	}
	
	/** ok非0表示成功，否则失败
	 * @param ok
	 * @param okmsg
	 * @param otherwise
	 * @return
	 */
	public static AjaxReturn ok(int ok,String okmsg,String otherwise){
		
		return new AjaxReturn(ok!=0, ok != 0?okmsg:otherwise);
	}
}
