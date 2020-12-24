<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
	import="java.util.Calendar"
	import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">

<head>
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
		int NO = Integer.parseInt(request.getParameter("no"));
		ReportDAO reportDao = new ReportDAO();
		ProjectDAO projectDao = new ProjectDAO();
		MemberDAO memberDao = new MemberDAO();
	
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd-a-hh:mm");
		String nowWeek = sf.format(nowTime);
		
		ReportBean report = reportDao.getReportBean(NO);
		String weekly = report.getWeekly();
		int projectNo = report.getProjectNo();
		int year = Integer.parseInt(weekly.split("/")[0]);
		
		ReportBean reportBackUp = reportDao.getReportBackUp(projectNo, weekly);
		ProjectBean project = projectDao.getProjectBean_no(projectNo, year);
		
		
		// 출력
		String [] line;
		
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Report_view</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function final_mark(){
		if('<%=report.getFinal_Check()%>' == '1'){
			$('#dataTable2').css('border','3px solid #03e895')
		}
	}

	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	    final_mark();
	});
</script>

<style>
.sidebar .nav-item{
	 	word-break: keep-all;
}
#sidebarToggle{
		display:none;
	}
.sidebar{
	position:relative;
	z-index:997;
}

p {
	margin-bottom: 0;
}

h6 {
	text-align: left;
}

#view_btn {
	vertical-align: middle;
	padding-left: 17px;
	display: inline;
}

#Delete {
	right: 0;
	margin-right: 24px;
	display: inline-block;
	position: absolute;
	top: 9px;
}

#dataTable td:nth-child(odd) {
	text-align: center;
	vertical-align: middle;
	word-break: keep-all;
}

