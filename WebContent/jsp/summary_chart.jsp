<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    
    /* 막대 차트 */
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(fh_order);
      google.charts.setOnLoadCallback(fh_sales);
      google.charts.setOnLoadCallback(sh_order);
      google.charts.setOnLoadCallback(sh_sales);
      google.charts.setOnLoadCallback(y_order);
      google.charts.setOnLoadCallback(y_sales);
      
      function fh_order() {
        var fh_order_data = google.visualization.arrayToDataTable([
          ['Team', '목표수주', '예상수주', '수주 달성률'],
          ['샤시힐스', 500, 400, 200],
          ['바디힐스', 1170, 460, 250],
          ['제어로직', 660, 1120, 300],
          ['기능안전', 1030, 540, 350],
          ['자율주행', 1170, 460, 250],
          ['실', 660, 1120, 300]
        ]);

        var fh_order_option = {
          chart: {
            title: '상반기 수주',
          }
        };

        var fh_order_chart = new google.visualization.ColumnChart(document.getElementById('fh_order_chart'));

        fh_order_chart.draw(fh_order_data, google.charts.Bar.convertOptions(fh_order_option));
      }
      
 function fh_sales() {
          var fh_sales_data = google.visualization.arrayToDataTable([
            ['Team', '목표매출', '예상매출', '매출 달성률'],
            ['샤시힐스', 3000, 400, 200],
            ['바디힐스', 1170, 460, 250],
            ['제어로직', 660, 1120, 300],
            ['기능안전', 1030, 540, 350],
            ['자율주행', 1170, 460, 250],
            ['실', 660, 1120, 300]
          ]);

          var fh_sales_option = {
            chart: {
              title: '상반기 매출',
            }
          };

          var fh_sales_chart =  new google.visualization.ColumnChart(document.getElementById('fh_sales_chart'));

          fh_sales_chart.draw(fh_sales_data, google.charts.Bar.convertOptions(fh_sales_option));
        }
 
 function sh_order() {
     var sh_order_data = google.visualization.arrayToDataTable([
       ['Team', '목표수주', '예상수주', '수주 달성률'],
       ['샤시힐스', 500, 400, 200],
       ['바디힐스', 1170, 460, 250],
       ['제어로직', 660, 1120, 300],
       ['기능안전', 1030, 540, 350],
       ['자율주행', 1170, 460, 250],
       ['실', 660, 1120, 300]
     ]);

     var sh_order_option = {
       chart: {
         title: '하반기 수주',
       }
     };

     var sh_order_chart = new google.charts.Bar(document.getElementById('sh_order_chart'));

     sh_order_chart.draw(sh_order_data, google.charts.Bar.convertOptions(sh_order_option));
   }
   
function sh_sales() {
       var sh_sales_data = google.visualization.arrayToDataTable([
         ['Team', '목표매출', '예상매출', '매출 달성률'],
         ['샤시힐스', 1000, 400, 200],
         ['바디힐스', 1170, 460, 250],
         ['제어로직', 660, 1120, 300],
         ['기능안전', 1030, 540, 350],
         ['자율주행', 1170, 460, 250],
         ['실', 660, 1120, 300]
       ]);

       var sh_sales_option = {
         chart: {
           title: '하반기 매출',
         }
       };

       var sh_sales_chart = new google.charts.Bar(document.getElementById('sh_sales_chart'));

       sh_sales_chart.draw(sh_sales_data, google.charts.Bar.convertOptions(sh_sales_option));
     }
     
function y_order() {
    var y_order_data = google.visualization.arrayToDataTable([
      ['Team', '목표수주', '예상수주', '수주 달성률'],
      ['샤시힐스', 500, 400, 200],
      ['바디힐스', 1170, 460, 250],
      ['제어로직', 660, 1120, 300],
      ['기능안전', 1030, 540, 350],
      ['자율주행', 1170, 460, 250],
      ['실', 660, 1120, 300]
    ]);

    var y_order_option = {
      chart: {
        title: '연간 수주',
      }
    };

    var y_order_chart = new google.charts.Bar(document.getElementById('y_order_chart'));

    y_order_chart.draw(y_order_data, google.charts.Bar.convertOptions(y_order_option));
  }
  
function y_sales() {
      var y_sales_data = google.visualization.arrayToDataTable([
        ['Team', '목표매출', '예상매출', '매출 달성률'],
        ['샤시힐스', 1500, 400, 200],
        ['바디힐스', 1870, 460, 250],
        ['제어로직', 660, 1720, 300],
        ['기능안전', 1030, 540, 350],
        ['자율주행', 1370, 460, 250],
        ['실', 660, 1420, 300]
      ]);

      var y_sales_option = {
        chart: {
          title: '연간 매출',
        }
      };

      var y_sales_chart = new google.charts.Bar(document.getElementById('y_sales_chart'));

      y_sales_chart.draw(y_sales_data, google.charts.Bar.convertOptions(y_sales_option));
    }
    
    
  /*도넛 차트*/
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(VT_Team);
google.charts.setOnLoadCallback(count_VT);
google.charts.setOnLoadCallback(count_chassis);
google.charts.setOnLoadCallback(count_body);
google.charts.setOnLoadCallback(count_control);
google.charts.setOnLoadCallback(count_safe);
google.charts.setOnLoadCallback(count_auto);

