package com.servlet.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class servletListener implements ServletContextListener{
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
		Scheduler ste = new Scheduler();
        ste.startScheduleTask();
        ste.projectUpdate();
	}
	
}
