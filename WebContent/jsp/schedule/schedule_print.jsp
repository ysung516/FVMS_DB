<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sure FVMS - Schedule Print</title>
<%
	PrintWriter script =  response.getWriter();
	if (session.getAttribute("sessionID") == null){
		script.print("<script> alert('세션의 정보가 없습니다.'); location.href = '../login.jsp' </script>");
	}
	int permission = Integer.parseInt(session.getAttribute("permission").toString());
	if(permission > 2){
		script.print("<script> alert('접근 권한이 없습니다.'); history.back(); </script>");
	}
	
	String sessionID = session.getAttribute("sessionID").toString();
	String sessionName = session.getAttribute("sessionName").toString();
	
	MemberDAO memberDao = new MemberDAO();
	ProjectDAO projectDao = new ProjectDAO();
	SchDAO schDao = new SchDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();
	ArrayList<ProjectBean> projectList = schDao.getProjectList_sch();
	ArrayList<schBean> schList = new ArrayList<schBean>();
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	
	
	ArrayList<String> userID = new ArrayList<String>();
	ArrayList<String> userName = new ArrayList<String>();
	
	for(int i=0; i<memberList.size(); i++){
		userID.add(memberList.get(i).getID());
		userName.add(memberList.get(i).getNAME());
	}
	
	String str = "";

	
	ArrayList<MemberBean> List1 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List11 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List12 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List13 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List14 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List15 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List2 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List21 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List22 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List23 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List24 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List25 = new ArrayList<MemberBean>();
	
	
	ArrayList<MemberBean> List3 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List31 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List32 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List33 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List34 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List35 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List4 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List41 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List42 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List43 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List44 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List45 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List5 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List51 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List52 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List53 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List54 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List55 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> List6 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List61 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List62 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List63 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List64 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> List65 = new ArrayList<MemberBean>();
	
	ArrayList<MemberBean> ListT = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT1 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT2 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT3 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT4 = new ArrayList<MemberBean>();
	ArrayList<MemberBean> ListT5 = new ArrayList<MemberBean>();
	
	for(int i=0; i<memberList.size(); i++){
		if(memberList.get(i).getTEAM().equals("미래차검증전략실")){
			List1.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List11.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List12.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List13.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List14.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List15.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("샤시힐스검증팀")){
			List2.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List21.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List22.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List23.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List24.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List25.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("바디힐스검증팀")){
			List3.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List31.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List32.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List33.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List34.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List35.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("제어로직검증팀")){
			List4.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List41.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List42.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List43.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List44.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List45.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("기능안전검증팀")){
			List5.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List51.add(memberList.get(i));
				ListT.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List52.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List53.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List54.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List55.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
			
		}else if(memberList.get(i).getTEAM().equals("자율주행검증팀")){
			List6.add(memberList.get(i));
			ListT.add(memberList.get(i));
			if(memberList.get(i).getRANK().equals("수석")){
				List61.add(memberList.get(i));
				ListT1.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("책임")){
				List62.add(memberList.get(i));
				ListT2.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("선임")){
				List63.add(memberList.get(i));
				ListT3.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("전임")){
				List64.add(memberList.get(i));
				ListT4.add(memberList.get(i));
			} else if(memberList.get(i).getRANK().equals("인턴")){
				List65.add(memberList.get(i));
				ListT5.add(memberList.get(i));
			}
		}
		
		
	}
	
   	String nowYear = sf.format(nowTime).split("-")[0];
   	int preYear = Integer.parseInt(nowYear) - 1;
   	int nextYear = Integer.parseInt(nowYear) + 1;
	
	for(int i=0; i<memberList.size(); i++){
		for(int j=0; j<projectList.size(); j++){
			schBean PMsch = new schBean();
			if(memberList.get(i).getID().equals(projectList.get(j).getPROJECT_MANAGER())){
				PMsch.setName(memberList.get(i).getID());
				PMsch.setName(memberList.get(i).getNAME());
				PMsch.setTeam(memberList.get(i).getTEAM());
				PMsch.setRank(memberList.get(i).getRANK());
				PMsch.setProjectName(projectList.get(j).getPROJECT_NAME());
				//PMsch.setPm(memberDao.returnMember(projectList.get(j).getPROJECT_MANAGER()).getNAME());
				PMsch.setPm(userName.get(userID.indexOf(projectList.get(j).getPROJECT_MANAGER())));
				
				String Wstr = "";
				for(int z=0; z<projectList.get(j).getWORKER_LIST().split(" ").length; z++){
					//Wstr += memberDao.returnMember(projectList.get(j).getWORKER_LIST().split(" ")[z]).getNAME() + " ";
					if(userID.indexOf(projectList.get(j).getWORKER_LIST().split(" ")[z]) == -1){
						Wstr += "";
						
					} else{
						Wstr += userName.get(userID.indexOf(projectList.get(j).getWORKER_LIST().split(" ")[z])) + " ";
					}
				}
				PMsch.setWorkList(Wstr);
				PMsch.setStart(projectList.get(j).getPROJECT_START());
				PMsch.setEnd(projectList.get(j).getPROJECT_END());
				schList.add(PMsch);
			}
			for(int z=0; z<projectList.get(j).getWORKER_LIST().split(" ").length; z++){
				if(!(memberList.get(i).getID().equals(projectList.get(j).getPROJECT_MANAGER())) && memberList.get(i).getID().equals(projectList.get(j).getWORKER_LIST().split(" ")[z])){
					//프로젝트 명, 착수, 종료, (이름, 소속팀, 직급)
					schBean sch = new schBean();
					sch.setId(memberList.get(i).getID());
					sch.setName(memberList.get(i).getNAME());
					sch.setTeam(memberList.get(i).getTEAM());
					sch.setRank(memberList.get(i).getRANK());
					sch.setProjectName(projectList.get(j).getPROJECT_NAME());
					//sch.setPm(memberDao.returnMember(projectList.get(j).getPROJECT_MANAGER()).getNAME());
					sch.setPm(userName.get(userID.indexOf(projectList.get(j).getPROJECT_MANAGER())));
					String Wstr2 = "";
					for(int x=0; x<projectList.get(j).getWORKER_LIST().split(" ").length; x++){
						//Wstr2 += memberDao.returnMember(projectList.get(j).getWORKER_LIST().split(" ")[x]).getNAME() + " ";
						if(userID.indexOf(projectList.get(j).getWORKER_LIST().split(" ")[x]) == -1){
							Wstr2 += "";
							
						} else{
							Wstr2 += userName.get(userID.indexOf(projectList.get(j).getWORKER_LIST().split(" ")[x])) + " ";
						}
					}
					sch.setWorkList(Wstr2);
					sch.setStart(projectList.get(j).getPROJECT_START());
					sch.setEnd(projectList.get(j).getPROJECT_END());
					schList.add(sch);
				}	
			}
		}
	}
