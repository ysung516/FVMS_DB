<%@page import="org.apache.catalina.valves.rewrite.RewriteCond"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.HashMap"
	import="java.util.LinkedHashMap"%>
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
	session.setMaxInactiveInterval(60*240);
	
	String team = request.getParameter("team");
	String time = request.getParameter("time");
	float sale = Float.parseFloat(request.getParameter("sale"));
	float saleSet = Float.parseFloat(request.getParameter("saleSet"));
	String year = request.getParameter("year");
	
	SummaryDAO summaryDao = new SummaryDAO();
	HashMap<String, Integer> rank = summaryDao.getRank();	// 직급별 기준
	MemberDAO memberDAO = new MemberDAO();
	LinkedHashMap<Integer, String> teamList = memberDAO.getTeam();	// 팀 리스트
	
	//매출 보정 변수
	HashMap<String, HashMap<String, ArrayList<CMSBean>>> setVal = new HashMap<String, HashMap<String, ArrayList<CMSBean>>>();
	for(int key : teamList.keySet()){
		HashMap<String, ArrayList<CMSBean>> pANDm = new HashMap<String, ArrayList<CMSBean>>();
		pANDm.put("plus", summaryDao.getCMS_plusList(teamList.get(key), year));
		pANDm.put("minus", summaryDao.getCMS_minusList(teamList.get(key), year));
		setVal.put(teamList.get(key), pANDm);
	}
	
	float totalPlus = 0;
	float totalMinus = 0;
	if(!(team.equals("Total"))){
		if(time.equals("상반기")){
			for(CMSBean cms : setVal.get(team).get("plus")){
				totalPlus += cms.getFH_MM_CMS();
			}
			for(CMSBean cms : setVal.get(team).get("minus")){
				totalMinus += cms.getFH_MM_CMS();
			}
		}else if(time.equals("하반기")){
			for(CMSBean cms : setVal.get(team).get("plus")){
				totalPlus += cms.getSH_MM_CMS();
			}
			for(CMSBean cms : setVal.get(team).get("minus")){
				totalMinus += cms.getSH_MM_CMS();
			}
		}else if(time.equals("연간")){
			for(CMSBean cms : setVal.get(team).get("plus")){
				totalPlus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
			}
			for(CMSBean cms : setVal.get(team).get("minus")){
				totalMinus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
			}
		}
	}else{
		for(int key : teamList.keySet()){
			if(time.equals("상반기")){
				for(CMSBean cms : setVal.get(teamList.get(key)).get("plus")){
					totalPlus += cms.getFH_MM_CMS();
				}
				for(CMSBean cms : setVal.get(teamList.get(key)).get("minus")){
					totalMinus += cms.getFH_MM_CMS();
				}
			}else if(time.equals("하반기")){
				for(CMSBean cms : setVal.get(teamList.get(key)).get("plus")){
					totalPlus += cms.getSH_MM_CMS();
				}
				for(CMSBean cms : setVal.get(teamList.get(key)).get("minus")){
					totalMinus += cms.getSH_MM_CMS();
				}
			}else if(time.equals("연간")){
				for(CMSBean cms : setVal.get(teamList.get(key)).get("plus")){
					totalPlus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
				}
				for(CMSBean cms : setVal.get(teamList.get(key)).get("minus")){
					totalMinus += cms.getFH_MM_CMS() + cms.getSH_MM_CMS();
				}
			}
		}
	}

%>
<head>
<meta charset="UTF-8">
<title><%=time%> <%=team %> 매출 보정 상세 내역</title>
</head>

