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
	String code = request.getParameter("code");
	String no = request.getParameter("no");
	ProjectBean project = projectDao.getProjectBean_code(code);
	MemberBean PMdata = memberDao.returnMember(project.getPROJECT_MANAGER());
	
	String[] workerID = {};	//투입명단 id 저장용
%>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">


  <title>Sure FVMS - Project_update</title>

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
	#Delete{
     right: 0;
     margin-right: 24px;
     display: inline-block;
     position: absolute;
     top: 9px;
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
	teamMember('#teamlist','#WORKER_LIST');
	
	$('#PM-team').val('<%=PMdata.getTEAM()%>').prop('selected', true);
	teamMember('#PM-team','#PROJECT_MANAGER');
	$("#team").val("<%=project.getTEAM()%>").prop("selected", true);
	$("#STATE").val("<%=project.getSTATE()%>").prop("selected", true);
	$('#PROJECT_MANAGER').val('<%=PMdata.getID()%>').prop("selected", true);
	$("input:radio[name='reportCheck']:radio[value='<%=project.getREPORTCHECK()%>']").prop("checked", true);
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
	var team = $("#teamlist option:selected").val();
	var id = $("#WORKER_LIST option:selected").val();
	var name = $("#WORKER_LIST option:selected").text();
	var inner = "";
	inner += "<tr>";
	inner += "<td style='display:none;'>"+id+"</td>";
	inner += "<td>"+team+"</td>";
	inner += "<td>"+name+"</td>";
	inner += "<td><input type='button' class='workDel' value='삭제'/></td>";
	inner += "</tr>";
	$('#workerList > tbody:last').append(inner);
	//id 저장
	$("#textValue2").append(id+" ");
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

//팀별 명단
function teamMember(team, member){
	var team1 = $(team).val();
	var memberName;
	var memberID;
	var dfselect = $("<option selected disabled hidden>선택</option>");
	$(member).empty();
	$(member).append(dfselect);
	
	<%
		for(int j=0; j<memberList.size(); j++){
			%>if(team1 == '<%=memberList.get(j).getTEAM()%>'){
				memberName = '<%=memberList.get(j).getNAME()%>';
				memberID = '<%=memberList.get(j).getID()%>';
				var option = $("<option value="+memberID+">"+ memberName +"</option>");
				$(member).append(option);
				if('팀장' == '<%=memberList.get(j).getPosition()%>' || '실장' == '<%=memberList.get(j).getPosition()%>'){
					$("#PROJECT_MANAGER").val(memberID).attr("selected", "selected");
				}
			}
			
	<%}%>
}

