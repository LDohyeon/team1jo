<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>차트 그리기</title>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	</head>
	<body>
		<div style="height:500px; width:600px">
  			<canvas id="myChart"></canvas>
  		</div>
  		<script>
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
	  		    borderColor: 'rgb(75, 192, 192)',
	  		  	borderWidth: 2,
	  		    tension: 0.1
	  		  }]
	  		};
	  		
	  		const config = {
	  			  type: 'line',
	  			  data: data,
	  			  options: {}
	  			};
	  		
	  		var myChart = new Chart(
	  			    document.getElementById('myChart'),
	  			    config
	  			  );
  		</script>
	</body>
</html>