package com.servlet.listener;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import jsp.smtp.method.PostMan;

public class Scheduler {
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public void startScheduleTask() {
    final ScheduledFuture<?> taskHandle = scheduler.scheduleAtFixedRate(
        new Runnable() {
            public void run() {
                try {
//                	PostMan post = new PostMan();
//                	post.post();
                    getDataFromDatabase();
                    
                }catch(Exception ex) {
                    ex.printStackTrace(); //or loggger would be better
                }
            }
        }, 0, 10, TimeUnit.SECONDS);
    }

    private void getDataFromDatabase() {
        System.out.println("getting data...");
    }
    
    
    public long calcTaskTime(int startTime) {

        if(startTime > 23 || startTime < 0){
            return 0;
        }
        Calendar calendar = new GregorianCalendar(Locale.KOREA);
        calendar.set(Calendar.HOUR_OF_DAY, startTime);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);

        long nowDate = new Date().getTime();

        if (nowDate > calendar.getTime().getTime()) {
            calendar.add(Calendar.DAY_OF_YEAR, 1);
        }
        long waiting = (calendar.getTime().getTime() - nowDate)/1000;

        return (int)waiting;
    }
}