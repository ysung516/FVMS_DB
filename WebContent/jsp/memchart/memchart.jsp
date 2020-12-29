<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="java.util.ArrayList"
	import="java.util.List" import="jsp.DB.method.*"
	import="jsp.Bean.model.*"
	import="java.text.SimpleDateFormat" import="java.util.Date"
	import="java.util.HashMap" import="java.util.LinkedHashMap"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%


		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());

		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		

		Date nowTime = new Date();
		SimpleDateFormat sf_yyyy = new SimpleDateFormat("yyyy");
		String nowYear = sf_yyyy.format(nowTime);
		int year = Integer.parseInt(sf_yyyy.format(nowTime));
		
		if(request.getParameter("selectYear") != null){
			nowYear = request.getParameter("selectYear");
		}
		
		SummaryDAO summaryDao = new SummaryDAO();
		MemberDAO memberDao = new MemberDAO();
		ManagerDAO managerDao = new ManagerDAO();

		int teamcnt = memberDao.getTeam().size();

		
		int maxYear = summaryDao.maxYear();
		int yearCount = maxYear - summaryDao.minYear() + 1;
		
		
	    ArrayList<MemberBean> memberList = memberDao.getMemberDataWithoutOut(year);	// 퇴사 제외하고 회원 정보 가져오기
	    ArrayList<MemberBean> cooperationList = memberDao.getMember_cooperation();	// 협력업체
	    HashMap<String, Integer> coopNum = memberDao.getNum_cooperation();	// 협력업체 별 인원 수 가져오기
	    LinkedHashMap<Integer, String> teamList = memberDao.getTeam_year(nowYear);// 올해 팀 리스트 가져오기
		LinkedHashMap<String, TeamBean> teamData = summaryDao.getTargetData(nowYear);	

		%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - 조직도</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>

	
<script type ="text/javascript">
$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
    $('.loading').hide();
    $('#count').val($('#table tr').length-1);
	$('#selYear').val(<%=nowYear%>).prop("selected",true);
});

