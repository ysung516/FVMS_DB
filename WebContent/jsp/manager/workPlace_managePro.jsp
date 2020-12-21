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
		int year = Integer.parseInt(request.getParameter("year"));
		
		String [] workPlace = new String[count];
		String [] color = new String[count];
		String [] cost = new String[count];
		int [] order = new int[count];
		
		workPlace = request.getParameterValues("place");
		color = request.getParameterValues("color");
		cost = request.getParameterValues("cost");
		for(int i=0; i<count; i++){
			order[i] = Integer.parseInt(request.getParameterValues("order")[i]);
		}
		
		ManagerDAO managerDao = new ManagerDAO();

		managerDao.drop_PlaceTable(year);

		if(count != 0){
			if(managerDao.save_WorkPlace(workPlace, color, cost, count ,year,order) == count){
				script.print("<script> alert('근무지가 저장 되었습니다.'); location.href = 'workPlace_manage.jsp?year="+year+"'</script>");
			} else{
				script.print("<script> alert('저장 실패!!'); history.back();</script>");
			}
		} else if(count == 0){
			script.print("<script> alert('근무지가 초기화 됬습니다.'); location.href = 'workPlace_manage.jsp?year="+year+"'</script>");
		} else{
			script.print("<script> alert('저장 실패!!'); location.href = 'manager.jsp'</script>");
		}

	%>
</body>
</html>