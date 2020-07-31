<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="jsp.Bean.model.MSC_Bean"
    import = "java.io.PrintWriter"
    import = "jsp.DB.method.*"
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
		MSC_DAO method = new MSC_DAO();
		PrintWriter script =  response.getWriter();
		String sessionID = session.getAttribute("sessionID").toString();
		String date = request.getParameter("date");
		String no = request.getParameter("num");
		int num = method.returnNo(sessionID, date);
		
		String amPlace = request.getParameter("amPlace");
		String pmPlace = request.getParameter("pmPlace");
		
		if(amPlace == "" && pmPlace == ""){
			no = Integer.toString(method.returnNo(sessionID, date));
			MSC_Bean mb = new MSC_Bean();
			mb = method.getMSCList_set(Integer.parseInt(no));
			amPlace = mb.getAMplace();
			pmPlace = mb.getPMplace();
		}
		
		%>
		<form id="GoAdd" name="GoAdd"method="post" action="manager_schedule_add.jsp">
			<input type="hidden" name = "date" value="<%=date%>"/>
			</form>
		<form id="GoUpdate" name="GoUpdate" method="post" action="manager_schedule_update.jsp">
			<input type="hidden" name = "date" value="<%=date%>"/>
			<input type="hidden" name = "num" value="<%=no%>"/>
			<input type="hidden" name = "amPlace" value="<%=amPlace%>"/>
			<input type="hidden" name = "pmPlace" value="<%=pmPlace%>"/>
		</form>
		<%
		if(num == 0){
			%>
				<script>document.GoAdd.submit();</script>
			<%	
		} else {
			%>
				<script>
						// 시트에서 해당날짜 아이디 검색해서 amPlace,pmPlace 가져오기
						document.GoUpdate.submit();
				</script>
			<%	
		}
	%>
	

</body>
</html>