<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.Bean.model.*"
    import = "java.util.ArrayList"
    import = "java.util.List"
    import = "jsp.DB.method.*"
    %>
<!DOCTYPE html>
<html lang="en">

<head>
	<%
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		session.setMaxInactiveInterval(15*60);
		
		MemberDAO memberDao = new MemberDAO();
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		String id = request.getParameter("id");
		MemberBean member = memberDao.returnMember(id);
	%>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Manager_view</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

	function btn_event(){
		if (confirm("비밀번호를 초기화합니다.") == true){
			return 1;
		}else{
			 return;
			 return -l;
		}
	}
	
	
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
	#Delete{
		     right: 0;
		     margin-right: 24px;
		     display: inline-block;
		     position: absolute;
		     top: 9px;
		    }
	#dataTable td:nth-child(odd){
    text-align: center;
    vertical-align: middle;
    word-break:keep-all;
    width:20%;
    }

	.loading{
		position:fixed;
		text-align: center;
		width:100%;
		height:100%;
		top:0;
		left:0;
		font-size:8px;
		background-color: #4e73df6b;
  	  	background-image: linear-gradient(181deg,#3d5482 16%,#6023b654 106%);
  	  	background-size: cover;
        z-index:1000;
        color:#ffffffc4;
	}
	.loading #load{
		position:fixed;
		top:50%;
		left: 50%;
		transform:translate(-50%, -50%);
	}

	@media(max-width:800px){
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
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
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../summary/summary.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Sure FVMS</div>
      </a>

    <!-- Divider -->
			<hr class="sidebar-divider my-0">
			
			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../mypage/mypage.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>마이페이지</span></a>
	     	</li>

			<!-- Nav Item - summary -->
		    <li class="nav-item">
	          <a class="nav-link" href="../summary/summary.jsp">
	          <i class="fas fa-fw fa-table"></i>
	          <span>요약정보</span></a>
	     	</li>
      
       		<!-- Nav Item - project -->
      		<li class="nav-item ">
     	     <a class="nav-link" href="../project/project.jsp">
             <i class="fas fa-fw fa-clipboard-list"></i>
             <span>프로젝트</span></a>
     	    </li>
      
		    <!-- Nav Item - rowdata -->
		    <li class="nav-item">
		      <a class="nav-link" href="../rowdata/rowdata.jsp">
		      <i class="fas fa-fw fa-chart-area"></i>
		      <span>멤버</span></a>
     		</li>
     		
	      <!-- Nav Item - schedule -->
	      <li class="nav-item">
	        <a class="nav-link" href="../schedule/schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>스케줄</span></a>
	      </li>
	      
	       <!-- Nav Item - manager schedule -->
	      <li class="nav-item">
	        <a class="nav-link" href="../manager_schedule/manager_schedule.jsp">
	        <i class="fas fa-fw fa-calendar"></i>
	        <span>관리자 스케줄</span></a>
	      </li>
		
		  <!-- Nav Item - report -->
			<li class="nav-item">
			  <a class="nav-link" href="../report/report.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>주간보고서</span></a>
			</li>
      
        <!-- Nav Item - meeting -->
			<li class="nav-item">
			  <a class="nav-link" href="../meeting/meeting.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>회의록</span></a>
			</li>
	  	<!-- Nav Item - manager page -->
     	<%if(permission == 0){ %>
			<li class="nav-item">
			  <a class="nav-link" href="../manager/manager.jsp">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>관리자 페이지</span></a>
			</li>
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
         	<h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;"><%=member.getNAME()%> 정보 조회</h6>
         	<form method="post" action="manager_deletePro.jsp">
         		<input type="hidden" name="id" value="<%=id%>">
         		<input id="Delete" type="submit" name="Delete" value="삭제"  class="btn btn-primary" >
         	</form>
        </div>
          
         <div class="card-body">
           <div class="table-responsive">
         <form method="post" action="reset_pwdPro.jsp">
         <input type="hidden" name="id" value="<%=id%>">  
					<table class="table table-bordered" id="dataTable">
					<tr>
						<td>팀</td>
						<td><%=member.getTEAM()%></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><%=member.getNAME()%></td>
					</tr>
					<tr>
						<td>권한</td>
						<td><%=member.getPermission()%></td>
					</tr>
					<tr>
						<td>소속</td>
						<td><%=member.getPART()%></td>
					</tr>
					<tr>
						<td>직급</td>
						<td><%=member.getRANK()%></td>
					</tr>
					<tr>
						<td>직책</td>
						<td><%=member.getPosition()%></td>
					</tr>
					<tr>
						<td>mobile</td>
						<td><%=member.getMOBILE()%></td>
					</tr>
					<tr>
						<td>gmail</td>
						<td><%=member.getGMAIL()%></td>
					</tr>
					<tr>
						<td>거주지</td>
						<td><%=member.getADDRESS()%></td>
					</tr>
					<tr>
						<td>연차</td>
						<td><%=member.getWyear()%></td>
					</tr>
					<tr>
						<td>입사일</td>
						<td><%=member.getComDate()%></td>
					</tr>
					<tr>
						<td>프로젝트 수행 이력</td>
						<td><%=member.getCareer()%></td>
					</tr>
					<tr>
						<td>ID</td>
						<td><%=member.getID()%></td>
					</tr>
				
          

	     <tr>
	     <td colspan="2">
	       <a href="manager_update.jsp?id=<%=id%>" class="btn btn-primary">수정</a>
	       <a href="manager.jsp" class="btn btn-primary">목록</a>
	       	<input id="reset" type="submit" value="비밀번호 초기화" class="btn btn-primary" onclick="btn_event();">
	        
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
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

<!-- Logout Modal-->
 <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <form method = "post" action = "../LogoutPro.jsp">
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