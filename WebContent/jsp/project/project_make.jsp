<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.io.PrintWriter"
    import = "jsp.Bean.model.*"
    import = "jsp.DB.method.*"
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
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if (permission > 1){
		script.print("<script> alert('관리자가 아닙니다.'); history.back(); </script>");
	}

	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	session.setMaxInactiveInterval(15*60);
	
	ProjectDAO projectDao = new ProjectDAO();
	MemberDAO memberDao = new MemberDAO();
	ArrayList<String> teamList = projectDao.getTeamData();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();

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
	
		@media(max-width:800px){
		.container-fluid{
			padding: 0;
		}
		.card-header:first-child{
			padding: 0;
		}
		.card-body{
		padding:0;
		}
}
</style>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">

	$(document).ready(function () {
		$('.loading').hide();
		sortSelect('WORKER_LIST'); 
		workDelete();
	    // Warning
	    $(window).on('beforeunload', function(){
	        return "Any changes will be lost";
	    });
	    // Form Submit
	    $(document).on("submit", "form", function(event){
	        $(window).off('beforeunload');
	    });
	})
	
//정렬함수
function sortSelect(selId) {
	var sel = $('#'+selId);
	var optionList = sel.find('option');
	optionList.sort(function(a, b){
		if (a.text > b.text) return 1;
		else if (a.text < b.text) return -1;
		else { 
			if (a.value > b.value) return 1; 
			else if (a.value < b.value) return -1; 
			else return 0; 
			} 
		}); 
		sel.html(optionList); 
	}

//명단선택
function getSelectValue(){
	//팀, 이름 저장
	var a = $("#WORKER_LIST option:selected").text();
	var b = $("#WORKER_LIST option:selected").val();
	$("#textValue").append(a+"\n");
	var worker = a.split('-');
	var team = worker[0];
	var name = worker[1];
	var inner = "";
	inner += "<tr>";
	inner += "<td style='display:none;'>"+b+"</td>";
	inner += "<td>"+team+"</td>";
	inner += "<td>"+name+"</td>";
	inner += "<td><input type='button' class='workDel' value='삭제'/></td>";
	inner += "</tr>";
	$('#workerList > tbody:last').append(inner);
	//id 저장
	$("#textValue2").append(b+" ");
}

