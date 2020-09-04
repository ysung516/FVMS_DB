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

import jsp.DB.method.ReportDAO;
import jsp.smtp.method.ExcelExporter;
import jsp.smtp.method.PostMan;

public class Scheduler {
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    
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
            		}
                    
                }catch(Exception ex) {
                    ex.printStackTrace(); //or loggger would be better
                }
            }
        }, 0, 60, TimeUnit.MINUTES);
    }
    
    public void reportBackUp() throws GeneralSecurityException, IOException, Exception {
    	
    	PostMan post = new PostMan();
		ExcelExporter excel = new ExcelExporter();
		ReportDAO reportDao = new ReportDAO();

		reportDao.deleteAllbackUp();
		reportDao.backUp();
		excel.export();
		DriveMethod.upload();
		reportDao.deleteAllreport();
	}
}