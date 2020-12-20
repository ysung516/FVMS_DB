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
	ProjectDAO projectDao = new ProjectDAO();
	int result = 0;

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

	if(workDataNull == 1){
		script.print("<script> alert('투입인력의 시작과 종료가 입력되지 않았습니다.'); history.back();</script>");
	}else{
		result = projectDao.updateWorker(no, P_WORKER_LIST);
		if(result == 1){
			projectDao.deleteCareer(no,"0");
			projectDao.setCareer(WORKER_LIST, no, start, end, "0");
			script.print("<script> alert('수정되었습니다.'); location.href = 'project.jsp#state"+no+"'</script>");
		}else{
			script.print("<script> alert('실패하였습니다.'); location.href = 'project.jsp#state"+no+"' </script>");
		}
	}
	
%>
</body>
</html>