<style>
	#plusTable, #minusTable, #plusTableT, #minusTableT, #allData{
		width: 100%;
    	border-collapse: collapse;
		table-layout:fixed;
		margin-bottom: 30px;
	}
	#allData{
		text-align: center;
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
	<h3 id="h3" style="text-align: center; margin-bottom: 30px;"><%=time%> <%=team %> 매출 보정 상세 내역</h3>
	<div>
		<div>
			<table id="allData">
				<thead>
					<tr style="background-color: #bde8ae;">
						<th>매출 달성</th>
						<th>매출 달성 보정</th>
						<th>추가 매출 총합</th>
						<th>삭제 매출 총합</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=String.format("%.1f", sale) %></td>
						<td><%=String.format("%.1f", saleSet) %></td>
						<td><%=totalPlus %></td>
						<td><%=totalMinus %></td>
					</tr>
				</tbody>
			</table>
		</div>
		<%if(!(team.equals("Total")) && setVal.get(team).get("plus").size() != 0){ %>
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
							<%if(permission == 0){ %>
							<th>상반기</th>
							<%} %>
							<th>월수(상)</th>
							<%}
							if(time.equals("하반기") || time.equals("연간")){%>
							<%if(permission == 0){ %>
							<th>하반기</th>
							<%} %>
							<th>월수(하)</th>
							<%} %>
						</tr>
					</thead>
					<tbody>
						<%for(CMSBean cms : setVal.get(team).get("plus")){
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
							<%if(permission == 0){ %>
							<td><%="+" + cms.getFH_MM_CMS() %></td>
							<%} %>
							<td><%=cms.getFH_MM() %></td>
							<%}
							if(time.equals("하반기") || time.equals("연간")){%>
							<%if(permission == 0){ %>
							<td><%="+" + cms.getSH_MM_CMS() %></td>
							<%} %>
							<td><%=cms.getSH_MM() %></td>
							<%} %>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		<%}else if(team.equals("Total")){
				int cnt = 0;
				for(int key : teamList.keySet()){
					if(setVal.get(teamList.get(key)).get("plus").size() != 0){
						cnt = 1;
					}
				}
				if(cnt != 0){%>
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
									<%if(permission == 0){ %>
									<th>상반기</th>
									<%} %>
									<th>월수(상)</th>
									<%}
									if(time.equals("하반기") || time.equals("연간")){%>
									<%if(permission == 0){ %>
									<th>하반기</th>
									<%} %>
									<th>월수(하)</th>
									<%} %>
								</tr>
							</thead>
							<tbody>
								<!-- teamList로 반복문 -->
								<%for(int key : teamList.keySet()){
									for(CMSBean cms : setVal.get(teamList.get(key)).get("plus")){
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
										<%if(permission == 0){ %>
										<td><%="+" + cms.getFH_MM_CMS() %></td>
										<%} %>
										<td><%=cms.getFH_MM() %></td>
										<%}
										if(time.equals("하반기") || time.equals("연간")){%>
										<%if(permission == 0){ %>
										<td><%="+" + cms.getSH_MM_CMS() %></td>
										<%} %>
										<td><%=cms.getSH_MM() %></td>
										<%} %>
									</tr>
									<%}
								} %>
								
							</tbody>
						</table>
					</div>
				<%}
		}%>
		<p class="none" id="plusP" style="display:none">*****추가된 매출 없음*****</p>
		<%
		if(!(team.equals("Total")) && setVal.get(team).get("minus").size() != 0){%>
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
							<%if(permission == 0){ %>
							<th>상반기</th>
							<%} %>
							<th>월수(상)</th>
							<%}
							if(time.equals("하반기") || time.equals("연간")){%>
							<%if(permission == 0){ %>
							<th>하반기</th>
							<%} %>
							<th>월수(하)</th>
							<%} %>
						</tr>
					</thead>
					<tbody>
						<%for(CMSBean cms : setVal.get(team).get("minus")){
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
							<%if(permission == 0){ %>
							<td><%="-" + cms.getFH_MM_CMS() %></td>
							<%} %>
							<td><%=cms.getFH_MM() %></td>
							<%}
							if(time.equals("하반기") || time.equals("연간")){%>
							<%if(permission == 0){ %>
							<td><%="-" + cms.getSH_MM_CMS() %></td>
							<%} %>
							<td><%=cms.getSH_MM() %></td>
							<%} %>
						</tr>
						<%} %>
					</tbody>
				</table>
			</div>
		<%}else if(team.equals("Total")){
				int cnt = 0;
				for(int key : teamList.keySet()){
					if(setVal.get(teamList.get(key)).get("minus").size() != 0){
						cnt = 1;
					}
				}
				if(cnt != 0){%>
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
								<%if(permission == 0){ %>
								<th>상반기</th>
								<%} %>
								<th>월수(상)</th>
								<%}
								if(time.equals("하반기") || time.equals("연간")){%>
								<%if(permission == 0){ %>
								<th>하반기</th>
								<%} %>
								<th>월수(하)</th>
								<%} %>
							</tr>
						</thead>
						<tbody>
							<%for(int key : teamList.keySet()){
								for(CMSBean cms : setVal.get(teamList.get(key)).get("minus")){
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
									<%if(permission == 0){ %>
									<td><%="-" + cms.getFH_MM_CMS() %></td>
									<%} %>
									<td><%=cms.getFH_MM() %></td>
									<%}
									if(time.equals("하반기") || time.equals("연간")){%>
									<%if(permission == 0){ %>
									<td><%="-" + cms.getSH_MM_CMS() %></td>
									<%} %>
									<td><%=cms.getSH_MM() %></td>
									<%} %>
								</tr>
								<%}
							} %>
						</tbody>
					</table>
				</div>
				<%}
		} %>
		<p class="none" id="minusP" style="display:none">*****삭제된 매출 없음*****</p>
	</div>
</body>
</html>