<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

	<%
	
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		if(permission > 2){
			script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
		}
		
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		session.setMaxInactiveInterval(60*60);
		
		MemberDAO memberDao = new MemberDAO();
		ProjectDAO projectDao = new ProjectDAO();
		SchDAO schDao = new SchDAO();
		ArrayList<MemberBean> memberList = memberDao.getMemberData();
		ArrayList<ProjectBean> projectList = schDao.getProjectList_sch();
		ArrayList<schBean> schList = new ArrayList<schBean>();
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sf.format(nowTime);
		
		String str = "";
		
		
		ArrayList<ProjectBean> List1 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List11 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List12 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List13 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List14 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List15 = new ArrayList<ProjectBean>();
		
		ArrayList<ProjectBean> List2 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List21 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List22 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List23 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List24 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List25 = new ArrayList<ProjectBean>();
		
		
		ArrayList<ProjectBean> List3 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List31 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List32 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List33 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List34 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List35 = new ArrayList<ProjectBean>();
		
		ArrayList<ProjectBean> List4 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List41 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List42 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List43 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List44 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List45 = new ArrayList<ProjectBean>();
		
		ArrayList<ProjectBean> List5 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List51 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List52 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List53 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List54 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List55 = new ArrayList<ProjectBean>();
		
		ArrayList<ProjectBean> List6 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List61 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List62 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List63 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List64 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> List65 = new ArrayList<ProjectBean>();
		
		ArrayList<ProjectBean> ListT = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> ListT1 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> ListT2 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> ListT3 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> ListT4 = new ArrayList<ProjectBean>();
		ArrayList<ProjectBean> ListT5 = new ArrayList<ProjectBean>();
	
	%>
<body>
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
			<a class="sidebar-brand d-flex align-items-center justify-content-center"
				href="../summary/summary.jsp">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">Sure FVMS</div>
			</a>

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
					
			<li class="nav-item active"><a class="nav-link"
				href="../project_schedule/project_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>프로젝트 스케줄</span></a></li>
					
			<!-- Nav Item - manager schedule -->
			<li class="nav-item"><a class="nav-link"
				href="../manager_schedule/manager_schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>관리자 스케줄</span></a></li>

			<!-- Nav Item - report -->
			<li class="nav-item"><a class="nav-link"
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


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="flex-column" style="display: inline">

			<!-- Main Content -->
			

				<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

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
				<h6 class="m-0 font-weight-bold text-primary">Schedule</h6>
				<div class="tableST">
				<div class="table-responsive">
				<table class="memberTable" id="dataTable">
				<thead>
	                  <tr style="background-color:#15a3da52;">
		                    <th></th>
		                    <th>total</th>
		                    <th>수석</th>
		                    <th>책임</th>
		                    <th>선임</th>
		                    <th>전임</th>
		                    <th>인턴</th>
	                    </tr>
                    </thead>
                    <tbody>
	                    <tr>
		                    <th>미래차검증전략실</th>
		                    <td onclick="drawChartOp('미래차검증전략실','total')"><%=List1.size()%></td>
		                    <td onclick="drawChartOp('미래차검증전략실','수석')"><%=List11.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','책임')"><%=List12.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','선임')"><%=List13.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','전임')"><%=List14.size() %></td>
		                    <td onclick="drawChartOp('미래차검증전략실','인턴')"><%=List15.size() %></td>
	                    </tr>
	                   <tr>
	          		 		<th>샤시힐스검증팀</th>
	                 		<td onclick="drawChartOp('샤시힐스검증팀','total')"><%=List2.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','수석')"><%=List21.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','책임')"><%=List22.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','선임')"><%=List23.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','전임')"><%=List24.size()%></td>
		                    <td onclick="drawChartOp('샤시힐스검증팀','인턴')"><%=List25.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>바디힐스검증팀</th>
	                   		<td onclick="drawChartOp('바디힐스검증팀','total')"><%=List3.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','수석')"><%=List31.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','책임')"><%=List32.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','선임')"><%=List33.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','전임')"><%=List34.size()%></td>
		                    <td onclick="drawChartOp('바디힐스검증팀','인턴')"><%=List35.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>제어로직검증팀</th>
	                   		<td onclick="drawChartOp('제어로직검증팀','total')"><%=List4.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','수석')"><%=List41.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','책임')"><%=List42.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','선임')"><%=List43.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','전임')"><%=List44.size()%></td>
		                    <td onclick="drawChartOp('제어로직검증팀','인턴')"><%=List45.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>기능안전검증팀</th>
	                   		<td onclick="drawChartOp('기능안전검증팀','total')"><%=List5.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','수석')"><%=List51.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','책임')"><%=List52.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','선임')"><%=List53.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','전임')"><%=List54.size()%></td>
		                    <td onclick="drawChartOp('기능안전검증팀','인턴')"><%=List55.size()%></td>
	                   </tr> 
	                   <tr>
	          		 		<th>자율주행검증팀</th>
	                   		<td onclick="drawChartOp('자율주행검증팀','total')"><%=List6.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','수석')"><%=List61.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','책임')"><%=List62.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','선임')"><%=List63.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','전임')"><%=List64.size()%></td>
		                    <td onclick="drawChartOp('자율주행검증팀','인턴')"><%=List65.size()%></td>
	                   </tr>
						<tr>
	          		 		<th>total</th>
	                        <td onclick="drawChartOp('total','total')"><%=ListT.size()%></td>
		                    <td onclick="drawChartOp('total','수석')"><%=ListT1.size()%></td>
		                    <td onclick="drawChartOp('total','책임')"><%=ListT2.size()%></td>
		                    <td onclick="drawChartOp('total','선임')"><%=ListT3.size()%></td>
		                    <td onclick="drawChartOp('total','전임')"><%=ListT4.size()%></td>
		                    <td onclick="drawChartOp('total','인턴')"><%=ListT5.size()%></td>
	                   </tr>
                   </tbody>
                </table>
                </div>
				
				<div class="table-responsive"style="height: 664px;">
				<table class="table table-bordered">
	                <thead>
	                    <tr  style="text-align:center;background-color:#15a3da52;">
		                    <th>소속</th>
		                    <th>팀</th>
		                    <th>이름</th>
		                    <th>직급</th>
		                    <th>Mobile</th>
		                    <th>주소</th>
							<th>프로젝트 수행이력</th>	                   	         
	                    </tr>
                    </thead>
                    <tbody id="memberINFO"></tbody>
                </table>
                </div>
        
                </div>
                <div id="timelineChart"></div>


			</div>			
						<!-- /.container-fluid -->
				
					<!-- End of Main Content -->
			
				<!-- End of Content Wrapper -->
			
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