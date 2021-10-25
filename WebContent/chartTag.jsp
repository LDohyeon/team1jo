<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>태그(차트)</title>
		<link rel="stylesheet" href="style.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>	
	</head>
	<body>
		<div class="chartCanvas">
			<canvas id="myChart" width="600px"; height="500px";></canvas>
		</div>
		<script>
			ㅊ
			
			var ctx = document.getElementById('myChart');
	        var myChart = new Chart(ctx, 
        	{
	            type: 'line',
	            data: {
	                labels: ['#html/xml','#java','#python','#sql','#javascript'],
	                datasets: [{
	                    label: '언어 선호도',
	                    data: ['${list[0]}','${list[1]}','${list[2]}','${list[3]}','${list[4]}'],       
	                    borderColor: ['rgba(255, 50, 100, 1)'],
	                    borderWidth: 2
	                }]
	            },
	            options: {
	                responsive: false
	            }
        	});
	      
		</script>
	</body>
</html>