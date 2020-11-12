<%@page import="org.apache.catalina.valves.rewrite.RewriteCond"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.HashMap"%>
<!DOCTYPE html>
<html>
<%	
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*60);
	
	String team = request.getParameter("team");
	String time = request.getParameter("time");
	
	SummaryDAO summaryDao = new SummaryDAO();
	
	//매출 보정 변수
	ArrayList<CMSBean> plus = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_chassis = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_body = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_control = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_safe = new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_auto =new ArrayList<CMSBean>();
	ArrayList<CMSBean> minus_vt = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_chassis = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_body = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_control = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_safe = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_auto = new ArrayList<CMSBean>();
	ArrayList<CMSBean> plus_vt = new ArrayList<CMSBean>();
	
	//Rank 기준
	HashMap<String, Integer> rank = summaryDao.getRank();
	
	if(!(team.equals("Total"))){
		plus = summaryDao.getCMS_plusList(team);
		minus = summaryDao.getCMS_minusList(team);
	} else{
	// 팀별 보정
		minus_chassis = summaryDao.getCMS_minusList("샤시힐스검증팀");
		minus_body = summaryDao.getCMS_minusList("바디힐스검증팀");
		minus_control = summaryDao.getCMS_minusList("제어로직검증팀");
		minus_safe = summaryDao.getCMS_minusList("기능안전검증팀");
		minus_auto = summaryDao.getCMS_minusList("자율주행검증팀");
		minus_vt = summaryDao.getCMS_minusList("미래차검증전략실");
	
		plus_chassis = summaryDao.getCMS_plusList("샤시힐스검증팀");
		plus_body = summaryDao.getCMS_plusList("바디힐스검증팀");
		plus_control = summaryDao.getCMS_plusList("제어로직검증팀");
		plus_safe = summaryDao.getCMS_plusList("기능안전검증팀");
		plus_auto = summaryDao.getCMS_plusList("자율주행검증팀");
		plus_vt = summaryDao.getCMS_plusList("미래차검증전략실");
	}

%>
<head>
<meta charset="UTF-8">
<title><%=team %> 매출 보정 상세 내역</title>
</head>

