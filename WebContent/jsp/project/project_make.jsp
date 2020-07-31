<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.sheet.method.*"
    import = "jsp.Bean.model.MSC_Bean"
    import = "java.util.ArrayList"
    import = "java.util.Date"
    import = "java.text.SimpleDateFormat" %>
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

%>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">


  <title>Sure FVMS - Project_Make</title>

  <!-- Custom fonts for this template-->
  <link href="../../vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="../../https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
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
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
	<!-- 로딩화면 -->
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
	
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
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../summary/summary.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Sure FVMS</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

    

      <!-- Heading -->
    

    
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
      		<li class="nav-item active">
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
			<%if(sessionID.equals("ymyou")){ %>
			<li class="nav-item">
			  <a class="nav-link" href="https://docs.google.com/spreadsheets/d/19MC9jOiCncDi06I5ZgoIEMQbt7cMSor-gU2Zehyo__c/edit#gid=607226601">
			  <i class="fas fa-fw fa-clipboard-list"></i> 
			  <span>관리자페이지</span></a>
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
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">홍길동</span>
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

<!--프로젝트 생성 테이블 시작 *********************************************************** -->
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">프로젝트 생성</h6>
            </div>
            <div class="card-body" style="width: 75%; margin: 0 auto;">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <tr>
                      <th>팀</th>
                      <th>
                      	<select id="team" name="team">
                      		<option value="바디힐스">팀</option>
                      		<option value="기능안전">기능안전</option>
                      		<option value="자율주행">자율주행</option>
                      		<option value="제어로직">제어로직</option>
                      		<option value="샤시힐스">샤시힐스</option>
                      	</select>
                      	</th>
                      </tr>
                      <tr>
                      	<th>프로젝트 코드</th>
                      	<th>
                      		<input name="PROJECT_CODE"  id="PROJECT_CODE" ></input>	
                      	</th>
                      </tr>
                      <tr>
                      <th>프로젝트 명</th>
                      <th>
                      	<input id="PROJECT_NAME" name="PROJECT_NAME"></input>
                      	</th>
                      </tr>
                      
                      <tr>
                      <th>상태</th>
                      <th>
                      	<select id="STATE" name="STATE">
                      		<option value="상태">상태</option>
                      		<option value="예산확보">1.예산확보</option>
                      		<option value="고객의사">2.고객의사</option>
                      		<option value="제안단계">3.제안단계</option>
                      		<option value="업체선정">4.업체선정</option>
                      		<option value="진행예정">5.진행예정</option>
                      		<option value="진행중">6.진행중</option>
                      		<option value="종료">7.종료</option>
                      		<option value="Dropped">8.Dropped</option>
                      	</select>
                      	</th>
                      </tr>
                      
                      <tr>
                      <th>실</th>
                      <th>
                      	<input id="PART" name="PART"></input>
                      	</th>
                      </tr>
                      
                      <tr>
                      <th>고객사</th>
                      <th>
                      	<input id="CLIENT" name="CLIENT"></input>
                      	</th>
                      </tr>
                      
                      <tr>
                      <th>고객부서</th>
                      <th>
                      	<input id="CLINET_PART" name="CLINET_PART"></input>
                      	</th>
                      </tr>
                      
                      <tr>
                      <th>M/M</th>
                      <th>
                      	<input id="MAN_MONTH" name="MAN_MONTH"></input>
                      	</th>
					  </tr>
					  
					  <tr>
					  <th>프로젝트계약금액</th> 
					  <th>
                      	<input id="PROJECT_DESOPIT" name="PROJECT_DESOPIT"> (백만)</input>
                      	</th>
					  </tr>
					  
					  <tr>
					  <th>상반기수주</th> 
					  <th>
                      	<input id="FH_ORDER " name="FH_ORDER "></input>
                      	</th> 
						</tr>
						
						<tr>
						<th>상반기예상매출</th>
						<th>
                      	<input id="FH_SALES_PROJECTIONS" name="FH_SALES_PROJECTIONS"></input>
                      	</th> 
						</tr>
						
						<tr>
						<th>상반기매출 </th>
						<th>
                      	<input id="FH_SALES" name="FH_SALES"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>하반기수주 </th>
							<th>
                      	<input id="SH_ORDER" name="SH_ORDER"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>하반기예상매출 </th>
						<th>
                      	<input id="SH_SALES_PROJECTIONS" name="SH_SALES_PROJECTIONS"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>하반기매출 </th>
						<th>
                      	<input id="SH_SALES" name="SH_SALES"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>착수</th> 
						<th>
                      	<input id="PROJECT_START" name="PROJECT_START"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>종료</th> 
							<th>
                      	<input id="PROJECT_END" name="PROJECT_END"></input>
                      	</th> 
						</tr>
						
						<tr>
						<th>고객담당자</th>
						<th>
                      	<input id="CLIENT_PTB" name="CLIENT_PTB"></input>
                      	</th> 
						</tr>
						
						<tr>
						<th>근무지</th> 
						<th>
                      	<input id="WORK_PLACE" name="WORK_PLACE"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>업무</th>
						<th>
                      	<input id="WORK" name="WORK"></input>
                      	</th> 
						</tr>
						
						<tr>
						<th>PM</th> 
						<th>
                      	<input id="PROJECT_MANAGER" name="PROJECT_MANAGER"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>투입 명단</th> 
						<th>
                      	<select id="WORKER_LIST" name="WORKER_LIST">
                      		<option value="투입명단">투입명단</option>
                      	</select>
                      	</th>
						</tr>
						
						<tr>
						<th>2020(상)평가유형</th> 
						<th>
                      	<input id="ASSESSMENT_TYPE" name="ASSESSMENT_TYPE"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>채용수요</th> 
						<th>
                      	<input id="EMPLOY_DEMAND" name="EMPLOY_DEMAND"></input>
                      	</th>
						</tr>
						
						<tr>
						<th>외주수요</th>  
						<th>
                      	<input id="OUTSOURCE_DEMAND" name="OUTSOURCE_DEMAND"></input>
                      	</th>
                        </tr>   
                </table>       
              </div>     		
            </div>
              <div class="card-body" style="margin: 0 auto;">
                	<input id="COMPLETE" type="submit" name="COMPLETE" value="완료"  class="btn btn-primary">
       				 <a href="project.jsp" class="btn btn-primary">취소</a>
              </div>
          </div>
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
    <div class="modal-body">Select "Logout" below if you are ready  to end your current session.</div>
    <div class="modal-footer">
     <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
    <form method = "post" action = "../LogoutPro.jsp">
     	  <input type="submit" class="btn btn-primary" value="Logout" />
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
