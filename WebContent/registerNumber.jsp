<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입자 수(차트)</title>
		<link rel="stylesheet" href="style.css">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>	
	</head>
	<body>
		<div class="chartCanvas">
			<canvas id="myChart" width="600" height="500"></canvas>
		</div>
		<script>
			var ctx = document.getElementById('myChart');
	        var myChart = new Chart(ctx, 
        	{
	            type: 'line',
	            data: {
	                labels: ['${ymdDate[0]}','${ymdDate[1]}','${ymdDate[2]}'],
	                datasets: [{
	                    label: '회원가입자 수',
	                    data: ['${countDate[0]}','${countDate[1]}','${countDate[2]}'],       
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