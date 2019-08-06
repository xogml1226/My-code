package com.sp.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

// AbstractExcelView는 spring 4.2 부터  deprecated 됨
// 높은 버전의 엑셀은 AbstractXlsxView 구현클래스로 작성(확장자는 xlsx) 
// 낮은 버전의 엑셀은 AbstractXlsView 구현클래스로 작성(확장자는 xls) 

@Service("excelView")
public class MyExcelView extends AbstractXlsxView {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String filename = (String)model.get("filename");
		String sheetName = (String)model.get("sheetName");
		
		List<String> labels = (List<String>)model.get("labels");
		List<Object[]> values = (List<Object[]>)model.get("values");
		
		response.setContentType("application/ms-excel");
		response.setHeader("Content-disposition", "attachment; filename="+filename);
		
		Sheet sheet = createSheet(workbook, 0, sheetName);
		createColumnLabel(sheet, labels);
		createColumnValue(sheet, values);
	}
	
	private Sheet createSheet(Workbook workbook, int sheetIdx, String sheetName) {
		Sheet sheet = workbook.createSheet();
		
		workbook.setSheetName(sheetIdx, sheetName);
		
		return sheet;
	}
	
	private void createColumnLabel(Sheet sheet, List<String> labels) {
		Row row = sheet.createRow(0);
		
		Cell cell;
		for(int idx=0; idx<labels.size(); idx++) {
			sheet.setColumnWidth(idx, 256*15);
			
			cell=row.createCell(idx);
			cell.setCellValue(labels.get(idx));
		}
	}
	
	//내용(두번째(1) 행) ~ 
	private void createColumnValue(Sheet sheet, List<Object[]> values) {
		Row row;
		Cell cell;
		
		for(int idx=0; idx<values.size(); idx++) {
			row = sheet.createRow(idx+1);
			
			Object[] objs = values.get(idx);
			for(int col=0; col<objs.length; col++) {
				cell = row.createCell(col);
				
				if(objs[col] instanceof Short) {
					cell.setCellValue((Short)objs[col]);
				}else if(objs[col] instanceof Integer) {
					cell.setCellValue((Integer)objs[col]);
				}else if(objs[col] instanceof Long) {
					cell.setCellValue((Long)objs[col]);
				}else if(objs[col] instanceof Float) {
					cell.setCellValue((Float)objs[col]);
				}else if(objs[col] instanceof Character) {
					cell.setCellValue((Character)objs[col]);
				}else if(objs[col] instanceof Boolean) {
					cell.setCellValue((Boolean)objs[col]);
				}else if(objs[col] instanceof String) {
					cell.setCellValue((String)objs[col]);
				}else {
					cell.setCellValue((String)objs[col]);
				}
			}
		}
	}
}
