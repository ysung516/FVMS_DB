<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
	import="java.util.Calendar"%>

<!DOCTYPE html>
<html lang="en">

<head>
<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 3){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(60*60);
	ReportDAO reportDao = new ReportDAO();
	ProjectDAO projectDao = new ProjectDAO();
	MemberDAO memberDao = new MemberDAO();
	
	ArrayList<ReportBean> list = reportDao.getReportList();
	ArrayList<ProjectBean> unWrite = reportDao.getUnwrittenReport();
	int projectNum = projectDao.useReportProject();
%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - report</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
.sidebar{
		position:fixed;
		z-index:9999999;
	}
#wrapper #content-wrapper{
	overflow-x: initial;
}

	#content{
		margin-left:90px;
	}
.table-responsive {
	overflow: auto;
}

#reportTable tr {
	border-bottom: 1px solid #d1d3e2;
	text-align: center;
}

#reportTable {
	white-space: nowrap;
	overflow: auto;
	width: 100%;
	margin-top: 10px;
	word-break: keep-all;
}

.summary_p {
	margin: 0;
	padding: 5px;
	border-left: 1px solid black;
	border-right: 1px solid black;
	background-color: #fff;
	font-weight: bold;
	display: none;
}

#report_btn {
	position: fixed;
	bottom: 0;
	padding: 10px;
	width: 100%;
	text-align: center;
	background-color: #fff;
	border-top: 1px solid;
}

#span1 {
	color: red;
}

.summary {
	font-weight: 700;
}

.details_body {
	margin-right: 5%;
	right: 0;
	position: absolute;
	top: 14px;
	background: #fff;
}

.m-0.font-weight-bold.text-primary {
	padding-left: 17px;
	display: inline !important"
}

.summary:focus {
	outline: none;
}

#reportList {
	white-space: initial;
}

#reportList td {
	border-right: 1px solid #b7b9cc;
	padding: 6px;
}

#reportList td:last-child {
	border: 0px;
}

p:last-child {
	border-bottom: 1px solid black !important;
	border-bottom-right-radius: 5px;
	border-bottom-left-radius: 5px;
	margin-bottom: 20%;
}

tr:last-child {
	border-bottom: 1px solid #fff !important;
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

@media ( max-width :800px) {
.details_body {
	margin-right: 5%;
	right: 0;
	position: absolute;
	top: 9%;
	background: #fff;
}
.card-header{
		margin-top:4.75rem;
	}
	.topbar{
		z-index:999;
		position:fixed;
		width:100%;
		}
#content{
		margin-left:0px;
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

.report_btn {
	font-size: 15px;
	border: 2px solid #929ae3;
	background-color: rgba(0, 0, 0, 0);
	color: #929ae3;
	border-radius: 100%;
	font-weight: 700;
	font-family: serif;
	margin: 5px;
}

.report_btn:hover {
	background-color: #929ae385;
}

.report_btn:active {
	background-color: #929ae385;
	border: 2px solid #505dd3;
	color: #4e73df;
}

button:focus {
	outline: none;
}

.projectList {
	margin: 0;
}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script>

	function yet_project(){
		 $(".summary").click(function(e){
			 if($(".summary_p").css('display')=='none'){
			     $(".summary_p").show();
			    	}
			    	else  
			     $(".summary_p").hide();
			    });
		 
	    $("body").click( function(e){
	        if(e.target.className !== "summary"){
	          $(".summary_p").hide();
	          $(".summary").show();
	        }
	      });  
	}
	
	 $(document).ready(function(){
		 yet_project();
	 });
</script>
<script type="text/javascript">
<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
</script>

<body id="page-top" style="color: #4c5280 !important">

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
			
			<button id="sidebarToggle" class="rounded-circle border-0" style="margin-left:30px; margin-top:10px">
						
					</button>
			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../mypage/mypage.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>마이페이지</span></a></li>

			<!-- Nav Item - summary -->
			<li class="nav-item"><a class="nav-link"
				href="../summary/summary.jsp"> <i class="fas fa-fw fa-table"></i>
					<span>요약정보</span></a></li>

			<!-- Nav Item - project -->
			<li class="nav-item"><a class="nav-link"
				href="../project/project.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>프로젝트</span></a></li>

			<!-- Nav Item - schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>스케줄</span></a></li>

			<li class="nav-item"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>프로젝트 스케줄</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>관리자 스케줄</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item active"><a class="nav-link"
				href="../report/report.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>주간보고서</span></a></li>

			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>회의록</span></a></li>

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
				<div class="container-fluid" style="padding-bottom: 50px;">

					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">주간보고목록</h6>

						</div>
						<div class="details_body">

							<div class="summary">
								미등록 프로젝트 <span id="span1"><%=unWrite.size()%></span>/<span><%=projectNum%></span>
							</div>
							<%for(int i=0; i<unWrite.size(); i++){
        				if(unWrite.get(i).getPROJECT_MANAGER().equals(sessionID) || unWrite.get(i).getWORKER_LIST().contains(sessionID)){
        					%><p class="summary_p">
								<a href="report_write.jsp?no=<%=unWrite.get(i).getNO()%>"><%=unWrite.get(i).getPROJECT_NAME()%></a>
							</p>
							<%}else{%>
							<p class="summary_p"><%=unWrite.get(i).getPROJECT_NAME()%></p>
							<% }}%>

						</div>

						<div class="table-responsive">
							<table id="reportTable">
								<thead>
									<tr>
										<th>프로젝트</th>
										<th>고객사</th>
										<th>PM</th>
										<th>최종수정시간</th>
									</tr>
								</thead>

								<tbody id="reportList" name="reportList" class="reportList">
									<%
			if(list != null){
				
				for(int i=0; i < list.size(); i++){
					String pmID = projectDao.getProjectBean_no(list.get(i).getProjectNo()).getPROJECT_MANAGER();
					%>
									<tr style="text-align: left;">
										<td><a href="report_view.jsp?no=<%=list.get(i).getNo()%>"><%=list.get(i).getTitle()%></a></td>
										<td><%=projectDao.getProjectBean_no(list.get(i).getProjectNo()).getCLIENT()%></td>
										<td><%=memberDao.returnMember(pmID).getNAME()%></td>
										<td><%=list.get(i).getDate()%></td>
									</tr>
									<%
				}
			} 
		  %>

								</tbody>
							</table>
						</div>

						<script type="text/javascript">
	var myTable = document.getElementById( "reportTable" ); 
	var replace = replacement(myTable); 
	function sortTD( index ){replace.ascending( index ); } 
	function reverseTD( index ){replace.descending( index );} 
</script>


						<!-- /.container-fluid -->

					</div>
					<div id="report_btn">
						<a href="report_write.jsp" class="btn btn-primary">주간보고서 작성</a>
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
