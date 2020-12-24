<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"%>
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
		int no = Integer.parseInt(request.getParameter("no"));
		MeetingDAO meetDao = new MeetingDAO();
		MeetBean mb = meetDao.getMeetList(no);
		ArrayList<nextPlanBean> nextPlanList = new ArrayList<nextPlanBean>();
		if(!(mb.getP_nextplan().equals("-"))){
			nextPlanList = meetDao.getNextPlan(mb.getP_nextplan());			
		}
		
		String id = mb.getId();
		
		//System.out.println(sessionID);
		//System.out.println(id);
		// 출력
		String [] line;		
	%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Meeting_view</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function fnMove(seq){
		var offset = $("#move" + seq).offset();
        $('html, body').animate({scrollTop : offset.top}, 400);
	}
	
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
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

#dataTable td:first-child {
	text-align: center;
	vertical-align: middle;
	word-break: keep-all;
	width: 10%;
}

.meeting_table {
	width: 100%;
}

.meeting_table td {
	border: 1px solid black;
	white-space: nowrap;
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

fieldset {
	border-top: 3px inset;
	border-color: #5d7ace;
}

legend {
	color: #1b3787 !important;
	font-size: 18px;
	font-weight: 600;
	width: auto;
	padding: 5px;
}

.report_div {
	padding-left: 15px;
	padding-bottom: 15px;
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
			<li class="nav-item"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트 주간보고</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item active"><a class="nav-link"
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
							<h6 class="m-0 font-weight-bold text-primary" id="view_btn">회의록
								조회</h6>
							<form method="post" action="meeting_deletePro.jsp">
								<input type="hidden" name="no" value="<%=no%>">
								<%
	     		if(sessionID.equals(id)){
	     			%><input id="Delete" type="submit" name="Delete" value="삭제"
									class="btn btn-primary">
								<%	
	     		}
	     	%>
							</form>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable">
									<tr>
										<td class="m-0 text-primary">회의명</td>
										<td colspan="3"><%=mb.getMeetName()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">작성자</td>
										<td colspan="3"><%=mb.getWriter()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">회의일시</td>
										<td colspan="3"><%=mb.getMeetDate()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">회의 장소</td>
										<td colspan="3"><%=mb.getMeetPlace()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">참석자 슈어</td>
										<td colspan="3"><%=mb.getAttendees()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">참석자 고객사</td>
										<td colspan="3"><%=mb.getAttendees_ex()%></td>
									</tr>
									<tr>
										<td class="m-0 text-primary">회의내용</td>
										<td colspan="3">
											<%
							line = mb.getMeetNote();
							for(String li : line){
								%><p style="white-space: break-spaces;"><%=li%></p> <%
							}
							
						%>
										</td>
									</tr>
									<tr>
										<td class="m-0 text-primary">이슈사항</td>
										<td colspan="3">
											<%
							line = mb.getP_issue();
							for(String li : line){
								%><p style="white-space: break-spaces;"><%=li%></p> <%
							}
							
						%>
										</td>
									</tr>
									<tr>
										<td colspan="4" class="m-0 text-primary">향후일정</td>
									</tr>
									<tr>
										<td class="m-0 text-primary">NO</td>
										<td class="m-0 text-primary">항목</td>
										<td class="m-0 text-primary">기한</td>
										<td class="m-0 text-primary" colspan="2">담당</td>
									</tr>

									<%
					for(int i=0; i<nextPlanList.size(); i++){%>
									<tr>
										<td><%=nextPlanList.get(i).getNo()%></td>
										<td><%=nextPlanList.get(i).getItem()%></td>
										<td><%=nextPlanList.get(i).getDeadline()%></td>
										<td><%=nextPlanList.get(i).getPM()%></td>
									</tr>
									<%}%>
									<tr>
										<td colspan="4">
											<form method="post" action="meeting_update.jsp"
												style="display: contents;">
												<input type="hidden" name="no" value="<%=no%>">
												<%
								if(sessionID.equals(id)){
									%><input id="update" type="submit" name="update" value="수정"
													class="btn btn-primary">
												<%
								}
							%>

											</form> <a href="meeting.jsp" class="btn btn-primary">목록</a>
										</td>
									</tr>
								</table>



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
