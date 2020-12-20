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
	ProjectDAO projectDao = new ProjectDAO();
	int result = 0;
	
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
	if(pmDataNull == 1){
		script.print("<script> alert('PM인력의 시작과 종료가 입력되지 않았습니다.'); history.back();</script>");
	} else{
		result = projectDao.updatePM(no, PROJECT_MANAGER);
		if(result == 1){
			projectDao.deleteCareer(no,"1");
			projectDao.setCareer(PM_List, no, startPM, endPM, "1");
			script.print("<script> alert('수정되었습니다.'); location.href = 'project.jsp#state"+no+"'</script>");
		}else{
			script.print("<script> alert('실패하였습니다.'); location.href = 'project.jsp#state"+no+"' </script>");
		}
	}
%>
</body>
</html>