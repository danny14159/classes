package com.clz.core.extend;

import org.apache.poi.hssf.usermodel.HSSFCell;

public class ExcelUtils {
	/**
	 * 获得单元格中的内容
	 * 
	 * @param cell
	 * @return
	 */
	public static  Object getCellString(HSSFCell cell) {
		Object result = null;
		if (cell != null) {

			int cellType = cell.getCellType();

			switch (cellType) {

			case HSSFCell.CELL_TYPE_STRING:
				result = cell.getRichStringCellValue().getString();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC:
				result = cell.getNumericCellValue();
				break;
			case HSSFCell.CELL_TYPE_FORMULA:
				result = cell.getNumericCellValue();
				break;
			case HSSFCell.CELL_TYPE_ERROR:
				result = null;
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				result = cell.getBooleanCellValue();
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				result = null;
				break;
			}
		}
		return result;
	}
}