function VT_Team() {
	  var VT_Team_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['샤시힐스',   14],
	    ['바디힐스',   10],
	    ['제어로직',  9],
	    ['기능안전',  7],
	    ['자율주행',  9],
	    ['미포함',  6],
	  ]);

	  var VT_Team_options = {
	    title: '미래차 검증 전략실 팀',
	    pieHole: 0.4,
	  };

	  var VT_Team_chart = new google.visualization.PieChart(document.getElementById('VT_Team_chart'));
	  VT_Team_chart.draw( VT_Team_data, VT_Team_options);
	}


function count_VT() {
  var count_VT_data = google.visualization.arrayToDataTable([
    ['Count', 'How Many'],
    ['수석',   1],
    ['책임',   6],
    ['선임',  9],
    ['전임',  17],
    ['협력업체',  3]
  ]);

  var count_VT_options = {
    title: '미래차 검증 전략실',
    pieHole: 0.4,
  };

  var count_VT_chart = new google.visualization.PieChart(document.getElementById('count_VT_chart'));
  count_VT_chart.draw(count_VT_data,count_VT_options);
}

function count_chassis() {
	  var count_chassis_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['수석',   0],
	    ['책임',   1],
	    ['선임',  2],
	    ['전임',  5],
	    ['협력업체',  3]
	  ]);

	  var count_chassis_options = {
	    title: '샤시힐스 검증팀',
	    pieHole: 0.4,
	  };

	  var count_chassis_chart = new google.visualization.PieChart(document.getElementById('count_chassis_chart'));
	  count_chassis_chart.draw(count_chassis_data,count_chassis_options);
	}
	
function count_body() {
	  var count_body_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['수석',   0],
	    ['책임',   1],
	    ['선임',  5],
	    ['전임',  7],
	    ['협력업체',  2]
	  ]);

	  var count_body_options = {
	    title: '바디힐스 검증팀',
	    pieHole: 0.4,
	  };

	  var count_body_chart = new google.visualization.PieChart(document.getElementById('count_body_chart'));
	  count_body_chart.draw(count_body_data,count_body_options);
	}
	
function count_control() {
	  var count_control_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['수석',   0],
	    ['책임',   1],
	    ['선임',  4],
	    ['전임',  8],
	    ['협력업체',  4]
	  ]);

	  var count_control_options = {
	    title: '제어로직 검증팀',
	    pieHole: 0.4,
	  };

	  var count_control_chart = new google.visualization.PieChart(document.getElementById('count_control_chart'));
	  count_control_chart.draw(count_control_data,count_control_options);
	}
 
function count_safe() {
	  var count_safe_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['수석',   0],
	    ['책임',   1],
	    ['선임',  4],
	    ['전임',  8],
	    ['협력업체',  4]
	  ]);

	  var count_safe_options = {
	    title: '기능안전 검증팀',
	    pieHole: 0.4,
	  };

	  var count_safe_chart = new google.visualization.PieChart(document.getElementById('count_safe_chart'));
	  count_safe_chart.draw(count_safe_data,count_safe_options);
	}
	
function count_auto() {
	  var count_auto_data = google.visualization.arrayToDataTable([
	    ['Count', 'How Many'],
	    ['수석',   0],
	    ['책임',   1],
	    ['선임',  4],
	    ['전임',  8],
	    ['협력업체',  4]
	  ]);

	  var count_auto_options = {
	    title: '자율주행 검증팀',
	    pieHole: 0.4,
	  };

	  var count_auto_chart = new google.visualization.PieChart(document.getElementById('count_auto_chart'));
	  count_auto_chart.draw(count_auto_data,count_auto_options);
	}
</script>

</head>
<body>
	<div id="fh_order_chart" style="width: 400px; height: 500px;"></div>
	<div id="fh_sales_chart" style="width: 800px; height: 500px;"></div>
	<div id="sh_order_chart" style="width: 800px; height: 500px;"></div>
	<div id="sh_sales_chart" style="width: 800px; height: 500px;"></div>
	<div id="y_order_chart" style="width: 800px; height: 500px;"></div>
	<div id="y_sales_chart" style="width: 800px; height: 500px;"></div>
	<div id="VT_Team_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_VT_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_chassis_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_body_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_control_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_safe_chart" style="width: 900px; height: 500px;"></div>
	<div id="count_auto_chart" style="width: 900px; height: 500px;"></div>
</body>
</html>