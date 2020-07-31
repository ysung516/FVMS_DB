<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		PrintWriter script =  response.getWriter();
		String date = request.getParameter("DATE");
		
		String AMother = "미입력";
		String PMother = "미입력";
		String level;
		
		if(!(request.getParameter("amselboxDirect") == "")){
			AMother = request.getParameter("amselboxDirect");	
		}
		
		if(!(request.getParameter("pmselboxDirect") == "")){
			PMother = request.getParameter("pmselboxDirect");	
		}
		
		
		String AmPlace = request.getParameter("amPlaceSel");
		if(AmPlace != null && AmPlace.equals("기타")){
			AmPlace = AMother;
		}
		
		String PmPlace = request.getParameter("pmPlaceSel");
		if(PmPlace != null && PmPlace.equals("기타")){
			PmPlace = PMother;
		}
	
		
		if(sessionName.equals("유영민")){
			level = "1";
		} else if (sessionName.equals("송우람")){
			level = "2";
		} else if (sessionName.equals("최인석")){
			level = "3";
		} else if (sessionName.equals("이창우")){
			level = "4";
		} else if (sessionName.equals("윤영산")){
			level = "5";
		} else if (sessionName.equals("이창수")){
			level = "6";
		} else {
			level = "1000";
		}
		
		
		sheetMethod method = new sheetMethod();
		String num = method.doubleCheck(sessionID, date);
		method.saveUser_info(sessionID);
		String team = method.getMember().getTEAM();
		if(num.equals("")){
			if (method.insert_MSC(sessionID, AmPlace, PmPlace, date, team, sessionName, level) == 1){
				script.print("<script> alert('일정이 추가 됬습니다.'); location.href = 'manager_schedule.jsp'</script>");
			} else script.print("<script> alert('일정을 모두 입력해주세요.'); history.back(); </script>");
		}
		else{ 
			if(method.update_MSC(num, AmPlace, PmPlace, date) == 1){
			 script.print("<script> alert('일정이 수정되었습니다.'); location.href = 'manager_schedule.jsp'; </script>");
			} else script.print("<script> alert('수정되지 않았습니다.'); history.back(); </script>");
		}
	%>
</body>
</html>