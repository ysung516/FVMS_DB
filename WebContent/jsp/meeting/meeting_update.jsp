<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.Bean.model.*"
    %>
<!DOCTYPE html>
<html lang="en">

<head>
	<%
		request.setCharacterEncoding("UTF-8");
		PrintWriter script =  response.getWriter();
		if (session.getAttribute("sessionID") == null){
			script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../../html/login.html' </script>");
		}
		int permission = Integer.parseInt(session.getAttribute("permission").toString());
		String sessionID = session.getAttribute("sessionID").toString();
		String sessionName = session.getAttribute("sessionName").toString();
		if(permission > 3){
			script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
		}
		
		session.setMaxInactiveInterval(15*60);
		String no = request.getParameter("no");
		String MeetName = request.getParameter("MeetName");
		String writer = request.getParameter("writer");
		String MeetDate = request.getParameter("MeetDate");
		String MeetPlace = request.getParameter("MeetPlace");
		String attendees = request.getParameter("attendees");
		String MeetNote = request.getParameter("MeetNote");
		String nextPlan = request.getParameter("nextPlan");
		String [] P_MeetNote = MeetNote.split("\n");
		String [] P_nextPlan = nextPlan.split("\n");
		// 출력
		String [] line;
		
		
	%>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Sure FVMS - Meeting_view</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

$(document).ready(function () {
	$('.loading').hide();
    // Warning
    $(window).on('beforeunload', function(){
        return "Any changes will be lost";
    });
    // Form Submit
    $(document).on("submit", "form", function(event){
        $(window).off('beforeunload');
    });
})

</script>
<style>
	input{
		
		border:1px solid #b7b9cc6e;
		padding:5px;
		border-radius:5px;
	}
	#dataTable td{
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    }
	
	.meeting_table{
		width:100%;
	}
	
	.meeting_table td{
    border: 1px solid black;
    white-space: nowrap;
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

  fieldset{
	  border-top: 3px inset;
	  border-color: #5d7ace;        	
  }
  
  legend{
  	color:#1b3787!important;
  	font-size: 18px;
  	font-weight: 600;
  	width: auto;
  	padding: 5px;
  }
  
  .report_div{
	  padding-left: 15px;
	  padding-bottom: 15px;
	  }

</style>

<body id="page-top">
	
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
		      <span>인력</span></a>
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
			<li class="nav-item active">
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
         <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">회의록 수정</h6>
        </div>
          
         <div class="card-body">
           <div class="table-responsive">
           
           <form method ="post" action="meeting_updatePro.jsp" name="meet_update">
			<table class="table table-bordered" id="dataTable">
					<tr>
						<td class="m-0 text-primary" align="center" style="word-break: keep-all;">회의명</td>
						<td colspan="4"><input name="MeetName" style=width:100%; value="<%=MeetName%>" placeholder="<%=MeetName%>"></td>
					</tr>
					<tr>
						<td class="m-0 text-primary">작성자</td>
						<td colspan="4"><input name="NAME" style="width:100%;" value="<%=writer%>" placeholder="<%=writer%>"></td>
					</tr>
					<tr>
						<td class="m-0 text-primary">회의일시</td>
						<td colspan="4"  style="text-align:left"><input type="date" name="MeetDate" value="<%=MeetDate%>"></td> 
					</tr>
					<tr>
						<td class="m-0 text-primary">회의 장소</td>
						<td colspan="4"><input name="MeetPlace" style=width:100%; value="<%=MeetPlace%>" placeholder="<%=MeetPlace%>"></td>
					</tr>
					<tr>
						<td class="m-0 text-primary">참석자(슈어) </td>
						<td colspan="4"><input name="attendees" style=width:100%; value="<%=attendees%>" placeholder="<%=attendees%>"></td>
					</tr>
					<tr>
				      <td class="m-0 text-primary" align="center">참석자(고객사)</td>
				      <td colspan="4"><input name="attendees" style=width:100%; value="<%=attendees%>" placeholder="<%=attendees%>"></td>
			     </tr>
					<tr>
						<td class="m-0 text-primary" colspan="4"><h6>회의내용</h6>
						<textarea name="MeetNote" rows="10" style="width: 100%;border: 1px solid #d1d3e2;border-radius: 5px;"><%
							line = P_MeetNote;
							for(String li : line){
							%><%=li%><%
									}
						%></textarea></td>
					</tr>
					 <tr>
						<td class="m-0 text-primary" colspan="4"><h6>이슈사항</h6
						><textarea name="" rows="5" style="width: 100%;border: 1px solid #d1d3e2;border-radius: 5px;"></textarea></td>
					</tr>
					<tr>
						<td class="m-0 text-primary" colspan="4"><h6 style="display: inline-block;">향후일정</h6>
						<div style="display: inline-block;float: right;">
				      <input type="button" value="+"  class="btn btn-primary">
				      <input type="button"  value="-"  class="btn btn-primary">
				      </div>
						</td>
					</tr>
					<tr>
			     	<td class="m-0 text-primary">No</td>
						<td class="m-0 text-primary">항목</td>
						<td class="m-0 text-primary">기한</td>
						<td class="m-0 text-primary">담당</td>
					</tr>
					<tr>
					<td style="padding: 0px;border: 0px solid;"><input style="border-radius: 0;border-top: 0px;width:100%;"></td>
					<td style="padding: 0px;border: 0px solid;"><input style="border-radius: 0;border-top: 0px;width:100%;"></td>
					<td style="padding: 0px;border: 0px solid;"><input style="border-radius: 0;border-top: 0px;width:100%;"></td>
					<td style="padding: 0px;border: 0px solid;"><input style="border-radius: 0;border-top: 0px;width:100%;"></td>
					</tr>
					
			<tr>
			<td colspan="4" style="border-color: #fff;">
			<input type="submit" name="complete" id="complete" value="완료" onclick="ok_btn();" class="btn btn-primary" ></td>
			</tr>
				<input type="hidden" name="no" value="<%=no%>">
				<input type="hidden" name="writer" value="<%=writer%>">
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
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="../../html/login.html">Logout</a>
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
