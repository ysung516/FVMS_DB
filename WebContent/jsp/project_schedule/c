<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.PrintWriter" import="java.util.ArrayList" 
    import="jsp.Bean.model.*" import="jsp.DB.method.*"
    import="java.util.Date"
	import="java.text.SimpleDateFormat"
	import="java.util.HashMap"
	import="java.util.LinkedHashMap"
    %>
<!DOCTYPE html>
<html>
<head>
<style>
#timelineChart{
	height : 1050px;
}

.endline{
	page-break-before:always
	}
#select_info{
	margin-top:50px;
}
th{
	text-align: left;
	padding: 5px;
}
td{
	padding: 5px;
}

</style>
<meta charset="UTF-8">
<title>Project TimelineChart</title>


<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	ProjectDAO projectDao = new ProjectDAO();
	HashMap<String, ArrayList<Project_sch_Bean>> projectList = projectDao.getProjectList_team();
	MemberDAO memberDao = new MemberDAO();
	LinkedHashMap<Integer, String> teamList = memberDao.getTeam();
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	int year = Integer.parseInt(date.split("-")[0]); // 이번 년도
	
	// 실, 팀별 프로젝트 정보 HashMap<팀명, ArrayList<프로젝트스케줄빈>>
	HashMap<String, ArrayList<Project_sch_Bean>> projectMap = new HashMap<String, ArrayList<Project_sch_Bean>>();
	for(int key : teamList.keySet()){
		ArrayList<Project_sch_Bean> teamProject = projectList.get(teamList.get(key));
		projectMap.put(teamList.get(key), teamProject);
	}
	
	// 실, 팀 프로젝트 상태별 개수 HashMap<팀명, HashMap<상태, 개수>>
	HashMap<String, HashMap<String, Integer>> projectNum = new HashMap<String, HashMap<String, Integer>>();
	for(int key : teamList.keySet()){
		HashMap<String, Integer> projectState = new HashMap<String, Integer>();
		for(Project_sch_Bean i : projectMap.get(teamList.get(key))){
			if(projectState.containsKey(i.getSTATE())){
				projectState.put(i.getSTATE(), projectState.get(i.getSTATE())+1);
			}else{
				projectState.put(i.getSTATE(), 1);
			}
		}
		projectNum.put(teamList.get(key), projectState);
	}
	
%>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["timeline"]});
google.charts.setOnLoadCallback(drawChart);

function nowLine(div){
	//get the height of the timeline div
		var height;
	  $('#' + div + ' rect').each(function(index){
	  	var x = parseFloat($(this).attr('x'));
	    var y = parseFloat($(this).attr('y'));
	    if(x == 0 && y == 0) {height = parseFloat($(this).attr('height'))}
	  })
		var nowWord = $('#' + div + ' text:contains("Now")');
	  nowWord.prev().first().attr('height', height + 'px').attr('width', '1px').attr('y', '0');
	}

function drawChart() {
	   	<%
	   	String nowYear = sf.format(nowTime).split("-")[0];
	   	int preYear = Integer.parseInt(nowYear) - 1;
	   	int nextYear = Integer.parseInt(nowYear) + 1;
	   	StringBuffer strColor = new StringBuffer();
		%>
  var container = document.getElementById('timelineChart');
  var chart = new google.visualization.Timeline(container);
  var dataTable = new google.visualization.DataTable();

  dataTable.addColumn({ type: 'string', id: 'Position' });
  dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
  dataTable.addColumn({ type: 'string', role: 'tooltip' });
  dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
  dataTable.addColumn({ type: 'date', id: 'Start' });
  dataTable.addColumn({ type: 'date', id: 'End' });
  dataTable.addRows([
  		['\0', 'Now','','',new Date(), new Date()],
  		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
    		<%for(String key : projectList.keySet()){
   		for(int b=0; b<projectList.get(key).size(); b++){%>
   			,[	'<%=projectList.get(key).get(b).getTEAM_ORDER()%>'
   				,'<%=projectList.get(key).get(b).getPROJECT_NAME()%>'
   				,'<div class = "tooltip-padding"> <h7><strong><%=projectList.get(key).get(b).getPROJECT_NAME()%></strong></h7>' + '<hr style ="border:solid 1px;color:black">'
   				+'<p><b>PM : </b><%=projectList.get(key).get(b).getPROJECT_MANAGER()%><br>'
   				+'<b>투입명단 : </b><%=projectList.get(key).get(b).getWORKER_LIST()%></p>' 
   				+'<b>착수일 : </b><%=projectList.get(key).get(b).getPROJECT_START()%><br><b>종료일 : </b><%=projectList.get(key).get(b).getPROJECT_END()%></div>'
   				,'<%=projectList.get(key).get(b).getColor()%>'
   				, new Date('<%=projectList.get(key).get(b).getPROJECT_START()%>'), new Date('<%=projectList.get(key).get(b).getPROJECT_END()%>')]
   		<%}}%>
     ]);
    
     var options = {
     	timeline: { colorByRowLabel: false, groupByRowLabel: true }
     };
     
         chart.draw(dataTable, options);
        	nowLine('timelineChart');
    	  
    	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
    		if(obj.row == 0){
    			$('.google-visualization-tooltip').css('display', 'none');
    		}
    	    nowLine('timelineChart');
    	  })
    	  
    	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
    	  	nowLine('timelineChart');
    	  })

     	var st = container.getElementsByTagName("div")[0];
		st.style.position = 'inherit';
   }
   
   
   