%>

<style>
	#timelineChart{
		padding-right : 40px;
	}
	#timelineChart2{
		padding-right : 40px;
	}
	#timelineChart3{
		padding-right : 40px;
	}
	#timelineChart4{
		padding-right : 40px;
	}
	#timelineChart5{
		padding-right : 40px;
	}
	#timelineChart6{
		padding-right : 40px;
	}
	
	.endline{
		page-break-before:always
	}

</style>

<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["timeline"]});
google.charts.setOnLoadCallback(drawChartOp);
google.charts.setOnLoadCallback(drawChartOp2);
google.charts.setOnLoadCallback(drawChartOp3);
google.charts.setOnLoadCallback(drawChartOp4);
google.charts.setOnLoadCallback(drawChartOp5);
google.charts.setOnLoadCallback(drawChartOp6);


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

var cnt = 0;
var cnt1 = 0;
var cnt2 = 0;
var cnt3 = 0;
var cnt4 = 0;
var cnt5 = 0;



function drawChartOp(){
	var team = '미래차검증전략실';
	var rank = 'total';
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
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt ++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt > 0){
			$('#timelineChart').height(cnt*50);
		}
	  	chart.draw(dataTable);
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
  	//memberInfoTable(team, rank);
}	//end

function drawChartOp2(){
	var team = '바디힐스검증팀';
	var rank = 'total';
	  var container = document.getElementById('timelineChart2');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt1++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt1 > 0){
			$('#timelineChart2').height(cnt1*50);
		}
	  	chart.draw(dataTable);
		nowLine('timelineChart2');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('timelineChart2');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('timelineChart2');
	 	  })
  	//memberInfoTable(team, rank);
}	//end