function defaultTeam(){
	var team = $("#team option:selected").val();
	$("#PM-team").val(team).attr("selected", "selected");
	$("#teamlist").val(team).attr("selected", "selected");
	teamMember('#PM-team','#PROJECT_MANAGER');
	$("#teamlist").val(team).attr("selected", "selected");
	teamMember('#teamlist','#WORKER_LIST');
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

<!--프로젝트 수정 테이블 시작 *********************************************************** -->
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary" style="padding-left: 17px;">프로젝트 수정</h6>
	         	<a id="Delete" href="project_deletePro.jsp?code=<%=code%>" class="btn btn-secondary btn-icon-split" onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</a>
            </div>
            <div class="card-body">
            <div class="table-responsive">
            <form method="post" action="project_updatePro.jsp">
            	<input type="hidden" name="NO" value="<%=no%>">
                <table class="table table-bordered" id="dataTable">
                    <tr>
                      <th><span style="color:red;">*</span>팀</th>
                      <td>
                      	<select id="team" name="team" onchange="defaultTeam()">
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
                      		<input name="PROJECT_CODE"  id="PROJECT_CODE" value="<%=project.getPROJECT_CODE()%>"></input>	
                      	</td>
                      </tr>
                      <tr>
                      <th><span style="color:red;">*</span>프로젝트 명</th>
                      <td>
                      	<input id="PROJECT_NAME" name="PROJECT_NAME" value="<%=project.getPROJECT_NAME()%>"></input>
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>상태</th>
                      <td>
                      	<select id="STATE" name="STATE">
                      		<option value="상태">상태</option>
                      		<option value="1.예산확보">1.예산확보</option>
                      		<option value="2.고객의사">2.고객의사</option>
                      		<option value="3.제안단계">3.제안단계</option>
                      		<option value="4.업체선정">4.업체선정</option>
                      		<option value="5.진행예정">5.진행예정</option>
                      		<option value="6.진행중">6.진행중</option>
                      		<option value="7.종료">7.종료</option>
                      		<option value="8.Dropped">8.Dropped</option>
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
                      	<input id="CLIENT" name="CLIENT" value="<%=project.getCLIENT()%>"></input>
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>고객부서</th>
                     <td>
                      	<input id="CLIENT_PART" name="CLIENT_PART" value="<%=project.getClIENT_PART()%>">
                      	</td>
                      </tr>
                      
                      <tr>
                      <th>M/M</th>
                      <td>
                      	<input id="MAN_MONTH" name="MAN_MONTH" value="<%=project.getMAN_MONTH()%>"></input>
                      	</td>
					  </tr>
					  
					  <tr>
					  <th>프로젝트계약금액</th> 
					  <td>
                      	<input id="PROJECT_DESOPIT" name="PROJECT_DESOPIT" value="<%=project.getPROJECT_DESOPIT()%>"> (백만)</input>
                      	</td>
					  </tr>
					  
					  <tr>
					  <th>상반기수주</th> 
					  <td>
                      	<input id="FH_ORDER" name="FH_ORDER" value="<%=project.getFH_ORDER()%>">
                      </td> 
					</tr>
						
						<tr>
						<th>상반기예상매출</th>
						<td>
                      		<input id="FH_SALES_PROJECTIONS" name="FH_SALES_PROJECTIONS" value="<%=project.getFH_SALES_PROJECTIONS()%>">
                      	</td> 
						</tr>
						
						<tr>
						<th>상반기매출 </th>
						<td>
                      		<input id="FH_SALES" name="FH_SALES" value="<%=project.getFH_SALES()%>">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기수주 </th>
						<td>
                      		<input id="SH_ORDER" name="SH_ORDER" value="<%=project.getSH_ORDER()%>">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기예상매출 </th>
						<td>
                      		<input id="SH_SALES_PROJECTIONS" name="SH_SALES_PROJECTIONS" value="<%=project.getSH_SALES_PROJECTIONS()%>">
                      	</td>
						</tr>
						
						<tr>
						<th>하반기매출 </th>
						<td>
                      		<input id="SH_SALES" name="SH_SALES" value="<%=project.getSH_SALES()%>"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>착수</th> 
						<td>
                      		<input id="PROJECT_START" name="PROJECT_START" value="<%=project.getPROJECT_START()%>"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>종료</th> 
						<td>
                      		<input id="PROJECT_END" name="PROJECT_END" value="<%=project.getPROJECT_END()%>"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th>고객담당자</th>
						<td>
                      		<input id="CLIENT_PTB" name="CLIENT_PTB" value="<%=project.getCLIENT_PTB()%>"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th>근무지</th> 
						<td>
                      		<input id="WORK_PLACE" name="WORK_PLACE" value="<%=project.getWORK_PLACE()%>"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>업무</th>
						<td>
                      		<input id="WORK" name="WORK" value="<%=project.getWORK()%>"></input>
                      	</td> 
						</tr>
						
						<tr>
						<th><span style="color:red;">*</span>PM</th> 
						<td>
							<select id="PM-team" name="PM-team" onchange="teamMember('#PM-team','#PROJECT_MANAGER')">
								<%
		                      		for(int i=0; i<teamList.size(); i++){
		                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option><%
		                      		}
		                      	%>
							</select>
							<select id="PROJECT_MANAGER" name="PROJECT_MANAGER"></select>
                      	</td>
						</tr>
						
						<tr>
						<th>투입 명단</th> 
						<td id ="WorkerList">
							<select id="teamlist" name="teamlist" onchange="teamMember('#teamlist','#WORKER_LIST')">
								<%
		                      		for(int i=0; i<teamList.size(); i++){
		                      			%><option value="<%=teamList.get(i)%>"><%=teamList.get(i)%></option><%
		                      		}
		                      	%>
							</select>
						<select id="WORKER_LIST" name="WORKER_LIST" onChange="getSelectValue();"></select>
							
                      	<textarea id="textValue2" name="WORKER_LIST2" style="display:none;"><%if(project.getWORKER_LIST()!=null)%><%=project.getWORKER_LIST()%></textarea>
                      		<table id = "workerList" style="margin-top:5px;">
                      			<thead>
                      				<th style="display:none;">id</th>
                      				<th>팀</th>
                      				<th>이름</th>
                      				<th></th>
                      			</thead>
                      			<tbody id="workerListAdd">
                      				<%
                      				if(project.getWORKER_LIST().length() != 0) {
                      				workerID = project.getWORKER_LIST().split(" ");
                      				for(int c=0; c<workerID.length;c++){
										MemberBean member = memberDao.returnMember(workerID[c]); %>
	                      				<tr>
	                      					<td style='display:none;'><%=workerID[c]%></td>
	                      					<td><%=member.getTEAM()%></td>
	                      					<td><%=member.getNAME()%></td>
	                      					<td><input type='button' class='workDel' value='삭제'/></td>
	                      				</tr>
                      				<%}} %>
                      			</tbody>
                      		</table>
                      	</td>
						</tr>
						<tr>
						<th>2020(상)평가유형</th> 
						<td>
                      		<input id="ASSESSMENT_TYPE" name="ASSESSMENT_TYPE" value="<%=project.getASSESSMENT_TYPE()%>"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>채용수요</th> 
						<td>
                      		<input id="EMPLOY_DEMAND" name="EMPLOY_DEMAND" value="<%=project.getEMPLOY_DEMAND()%>"></input>
                      	</td>
						</tr>
						
						<tr>
						<th>외주수요</th>  
						<td>
                      		<input id="OUTSOURCE_DEMAND" name="OUTSOURCE_DEMAND" value="<%=project.getOUTSOURCE_DEMAND()%>"></input>
                      	</td>
                        </tr>
                        <tr>
                        <th><span style="color:red;">*</span>주간보고서</th>
                      	<td>
                      		<input type="radio" name="reportCheck" value="1">사용
							<input type="radio" name="reportCheck" value="0">미사용
                      	</td>
                        </tr>
                         <tr align="center">
                  	<td  colspan="2">
                        <input id="COMPLETE" type="submit" name="COMPLETE" value="수정"  class="btn btn-primary">
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