<style>
	#plusTable, #minusTable, #plusTableT, #minusTableT, #allData{
		width: 100%;
    	border-collapse: collapse;
    	margin-bottom: 10px;
		table-layout:fixed;
	}
	th, td{
		font-size: small;
		padding : 10px;
		border: 1px solid black;
		overflow: hidden;
		white-space: nowrap;
	}
	.none{
		text-align: center;
		font-weight: bold;
	}
	.caption{
		margin-bottom: 10px;
		font-weight: bold;
		caption-side: top;
	}
	.captionP{
		color: #4798bf;
	}
	.captionM{
		color: red;
	}
	.headerP{
		background-color: #5bb8e4ad;
	}
	.headerM{
		background-color: #e28989ad;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.0.min.js" ></script>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script src="https://code.jquery.com/jquery.min.js"></script>
<script>
	function tableCheck(){
		console.log($('#minusTableT td').length);
		console.log($('#minusTable td').length)
		if($('#minusTableT td').length == 0 && $('#minusTable td').length == 0){
			$('#minusTableT').css('display', 'none');
			$('#minusTable').css('display', 'none');
			$('#minusP').css('display', 'block');
		}
		if($('#plusTableT td').length == 0 && $('#plusTable td').length == 0){
			$('#plusTableT').css('display', 'none');
			$('#plusTable').css('display', 'none');
			$('#plusP').css('display', 'block');
		}
	}
	
	$(document).ready(function(){
		tableCheck();
	});
</script>

<body>
	<h3 id="h3" style="text-align: center; margin-bottom: 30px;"><%=team %> 매출 보정 상세 내역</h3>
	<div>
		<div>
			<table id="allData">
				<thead>
					<tr>
						<th>매출 달성</th>
						<th>매출 달성 보정</th>
						<th>추가 매출 총합</th>
						<th>삭제 매출 총합</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<%if(!(team.equals("Total")) && plus.size() != 0){ %>
		<div>
			<table id="plusTable">
				<caption class="caption captionP">추가된 매출 내역</caption>
				<thead id="plusTableH" class="header headerP">
					<tr>
						<th style="width:7%">이름</th>
						<th>소속팀</th>
						<th>매출팀</th>
						<th style="width:30%">프로젝트명</th>
						<th style="width:5%">직급</th>
						<th style="width:9%">시작일</th>
						<th style="width:9%">종료일</th>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<th>상반기</th>
						<th>월수(상)</th>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<th>하반기</th>
						<th>월수(하)</th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<%for(CMSBean cms : plus){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<%}else if(team.equals("Total") && (plus_chassis.size() != 0 || plus_body.size() != 0 || 
					plus_control.size() != 0 || plus_safe.size() != 0 || 
					plus_auto.size() != 0 || plus_vt.size() != 0)){%>
		<div>
			<table id="plusTableT">
				<caption class="caption captionP">추가된 매출 내역</caption>
				<thead id="plusTableH" class="header headerP">
					<tr>
						<th style="width:7%">이름</th>
						<th>소속팀</th>
						<th>매출팀</th>
						<th style="width:30%">프로젝트명</th>
						<th style="width:5%">직급</th>
						<th style="width:9%">시작일</th>
						<th style="width:9%">종료일</th>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<th>상반기</th>
						<th>월수(상)</th>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<th>하반기</th>
						<th>월수(하)</th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<%for(CMSBean cms : plus_chassis){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : plus_body){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : plus_control){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : plus_safe){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : plus_auto){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : plus_vt){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="+" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="+" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<%}%>
		<p class="none" id="plusP" style="display:none">*****추가된 매출 없음*****</p>
		<%
		if(!(team.equals("Total")) && minus.size() != 0){%>
		<div>
			<table id="minusTable">
				<caption class="caption captionM">삭제된 매출 내역</caption>
				<thead id="minusTableH" class="header headerM">
					<tr>
						<th style="width:7%">이름</th>
						<th>소속팀</th>
						<th>매출팀</th>
						<th style="width:30%">프로젝트명</th>
						<th style="width:5%">직급</th>
						<th style="width:9%">시작일</th>
						<th style="width:9%">종료일</th>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<th>상반기</th>
						<th>월수(상)</th>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<th>하반기</th>
						<th>월수(하)</th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<%for(CMSBean cms : minus){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<%}else if(team.equals("Total") && (minus_chassis.size() != 0 || minus_body.size() != 0 || 
				minus_control.size() != 0 || minus_safe.size() != 0 || 
				minus_auto.size() != 0 || minus_vt.size() != 0)){%>
		<div>
			<table id="minusTableT">
				<caption class="caption captionM">삭제된 매출 내역</caption>
				<thead id="minusTableH" class="header headerM">
					<tr>
						<th style="width:7%">이름</th>
						<th>소속팀</th>
						<th>매출팀</th>
						<th style="width:30%">프로젝트명</th>
						<th style="width:5%">직급</th>
						<th style="width:9%">시작일</th>
						<th style="width:9%">종료일</th>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<th>상반기</th>
						<th>월수(상)</th>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<th>하반기</th>
						<th>월수(하)</th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<%for(CMSBean cms : minus_chassis){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : minus_body){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : minus_control){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : minus_safe){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : minus_auto){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
					<%for(CMSBean cms : minus_vt){
						if((time.equals("상반기") && cms.getFH_MM_CMS()==0.0) || 
								(time.equals("하반기") && cms.getSH_MM_CMS()==0.0) || 
								(time.equals("연간") && cms.getFH_MM_CMS()==0.0 && cms.getSH_MM_CMS()==0.0)){
							continue;
						}%>
					<tr>
						<td><%=cms.getName() %></td>
						<td><%=cms.getTeam() %></td>
						<td><%=cms.getSalesTeam() %></td>
						<td><%=cms.getProjectName() %></td>
						<td><%=cms.getRank() %></td>
						<td><%=cms.getStart() %></td>
						<td><%=cms.getEnd() %></td>
						<%if(time.equals("상반기") || time.equals("연간")){ %>
						<td><%="-" + cms.getFH_MM_CMS() %></td>
						<td><%=cms.getFH_MM() %></td>
						<%}
						if(time.equals("하반기") || time.equals("연간")){%>
						<td><%="-" + cms.getSH_MM_CMS() %></td>
						<td><%=cms.getSH_MM() %></td>
						<%} %>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		<%}%>
		<p class="none" id="minusP" style="display:none;">*****삭제된 매출 없음*****</p>
	</div>
</body>
</html>