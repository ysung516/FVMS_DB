<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.PrintWriter"
	import="jsp.DB.method.*" 
	import="jsp.Bean.model.*"%>
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
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		int count = Integer.parseInt(request.getParameter("count"));
		
		String [] workPlace = new String[count];
		String [] color = new String[count];
		
		for(int i=0; i<count; i++){
			workPlace = request.getParameterValues("place");
			color = request.getParameterValues("color");
		}
		
		ManagerDAO managerDao = new ManagerDAO();
		
		managerDao.drop_PlaceTable();
		
		if(count != 0){
			if(managerDao.save_WorkPlace(workPlace, color, count) == count){
				script.print("<script> alert('근무지가 저장 되었습니다.'); location.href = 'manager.jsp'</script>");
			} else{
				script.print("<script> alert('저장 실패!!'); history.back();</script>");
			}
		} else{
			script.print("<script> alert('근무지가 초기화 됬습니다.'); location.href = 'manager.jsp'</script>");
		}
			
			

			
		
			
				
	
	%>
</body>
</html>