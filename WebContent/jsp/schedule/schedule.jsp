<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.PrintWriter"
	import="jsp.Bean.model.*" import="jsp.DB.method.*"
	import="java.util.ArrayList" import="java.util.Date"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">

<head>
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
	session.setMaxInactiveInterval(60*60);
	
	MemberDAO memberDao = new MemberDAO();
	SchDAO schDao = new SchDAO();
	ArrayList<MemberBean> memberList = memberDao.getMemberData();
	ArrayList<schBean> schList = schDao.getProject_except8();
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sf.format(nowTime);
	int year = Integer.parseInt(date.split("-")[0]);
	
	ArrayList<String> userID = new ArrayList<String>();
	ArrayList<String> userName = new ArrayList<String>();
	
	for(int i=0; i<memberList.size(); i++){
		userID.add(memberList.get(i).getID());
		userName.add(memberList.get(i).getNAME());
	}
	
	String str = "";
	
	
%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Sure FVMS - Schedule</title>

<!-- Custom fonts for this template-->
<link href="../../vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">


<!-- Custom styles for this template-->
<link href="../../css/sb-admin-2.min.css" rel="stylesheet">


</head>
<style>
.sidebar .nav-item{
	 	word-break: keep-all;
}
.topbar {
	height: 3.375rem;
}
#sidebarToggle{
		display:none;
	}
@media ( max-width :800px) {
#sidebarToggle{
		display:block;
	}
	.tableST {
		width: 100% !important;
		height: 40%;
		
	}
.table-responsive2 {
	height: 40vh !important;
}

	#timelineChart {
		width: 100% !important;
	}
}


#fixedd {
 table-layout:fixed; 
 width:100%;
 }


.table { border:1px solid; border-collapse: collapse; table-layout:fixed;}
.table td, .test-table th { border: 1px solid;  word-break:break-all;}
.table thead th { position:sticky; top: 0; background-color: #15a3da52; border:1px solid;  word-break:break-all; }

.table-responsive2 {
	display: block;
	width: 100%;
	height: 65vh;
	overflow: auto;
	-webkit-overflow-scrolling: touch;
}

.memberTable {
	width: 100%;
	white-space: nowrap;
	text-align: center;
}

#dataTable td:hover {
	background-color: black;
}

.memberTable2 {
	width: 100%;
	height: 60%;
	text-align: center;
}

.tableST {
	width: 45%;
	height: auto;
	float: right;
}

#timelineChart {
	height: 90%;
	width: 55%;
	float: right;
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

.tooltip-padding {
	text-align: left;
	padding: 5%;
}
</style>