function loadYear(){
	var year = $('#selYear').val();
	location.href ="memchart.jsp?selectYear="+year;
}

	function memchartInsert(){	// 슈어소프트테크 소속 인원 표에 데이터 담기
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth()+1;
		

		if(month > 6){
			var half = '하반기';
		}else{
			var half = '상반기';
		}
		<!--$('.tag').html('인턴('+year+'년 '+half+')');-->
		$('.tag').html('인턴');
		<%for(int key : teamList.keySet()){%>
			var Num<%=key%> = 0;
		<%}%>
		var internNum = 0;
		
		<%for(MemberBean mem : memberList){
			if(mem.getPosition().equals("실장")){%>
				$('#vtM').html('<%=mem.getNAME()%>' + ' 실장');
			<%	continue; }
			if(mem.getRANK().equals("인턴")){%>
				internNum = internNum + 1;
				if(!($('.cen').is(':empty'))){
					$('.cen').append(', ' + '<%=mem.getNAME()%>'); 
				}else{
					$('.cen').append('<%=mem.getNAME()%>');
				}
			<%	continue; }
			for(int key : teamList.keySet()){
				if(key != 0){
					if(mem.getTEAM().equals(teamList.get(key))){%>
						Num<%=key%> = Num<%=key%> + 1;
						<%if(mem.getPosition().equals("팀장")){%>
							$('.<%=key%> > .teamM').html('<%=mem.getNAME()%>' + ' 팀장');
						<%break; }
						if(mem.getRANK().equals("수석") || mem.getRANK().equals("책임")){%>
							$('.<%=key%> > .lv2').append('<%=mem.getNAME()%>' + ' ' + '<%=mem.getRANK()%>' + '<br>');
						<%break; }
						if(mem.getRANK().equals("선임")){%>
							$('.<%=key%> > .lv3').append('<%=mem.getNAME()%>' + ' 선임<br>');
						<%break; }
						if(mem.getRANK().equals("전임")){%>
							$('.<%=key%> > .lv4').append('<%=mem.getNAME()%>' + ' 전임<br>');
						<%break; }
					}
				}
			}
		}
		%>
		var totalVT = 1;
		<%
		for(int key : teamList.keySet()){
			if(key != 0){%>
				$('#'+'<%=key%>'+'num').html(Num<%=key%> + '명');
				totalVT += Num<%=key%>;
			<%}
		}%>
		
		var string = '<span style="font-size: medium; color: red; margin-left:10px;">총 인원 : ' + totalVT + '명</span>'
		$('#vtMain h4').html('<%=teamList.get(0)%>' + string);
		
		$('#internnum').html(internNum + '명');
	}
	
	function cooperView(){	// 협력업체 표에 담기, 체크박스 체크 시 보여짐
		$('#cooper').change(function(){
			if($('#cooper').is(":checked")){
				$('#vt6 > td').css('border-bottom','0px');
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
				$('#coopTR > .<%=key%> > .coop').empty();
				<%}}%>
				
				var str = "";
				<%for(String coop : coopNum.keySet()){%>
					str = str + '<%=coop%>' + ' : ' + '<%=coopNum.get(coop)%>' + '명<br>';
				<%}%>
				
				var vtnum = 0;
				<%for(int key : teamList.keySet()){%>
						var Num<%=key%> = 0;
				<%}%>
				
				var coopTR = '<td class = "vt vtadd" style="border:0.1px #393A60 solid;border-top:0px;"><div class="coop vtadd"></div></td>';
				$('#coopTR').append(coopTR);
				
				<%for(MemberBean mem : cooperationList){
					String rank = mem.getRANK();
					if(mem.getRANK().equals("-")){
						rank = "";
					}
					for(int key : teamList.keySet()){
						if(key == 0 && mem.getTEAM().equals(teamList.get(key))){%>
							$('#coopTR > .vt > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=rank%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
							vtnum = vtnum + 1;
							<%break; 
						}else if(key != 0 && mem.getTEAM().equals(teamList.get(key))){%>
							$('#coopTR > .<%=key%> > .coop').append('<%=mem.getNAME()%>' + ' ' + '<%=rank%>' + '<br>(' + '<%=mem.getPART()%>' + ')<br>');
							Num<%=key%> = Num<%=key%> + 1;
							<%break; 
						}
					}
				}%>
				
				var total_vt = 1;
				var total = 1;
				
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
					Num<%=key%> = Num<%=key%> + parseInt($('#'+'<%=key%>'+'num').text().split()[0]);
					<%}
				}%>
				
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
					total_vt = total_vt + parseInt($('#'+'<%=key%>'+'num').text().split()[0]);
					total = total + Num<%=key%>;
					<%}%>
				<%}%>
				total = total + vtnum;
				
				var vt18 = '<td class="chartHeader vtadd">' + '<%=teamList.get(0)%>' + '</td>';
				$('#vt1').append(vt18);
				$('#vt8').append(vt18);
				var vt2 = '<th class="chartHeader vtadd">' + '<%=teamList.get(0)%>' + '</th>';
				$('#vt2').append(vt2);
				var vt3 = '<td class = "vt vtadd" style="border:0.1px #393A60 solid; border-bottom: 0px;"><div class="teamM vtadd"></div></td>';
				$('#vt3').append(vt3);
				var vt4 = '<td rowspan = "3" class = "vt vtadd" style="border:1px #393A60 solid; border-bottom: 0px; border-top:0px;"><div class="lv2 vtadd" style="color:black;">'
						+'<p style="color:red;"><b>Total : '+total+'명</b></p>'
						+'<p style="color:red;"><b>Total<a style="font-size:10px; color:red;">(협력제외)</a> : '+total_vt+'명</b></p><br>'
						+'<b>협력업체 총 인원</b><br>' + str + '</div></td>';
				$('#vt4').append(vt4);
				var vt7 = '<th class="chartHeader vtadd">명</th>';
				$('#vt7').append(vt7);
				var totalP = '<td class = "chartHeader vtadd" id="vtnum"></td>';
				$('#totalP').append(totalP);
				
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
					$('#'+'<%=key%>'+'num').html(Num<%=key%>+ '명');
					<%}
				}%>
				$('#vtnum').html(vtnum + '명');
				$('#coopTR').css('visibility', 'visible');
				
	
			}else{
				$('#vt6 > td').css('border-bottom','0.1px solid #393A60');
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
						var Num<%=key%> = 0;
					<%}
				}%>
				
				<%for(MemberBean mem : cooperationList){
					for(int key : teamList.keySet()){
						if(key != 0){
							if(mem.getTEAM().equals(teamList.get(key))){%>
								Num<%=key%> = Num<%=key%> + 1;
							<%break; }
						}
					}
				}%>
				
				$('.vtadd').remove();
				
				<%for(int key : teamList.keySet()){
					if(key != 0){%>
						Num<%=key%> =parseInt($('#'+'<%=key%>'+'num').text().split()[0]) - Num<%=key%>;
						$('#'+'<%=key%>'+'num').html(Num<%=key%> + '명');
						$('#coopTR > .<%=key%> > .coop').empty();
					<%}
				}%>
				
				$('#coopTR').css('visibility', 'collapse');
			}
		});
	}
	
	$(document).ready(function(){
		$('.loading').hide();
		memchartInsert();
		cooperView();
		
		/*$('#cooper').change(function(){
			if($('#cooper').is(":checked")){
				$('.sidebar').css("height", '100%');
			}else{
				$('.sidebar').css("height", 'auto');
			}
		});*/
		
	});
	
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
</script>

