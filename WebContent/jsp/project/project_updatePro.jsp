<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "jsp.Bean.model.*"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"%>
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
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		String sessionID = (String)session.getAttribute("sessionID");
		
		
		if(request.getParameter("MAN_MONTH") == "" || request.getParameter("PROJECT_DESOPIT") == "" || request.getParameter("FH_ORDER") == "" ||
				request.getParameter("FH_SALES_PROJECTIONS") == "" || request.getParameter("FH_SALES") == "" || 
				request.getParameter("SH_ORDER") == ""|| request.getParameter("SH_SALES_PROJECTIONS") == "" || 
				request.getParameter("SH_SALES") == "" || request.getParameter("EMPLOY_DEMAND") == "" || request.getParameter("OUTSOURCE_DEMAND") == ""){
			script.print("<script> alert('등록 실패!!'); history.back();</script>");
		}
		
		ProjectDAO projectDao = new ProjectDAO();
		String TEAM = request.getParameter("team");
		String RPOJECT_CODE = request.getParameter("PROJECT_CODE");
		String PROJECT_NAME = request.getParameter("PROJECT_NAME");
		String STATE = request.getParameter("STATE");
		String PART = request.getParameter("PART");
		System.out.print(PART);
		String CLIENT = request.getParameter("CLIENT");
		String CLIENT_PART = request.getParameter("CLIENT_PART");
		float MAN_MONTH = Float.valueOf(request.getParameter("MAN_MONTH"));
		float PROJECT_DESOPIT = Float.valueOf(request.getParameter("PROJECT_DESOPIT"));
		float FH_ORDER = Float.valueOf(request.getParameter("FH_ORDER")); 
		float FH_SALES_PROJECTIONS = Float.valueOf(request.getParameter("FH_SALES_PROJECTIONS")); 
		float FH_SALES = Float.valueOf(request.getParameter("FH_SALES"));
		float SH_ORDER = Float.valueOf(request.getParameter("SH_ORDER"));
		float SH_SALES_PROJECTIONS = Float.valueOf(request.getParameter("SH_SALES_PROJECTIONS"));
		float SH_SALES = Float.valueOf(request.getParameter("SH_SALES"));
		String PROJECT_START = request.getParameter("PROJECT_START");
		String PROJECT_END = request.getParameter("PROJECT_END");
		String CLIENT_PTB = request.getParameter("CLIENT_PTB");
		String WORK_PLACE = request.getParameter("WORK_PLACE");
		String WORK = request.getParameter("WORK");
		String PROJECT_MANAGER = request.getParameter("PROJECT_MANAGER");
		String WORKER_LIST = request.getParameter("WORKER_LIST2");
		String ASSESSMENT_TYPE = request.getParameter("ASSESSMENT_TYPE");
		float EMPLOY_DEMAND = Float.valueOf(request.getParameter("EMPLOY_DEMAND"));
		float OUTSOURCE_DEMAND = Float.valueOf(request.getParameter("OUTSOURCE_DEMAND"));
		
		if(TEAM == null || TEAM =="" || RPOJECT_CODE == null || RPOJECT_CODE == "" || PROJECT_NAME ==null || PROJECT_NAME == ""|| PROJECT_MANAGER ==null || PROJECT_MANAGER == ""){
			script.print("<script> alert('*표시 부분은 반드시 작성해야 합니다..'); history.back();</script>");
		} else{
			
			if(projectDao.updateProject(TEAM, RPOJECT_CODE, PROJECT_NAME, STATE, PART, CLIENT, 
					CLIENT_PART, MAN_MONTH, PROJECT_DESOPIT, FH_ORDER, FH_SALES_PROJECTIONS, FH_SALES, 
					SH_ORDER, SH_SALES_PROJECTIONS, SH_SALES, PROJECT_START, PROJECT_END, CLIENT_PTB, WORK_PLACE, 
					WORK, PROJECT_MANAGER, WORKER_LIST, ASSESSMENT_TYPE, EMPLOY_DEMAND, OUTSOURCE_DEMAND) == 1){
				script.print("<script> alert('프로젝트가 수정되었습니다.'); location.href = 'project.jsp'</script>");
			}
				else script.print("<script> alert('등록 실패!!'); history.back();</script>");
		}
		
	
		
		
		
	%>
</body>
</html>