function defaultTotal(){
	for(var j=0;j<9;j++){
    	var total_step = 0;
		for(var i=1;i<7;i++){
    		total_step += Number($("#infoTable tbody tr:eq(" + j + ") td:eq(" + i + ")").text());
    	}
		$("#infoTable tbody tr:eq(" + j + ") td:eq(0)").html(total_step);
    }
}

function clickfun(state, team){
	var inner = "";
	<%for(String key : projectList.keySet()){%>
		if(team == '<%=key%>'){
			<%for(Project_sch_Bean i : projectList.get(key)){%>
				if(state == '<%=i.getSTATE()%>'){
					inner += '<tr>';
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					if(<%=permission%> == 0){
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
	  				}else{
	  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
	  				}
					inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
					inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
					inner += "</tr>";
				}else if(state == 'total'){
					inner += "<tr>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
 					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
 					if(<%=permission%> == 0){
	  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
	  				}else{
	  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
	  				}
					inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
					inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
					inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
					inner += "</tr>";
				}
			<%}%>
		}else if(team == 'total'){
			<%for(Project_sch_Bean i : projectList.get(key)){%>
			if(state == '<%=i.getSTATE()%>'){
				inner += "<tr>";
				inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
					if(<%=permission%> == 0){
  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
  				}else{
  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
  				}
				inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
				inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
				inner += "</tr>";
			}else if(state == 'total'){
				inner += "<tr>";
				inner += "<td><div class='teamover'>"+'<%=i.getTEAM_ORDER()%>'+"</div></td>";
					inner += "<td><div class='teamover'>"+'<%=i.getTEAM_SALES()%>'+"</div></td>";
					if(<%=permission%> == 0){
  					inner += "<td><div class='textover'><a href='../project/project_update.jsp?no=<%=i.getNO()%>&year=<%=year%>'>"+"<%=i.getPROJECT_NAME()%>"+"</a></div></td>";
  				}else{
  					inner += "<td><div class='textover'>"+"<%=i.getPROJECT_NAME()%>"+"</div></td>";
  				}
				inner += "<td><div class='teamover'>"+'<%=i.getCLIENT()%>'+"</div></td>";
				inner += "<td>"+'<%=i.getPROJECT_START()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_END()%>'+"</td>";
				inner += "<td>"+'<%=i.getPROJECT_MANAGER()%>'+"</td>";
				inner += "</tr>";
			}
		<%}%>
		}
	<%}%>

	$('#projectINFO').empty();
	$('#projectINFO').append(inner);
}
   
	//페이지 시작시 호출 함수
	$(document).ready(function (){
		document.body.style.zoom=0.8;
		defaultTotal();
		drawChart('timelineChart');
	});
</script>

