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
	
	int no = Integer.parseInt(request.getParameter("no"));
	String PROJECT_MANAGER = request.getParameter("PROJECT_MANAGER");
	
	  String PM_LIST = request.getParameter("WORKER_LIST_PM").trim()+" ";
	  int pm_cnt = PM_LIST.split(" ").length;
	
	  String [] workerListPM = new String[pm_cnt];
	  String []startPM = new String[pm_cnt];
	  String []endPM = new String[pm_cnt];
	  for(int i=0; i<pm_cnt; i++){
		  workerListPM[i] = PM_LIST.split(" ")[i];
		  startPM[i] = request.getParameter(workerListPM[i]+"/startPM");
		  endPM[i] = request.getParameter(workerListPM[i]+"/endPM");
	  }
	
	ProjectDAO projectDao = new ProjectDAO();
	int result = 0;
	result = projectDao.updatePM(no, PROJECT_MANAGER);
	if(result == 1){
		projectDao.deleteCareer(no,"1");
		projectDao.setCareer(workerListPM, no, startPM, endPM, "1");
		script.print("<script> alert('수정되었습니다.'); location.href = 'project.jsp#state"+no+"'</script>");
	}else{
		script.print("<script> alert('실패하였습니다.'); location.href = 'project.jsp#state"+no+"' </script>");
	}
%>
</body>
</html>