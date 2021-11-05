<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>차트</title>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>
		<link rel="stylesheet" href="style.css">
		<style>
			.wrap{
				margin:30px 0px 100px 0px;
				align-items:center;
				display:flex;
				justify-content:center;
			}
			.chartWrap{
				width:1260px;
				margin:0 auto;
				vertical-align:middle;
			}
		</style>
	</head>
	<body>
		<jsp:include page="./header.jsp"></jsp:include>
		<div class="wrap">
			<div class="chartWrap">
				<canvas id="myChart" style="display:inline-block; width:400px; height:400px;"></canvas>
	  			<canvas id="myChart02" style="display:inline-block; width:400px; height:400px; margin-left:20px;"></canvas>
	  			<canvas id="myChart03" style="display:inline-block; width:400px; height:400px; margin-left:20px;"></canvas>
			</div>
		</div>
		<jsp:include page="./footer.jsp"></jsp:include>
		
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

	  		///////////////////////////////정현/////////////////////////////////		
	  		var myChart02 = new Chart(
	  			    document.getElementById('myChart02'),
	  			    config
	  			  );
	  		
	  		var ctx = document.getElementById('myChart03');
	        var myChart = new Chart(ctx, 
        	{
	            type: 'bar',
	            data: {
	                labels: ['#html/xml','#java','#python','#sql','#javascript'],
	                datasets: [{
	                    label: '오늘의 언어 선호도',
	                    data: ['${list[0]}','${list[1]}','${list[2]}','${list[3]}','${list[4]}'],       
	                    borderColor: ['#ff0066','#ff9933','#ffff33','#33ff99','#333ccc'],
	                    backgroundColor: ['#ff0033','#ff9900','#ffff00','#33ff66','#3333ff'],
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