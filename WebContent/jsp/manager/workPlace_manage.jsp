<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.DB.method.*" import="jsp.Bean.model.*"
	import="java.util.ArrayList" import="java.util.List"
	import="java.text.SimpleDateFormat" import="java.util.Date"%>
	
<!DOCTYPE html>
<html lang="en">

<head>
<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
		}
			
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		ManagerDAO managerDao = new ManagerDAO();
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		
		int maxYear = managerDao.maxYear();
		int minYear = managerDao.minYear();
		int yearCount = maxYear - minYear + 1;
		
		Date nowDate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		
		String nowYear = sf.format(nowDate); 
		int year = Integer.parseInt(nowYear);
		if(request.getParameter("year") != null){
			year = Integer.parseInt(request.getParameter("year"));
		}
		ArrayList<WorkPlaceBean> wpList = managerDao.getWorkPlaceList(year);
	%>
	

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - workPlaceMangement</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>

.sidebar .nav-item{
	 	word-break: keep-all;
}
.place_width{
	width: 40%
}
#sidebarToggle{
	display:none;
}
.wpTable{
	padding : 10px;
	width : 50%;
	text-align: center;
}
.sidebar{
	position:relative;
	z-index:997;
}
#manager_btn {
	position: fixed;
	bottom: 0;
	padding: 10px;
	width: 100%;
	text-align: center;
	background-color: #fff;
	border-top: 1px solid;
}


.m-0 .text-primary {
	vertical-align: middle;
	text-align: center;
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
	.wpTable{
		padding: 5px;
		width: 100%;
	}
	#sidebarToggle{
		display:block;
	}
	.extra{
		display:none;
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
	.table-responsive {
		width: 100%;
		margin-left:0;
	}
}

</style>

<!-- sorting table -->
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">

	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	    $('#count').val($('#workplaceList tr').length);
	    $('#wp_year').val(<%=year%>).attr("selected","selected");
	});
	
	function memberSyn(){
		location.href ="member_syn.jsp";
	}

	function workPlaceManage(){
		location.href ="workPlace_manage.jsp"
	}
	
	var count = $('#workplaceList tr').length;
	
	function rowAdd(){
		count = $('#workplaceList tr').length;
		count++;
		console.log(count);
		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '<td>'+count+'</td>';
		innerHtml += '<td class="place_width"><input name="place"></td>';
		innerHtml += '<td><input name="cost" value="0"></td>';
		innerHtml += '<td><input type="color" value="#ffffff" name="color"></td>';
		innerHtml += '<td><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>';
		innerHtml += '</tr>';
		$('#count').val(count);
		$('#workplaceList').append(innerHtml);
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
			
			var len = $('#workplaceList tr').length;
			for(var a=0; a<=len; a++){
				$("#workplaceList tr:eq("+a+") td:eq(0)").text((a+1));
				$("#workplaceList tr:eq("+a+") td:eq(1) input").attr("name", "place");
				$("#workplaceList tr:eq("+a+") td:eq(2) input").attr("name", "cost");
				$("#workplaceList tr:eq("+a+") td:eq(3) input").attr("name", "color");
			}
			$('#count').val($('#workplaceList tr').length);
		});
	}

	function listLoad(){
		var year = $('#wp_year').val();
		location.href ="workPlace_manage.jsp?year="+year;
	}
	
	function copy_nextYear(){
		var year = $('#wp_copy').val();
		var cnt = $('#count').val();
		location.href ="wp_nextcopy.jsp?year="+<%=maxYear+1%>+"&cnt="+cnt;	
	}
	
	function delete_previousYear(){
		var year = $('#delete_copy').val();
		var cnt = $('#count').val();
		location.href ="delete_copy.jsp?year="+<%=maxYear%>+"&cnt="+cnt;	
	}
</script>

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
			<li class="nav-item"><a class="nav-link"
				href="../meeting/meeting.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>고객미팅 회의록</span></a></li>
					
			<!-- Nav Item - meeting -->
			<li class="nav-item"><a class="nav-link"
				href="../assessment/assessment.jsp"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>평가</span></a></li>

			<!-- Nav Item - manager page -->
			<%if(permission == 0){ %>
			<li class="nav-item active"><a class="nav-link"
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
							<h6 class="m-0 font-weight-bold text-primary" id="view_btn">관리자 페이지
								<select id="wp_year" name="wp_year" onchange="listLoad()">
									<%
										for(int i=0; i<yearCount; i++){%>
											<option value='<%=maxYear-i%>'><%=maxYear-i%></option>
									<%}%>
								</select>
							</h6>
							<div style="margin-top: 5px;">
								<button class="btn btn-primary" onClick="location.href='manager.jsp'" style="font-size:small; margin-right:5px;">관리자 메인</button>
								<button class="btn btn-primary" onclick="location.href ='teamSet.jsp'" style="font-size:small; margin-right:5px;">팀 관리</button>
								<button id="delete_copy" class="btn btn-primary" style="font-size:small; background-color: #364d91;" onclick="delete_previousYear()"><%=maxYear%>년 삭제</button>
								<button id="wp_copy" class="btn btn-primary" style="font-size:small; background-color: #364d91;" onclick="copy_nextYear()"><%=maxYear+1%>년 생성</button>
							</div>
							
						</div>
						<form method="post" action="workPlace_managePro.jsp">
						<div class="table-responsive" style="padding: 20px">
						
						 <input id="count" type="hidden" name="count">
						 <input id="year" type="hidden" name="year" value="<%=year%>">
						<table class="wpTable table table-bordered">
							<thead>
								<tr>
									<th>NO</th>
									<th>근무지</th>
									<th>파견비용(단위: 만)</th>
									<th>COLOR</th>
									<th>정렬순서</th>
									<th><input type="button" value="+"  class="btn btn-primary" onclick="rowAdd();"></th>
								</tr>
							</thead>
							<tbody id="workplaceList">
							<%
								for(int i=0; i<wpList.size(); i++){%>
									<tr>
										<td><%=i+1%></td>
										<td class="place_width"><input name="place" value="<%=wpList.get(i).getPlace()%>" ></td>
										<td class="place_width"><input name="cost" value="<%=wpList.get(i).getCost()%>"></td>
										<td class="place_width"><input type="color" name="color" value="<%=wpList.get(i).getColor()%>" ></td>
										<td class="place_width"><input name="order" value="<%=wpList.get(i).getOrder()%>"></td>
										<td><input class="deleteNP" type="button" onclick="deleteNP()" value="삭제"></td>
									</tr>									
							<%}%>
							</tbody>
						</table>
						
						</div>

						<!-- /.container-fluid -->

						<div id="manager_btn">
							<input type="submit" value="저장" class="btn btn-primary">
						</div>
						</form>
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