<style>

.sidebar .nav-item {
	word-break: keep-all;
}

#sidebarToggle {
	display: none;
}

.sidebar {
	position: relative;
	z-index: 997;
}

.loading {
	position: fixed;
	text-align: center;
	width: 100%;
	height: 100%;
	top: 0;
	left: 0;
	font-size: 8px;
	background-color: #4e73df6b;
	background-image: linear-gradient(181deg, #3d5482 16%, #6023b654 106%);
	background-size: cover;
	z-index: 1000;
	color: #ffffffc4;
}

.loading #load {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

@media ( max-width :765px) {
	.card-body{
		padding:0.25rem;
	}
	.memchart{
		wihte-space:nowwrap;
		border-collapse:collapse !important;
	}

	#sidebarToggle {
		display: block;
	}
	.sidebar .nav-item {
		white-space: nowrap !important;
		font-size: x-large !important;
	}
	#accordionSidebar {
		width: 100%;
		text-align: center;
		display: inline;
		padding-top: 60px;
		position: fixed;
		z-index: 998;
	}
	#content {
		margin-left: 0;
	}
	.nav-item {
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
		padding-top: 0px;
	}
	.card-header {
		margin-top: 4.75rem;
	}
	.topbar {
		z-index: 999;
		position: fixed;
		width: 100%;
	}
	.container-fluid {
		padding: 0;
	}
	.card-header:first-child {
		padding: 0;
	}
	body {
		font-size: small;
	}
}

td {
	text-align: center;
}

.table-responsive {
	table-layout: fixed;
	display: table;
}

table:not(.memchart):not(#intern) {
	white-space: nowrap;
	/*display:table-cell;*/
	overflow: auto;
	white-space: nowrap;
}

<!--
조직도 css -->.memchart #intern {
	text-align: center;
}

.chartHeader, #totalP, .memInfo, .intd {
	padding-top: 6px !important;
	padding-bottom: 6px !important;
	padding-right: 20px !important;
	padding-left: 20px !important;
}

.chartHeader, #totalP {
	background-color: #393A60;
	color: white;
	text-align: center;
}

.memchart td {
	vertical-align: top;
	padding-top: 10px;
	padding-bottom: 10px;
}

.teamM {
	background-color: #F2F2F2;
	color: #393A60;
	text-decoration: underline;
}

.lv2 {
	background-color: #F2F2F2;
	color: #045FB4;
}

.lv3 {
	background-color: #F2F2F2;
	color: #B45F04;
}

.lv4 {
	background-color: #F2F2F2;
	color: #298A08;
}

.coop {
	background-color: #F2F2F2;
	color: #8904B1;
}

.tag {
	background-color: #97A3C2;
	color: white;
}

.cen {
	background-color: #F2F2F2;
	color: #298A08;
}

.memchart div {
	line-height: 130% !important;
}

#organizationChart {
	float: left;
}
</style>

