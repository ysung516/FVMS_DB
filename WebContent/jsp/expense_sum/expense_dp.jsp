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
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">
<title>주요 지출 내역</title>
	<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		
		String team = request.getParameter("team");
		int year = Integer.parseInt(request.getParameter("year"));
		String semi = request.getParameter("semi");
		String sum = request.getParameter("sum");
		
		int eq_semi = 0;
		if(semi.equals("상반기")){
			eq_semi = 0;
		} else if(semi.equals("하반기")){
			eq_semi = 1;
		}
		
		ExpendDAO expendDao = new ExpendDAO();
		ArrayList<MemberBean> memberList = expendDao.getMemberData(team);
		ArrayList<DPcostBean> FH_dpList = expendDao.getExpend_dp_FH(team, year);
		ArrayList<DPcostBean> SH_dpList = expendDao.getExpend_dp_SH(team, year);
		ArrayList<Eq_PurchaseBean> eqList = expendDao.getPurchaseList(team, year, eq_semi);
		ArrayList<Outside_ExpendBean> outexList = expendDao.getOutside_Expend(team, year, eq_semi);
		float eq_sum = 0;
		float outex_sum = 0;
		
		for(int i=0; i<eqList.size(); i++){
			eq_sum += eqList.get(i).getSum();
		}
		for(int i=0; i<outexList.size(); i++){
			outex_sum += outexList.get(i).getCost();
		}
		
		
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

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>
	
	function rowAdd(){
			count = $('#eqList tr').length;
			count++;
			var innerHtml = "";
			innerHtml += '<tr>';
			innerHtml += '<td>'+count+'</td>';
			innerHtml += '<td><input name="name"></td>';
			innerHtml += '<td><input type="date" name="date"></td>';
			innerHtml += '<td><input name="cost" value="0"></td>';
			innerHtml += '<td><input name="count" value="0"></td>';
			innerHtml += '<td></td>';
			innerHtml += '<td><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>';
			innerHtml += '</tr>';
			$('#eqList').append(innerHtml);
		}
		
	function deleteNP(){
		$(document).on("click",".deleteNP",function(){
			var str =""
			var tdArr = new Array();
			var btn = $(this);
			var tr = btn.parent().parent();
			var td = tr.children();
			var delID = td.eq(0).text();
			tr.remove();
			
			var len = $('#eqList tr').length;
			for(var a=0; a<=len; a++){
				$("#eqList tr:eq("+a+") td:eq(0)").text((a+1));
			}
		});
	}
	
	function rowAdd2(){
		count = $('#outexList tr').length;
		count++;
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td>'+count+'</td>';
		innerHtml += '<td><select name="id"><% for(int j=0; j<memberList.size(); j++){%><option value="<%=memberList.get(j).getID()%>"><%=memberList.get(j).getNAME()+" - "+memberList.get(j).getRANK() %></option><%}%></select></td>';
		innerHtml += '<td><input name="content"></td>';
		innerHtml += '<td><input type="date" name="date"></td>';
		innerHtml += '<td><input name="cost" value="0"></td>';
		innerHtml += '<td><input class="deleteNP2" type="button" onclick="deleteNP2()" value="삭제"></td>';
		innerHtml += '</tr>';
		$('#outexList').append(innerHtml);
	}
	
