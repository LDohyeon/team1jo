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
			<canvas id="myChart" style="display:inline-block;"></canvas>
  			<canvas id="myChart02" style="display:inline-block;"></canvas>
		</div>
		<script>
			///////////////////////////////정현/////////////////////////////////
			var ctx = document.getElementById('myChart');
	        var myChart = new Chart(ctx, 
        	{
	            type: 'line',
	            data: {
	                labels: ['${ymdDate[2]}','${ymdDate[1]}','${ymdDate[0]}'],
	                datasets: [{
	                    label: '회원가입자 수',
	                    data: ['${countDate[2]}','${countDate[1]}','${countDate[0]}'],       
	                    borderColor: ['rgba(255, 50, 100, 1)'],
	                    borderWidth: 2
	                }]
	            },
	            options: {
	                responsive: false
	            }
        	});
	        
			///////////////////////////////지애/////////////////////////////////
			const labels = [
	  		'${date[2]}',
	  		'${date[1]}',
	  		'${date[0]}'
	  		];
	  		
	  		const data = {
	  		 labels: labels,
	  		 datasets: [{
	  		    label: '작성한 글 개수',
	  		    data: ['${count[2]}', '${count[1]}', '${count[0]}'],
	  		    fill: true,
	  		    borderColor: 'rgba(255, 50, 100, 1)',
	  		  	borderWidth: 2,
	  		    tension: 0.1
	  		  }]
	  		};
	  		
	  		const config = {
	  			type: 'line',
	  			data: data,
	  			options:
	  			{
	                responsive: false
	            }
	  		};
	  		
	  		var myChart02 = new Chart(
	  			    document.getElementById('myChart02'),
	  			    config
	  			  );
		</script>
	</body>
</html>