function drawChartOp3(){
	var team = '샤시힐스검증팀';
	var rank = 'total';
	  var container = document.getElementById('timelineChart3');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt2++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt2 > 0){
			$('#timelineChart3').height(cnt2*47);
		}
	  	chart.draw(dataTable);
		nowLine('timelineChart3');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('timelineChart3');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('timelineChart3');
	 	  })
}	//end


function drawChartOp4(){
	var team = '제어로직검증팀';
	var rank = 'total';
	  var container = document.getElementById('timelineChart4');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt3++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt3 > 0){
			$('#timelineChart4').height(cnt3*50);
		}
	  	chart.draw(dataTable);
		nowLine('timelineChart4');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('timelineChart4');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('timelineChart4');
	 	  })
  	//memberInfoTable(team, rank);
}	//end


function drawChartOp5(){
	var team = '기능안전검증팀';
	var rank = 'total';
	  var container = document.getElementById('timelineChart5');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt4++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt4 > 0){
			$('#timelineChart5').height(cnt4*50);
		}
	  	chart.draw(dataTable);
		nowLine('timelineChart5');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('timelineChart5');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('timelineChart5');
	 	  })
}	//end

function drawChartOp6(){
	var team = '자율주행검증팀';
	var rank = 'total';
	  var container = document.getElementById('timelineChart6');
	    var chart = new google.visualization.Timeline(container);
	    var dataTable = new google.visualization.DataTable();

	    dataTable.addColumn({ type: 'string', id: 'Position' });
	    dataTable.addColumn({ type: 'string', id: 'dummy bar label' });
	    dataTable.addColumn({ type: 'string', role: 'tooltip' });
	    dataTable.addColumn({ type: 'string', id: 'style', role: 'style' });
	    dataTable.addColumn({ type: 'date', id: 'Start' });
	    dataTable.addColumn({ type: 'date', id: 'End' });
	    dataTable.addRows([
	    		[ '\0', 'Now','','',new Date(), new Date()],
	    		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
			]);
	    <%
	  	  for(int i=0; i<schList.size(); i++){%>
	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
	  	  		cnt5++;
	  			 dataTable.addRows([
	  				[	'<%=schList.get(i).getName()%>'
      				,'<%=schList.get(i).getProjectName()%>'
      				
      				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
      				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
      				,''
      				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
	            ]);
	  		}  	
	<%}%>
		if(cnt5 > 0){
			$('#timelineChart6').height(cnt5*50);
		}
	  	chart.draw(dataTable);
		nowLine('timelineChart6');
	 	google.visualization.events.addListener(chart, 'onmouseover', function(obj){
	 		if(obj.row == 0){
	 			$('.google-visualization-tooltip').css('display', 'none');
	 		}
	 	    nowLine('timelineChart6');
	 	  })
	 	  
	 	  google.visualization.events.addListener(chart, 'onmouseout', function(obj){
	 	  	nowLine('timelineChart6');
	 	  })
}	//end

//페이지 시작시 호출 함수
$(document).ready(function (){
	document.body.style.zoom=0.8;
	window.print(); //윈도우 인쇄 창 띄우고
});
</script>

</head>
<body>

	<p><b>미래차검증전략실</b></p>
	<div id="timelineChart"></div>
	<div class="endline"></div><br style="height:0; line-height:0">
  
    <p><b>바디힐스검증팀</b></p>
    <div id="timelineChart2"></div>
    <div class="endline"></div><br style="height:0; line-height:0">

    <p><b>샤시힐스검증팀</b></p>
    <div id="timelineChart3"></div>
    <div class="endline"></div><br style="height:0; line-height:0">

    <p><b>제어로직검증팀</b></p>
    <div id="timelineChart4"></div>
    <div class="endline"></div><br style="height:0; line-height:0">
 
    <p><b>기능안전검증팀</b></p>
    <div id="timelineChart5"></div>
 
    <div class="endline"></div><br style="height:0; line-height:0">
    
    <p><b>자율주행검증팀</b></p>
    <div id="timelineChart6"></div>

    </body>
</html>