function deleteNP2(){
	$(document).on("click",".deleteNP2",function(){
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		var delID = td.eq(0).text();
		tr.remove();
		
		var len = $('#outexList tr').length;
		for(var a=0; a<=len; a++){
			$("#outexList tr:eq("+a+") td:eq(0)").text((a+1));
		}
	});
}
</script>
<body>
	<br>
	<p id="name"><%=team%> - <%=semi%> 파견 지출 내역</p>
		<table  style="width: 100%">
			<thead>
				<tr>
					<th>이름</th>
					<th>직급</th>
					<th>프로젝트</th>
					<th>근무지</th>
					<th>파견비용</th>
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
					if(semi.equals("상반기")){
						for(int i=0; i<FH_dpList.size(); i++){%>
						<tr>
							<td><%=FH_dpList.get(i).getName() %></td>
							<td><%=FH_dpList.get(i).getRank() %></td>
							<td><%=FH_dpList.get(i).getProject() %></td>
							<td><%=FH_dpList.get(i).getPlace() %></td>
							<td><%=FH_dpList.get(i).getCost() %></td>
							<td><%=FH_dpList.get(i).getStart() %></td>
							<td><%=FH_dpList.get(i).getEnd() %></td>
							<td><%=FH_dpList.get(i).getFh_mm() %></td>
							<td><%=FH_dpList.get(i).getFh_ex() %></td>
						</tr>					
					<%}
					} else if(semi.equals("하반기")){
						for(int i=0; i<FH_dpList.size(); i++){%>
						<tr>
							<td><%=SH_dpList.get(i).getName() %></td>
							<td><%=SH_dpList.get(i).getRank() %></td>
							<td><%=SH_dpList.get(i).getProject() %></td>
							<td><%=SH_dpList.get(i).getPlace() %></td>
							<td><%=SH_dpList.get(i).getCost() %></td>
							<td><%=SH_dpList.get(i).getStart() %></td>
							<td><%=SH_dpList.get(i).getEnd() %></td>
							<td><%=SH_dpList.get(i).getSh_mm() %></td>
							<td><%=SH_dpList.get(i).getSh_ex() %></td>								
						</tr>					
					<%}
					}%>
				
				<tr style="b">
					<td style="background-color: yellowgreen">지출 합계</td>
					<td colspan=8><%=sum %> (만)</td>
				</tr>
			</tbody>
		</table>
		
		<br><br><br>
		<form method="post" action="update_EqPro.jsp">
		<input type="hidden" name="team" value="<%=team%>">
		<input type="hidden" name="eq_semi" value="<%=eq_semi%>">
		<input type="hidden" name="year" value="<%=year%>">
		<input type="hidden" name="sum" value="<%=sum %>">
		<p id="name"><%=team%> - <%=semi%> 장비 구입 내역</p>
			<table  style="width: 100%">
				<thead>
					<tr>
						<th></th>
						<th>장비</th>
						<th>구입날짜</th>
						<th>단가</th>
						<th>수량</th>
						<th>금액(만)</th>
						<th><input type="button" value="+"  class="btn btn-primary" onclick="rowAdd();"></th>
					</tr>
				</thead>
				<tbody id ="eqList">
					<%
						for(int i=0; i<eqList.size(); i++){%>
						<tr>
							<td><%=i+1%></td>
							<td><input name="name" value="<%=eqList.get(i).getName()%>"></td>
							<td><input type="date" name="date" value="<%=eqList.get(i).getDate()%>"></td>
							<td><input name="cost" value="<%=eqList.get(i).getCost()%>"></td>
							<td><input name="count" value="<%=eqList.get(i).getCount()%>"></td>
							<td><%=eqList.get(i).getSum() %></td>
							<td><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>
						</tr>					
					<%}%>
				</tbody>
				<tfoot>
					<tr style="b">
						<td style="background-color: yellowgreen">지출 합계</td>
						<td colspan=8><%=eq_sum%> (만)</td>
					</tr>
				</tfoot>
			</table>
				<%
					if(permission == 0){%>
						<input style="margin-top: 15px" type="submit" class="btn btn-primary" value="저장">
				<%}%>
				
			</form>
			
			
			
			<br><br><br>
			<form method="post" action="update_outexPro.jsp">
				<input type="hidden" name="team" value="<%=team%>">
				<input type="hidden" name="eq_semi" value="<%=eq_semi%>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="sum" value="<%=sum %>">
				<p id="name"><%=team%> - <%=semi%> 외근 비용 처리 내역</p>
					<table  style="width: 100%">
						<thead>
							<tr>
								<th></th>
								<th>이름</th>
								<th>외근 처리</th>
								<th>날짜</th>
								<th>금액(만)</th>
								<th><input type="button" value="+"  class="btn btn-primary" onclick="rowAdd2();"></th>
							</tr>
						</thead>
						<tbody id ="outexList">
							<%
								for(int i=0; i<outexList.size(); i++){%>
								<tr>
									<td><%=i+1%></td>
									<td><select name="id">
										<%
											for(int j=0; j<memberList.size(); j++){
												if(outexList.get(i).getId().equals(memberList.get(j).getID())){%>
													<option value="<%=memberList.get(j).getID()%>" selected><%=memberList.get(j).getNAME()+" - "+memberList.get(j).getRANK() %></option>
												<%} else{%>
													<option value="<%=memberList.get(j).getID()%>"><%=memberList.get(j).getNAME()+" - "+memberList.get(j).getRANK() %></option>
												<%}%>
												
										<%} %>
									</select></td>
									<td><input name="content" value="<%=outexList.get(i).getContent()%>"></td>
									<td><input type="date" name="date" value="<%=outexList.get(i).getDate()%>"></td>
									<td><input name="cost" value="<%=outexList.get(i).getCost()%>"></td>
									<td><input class="deleteNP2" type="button" onclick="deleteNP2()" value="삭제"></td>
								</tr>					
							<%}%>
						</tbody>
						<tfoot>
							<tr style="b">
								<td style="background-color: yellowgreen">지출 합계</td>
								<td colspan=7><%=outex_sum%> (만)</td>
							</tr>
						</tfoot>
					</table>
						<%
							if(permission == 0){%>
								<input style="margin-top: 15px" type="submit" class="btn btn-primary" value="저장">
					<%}%>	
			</form>
</body>








</html>