<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
<%
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
%>	
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
            		[ '\0', 'Now','','',new Date(), new Date()],
            		['\0','','', 'opacity:0', new Date('<%=preYear%>-01-01'), new Date('<%=nextYear%>-12-31')]
              		<%
	            		for(int b=0; b<schList.size(); b++){
	            		%>
	            			,[	'<%=schList.get(b).getName()%>'
	            				,'<%=schList.get(b).getProjectName()%>'
	            				
	            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(b).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(b).getPm()%><br><b>투입명단 : </b><%=schList.get(b).getWorkList().trim()%></p>' 
	            				+ '<b>착수일 : </b><%=schList.get(b).getStart()%><br><b>종료일 : </b><%=schList.get(b).getEnd()%></div>'
	            				,''
	            				, new Date('<%=schList.get(b).getStart()%>'), new Date('<%=schList.get(b).getEnd()%>')]
	            		<%}
            	%>
            ]);
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

            var st = container.getElementsByTagName("div")[0];
			st.style.position = 'inherit';
          }
          
          
          var c_team='';
          var c_rank='';
          
          function drawChartOp(team, rank){
        	  
        	  c_team=team;
        	  c_rank=rank;
        	  
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
	      	  	  	if(rank=='total'){
		      	  	  	if(team == '<%=schList.get(i).getTeam()%>'){
		    	  			 dataTable.addRows([
		    	  				[	'<%=schList.get(i).getName()%>'
		            				,'<%=schList.get(i).getProjectName()%>'
		            				
		            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
		            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
		            				,''
		            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
		    	            ]);
		    	  		} else if(team == 'total'){
		    	  			dataTable.addRows([
		    	  				[	'<%=schList.get(i).getName()%>'
		            				,'<%=schList.get(i).getProjectName()%>'
		            				
		            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
		            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
		            				,''
		            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
		    	            ]);
		    	  		}
	
	      	  	  	}
	      	  	  	else{
		      	  	  	if(team == '<%=schList.get(i).getTeam()%>' && rank == '<%=schList.get(i).getRank()%>'){
		    	  			dataTable.addRows([
		    	  				[	'<%=schList.get(i).getName()%>'
		            				,'<%=schList.get(i).getProjectName()%>'
		            				
		            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
		            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
		            				,''
		            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
		    	            ]);
		    	  		}else if(team == 'total' && rank == '<%=schList.get(i).getRank()%>'){
		    	  			dataTable.addRows([
		    	  				[	'<%=schList.get(i).getName()%>'
		            				,'<%=schList.get(i).getProjectName()%>'
		            				
		            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
		            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
		            				,''
		            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
		    	            ]);
		    	  		}
	      	  	  	}			      	  	
      	  	  	
	  	  <%}%> 
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
           	  
      	  	memberInfoTable(team, rank);
       }	//end
         
          function memberInfoTable(team, rank){
        	  	var inner="";   	  	
          	  	if(team == '미래차검증전략실'){
          	  		if(rank == 'total'){
          	  			inner="";
          	  			<%
          	  				
          	  				for(int a=0; a<List1.size(); a++){
          	  					str = "";
          	  				%>
          	  					var id = '<%=List1.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List1.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List1.get(a).getTEAM()%>'+"</td>";
    	      	  				inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List1.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List1.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List1.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List1.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List1.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List11.size(); a++){
        	  					str = "";
        	  				%>
        	  					var id = '<%=List11.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List11.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List11.get(a).getTEAM()%>'+"</td>";
          	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List11.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List11.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List11.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List11.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List11.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List12.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List12.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List12.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List12.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List12.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List12.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List12.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List12.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List12.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List13.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List13.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List13.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List13.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List13.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List13.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List13.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List13.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List13.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List14.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List14.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List14.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List14.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List14.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List14.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List14.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List14.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List14.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
          				inner="";
           	  			<%
        	  				for(int a=0; a<List15.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List15.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List15.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List15.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List15.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List15.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List15.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List15.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List15.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}	  		
          	  		}
          	  	
          	  	else if(team == '샤시힐스검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List2.size(); a++){
          	  					str = "";
          	  				%>
          	  				var id = '<%=List2.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List2.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List2.get(a).getTEAM()%>'+"</td>";
       		  				inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List2.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List2.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List2.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List2.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List2.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List21.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List21.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List21.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List21.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List21.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List21.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List21.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List21.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List21.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List22.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List22.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List22.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List22.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List22.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List22.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List22.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List22.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List22.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List23.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List23.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List23.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List23.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List23.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List23.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List23.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List23.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List23.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List24.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List24.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List24.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List24.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List24.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List24.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List24.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List24.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List24.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List25.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List25.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List25.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List25.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List25.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List25.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List25.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List25.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List25.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}	
          	  		}
          	  	
          	  	else if(team == '바디힐스검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List3.size(); a++){
          	  					str = "";
          	  				%>
          	  				var id = '<%=List3.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List3.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List3.get(a).getTEAM()%>'+"</td>";
       		  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List3.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List3.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List3.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List3.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List3.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List31.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List31.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List31.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List31.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List31.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List31.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List31.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List31.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List31.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List32.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List32.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List32.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List32.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List32.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List32.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List32.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List32.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List32.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List33.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List33.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List33.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List33.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List33.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List33.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List33.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List33.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List33.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List34.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List34.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List34.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List34.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List34.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List34.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List34.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List34.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List34.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List35.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List35.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List35.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List35.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List35.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List35.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List35.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List35.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List35.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == '제어로직검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List4.size(); a++){
          	  					str = "";
          	  				%>
          	  				var id = '<%=List4.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List4.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List4.get(a).getTEAM()%>'+"</td>";
       		  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List4.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List4.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List4.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List4.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List4.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List41.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List41.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List41.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List41.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List41.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List41.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List41.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List41.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List41.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List42.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List42.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List42.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List42.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List42.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List42.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List42.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List42.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List42.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List43.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List43.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List43.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List43.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List43.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List43.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List43.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List43.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List43.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List44.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List44.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List44.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List44.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List44.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List44.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List44.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List44.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List44.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List45.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List45.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List45.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List45.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List45.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List45.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List45.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List45.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List45.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		
          	  		}
          	  	
          	  	else if(team == '기능안전검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List5.size(); a++){
          	  					str = "";
          	  				%>
          	  				var id = '<%=List5.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List5.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List5.get(a).getTEAM()%>'+"</td>";
       		  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List5.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List5.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List5.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List5.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List5.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List51.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List51.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List51.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List51.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List51.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List51.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List51.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List51.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List51.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List52.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List52.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List52.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List52.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List52.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List52.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List52.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List52.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List52.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List53.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List53.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List53.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List53.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List53.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List53.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List53.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List53.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List53.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List54.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List54.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List54.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List54.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List54.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List54.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List54.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List54.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List54.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List55.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List55.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List55.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List55.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List55.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List55.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List55.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List55.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List55.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == '자율주행검증팀'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<List6.size(); a++){
          	  					str = "";
          	  				%>
          	  				var id = '<%=List6.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=List6.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=List6.get(a).getTEAM()%>'+"</td>";
       		  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List6.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=List6.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List6.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List6.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List6.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List61.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List61.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List61.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List61.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List61.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List61.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List61.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List61.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List61.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<List62.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List62.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List62.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List62.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List62.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List62.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List62.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List62.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List62.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<List63.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List63.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List63.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List63.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List63.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List63.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List63.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List63.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List63.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<List64.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List64.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List64.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List64.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List64.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List64.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List64.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List64.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List64.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<List65.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=List65.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=List65.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=List65.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=List65.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=List65.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=List65.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=List65.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=List65.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
          	  	
          	  	else if(team == 'total'){
          	  		if(rank == 'total'){
          	  		inner="";
          	  			<%
          	  				for(int a=0; a<ListT.size(); a++){
          	  					str = "";
          	  				%>
          	  			var id = '<%=ListT.get(a).getID()%>';
       	  						inner += "<tr>";
       	  						inner += "<td>"+'<%=ListT.get(a).getPART()%>'+"</td>";
       		  					inner += "<td>"+'<%=ListT.get(a).getTEAM()%>'+"</td>";
       		  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT.get(a).getNAME()%>'+"</a></td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
       	  						inner += "</tr>";
       	  					<%}%>
       	  					$('#memberINFO').empty();
       	  					$('#memberINFO').append(inner);
          	  			}
          			else if(rank == '수석'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<ListT1.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=ListT1.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT1.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT1.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT1.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=ListT1.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT1.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT1.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT1.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '책임'){
          			inner="";
           	  			<%
        	  				for(int a=0; a<ListT2.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=ListT2.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT2.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT2.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT2.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=ListT2.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT2.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT2.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT2.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '선임'){
           	  			<%
        	  				for(int a=0; a<ListT3.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=ListT3.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT3.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT3.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT3.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=ListT3.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT3.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT3.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT3.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '전임'){
           	  			<%
        	  				for(int a=0; a<ListT4.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=ListT4.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT4.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT4.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT4.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=ListT4.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT4.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT4.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT4.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          			else if(rank == '인턴'){
           	  			<%
        	  				for(int a=0; a<ListT5.size(); a++){
        	  					str = "";
        	  				%>
        	  				var id = '<%=ListT5.get(a).getID()%>';
         						inner += "<tr>";
         						inner += "<td>"+'<%=ListT5.get(a).getPART()%>'+"</td>";
        	  					inner += "<td>"+'<%=ListT5.get(a).getTEAM()%>'+"</td>";
        	  					inner += "<td><a href=../manager/manager_update.jsp?id="+id+">"+'<%=ListT5.get(a).getNAME()%>'+"</a></td>";
         						inner += "<td>"+'<%=ListT5.get(a).getRANK()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT5.get(a).getMOBILE()%>'+"</td>";
       	  						inner += "<td>"+'<%=ListT5.get(a).getADDRESS()%>'+"</td>";
       	  						str = "<%=ListT5.get(a).getID()%>";
       	  						inner += "<td>"+"<input type='button' class='detailBTN btn btn-info btn-icon-split btn-sm' value='상세보기' onclick='viewDetail(\""+str+"\")'>"+"</td>";
         						inner += "</tr>";
         					<%}%>
         					$('#memberINFO').empty();
         					$('#memberINFO').append(inner);
           	  			}
          	  		}
       }

    function viewDetail(id){
    	var popupX = (document.body.offsetWidth/2)-(600/2);
    	window.open('detail_PR.jsp?id='+id+'&year='+<%=year%> , 'popUpWindow', 'toolbar=yes,status=yes, menubar=yes, left='+popupX+', top=10, width=760, height=700');
    }
       
   	function goPrint(){
 		var popupX = (document.body.offsetWidth/2)-(600/2);
 		window.open('schedule_print.jsp', '', 'toolbar=no, menubar=no, left='+popupX+', top=100, width=1300, height=900');
   	}
      
	<!-- 로딩화면 -->
	
	window.onbeforeunload = function () { $('.loading').show(); }  //현재 페이지에서 다른 페이지로 넘어갈 때 표시해주는 기능
	$(window).load(function () {          //페이지가 로드 되면 로딩 화면을 없애주는 것
	    $('.loading').hide();
	});
	
	function match(a, b){
		if (a==b){
			return 'stroke-width: 3;stroke-color: red;';
		}else{
			return '';
		}
	}

	function clickData(){
		$(document.body).delegate('#fixedd tr', 'click', function(){
				var name = '';
	 			var tr = $(this);
	 			var td = tr.children();
	 			name = td.eq(2).text();
	 			console.log(name);
	 	    	
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
		      	  	  	if(c_rank=='total'){
			      	  	  	if(c_team == '<%=schList.get(i).getTeam()%>'){
			    	  			 dataTable.addRows([
			    	  				[	'<%=schList.get(i).getName()%>'
			            				,'<%=schList.get(i).getProjectName()%>'
			            				
			            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
			            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
			            				,match(name, '<%=schList.get(i).getName()%>')
			            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		} else if(c_team == 'total'){
			    	  			dataTable.addRows([
			    	  				[	'<%=schList.get(i).getName()%>'
			            				,'<%=schList.get(i).getProjectName()%>'
			            				
			            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
			            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
			            				,match(name, '<%=schList.get(i).getName()%>')
			            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}
		
		      	  	  	}
		      	  	  	else{
			      	  	  	if(c_team == '<%=schList.get(i).getTeam()%>' && c_rank == '<%=schList.get(i).getRank()%>'){
			    	  			dataTable.addRows([
			    	  				[	'<%=schList.get(i).getName()%>'
			            				,'<%=schList.get(i).getProjectName()%>'
			            				
			            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
			            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
			            				,match(name, '<%=schList.get(i).getName()%>')
			            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}else if(c_team == 'total' && c_rank == '<%=schList.get(i).getRank()%>'){
			    	  			dataTable.addRows([
			    	  				[	'<%=schList.get(i).getName()%>'
			            				,'<%=schList.get(i).getProjectName()%>'
			            				
			            				,'<div class = "tooltip-padding"> <h6><strong><%=schList.get(i).getProjectName()%></strong></h6>' + '<hr style ="border:solid 1px;color:black">' + '<p><b>PM : </b><%=schList.get(i).getPm()%><br><b>투입명단 : </b> <%=schList.get(i).getWorkList().trim()%></p>' 
			            				+ '<b>착수일 : </b><%=schList.get(i).getStart()%><br><b>종료일 : </b><%=schList.get(i).getEnd()%></div>'
			            				,match(name, '<%=schList.get(i).getName()%>')
			            				, new Date('<%=schList.get(i).getStart()%>'), new Date('<%=schList.get(i).getEnd()%>')]
			    	            ]);
			    	  		}
		      	  	  	}			      	  	
	      	  	  	
		  	  <%}%> 
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

	     });
	}
	
	// 페이지 시작시 호출 함수
	$(function(){
		//drawChart();
		clickData();
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
			<li class="nav-item active"><a class="nav-link"
				href="../schedule/schedule.jsp"> <i
					class="fas fa-fw fa-calendar"></i> <span>엔지니어 스케줄</span></a></li>

			<li class="nav-item"><a class="nav-link"
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
					<button onclick="goPrint()">인쇄</button>
				</nav>
				<!-- <h6 class="m-0 font-weight-bold text-primary">Schedule</h6> -->

				<div class="tableST">
				<div class="table-responsive">
				<h6 class="m-0 font-weight-bold text-primary">부서 / 직급 별 프로젝트 현황</h6>
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
				
				<div class="table-responsive2">
				<table class="table table-bordered" id="fixedd">
	                <thead>
	                    <tr  style="text-align:center;background-color:#15a3da52;">
		                    <th  style="width:15%">소속</th>
		                    <th  style="width:15%">팀</th>
		                    <th>이름</th>
		                    <th>직급</th>
							<th>Mobile</th>
							<th>주소</th>
							<th style="width:15%">프로젝트<br>수행이력</th>	    
							               	         
	                    </tr>
                    </thead>
                    <tbody id="memberINFO"></tbody>
                </table>
                </div>
        
                </div>
				
				<h6 class="m-0 font-weight-bold text-primary">프로젝트 타임라인</h6>
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