<body id="page-top">
	<!--  로딩화면  시작  -->
	<div class="loading">
		<div id="load">
			<i class="fas fa-spinner fa-10x fa-spin"></i>
		</div>
	</div>
	<!--  로딩화면  끝  -->
	<!-- Page Wrapper -->
	<div id="wrapper">
		<!-- Sidebar -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">
			<!-- Sidebar - Brand -->

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수입 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../expense_sum/expense_sum.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>지출 요약</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../profit_analysis/profit_analysis.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>수익 지표</span></a></li>
					
			<!-- Nav Item - summary -->
			<li class="nav-item active"><a class="nav-link"
				href="../memchart/memchart.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>조직도</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 관리</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 엔지니어</span></a></li>

			<li class="nav-item"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 프로젝트</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄 - 관리자</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 주간보고</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>고객미팅 회의록</span></a></li>
					
			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../assessment/assessment.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>평가</span></a></li>

			<!-- Nav Item - manager page -->
			<%if(permission == 0){ %>
			<li class="nav-item"><a class="nav-link"
				href="../manager/manager.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>관리자 페이지</span></a></li>
			<% }%>
		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
					
					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
								<i class="fas fa-info-circle"></i>
							</a>
							<!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
									<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div>
						</li>
					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary"
								style="padding-left: 17px;" id="view_btn">조직도
								<select id="selYear" name="selYear" onchange="loadYear()">
				         			<%for(int i=0; i<yearCount; i++){%>
									<option value='<%=maxYear-i%>'><%=maxYear-i%></option>
									<%}%>
				         		</select>
								<label style="font-size: 12px; display: block; margin-left: 5px; margin-top: 5px; margin-bottom: 0px;">
									<input type="checkbox" id="cooper" name="cooper" value="cooper">
									<span style="vertical-align: text-top; margin-left: 2px; color: black; font-weight: 100;">협력업체 및 상세 정보</span>
								</label>
							</h6>
							
						</div>

						<div class="card-body">
							<div class="table-respensive" id="organizationChart">
								<div id="vtMain" style="text-align: center;">
									<h4 style="color:black;"></h4>
								</div>
								<div id="vtM" style="text-align:center; margin:15px; color:black; text-decoration:underline; font-size:18px;">
								</div>
								<div>
									<table class = "memchart" style="margin-left: auto; margin-right: auto; border-spacing : 20px 0; border-collapse:unset; margin-bottom:15px;">
											<tr id = "vt1">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "chartHeader"><%=teamList.get(key) %></td>
												<%}} %>
											</tr>
									</table>
							      	<table class = "memchart" style="margin-left: auto; margin-right: auto; border-spacing : 20px 0px; border-collapse:unset;">
										<thead style="visibility : collapse;">
											<tr id = "vt2">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<th class = "chartHeader"><%=teamList.get(key) %></th>
												<%}} %>
											</tr>
										</thead>
										<tbody style="background-color:#F2F2F2;">
											<tr id = "vt3">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "<%=key %>" style="border:0.1px #393A60 solid; border-bottom: 0px;">
														<div class="teamM"></div>
													</td>
												<%}} %>
											</tr>
											<tr id = "vt4">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "<%=key %>" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
														<div class = "lv2"></div>
													</td>
												<%}} %>
											</tr>
											<tr id = "vt5">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "<%=key %>" style="border:0.1px #393A60 solid; border-bottom: 0px; border-top:0px;">
														<div class = "lv3"></div>
													</td>
												<%}} %>
											</tr>
											<tr id = "vt6">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "<%=key %>" style="border:0.1px #393A60 solid;border-top:0px;">
														<div class = "lv4"></div>
													</td>
												<%}} %>
											</tr>
											<tr id="coopTR" style="visibility : collapse;">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "<%=key %>" style="border:0.1px #393A60 solid; border-top:0px;">
														<div class = "coop"></div>
													</td>
												<%}} %>
											</tr>
										</tbody>
										<tfoot style="visibility : collapse;">
											<tr id = "vt7">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<th class = "chartHeader">명</th>
												<%}} %>
											</tr>
										</tfoot>
									</table>
									
									<table class="memchart" style="margin-left: auto; margin-right: auto; margin-top:15px; border-spacing : 20px 0; border-collapse:unset;">
										<thead style="visibility : collapse;">
											<tr id = "vt8">
												<%for(int key : teamList.keySet()){ 
													if(key != 0){%>
													<td class = "chartHeader"><%=teamList.get(key) %></td>
												<%}} %>
											</tr>
										</thead>
										<tr id = "totalP">
											<%for(int key : teamList.keySet()){ 
												if(key != 0){%>
												<td class = "chartHeader" id="<%=key %>num"></td>
											<%}} %>
										</tr>
									</table>
								</div>
								<div>
									<table id = "intern" style="margin-left: auto; margin-right: auto; margin-top:15px;">
										<tr>
											<td class = "tag intd">인턴</td>
											<td class = "cen intd"></td>
											<td class = "tag intd" id="internnum"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<!-- container-fluid -->
					
			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->
		
	</div>
	<!-- End of Page Wrapper -->

				<!-- Scroll to Top Button-->
				<a class="scroll-to-top rounded" href="#page-top">
					<i class="fas fa-angle-up"></i>
				</a>

				<!-- Logout Modal-->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
								<button class="close" type="button" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
								<form method="post" action="../LogoutPro.jsp">
									<input type="submit" class="btn btn-primary" value="확인" />
								</form>
							</div>
						</div>
					</div>
				</div>


				<!-- Bootstrap core JavaScript-->
				<script src="../../vendor/jquery/jquery.min.js"></script>
				<script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

				<!-- Core plugin JavaScript-->
				<script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

				<!-- Custom scripts for all pages-->
				<script src="../../js/sb-admin-2.min.js"></script>

				<!-- Page level plugins -->
				<script src="../../vendor/chart.js/Chart.min.js"></script>

				<!-- Page level custom scripts -->
				<script src="../../js/demo/chart-area-demo.js"></script>
				<script src="../../js/demo/chart-pie-demo.js"></script>
				<script src="../../js/demo/chart-bar-demo.js"></script>
</body>

</html>