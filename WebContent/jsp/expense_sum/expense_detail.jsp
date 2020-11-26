<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">
<title>지출 상세 내역</title>

	<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		String team = request.getParameter("team");
		String year = request.getParameter("year");
		String semi = request.getParameter("semi");
		String com = request.getParameter("com");
		String sum = request.getParameter("sum");
		ExpendDAO expendDao = new ExpendDAO();
		ArrayList<Expend_TeamBean> expend_sure = expendDao.getExpend_sure(team, year);
		ArrayList<Expend_CoopBean> expend_coop = expendDao.getExpend_coop(team, Integer.parseInt(year));
		
	%>
</head>
<style>
	body{
		text-align:center;
	}
	#name{
		font-size:18px;
		word-break:break-all;
	}
	table{
		margin-left: auto;
		margin-right: auto;
		margin-top:20px;
		border : 1px solid;
	}
	th, td{
		padding:10px;
		border : 1px solid;
	}
</style>
<body>
	<br>
	<p id="name"><%=team%> - <%=semi%> 상세 지출 내역(<%=com%>)</p>
	<%
		if(com.equals("슈어")){%>
		<table  style="width: 100%">
			<thead>
				<tr>
					<th>이름</th>
					<th>직급</th>
					<th>직급 단가</th>
					<th>start</th>
					<th>end</th>
					<%
						if(semi.equals("상반기")){%>
						<th>상반기 MM</th>
						<th>상반기 지출</th>
					<%} else if(semi.equals("하반기")){%>
						<th>하반기 MM</th>
						<th>하반기 지출</th>
					<%}%>
				</tr>
			</thead>
			<tbody>
				
				<%
					for(int i=0; i<expend_sure.size(); i++){%>
					<tr>
						<td><%=expend_sure.get(i).getName() %></td>
						<td><%=expend_sure.get(i).getRank() %></td>
						<td><%=expend_sure.get(i).getExpend() %></td>
						<td><%=expend_sure.get(i).getStart() %></td>
						<td><%=expend_sure.get(i).getEnd() %></td>
						
						<%
							if(semi.equals("상반기")){%>
							<td><%=expend_sure.get(i).getFh_mm() %></td>
							<td><%=expend_sure.get(i).getFh_expend() %></td>
						<%} else if(semi.equals("하반기")){%>
							<td><%=expend_sure.get(i).getSh_mm() %></td>
							<td><%=expend_sure.get(i).getSh_expend() %></td>
						<%}%>			
					</tr>					
				<%}%>
				
				<tr style="b">
					<td style="background-color: yellowgreen">지출 합계</td>
					<td colspan=6><%=sum %> (만)</td>
				</tr>
			</tbody>
		</table>
			
		<%}else if(com.equals("외부")){%>
			<table  style="width: 100%">
				<thead>
					<tr>
						
						<th>이름</th>
						<th>투입 프로젝트</th>
						<th>소속</th>
						<th>직급</th>
						<%
							if(permission == 0){%>
								<th>상반기 지출</th>
						<%}%>
						<th>start</th>
						<th>end</th>
						<%
							if(semi.equals("상반기")){%>
							<th>상반기 MM</th>
							<%
								if(permission == 0){%>
									<th>상반기 지출</th>
							<%}
							
						} else if(semi.equals("하반기")){%>
							<th>하반기 MM</th>
							<%
								if(permission == 0){%>
									<th>하반기 지출</th>
							<%}}%>
					</tr>
				</thead>
				<tbody>
					
					<%
						for(int i=0; i<expend_coop.size(); i++){%>
						<tr>
							<td><%=expend_coop.get(i).getName() %></td>
							<td><%=expend_coop.get(i).getProjectName()%></td>
							<td><%=expend_coop.get(i).getPart() %></td>
							<td><%=expend_coop.get(i).getRank() %></td>
							<%
								if(permission == 0){%>
									<td><%=expend_coop.get(i).getExpend() %></td>
							<%}%>
							
							<td><%=expend_coop.get(i).getStart() %></td>
							<td><%=expend_coop.get(i).getEnd() %></td>
							<%
								if(semi.equals("상반기")){%>
								<td><%=expend_coop.get(i).getFh_mm() %></td>
								<%
								if(permission == 0){%>
									<td><%=expend_coop.get(i).getFh_ex() %></td>
								<%}%>
								
							<%} else if(semi.equals("하반기")){%>
								<td><%=expend_coop.get(i).getSh_mm() %></td>
								<%
								if(permission == 0){%>
									<td><%=expend_coop.get(i).getSh_ex() %></td>
								<%}%>
								
							<%}%>			
						</tr>					
					<%}%>
					
					<tr style="b">
						<td style="background-color: yellowgreen">지출 합계</td>
						<td colspan=8><%=sum %> (만)</td>
					</tr>
				</tbody>
			</table>
	<%}%>
	
</body>








</html>