#dataTable2 td:nth-child(odd) {
	text-align: center;
	vertical-align: middle;
	word-break: keep-all;
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
#sidebarToggle{
		display:block;
	}
	.card-header{
		margin-top:4.75rem;
	}
		.sidebar .nav-item{
	 	white-space:nowrap !important;
	 	font-size: x-large !important;	 	
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
	}
	#accordionSidebar{
		width: 100%;
		height: 100%;
		text-align: center;
		display: inline;
		padding-top: 60px;
		position: fixed;
		z-index: 998;
	}
	#content{
		margin-left:0;
	}
	.nav-item{
		position: absolute;
		display: inline-block;
		padding-top: 20px;
	}
	.topbar .dropdown {
			padding-top: 0px;
			
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
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled"
			id="accordionSidebar">

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
			<li class="nav-item"><a class="nav-link"
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
			<li class="nav-item active"><a class="nav-link"
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
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>


					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">


						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small"><%=sessionName%></span>
								<i class="fas fa-info-circle"></i>
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary" id="view_btn">주간보고서
								조회</h6>
							<%if(project.getWORKER_LIST().contains(sessionID) || project.getPROJECT_MANAGER().equals(sessionID)){ %>
							<a id="Delete" href="report_deletePro.jsp?no=<%=NO%>"
								class="btn btn-secondary btn-icon-split"
								onclick="return confirm('삭제하시겠습니까?')">삭제</a>
							<% }%>

						</div>
						<div class="card-body">
							<div class="table-responsive">
								<form method="post" action="report_update.jsp">
									<input type="hidden" name="no" value=<%=NO%>> <input
										type="hidden" name="projectNo"
										value=<%=report.getProjectNo()%>> <input type="hidden"
										name="reportTitle" value=<%=report.getTitle()%>>
									<table class="table table-bordered" id="dataTable">
										<tr>
											<td class="m-0 text-primary" id="move1">프로젝트</td>
											<%
												if(permission == 0  || (permission == 1 && (project.getWORKER_LIST().contains(sessionID) || project.getPROJECT_MANAGER().equals(sessionID)))){
													%><td><a href="../project/project_update.jsp?no=<%=report.getProjectNo()%>&year=<%=year%>"> <%=report.getTitle()%></a></td><%
												} else {
													%><td><%=report.getTitle()%></td><%
												}
											%>		
										</tr>
										<tr>
											<td class="m-0 text-primary">작성자</td>
											<td><%=report.getName()%></td>
										</tr>
										<tr>
											<td class="m-0 text-primary">최종수정시간</td>
											<td><%=report.getDate()%>
													(<%=reportDao.validDate(report.getDate())%>)
											</td>
										</tr>
										<tr> 
											<td class="m-0 text-primary">PM</td>
											<td><%=memberDao.returnMember(project.getPROJECT_MANAGER()).getNAME()%></td>
										</tr>
										<tr>
											<td class="m-0 text-primary">상태</td>
											<td><%=project.getSTATE()%></td>
										</tr>
										<tr>
											<td class="m-0 text-primary">착수일</td>
											<td><%=project.getPROJECT_START()%></td>
										</tr>
										<tr>
											<td class="m-0 text-primary">착수 종료일</td>
											<td><%=project.getPROJECT_END()%></td>
										</tr>
										</table>
										<table class="table table-bordered" id="dataTable2">
										<tr>
											<td colspan="1"><h6 class="m-0 text-primary">(전)금주계획</h6></td>
											<td colspan="1"><h6 class="m-0 text-primary">금주계획</h6></td>
										</tr>
										<tr>
										<td colspan="1" style="text-align: left;">
											<%
											if(reportBackUp.getWeekPlan() != null){
												line = reportBackUp.getP_weekPlan();
												for(String li : line){
										      		%><p style="white-space: break-spaces;"><%=li%></p> <%
										      	}
											}							
					     	 				%>
										</td>
										
										<td colspan="1" style="text-align: left;">
											<%
										      	line = report.getP_weekPlan();
										      	for(String li : line){
										      		%><p style="white-space: break-spaces;"><%=li%></p> <%
										      	}
					     	 				%>
											</td>
										</tr>
										
										<tr>
											<td colspan="1" id="move3" style="width:50%"><h6 class="m-0 text-primary">(전)금주진행</h6></td>
											<td colspan="1" id="move3" style="width:50%"><h6 class="m-0 text-primary">금주진행</h6></td>
										</tr>
										<tr>
											<td colspan="1" style="text-align: left;">
												<%
													if(reportBackUp.getWeekPro() != null){
														line = reportBackUp.getP_weekPro();
														for (String li : line) {
														%><p style="white-space: break-spaces;"><%=li%></p> <%
													 	}
													}	
												 %>
											</td>
											<td colspan="1" style="text-align: left;">
												<%
													line = report.getP_weekPro();
													for (String li : line) {
													%><p style="white-space: break-spaces;"><%=li%></p> <%
												 	}
												 %>
											</td>
										</tr>
										<tr>
											<td colspan="1" id="move4"><h6 class="m-0 text-primary">(전)차주진행</h6></td>
											<td colspan="1" id="move4"><h6 class="m-0 text-primary">차주계획</h6></td>
										</tr>
										<tr>
											<td style="text-align: left;">
												<%
													if(reportBackUp.getNextPlan() != null){
														line = reportBackUp.getP_nextPlan();
						      							for(String li : line){
						      							%><p style="white-space: break-spaces;"><%=li%></p> <%
						      							}
													}
					      						%>
											</td>
											<td colspan="1" style="text-align: left;">
												<%
					      							line = report.getP_nextPlan();
					      							for(String li : line){
					      							%><p style="white-space: break-spaces;"><%=li%></p> <%
					      							}
					      						%>
											</td>
										</tr>
										<tr>
											<td colspan="1" id="move5"><h6 class="m-0 text-primary">(전)특이사항</h6></td>
											<td colspan="1" id="move5"><h6 class="m-0 text-primary">특이사항</h6></td>
										</tr>
										<tr>
											<td style="text-align: left;">
												<%
													if(reportBackUp.getSpecialty() != null){
						      							line = reportBackUp.getP_specialty();
						      							for(String li : line){
						      							%><p style="white-space: break-spaces;"><%=li%></p> <%
						      							}
													}
					      						%>
											</td>
											<td style="text-align: left;">
												<%
					      							line = report.getP_specialty();
					      							for(String li : line){
					      							%><p style="white-space: break-spaces;"><%=li%></p> <%
					      							}
					      						%>
											</td>
										</tr>
										<tr>
											<td colspan="1" id="move6"><h6 class="m-0 text-primary">(전)비고</h6></td>
											<td colspan="1" id="move6"><h6 class="m-0 text-primary">비고</h6></td>
										</tr>
										<tr>
											<td style="text-align: left;">
												<%
													if(reportBackUp.getNote() != null){
												      	line = reportBackUp.getP_note();
												      	for(String li : line){
												      		%><p style="white-space: break-spaces;"><%=li%></p> <%
												      	}
													}
											     %>
											
											</td>
											<td colspan="1" style="text-align: left;">
												<%
											      	line = report.getP_note();
											      	for(String li : line){
											      		%><p style="white-space: break-spaces;"><%=li%></p> <%
											      	}
											     %>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<%if((project.getWORKER_LIST().contains(sessionID) || project.getPROJECT_MANAGER().equals(sessionID)) 
														&& weekly.equals(reportDao.getWeekly(nowWeek))){ %>
												<input id="update" type="submit" name="update" value="수정"
												class="btn btn-primary"> <% }%> <a href="report.jsp"
												class="btn btn-primary">목록</a>
											</td>
										</tr>
									</table>
								</form>
							</div>

							<!-- /.container-fluid -->

						</div>
						<!-- End of Main Content -->

					</div>
					<!-- End of Content Wrapper -->

				</div>
				<!-- End of Page Wrapper -->

				<!-- Scroll to Top Button-->
				<a class="scroll-to-top rounded" href="#page-top"> <i
					class="fas fa-angle-up"></i>
				</a>

				<!-- Logout Modal-->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">확인버튼을 누를 시 로그아웃 됩니다.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button"
									data-dismiss="modal">취소</button>
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