//명단삭제
function workDelete(){
	$(document).on("click",".workDel",function(){
		var str =""
		var tdArr = new Array();
		var btn = $(this);
		var tr = btn.parent().parent();
		var td = tr.children();
		var delID = td.eq(0).text();
		var text = $("#textValue2").text();
		var te = text.replace(delID+" ", "");
		$("#textValue2").text(te);
		tr.remove();
	});
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
              <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">프로젝트 생성</h6>
            </div>
            <div class="card-body">
            <div class="table-responsive">
            <form method="post" action="project_makePro.jsp">
                <table class="table table-bordered" id="dataTable">
                    <tr>
                      <th><span style="color:red;">*</span>팀</th>
                      <td>
                      	<select id="team" name="team">
                      	<%
                      		for(int i=0; i<teamList.size(); i++){
                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option><%
                      		}
                      	%>
                      	</select>
                      	</td>
                      </tr>
                      <tr>
                      	<th><span style="color:red;">*</span>프로젝트 코드</th>
                      	<td>
                      		<input name="PROJECT_CODE"  id="PROJECT_CODE" ></input>	
                      	</td>
                      </tr>
                      <tr>
                      <th><span style="color:red;">*</span>프로젝트 명</th>
                      <td>
                      	<input id="PROJECT_NAME" name="PROJECT_NAME"></input>
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>상태</th>
                      <td>
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
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>실</th>
                      <td><input name="PART" value="VT" ></td>
                      </tr>
                      
                      <tr>
                      <th>고객사</th>
                      <td>
                      	<input id="CLIENT" name="CLIENT"></input>
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>고객부서</th>
                     <td>
                      	<input id="CLIENT_PART" name="CLIENT_PART">
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>M/M</th>
                      <td>
                      	<input id="MAN_MONTH" name="MAN_MONTH" value="0"></input>
                      	</td>
					  </tr>
					  
					  <tr>
					  <th>프로젝트계약금액</th> 
					  <td>
                      	<input id="PROJECT_DESOPIT" name="PROJECT_DESOPIT" value="0"> (백만)</input>
                      	</td>
					  </tr>
					  
					  <tr>
					  <th>상반기수주</th> 
					  <td>
                      	<input id="FH_ORDER" name="FH_ORDER" value="0">
                      </td> 
					</tr>
						
						<tr>
						<th>상반기예상매출</th>
						<td>
                      		<input id="FH_SALES_PROJECTIONS" name="FH_SALES_PROJECTIONS" value="0">
                      	</td> 
						</tr>
						
						<tr>
						<th>상반기매출 </th>
						<td>
                      		<input id="FH_SALES" name="FH_SALES" value="0">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기수주 </th>
						<td>
                      		<input id="SH_ORDER" name="SH_ORDER" value="0">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기예상매출 </th>
						<td>
                      		<input id="SH_SALES_PROJECTIONS" name="SH_SALES_PROJECTIONS" value="0">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기매출 </th>
						<td>
                      		<input id="SH_SALES" name="SH_SALES" value="0"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>착수</th> 
						<td>
                      		<input id="PROJECT_START" name="PROJECT_START" placeholder="ex)0000-00-00"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>종료</th> 
						<td>
                      		<input id="PROJECT_END" name="PROJECT_END" placeholder="ex)0000-00-00"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th>고객담당자</th>
						<td>
                      		<input id="CLIENT_PTB" name="CLIENT_PTB"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th>근무지</th> 
						<td>
                      		<input id="WORK_PLACE" name="WORK_PLACE"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>업무</th>
						<td>
                      		<input id="WORK" name="WORK"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th><span style="color:red;">*</span>PM</th> 
						<td>
                      		<input id="PROJECT_MANAGER" name="PROJECT_MANAGER"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>투입 명단</th> 
						<td id ="WorkerList">
						<select id="WORKER_LIST" name="WORKER_LIST" onChange="getSelectValue();">
                      		 <option value="" selected disabled hidden>선택</option>
                      		<%
                      			for(int i=0; i<memberList.size(); i++){
                      				%><option value="<%=memberList.get(i).getID()%>"><%=memberList.get(i).getTEAM()%>-<%=memberList.get(i).getNAME()%></option><%		
                      			}
                      		%>
                      	</select>
                      	<textarea id="textValue2" name="WORKER_LIST2" style="display:none;"></textarea>
                      		<table id = "workerList" style="margin-top:5px;">
                      			<thead>
                      				<th style="display:none;">id</th>
                      				<th>팀</th>
                      				<th>이름</th>
                      				<th>  </th>
                      			</thead>
                      			<tbody id="workerListAdd">
                      			</tbody>
                      		</table>
                      	</td>
						</tr>
						<tr>
						<th>2020(상)평가유형</th> 
						<td>
                      		<input id="ASSESSMENT_TYPE" name="ASSESSMENT_TYPE"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>채용수요</th> 
						<td>
                      		<input id="EMPLOY_DEMAND" name="EMPLOY_DEMAND" value="0"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>외주수요</th>  
						<td>
                      		<input id="OUTSOURCE_DEMAND" name="OUTSOURCE_DEMAND" value="0"></input>
                      	</td>
                        </tr>
                  <tr align="center">
                  	<td  colspan="2">
                	<input id="COMPLETE" type="submit" name="COMPLETE" value="완료"  class="btn btn-primary">
       				 <a href="project.jsp" class="btn btn-primary">취소</a>
              		</td>
              	</tr>
              	  </table>
                </form>  
              </div>     		
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