</head>
<body>
	<div id="timelineChart"></div>
	<div class="endline"></div><br style="height:0; line-height:0">
				<table class="memberTable" id="infoTable" style="font-size:14px;">
					<thead>
	                  <tr style="background-color:#15a3da52;">
		                    <th>상태</th>
		                    <th>Total</th>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<th><%=teamList.get(key).substring(0, 4) %></th>
		                    	<%} 
		                    }%>
		                    <th>실</th>
	                    </tr>
                    </thead>
                    <tbody>
	                    <tr id="step1">
		                    <th style="text-align:left">1.예산확보</th>
		                    <td onclick="clickfun('1.예산확보', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('1.예산확보', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("1.예산확보")!=null){%><%=projectNum.get(teamList.get(key)).get("1.예산확보") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('1.예산확보', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("1.예산확보")!=null){%><%=projectNum.get(teamList.get(0)).get("1.예산확보") %><%}else{ %>0<%} %></td>
	                    </tr>
	                   <tr id="step2">
		                    <th style="text-align:left">2.고객의사</th>
		                    <td onclick="clickfun('2.고객의사', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('2.고객의사', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("2.고객의사")!=null){%><%=projectNum.get(teamList.get(key)).get("2.고객의사") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('2.고객의사', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("2.고객의사")!=null){%><%=projectNum.get(teamList.get(0)).get("2.고객의사") %><%}else{ %>0<%} %></td>
	                    </tr> 
	                   <tr id="step3">
		                    <th style="text-align:left">3.제안단계</th>
		                    <td onclick="clickfun('3.제안단계', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('3.제안단계', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("3.제안단계")!=null){%><%=projectNum.get(teamList.get(key)).get("3.제안단계") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('3.제안단계', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("3.제안단계")!=null){%><%=projectNum.get(teamList.get(0)).get("3.제안단계") %><%}else{ %>0<%} %></td>
	                    </tr> 
	                   <tr id="step4">
		                    <th style="text-align:left">4.업체선정</th>
		                    <td onclick="clickfun('4.업체선정', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('4.업체선정', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("4.업체선정")!=null){%><%=projectNum.get(teamList.get(key)).get("4.업체선정") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('4.업체선정', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("4.업체선정")!=null){%><%=projectNum.get(teamList.get(0)).get("4.업체선정") %><%}else{ %>0<%} %></td>
	                    </tr> 
	                   <tr id="step5">
		                    <th style="text-align:left">5.진행예정</th>
		                    <td onclick="clickfun('5.진행예정', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('5.진행예정', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("5.진행예정")!=null){%><%=projectNum.get(teamList.get(key)).get("5.진행예정") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('5.진행예정', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("5.진행예정")!=null){%><%=projectNum.get(teamList.get(0)).get("5.진행예정") %><%}else{ %>0<%} %></td>
	                    </tr> 
	                   <tr id="step6">
		                    <th style="text-align:left">6.진행중</th>
		                    <td onclick="clickfun('6.진행중', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('6.진행중', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("6.진행중")!=null){%><%=projectNum.get(teamList.get(key)).get("6.진행중") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('6.진행중', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("6.진행중")!=null){%><%=projectNum.get(teamList.get(0)).get("6.진행중") %><%}else{ %>0<%} %></td>
	                    </tr>
						<tr id="step7">
		                    <th style="text-align:left">7.종료</th>
		                    <td onclick="clickfun('7.종료', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('7.종료', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("7.종료")!=null){%><%=projectNum.get(teamList.get(key)).get("7.종료") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('7.종료', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("7.종료")!=null){%><%=projectNum.get(teamList.get(0)).get("7.종료") %><%}else{ %>0<%} %></td>
	                    </tr>
						<tr id="step8">
		                    <th style="text-align:left">8.Dropped</th>
		                    <td onclick="clickfun('8.Dropped', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('8.Dropped', '<%=teamList.get(key)%>')"><%if(projectNum.get(teamList.get(key)).get("8.Dropped")!=null){%><%=projectNum.get(teamList.get(key)).get("8.Dropped") %><%}else{ %>0<%} %></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('8.Dropped', '<%=teamList.get(0)%>')"><%if(projectNum.get(teamList.get(0)).get("8.Dropped")!=null){%><%=projectNum.get(teamList.get(0)).get("8.Dropped") %><%}else{ %>0<%} %></td>
	                   </tr>
					   <tr id="step9">
		                    <th style="text-align:left">Total</th>
		                    <td onclick="clickfun('total', 'total')"></td>
		                    <%for(int key : teamList.keySet()){ 
		                    	if(key != 0){%>
		                    	<td onclick="clickfun('total', '<%=teamList.get(key)%>')"><%=projectMap.get(teamList.get(key)).size()%></td>
		                    	<%} 
		                    }%>
		                    <td onclick="clickfun('total', '<%=teamList.get(0)%>')"><%=projectMap.get(teamList.get(0)).size()%></td>
	                   </tr>
                   </tbody>
                </table>
                
                <table class="table table-bordered" id="select_info" style="font-size:12px;">
	                <thead> 
	                    <tr style="text-align:center;background-color:#15a3da52;">
		                    <th style="width:12%;">팀(수주)</th>
		                    <th style="width:12%;">팀(매출)</th>
		                    <th style="width:29%;">프로젝트명</th>
		                    <th style="width:13%;">고객사</th>
		                    <th style="width:13%;">착수</th>
		                    <th style="width:13%;">종료</th>
		                    <th style="width:8%;">PM</th>                 	         
	                    </tr>
                    </thead>
                    <tbody id="projectINFO"></tbody>
                </table>
</body>
</html>