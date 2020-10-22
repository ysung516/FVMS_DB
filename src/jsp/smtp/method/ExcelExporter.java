package jsp.smtp.method;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

import jsp.Bean.model.nextPlanBean;
import jsp.DB.method.DBconnection;
import jsp.DB.method.MeetingDAO;

public class ExcelExporter {

	// 레포트 백업 파일 엑셀로 내보내기
	public void export(String weekly) {

		String excelFilePath = "Report-export.xlsx";
		//String excelFilePath = "C:\\Users\\User\\git\\FVMS_DB\\Report-export.xlsx";

		try (Connection connection = DBconnection.getConnection()) {
			String sql = "SELECT * FROM weekly_Report where 주차 =" + weekly;

			Statement statement = connection.createStatement();

			ResultSet result = statement.executeQuery(sql);

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet("reportBackup");

			writeHeaderLine(sheet);
			writeDataLines(result, workbook, sheet);

			FileOutputStream outputStream = new FileOutputStream(excelFilePath);
			workbook.write(outputStream);
			workbook.close();
			statement.close();

		} catch (SQLException e) {
			System.out.println("Datababse error:");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("File IO error:");
			e.printStackTrace();
		}
	}

	// 레포트 백업 파일 엑셀 제목 설정
	private void writeHeaderLine(XSSFSheet sheet) {

		Row headerRow = sheet.createRow(0);

		Cell headerCell = headerRow.createCell(0);
		headerCell.setCellValue("PM");

		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("프로젝트명");

		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("작성일");

		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("금주계획");

		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("금주진행");

		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("차주계획");

		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("특이사항");

		headerCell = headerRow.createCell(7);
		headerCell.setCellValue("비고");
	}

	// 레포트 백업 파일 엑셀에 데이터 추가
	private void writeDataLines(ResultSet result, XSSFWorkbook workbook, XSSFSheet sheet) throws SQLException {
		int rowCount = 1;
		while (result.next()) {
			
			String name = result.getString("이름");
			String projectName = result.getString("프로젝트명");
			String writingDate = result.getString("작성일");
			String week = result.getString("금주계획");
			String weekWork = result.getString("금주진행");
			String after = result.getString("차주계획");
			String ts = result.getString("특이사항");
			String bg = result.getString("비고");
			Row row = sheet.createRow(rowCount++);

			int columnCount = 0;
			Cell cell = row.createCell(columnCount++);
			cell.setCellValue(name);

			cell = row.createCell(columnCount++);
			cell.setCellValue(projectName);

			cell = row.createCell(columnCount++);
			cell.setCellValue(writingDate);

			cell = row.createCell(columnCount++);
			cell.setCellValue(week);

			cell = row.createCell(columnCount++);
			cell.setCellValue(weekWork);

			cell = row.createCell(columnCount++);
			cell.setCellValue(after);

			cell = row.createCell(columnCount++);
			cell.setCellValue(ts);

			cell = row.createCell(columnCount);
			cell.setCellValue(bg);
		}
	}
	// 회의록 엑셀로 내보내기
	public void MeetExport( String MeetName, String writer,
			String meetnote, String nextplan, String issue, String date, 
			String MeetDate, String attendees, String attendees_ex, String MeetPlace) {
		String excelFilePath = "MeetingLog-export.xlsx";
		try {
			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet("MeetingLog");
			writeHeaderLine2(sheet);
			writeDataLines2(workbook, sheet, MeetName, writer,
				meetnote, nextplan, issue, date, MeetDate, attendees, attendees_ex, MeetPlace);

			
			FileOutputStream outputStream = new FileOutputStream(excelFilePath);
			workbook.write(outputStream);
			workbook.close();
		} catch (IOException e) {
			System.out.println("File IO error:");
			e.printStackTrace();
		}
		

	}

	// 회의록 엑셀 제목 설정
	private void writeHeaderLine2(XSSFSheet sheet) {
		Row headerRow = sheet.createRow(0);

		Cell headerCell = headerRow.createCell(0);
		headerCell.setCellValue("회의명");

		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("작성자");

		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("회의내용");
		
		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("향후일정");
		
		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("이슈사항");
		
		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("작성날짜");

		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("회의일시");

		headerCell = headerRow.createCell(7);
		headerCell.setCellValue("회의장소");

		headerCell = headerRow.createCell(8);
		headerCell.setCellValue("참석자");

		headerCell = headerRow.createCell(9);
		headerCell.setCellValue("외부참석자");
		
	}

	// 회의록 엑셀에 데이터 추가
	private void writeDataLines2(XSSFWorkbook workbook, XSSFSheet sheet, String MeetName, String writer,
			String meetnote, String nextplan, String issue, String date, String MeetDate, String attendees, String attendees_ex, String MeetPlace) {
		
		MeetingDAO meetDao = new MeetingDAO();
		ArrayList<nextPlanBean> li = meetDao.getNextPlan(nextplan);
		
		StringBuffer str = new StringBuffer();
		if(li.size() > 0) {
			for(int i=0; i<li.size(); i++) {
				str.append(li.get(i).getNo()+".항목: " + li.get(i).getItem() + "\n" + "기한: " + li.get(i).getDeadline() + "\n" + "담당" + li.get(i).getPM() + "\n");
			}
		}
		
		int rowCount = 1;

			Row row = sheet.createRow(rowCount++);
			int columnCount = 0;
			Cell cell = row.createCell(columnCount++);
			cell.setCellValue(MeetName);

			cell = row.createCell(columnCount++);
			cell.setCellValue(writer);

			cell = row.createCell(columnCount++);
			cell.setCellValue(meetnote);

			cell = row.createCell(columnCount++);
			cell.setCellValue(str.toString());

			cell = row.createCell(columnCount++);
			cell.setCellValue(issue);

			cell = row.createCell(columnCount++);
			cell.setCellValue(date);

			cell = row.createCell(columnCount++);
			cell.setCellValue(MeetDate);

			cell = row.createCell(columnCount++);
			cell.setCellValue(MeetPlace);
			
			cell = row.createCell(columnCount++);
			cell.setCellValue(attendees);
			
			cell = row.createCell(columnCount++);
			cell.setCellValue(attendees_ex);
		
	}
	


}
