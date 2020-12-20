<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.Bean.model.*"
	import="java.io.PrintWriter" import="jsp.DB.method.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		String sessionID = (String)session.getAttribute("sessionID");
		
		
		if(request.getParameter("MAN_MONTH") == "" || request.getParameter("PROJECT_DESOPIT") == "" || request.getParameter("FH_ORDER") == "" ||
				request.getParameter("FH_SALES_PROJECTIONS") == "" || request.getParameter("FH_SALES") == "" || 
				request.getParameter("SH_ORDER") == ""|| request.getParameter("SH_SALES_PROJECTIONS") == "" || 
				request.getParameter("SH_SALES") == "" || request.getParameter("EMPLOY_DEMAND") == "" || request.getParameter("OUTSOURCE_DEMAND") == ""){
			script.print("<script> alert('수정 실패!!'); history.back();</script>");
		}
		
		  ProjectDAO projectDao = new ProjectDAO();
		  String TEAM_SALES = request.getParameter("team_sales");
		  String TEAM_ORDER = request.getParameter("team_order");
		  String RPOJECT_CODE = request.getParameter("PROJECT_CODE");
		  String PROJECT_NAME = request.getParameter("PROJECT_NAME");
		  String STATE = request.getParameter("STATE");
		  String PART = request.getParameter("PART");
		  String CLIENT = request.getParameter("CLIENT");
		  String CLIENT_PART = request.getParameter("CLIENT_PART");
		  float MAN_MONTH = Float.valueOf(request.getParameter("MAN_MONTH"));
		  float PROJECT_DESOPIT = Float.valueOf(request.getParameter("PROJECT_DESOPIT"));
		  float FH_ORDER_PROJECTIONS = Float.valueOf(request.getParameter("FH_ORDER_PROJECTIONS"));
		  float FH_ORDER = Float.valueOf(request.getParameter("FH_ORDER")); 
		  float FH_SALES_PROJECTIONS = Float.valueOf(request.getParameter("FH_SALES_PROJECTIONS")); 
		  float FH_SALES = Float.valueOf(request.getParameter("FH_SALES"));
		  float SH_ORDER_PROJECTIONS = Float.valueOf(request.getParameter("SH_ORDER_PROJECTIONS")); 
		  float SH_ORDER = Float.valueOf(request.getParameter("SH_ORDER"));
		  float SH_SALES_PROJECTIONS = Float.valueOf(request.getParameter("SH_SALES_PROJECTIONS"));
		  float SH_SALES = Float.valueOf(request.getParameter("SH_SALES"));
		  String PROJECT_START = request.getParameter("PROJECT_START");
		  String PROJECT_END = request.getParameter("PROJECT_END");
		  String CLIENT_PTB = request.getParameter("CLIENT_PTB");
		  String WORK_PLACE = request.getParameter("WORK_PLACE");
		  String WORK = request.getParameter("WORK");
		  String PROJECT_MANAGER = request.getParameter("PROJECT_MANAGER");
		  String ASSESSMENT_TYPE = request.getParameter("ASSESSMENT_TYPE");
		  float EMPLOY_DEMAND = Float.valueOf(request.getParameter("EMPLOY_DEMAND"));
		  float OUTSOURCE_DEMAND = Float.valueOf(request.getParameter("OUTSOURCE_DEMAND"));
		  int REPORT_CHECK = Integer.parseInt(request.getParameter("reportCheck"));
		  int RESULT_REPORT = Integer.parseInt(request.getParameter("sheetCheck"));
		  int NO = Integer.parseInt(request.getParameter("NO"));
		  int year = Integer.parseInt(request.getParameter("year"));
		  String copy = request.getParameter("copyCheck");

		  
		  String [] WORKER_LIST;
		  String [] start;
		  String [] end;		  
		  if(request.getParameterValues("WORKER_LIST") != null){
			  WORKER_LIST = request.getParameterValues("WORKER_LIST");
			  start = request.getParameterValues("start");
			  end = request.getParameterValues("end");
		  } else {
			  WORKER_LIST = new String[0];
			  start = new String[0];
			  end = new String[0];
		  }
		  String P_WORKER_LIST =""; 
		  int workDataNull = 0;
		  for(int i=0; i<WORKER_LIST.length; i++){
			  P_WORKER_LIST += WORKER_LIST[i]+" ";
			  
			  if(start[i].equals("") || end[i].equals("")){
				  workDataNull = 1;
			  }
		  }
	
		  
		  String [] PM_List;
		  String [] startPM;
		  String [] endPM;
		  if (request.getParameterValues("WORKER_LIST_PM") != null){
			  PM_List = request.getParameterValues("WORKER_LIST_PM");
			  startPM = request.getParameterValues("startPM");
			  endPM = request.getParameterValues("endPM");
		  } else {
			  PM_List = new String[0];
			  startPM = new String[0];
			  endPM = new String[0];
		  }
		  
		  int pmDataNull = 0;
		  for(int i=0; i<PM_List.length; i++){
			  if(startPM[i].equals("") || endPM[i].equals("")){
				  pmDataNull = 1;
			  }
		  }
		  
		if(PROJECT_NAME ==null || PROJECT_NAME == ""){
			script.print("<script> alert('*표시 부분은 반드시 작성해야 합니다..'); history.back();</script>");
		} else{
			if(pmDataNull == 1){
				script.print("<script> alert('PM인력의 시작과 종료가 입력되지 않았습니다.'); history.back();</script>");
			}else {
				if(workDataNull == 1){
					script.print("<script> alert('투입인력의 시작과 종료가 입력되지 않았습니다.'); history.back();</script>");
				}else{
					if(projectDao.updateProject(TEAM_ORDER, TEAM_SALES, RPOJECT_CODE, PROJECT_NAME, STATE, PART, CLIENT, 
							CLIENT_PART, MAN_MONTH, PROJECT_DESOPIT, FH_ORDER_PROJECTIONS,FH_ORDER, FH_SALES_PROJECTIONS, FH_SALES, 
							SH_ORDER_PROJECTIONS, SH_ORDER, SH_SALES_PROJECTIONS, SH_SALES, PROJECT_START, PROJECT_END, CLIENT_PTB, WORK_PLACE, 
							WORK, PROJECT_MANAGER, P_WORKER_LIST, ASSESSMENT_TYPE, EMPLOY_DEMAND, OUTSOURCE_DEMAND, REPORT_CHECK, RESULT_REPORT, NO, year,copy) == 1){
						projectDao.deleteCareer(NO,"1");
						projectDao.deleteCareer(NO,"0");
						projectDao.setCareer(PM_List, NO, startPM, endPM, "1");
						projectDao.setCareer(WORKER_LIST, NO, start, end, "0");
						
						if(STATE.equals("8.Dropped")){
							projectDao.projectDropped(NO);
						}
						script.print("<script> alert('프로젝트가 수정되었습니다.'); location.href = 'project.jsp'</script>");
					}
					else {
						script.print("<script> alert('수정 실패!!'); history.back();</script>");
					}
				}
			}
		}
		
	%>
</body>
</html>