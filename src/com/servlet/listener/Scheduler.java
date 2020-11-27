package com.servlet.listener;
import java.text.SimpleDateFormat;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import com.googleDrive.method.DriveMethod;

import jsp.DB.method.ProjectDAO;
import jsp.DB.method.ReportDAO;
import jsp.sheet.method.sheetMethod;
import jsp.smtp.method.ExcelExporter;
import jsp.smtp.method.PostMan;

public class Scheduler {
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
  	PostMan post = new PostMan();
	ExcelExporter excel = new ExcelExporter();
	ReportDAO reportDao = new ReportDAO();
	ProjectDAO projectDao = new ProjectDAO();
	
	
    public void startScheduleTask() {
    final ScheduledFuture<?> taskHandle = scheduler.scheduleAtFixedRate(
        new Runnable() {
            public void run() {
                try {
                	
                	Calendar cal = Calendar.getInstance();
            		String day = cal.getTime().toString().split(" ")[0];
            		String time = cal.getTime().toString().split(" |:")[3];
            		if(day.equals("Wed") && time.equals("18")) {
        				reportBackUp();
        				System.out.println("보고서 드라이브 업로드");
            		}
                    
                }catch(Exception ex) {
                    ex.printStackTrace(); //or loggger would be better
                }
            }
        }, 0, 60, TimeUnit.MINUTES);
    }
    public void projectUpdate() {
    final ScheduledFuture<?> taskHandle = scheduler.scheduleAtFixedRate(
        new Runnable() {
            public void run() {
                try {
                	Date nowTime = new Date();
                	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");
                	SimpleDateFormat sfyear = new SimpleDateFormat("yyyy");
                	String nowDate = sf.format(nowTime);
                	String nowYear = sfyear.format(nowTime);
                	Calendar cal = Calendar.getInstance();
            		String time = cal.getTime().toString().split(" |:")[3];
            		
            		// 동기화 될 시트 이름
            		String sheetName = projectDao.getSpreadSheetYear(nowYear);
            		
            		if(time.equals("05")) {
            			sheetMethod.synchronization(sheetName); //변경필요
            			System.out.println(nowDate+" --- 시트 동기화");
            		}
                    
                }catch(Exception ex) {
                    ex.printStackTrace(); //or loggger would be better
                }
            }
        }, 0, 60, TimeUnit.MINUTES);
    }
      
    
    public void reportBackUp() throws GeneralSecurityException, IOException, Exception {
	       	Date nowTime = new Date();
	    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");
	    	String nowDate = sf.format(nowTime);
			excel.export(nowDate);
			DriveMethod.upload();
		}
}












