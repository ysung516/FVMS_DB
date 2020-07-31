package jsp.sheet.method;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.TimerTask;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;

import com.google.gdata.util.ServiceException;

import jsp.Bean.model.BoardBean;



public class backUp extends TimerTask{

	public void run() {
		
		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd");
        String fileName = sDate.format(new Date());
        
        
        sheetMethod method = new sheetMethod();
        ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
        try {
			boardList = method.get_DayBoardList();
		} catch (GeneralSecurityException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (ServiceException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        // 워크북 생성
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 워크시트 생성
        HSSFSheet sheet = workbook.createSheet();
        // 행 생성
        HSSFRow row = sheet.createRow(0);
        
        // 쎌 생성
        HSSFCell cell;
        
        // 헤더 정보 구성
        cell = row.createCell(0);
        cell.setCellValue("no");
        cell = row.createCell(1);
        cell.setCellValue("id");
        cell = row.createCell(2);
        cell.setCellValue("이름");
        cell = row.createCell(3);
        cell.setCellValue("직급");
        cell = row.createCell(4);
        cell.setCellValue("팀");
        cell = row.createCell(5);
        cell.setCellValue("제목");
        cell = row.createCell(6);
        cell.setCellValue("작성일");
        cell = row.createCell(7);
        cell.setCellValue("금일계획");
        cell = row.createCell(8);
        cell.setCellValue("금일진행");
        cell = row.createCell(9);
        cell.setCellValue("내일계확");
        CellStyle cs = workbook.createCellStyle();
        cs.setWrapText(true);
   
        BoardBean board;
        for(int i=0; i < boardList.size(); i++) {
        	
        	board = boardList.get(i);
        	
        	// 행 생성
        	row = sheet.createRow(i+1);
        	
        	cell = row.createCell(0);
        	cell.setCellValue(board.getNo());
        	cell = row.createCell(1);
        	cell.setCellValue(board.getId());
        	cell = row.createCell(2);
        	cell.setCellValue(board.getName());
        	cell = row.createCell(3);
        	cell.setCellValue(board.getRank());
        	cell = row.createCell(4);
        	cell.setCellValue(board.getTeam());
        	cell = row.createCell(5);
        	cell.setCellValue(board.getTitle());
        	cell = row.createCell(6);
        	cell.setCellValue(board.getDate());
        	cell = row.createCell(7);
        	cell.setCellValue(board.getWeekPlan());
        	cell.setCellStyle(cs);
        	cell = row.createCell(8);
        	cell.setCellValue(board.getWeekPro());
        	cell.setCellStyle(cs);
        	cell = row.createCell(9);
        	cell.setCellValue(board.getNextPlan());
        	cell.setCellStyle(cs);
             
        }
        
        
        for(int i=0; i < row.getPhysicalNumberOfCells(); i++) {
       	 sheet.autoSizeColumn(i);
       	 sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+1024);
       }
       
        
        // 입력된 내용 파일로 쓰기
        File file = new File("C:\\test/"+fileName+"-일간보고서.xls");
        FileOutputStream fos = null;
        try {
            fos = new FileOutputStream(file);
            workbook.write(fos);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if(workbook!=null) workbook.close();
                if(fos!=null) fos.close();
                
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    

	}



}

