package com.clz.core.extend;

public class SystemUtil {
	
	/**获取操作系统名称
	 * @return
	 */
	public static String getOSName() {
		return System.getProperty("os.name").toLowerCase();
	}

	/**是否是windows系统
	 * @return
	 */
	public static boolean isOSWindows() {
		return "windows".equals(getOSName());
	}
}
