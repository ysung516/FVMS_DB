package com.servlet.listener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import jsp.smtp.method.PostMan;

public class servletListener implements ServletContextListener{
	String name = this.getClass().getName();
	PostMan post = new PostMan();
	// 웹 종료시
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		System.out.println("종료");
	}

	// 웹 시작시
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		System.out.println("시작");
		System.out.println(name);
		
//		Scheduler ste = new Scheduler();
//        ste.startScheduleTask();
	}
	
}
