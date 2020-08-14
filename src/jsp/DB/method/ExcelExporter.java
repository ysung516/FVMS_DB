package jsp.DB.method;

import java.io.*;
import java.sql.*;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

public class ExcelExporter {

	public static void main(String[] args) {
		ExcelExporter test = new ExcelExporter();
		System.out.println("출력 성공 전");
		test.export();
		System.out.println("출력 성공");
	}

	public void export() {

		String excelFilePath = "Report-export.xlsx";

		try (Connection connection = DBconnection.getConnection()) {
			String sql = "SELECT * FROM reportBackUp";

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

	private void writeHeaderLine(XSSFSheet sheet) {

		Row headerRow = sheet.createRow(0);

		Cell headerCell = headerRow.createCell(0);
		headerCell.setCellValue("no");

		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("id");

		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("이름");

		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("프로젝트명");

		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("작성일");

		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("금주계획");

		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("금주진행");

		headerCell = headerRow.createCell(7);
		headerCell.setCellValue("차주계획");

		headerCell = headerRow.createCell(8);
		headerCell.setCellValue("특이사항");

		headerCell = headerRow.createCell(9);
		headerCell.setCellValue("비고");
	}

	private void writeDataLines(ResultSet result, XSSFWorkbook workbook, XSSFSheet sheet) throws SQLException {
		int rowCount = 1;

		while (result.next()) {
			String no = result.getString("no");
			String id = result.getString("id");
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
			cell.setCellValue(no);

			cell = row.createCell(columnCount++);
			cell.setCellValue(id);

			cell = row.createCell(columnCount++);
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

}
