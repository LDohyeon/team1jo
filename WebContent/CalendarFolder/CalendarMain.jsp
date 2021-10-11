<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- Login User Key: loginUserId -->
<html>
	<head>
		<meta charset="utf-8">
		<title>calendar</title>
        <link href="calendarCss.css" rel="stylesheet">
	</head>
	<body>
		<div id="calendar">
			
		</div>
	</body>
	<script>
		let calendar = document.getElementById("calendar");
   		
        let thisGroup = ["1", "A", "B", "C"]; // 견본
        let monthDayTitle = ["일", "월", "화", "수", "목", "금", "토"];
        
        let benchmarkDay = {
       		year: 1900, 
           	month: 1, 
           	day: 1,
           	hour: 00, 
           	minites: 00
        }; //월요일
        
        // 견본 콘텍스트 
        let calendarData = {
            date: "2021-10-06 00:00:00", // 오늘 날짜 > 시스템에서 받아옴
            form: "M", // 선택한 Form 데이터, 헤더 컨트롤에서 변경 데이터를 onChange로 설정
            id: "testcalendar", // 유저 Id 
            group: thisGroup // 유저가 속한 그룹 데이터 > 이를 기반으로 DB와 통신
        }
        
        // 오늘 날짜 
        function getToday(){
        	let date = new Date();
        	let year = date.getFullYear();
        	let month = (1 + date.getMonth());
        	let day = date.getDate();
        	let hour = ("0" + date.getHours()).slice(-2);
			let minute = ("0" + date.getMinutes()).slice(-2);
			
            let today = {
            	year: year, 
            	month: month, 
            	day: day,
            	hour: hour, 
            	minute: minute	
            }
        	return today;
        }
        
        // 특정 날짜
        function getThisDay(year, month, day, hour, minute){
        	let thisDay = {
               	year: year, 
               	month: month, 
               	day: day,
               	hour: hour, 
               	minute: minute
            }
        
            return thisDay;
        }
        
        // 오늘 요일을 구함 + 매개 변수 입력하면 특정 요일 구함 getThisDay()
        function getYoil(date){
        	let yoil; 
        	let days = 0;
        	
        	if(typeof(date)!="undefined"&&date!=null){
        		let months = getMonthStructure();
            	let today = date;
            	
            	for(let i = benchmarkDay.year; i<today.year; i++){
            		let month = getMonthStructure(i);
            		
            		for(let j=0; j<month.length; j++){
            			days += month[j];
            		} 
            	}
            	
            	for(let i = benchmarkDay.month; i<today.month; i++){
            		let month = getMonthStructure(today.year);
            		days += month[i-1];
            	}
            	
            	for(let i = benchmarkDay.day; i<today.day; i++){
            		days+=1;
            	}
            	
            	// 7로 나눠지는 경우, 벤치마크데이의 요일과 동일함 
            	if(days%7==0){
            		yoil = monthDayTitle[1];
            	}
            	else if(days%7==1){
            		yoil = monthDayTitle[2];
            	}
            	else if(days%7==2){
            		yoil = monthDayTitle[3];
            	}
            	else if(days%7==3){
            		yoil = monthDayTitle[4];
            	}
            	else if(days%7==4){
            		yoil = monthDayTitle[5];
            	}
            	else if(days%7==5){
            		yoil = monthDayTitle[6];
            	}
            	else if(days%7==6){
            		yoil = monthDayTitle[0];
            	}
        	}
        	else{
        		let months = getMonthStructure();
            	let today = getToday();
            	
            	for(let i = benchmarkDay.year; i<today.year; i++){
            		let month = getMonthStructure(i);
            		
            		for(let j=0; j<month.length; j++){
            			days += month[j];
            		} 
            	}
            	
            	for(let i = benchmarkDay.month; i<today.month; i++){
            		let month = getMonthStructure(today.year);
            		days += month[i];
            	}
            	
            	for(let i = benchmarkDay.day; i<today.day; i++){
            		days+=1;
            	}
            	
            	if(days%7==0){
            		yoil = monthDayTitle[1];
            	}
            	else if(days%7==1){
            		yoil = monthDayTitle[2];
            	}
            	else if(days%7==2){
            		yoil = monthDayTitle[3];
            	}
            	else if(days%7==3){
            		yoil = monthDayTitle[4];
            	}
            	else if(days%7==4){
            		yoil = monthDayTitle[5];
            	}
            	else if(days%7==5){
            		yoil = monthDayTitle[6];
            	}
            	else if(days%7==6){
            		yoil = monthDayTitle[0];
            	}
        	}
        	return yoil;
        }
        
        // 윤년 여부 보기
        function getYunNyen(y){
        	let yunNyen; 
        	
      		if(typeof(y)!='undefined'&&y!=null){
    			
            	if(y%4==0){
            		yunNyen = true;
            		
            		if(y%100==0){
            			yunNyen = false;
            			
            			if(y%400==0){
            				yunNyen = true;
            			}
            			else{
            				yunNyen = false;
            			}
            		}
            	}
            	else{
            		yunNyen=false;
            	}
      		}	
      		else{
      			let date = getToday();
            	let year = date.year;
    			
            	if(year%4==0){
            		yunNyen = true;
            		
            		if(year%100==0){
            			yunNyen = false;
            			
            			if(year%400==0){
            				yunNyen = true;
            			}
            			else{
            				yunNyen = false;
            			}
            		}
            	}
            	else{
            		yunNyen=false;
            	}
      		}
      		return yunNyen;
        }
      
        // 윤년 여뷰에따라 올해 달력 구조를 생성
        function getMonthStructure(year){
        	let months;
        	
        	// months 는 1~12 월의 달수 표시, 배열로 확인 0 == 1월 
        	if(typeof(year)!='undefined'&&year!=null){
        		if(getYunNyen(year)==true){
            		months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            	}
            	else{
            		months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            	}
        	}
        	else{
        		if(getYunNyen()==true){
            		months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            	}
            	else{
            		months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            	}
        	}
        	return months;
        }
        
        // 기본 데이터 변경
        function definitionData(date, form, id, group){
            calendarData.date = date;
            calendarData.form = form;
            calendarData.id = id;
            calendarData.group = group;
            console.log(calendarData);
        }
        
        // 헤더의 필터 정보가 변경될 경우
        function filterToChangeData(form){
            calendarData.form = form;
        
        }
        
        /*
            요소 만들기 변수
            p = parent
            c = child
            pp = parentparent
            cc = child
            v = 기준 요소
        */
        createToCalendar();
        
        // 달력 모양 만들기
        function createToCalendar(){
            let calendar = document.getElementById("calendar");
            calendar.appendChild(createToHeaderLayout());
            calendar.appendChild(createToBodyLayout());
            MonthForm();
        }
        
        // 달력 조작 헤더 요소 만들기
        function createToHeaderLayout(){
            let v; 
            let c;
            let cc;
            v = document.createElement("div");
            v.classList.add("calendarHeader");
            
            c = document.createElement("div");
            c.classList.add("calendarHeadMenu");
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadNow");
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadPre");
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadNext");
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadDate");
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadSearch");
            v.appendChild(c);
            
            
            c = document.createElement("div");
            c.classList.add("calendarHeadSelect");
            cc = document.createElement("select");
            cc.classList.add("selectForm");
            ccc = document.createElement("option");
            ccc.innerHTML = "년"
            ccc.setAttribute("value", "Y")
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "월"
            ccc.setAttribute("value", "M")
            ccc.setAttribute("selected", "true")
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "주"
            ccc.setAttribute("value", "W")
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "일"
            ccc.setAttribute("value", "D")
            cc.appendChild(ccc);
            
            c.appendChild(cc);
            
            v.appendChild(c);
            
            return v;
        }
        // Header 내의 버튼들에 동작 부여
        // 퐁선택 
        let selectForm = document.getElementsByClassName("selectForm")[0];
       
        selectForm.addEventListener("change", function(){
        	changeForm(selectForm.value);
        });
        
        // Calendar Body 영역 만들기 
        function createToBodyLayout(){
            let v = document.createElement("div");
            v.classList.add("calendarBody");
            
            let rightBox = document.createElement("div");
            rightBox.classList.add("rightBox");
            rightBox.appendChild(createToDoLayout());
            rightBox.appendChild(createGroupLayout());
            
            let centerBox = document.createElement("div");
            centerBox.classList.add("centerBox");
            centerBox.appendChild(createCalanderLayout());
            
            let leftBox = document.createElement("div");
            leftBox.classList.add("leftBox");
            leftBox.appendChild(createNaviLayout());
            
            v.appendChild(rightBox);
            v.appendChild(centerBox);
            v.appendChild(leftBox);
            
            return v;
        }
        
        // 달력 TodoList 만들기
        function createToDoLayout(){   
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("toDoListDiv");
            
            return v;
        }
        
        // 달력 네비게이션 만들기 
        function createNaviLayout(){
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("naviDiv");
            
            return v;
        }
        
        // 달력 그룹 항목 만들기
        function createGroupLayout(){
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("groupDiv");
            
            return v;
        }
		
        // 달력 만들기
        function createCalanderLayout(){
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("calendarDiv");
            
            return v;
        };
        
		// ChangeForm: 매개변수에 따라 현재 달력 폼을 변경
		function changeForm(selectForm){
			if(selectForm=="Y"){
				YearForm();
			}
			else if(selectForm=="M"){
				MonthForm();
			}
			else if(selectForm=="W"){
				WeekForm();			
			}
			else if(selectForm=="D"){
				DayForm();
			}	
		}
        
		// Form 모양생성
		function YearForm(date){
			let div = document.getElementsByClassName("calendarDiv")[0];
			let divc = document.createElement("div");
            
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
            
			if(typeof(date)!='undefined'&&year!=null){
				for(let box = 1; box < 13; box++){
                    
                    let p = document.createElement("div");
                    p.classList.add("yearLayoutBox")
                    
                    let c = document.createElement("div");
                    c.classList.add("yearInMonthTitle");
                    c.innerHTML = box+" 월";
                    
                    p.appendChild(c);
                    
					date.month = box;
                    
                    
					p.appendChild(createYearFormElement(date));
                    div.appendChild(p);
				}
			}
			else{
				for(let box = 1; box < 13; box++){
					let dayInfo = getToday();
					dayInfo.month = box;
                    
                    let p = document.createElement("div");
                    p.classList.add("yearLayoutBox")
                    
                    let c = document.createElement("div");
                    c.classList.add("yearInMonthTitle");
                    c.innerHTML = box+" 월";
                    
                    p.appendChild(c);
                    
					p.appendChild(createYearFormElement(dayInfo));
                    div.appendChild(p);
				}
			}
		}
        
		// 몬스 폼을 만들기 
		function MonthForm(date){
			if(typeof(date)!='undefined'&&year!=null){
				let div = document.getElementsByClassName("calendarDiv")[0];
				
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
					
				}
				
	            div.appendChild(createMonthFormElement());
			}
			else{
				let div = document.getElementsByClassName("calendarDiv")[0];
				
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
					
				}

	            div.appendChild(createMonthFormElement());
			}
		}
		
		// 주간 폼 만들기
		function WeekForm(date){
			let div = document.getElementsByClassName("calendarDiv");
			
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
				
			}
			
			
		}
		
		// 일 폼 만들기 
		function DayForm(){
			let div = document.getElementsByClassName("calendarDiv");
			
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
				
			}
            
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("calendarArea");
           
		}
        
        
		// GroupCheck
		function CheckGroup(){
			
		}
		
		function toDoList(){
			
		}
		
		function toDoListComplete(){
			
		}
		
		function toDoLostDelete(){
			
		}
		
		function toDoListChange(){
			
		}
		
		function addPlan(){
			
		}
		
		// 월 폼의 요소 만들기
		function createMonthFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            
			if(typeof(date)!='undefined'&&date!=null){
				
	            v = document.createElement("div");
	            v.classList.add("calendarArea");
	        
	            
	            c = document.createElement("div");
	            c.classList.add("monthAreaHead");
	            
	            for(let i = 0; i < 7; i++){
	                cc = document.createElement("div");
	                cc.classList.add("monthAreaHeadTitle");
	                cc.innerHTML = monthDayTitle[i];
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            c = document.createElement("div");
	            c.classList.add("monthAreaBody");
	            
	            let months = getMonthStructure();
	            let flag = months[date.month-1];
	            let yoil = getYoil(getThisDay(date.year, date.month, 1, 0, 0));
	            let beforeYoil;
	            let NowMonth = months[date.month-2];
	            
	            if(NowMonth==NaN||NowMonth==null){
	            	NowMonth = months[11];
	            }
	          	
	           	if(yoil=="월"){
	           		for(let i = 0; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("monthBox"); 
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("monthBoxTitle");
	                
					if(i==1){
						cccc = document.createElement("span");
		                cccc.classList.add("monthBoxTitleBox");
		                cccc.innerHTML = date.month+"월 "+ i +"일";
		                ccc.appendChild(cccc);
	            	}
	            	else{
	            		cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	            	}
	              
	                cc.appendChild(ccc);
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("monthBoxBody");
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[date.month];
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
			}
			else{
				let div = document.getElementsByClassName("calendarDiv")[0];
				
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
					
				}
				
	            v = document.createElement("div");
	            v.classList.add("calendarArea");
	        
	            
	            c = document.createElement("div");
	            c.classList.add("monthAreaHead");
	            
	            for(let i = 0; i < 7; i++){
	                cc = document.createElement("div");
	                cc.classList.add("monthAreaHeadTitle");
	                cc.innerHTML = monthDayTitle[i];
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            c = document.createElement("div");
	            c.classList.add("monthAreaBody");
	            
	            let today = getToday();
	            let months = getMonthStructure();
	            let flag = months[today.month-1];
	            let yoil = getYoil(getThisDay(today.year, today.month, 1, 0, 0));
	            let beforeYoil;
	            let NowMonth = months[today.month-2];
	          	
	           	if(yoil=="월"){
	           		for(let i = 0; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = (NowMonth-i) +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("monthBox"); 
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("monthBoxTitle");
	                
					if(i==1){
						cccc = document.createElement("span");
		                cccc.classList.add("monthBoxTitleBoxOne");
		                cccc.innerHTML = getToday().month+"월 "+ i +"일";
		                ccc.appendChild(cccc);
	            	}
	            	else{
	            		cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	            	}
	              
	                cc.appendChild(ccc);
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("monthBoxBody");
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	          
	            yoil = getYoil(getThisDay(today.year, today.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[today.month];
	          	
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("monthBox"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxTitle");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("monthBoxTitleBox");
	                    cccc.innerHTML = i +"";
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("monthBoxBody");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
			}
			return v;
		}
		
		// 년 폼 요소 만들기 
		function createYearFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            
			if(typeof(date)!='undefined'&&date!=null){
				
	            v = document.createElement("div");
	            v.classList.add("calendarArea");
	        
	            
	            c = document.createElement("div");
	            c.classList.add("yearAreaHead");
	            
	            for(let i = 0; i < 7; i++){
	                cc = document.createElement("div");
	                cc.classList.add("yearAreaHeadTitle");
	                cc.innerHTML = monthDayTitle[i];
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            c = document.createElement("div");
	            c.classList.add("yearAreaBody");
	            
	            let months = getMonthStructure();
	            let flag = months[date.month-1];
	            let yoil = getYoil(getThisDay(date.year, date.month, 1, 0, 0));
	            let beforeYoil;
	            let NowMonth = months[date.month-2];
	            
	            // 배열 값이 없는 항목을 참조: 할때 실행, 말을 12로 설정함 (1월일 경우 실행됨)
	            if(NowMonth==NaN||NowMonth==null){
	            	NowMonth = months[11];
	            }
	          	
	           	if(yoil=="월"){
	           		for(let i = 0; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("yearBox"); 
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("yearBoxTitle");
	                
            		cccc = document.createElement("span");
                    cccc.classList.add("yearBoxTitleBox");
                    cccc.innerHTML = i +"";
                    ccc.appendChild(cccc);
	              
	                cc.appendChild(ccc);
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("yearBoxBody");
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[date.month];
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearhBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
			}
			else{
				let div = document.getElementsByClassName("calendarDiv")[0];
				
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
					
				}
				
	            v = document.createElement("div");
	            v.classList.add("calendarArea");
	        
	            
	            c = document.createElement("div");
	            c.classList.add("yearAreaHead");
	            
	            for(let i = 0; i < 7; i++){
	                cc = document.createElement("div");
	                cc.classList.add("yearAreaHeadTitle");
	                cc.innerHTML = monthDayTitle[i];
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            c = document.createElement("div");
	            c.classList.add("yearAreaBody");
	            
	            let today = getToday();
	            let months = getMonthStructure();
	            let flag = months[today.month-1];
	            let yoil = getYoil(getThisDay(today.year, today.month, 1, 0, 0));
	            let beforeYoil;
	            let NowMonth = months[today.month-2];
	          	
	           	if(yoil=="월"){
	           		for(let i = 0; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
                        cc.innerHTML = "";
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			beforeYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("yearBox"); 
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("yearBoxTitle");
	                
					cccc = document.createElement("span");
	                cccc.classList.add("yearBoxTitleBox");
	                cccc.innerHTML = i +"";
	                ccc.appendChild(cccc);
	            	
	                cc.appendChild(ccc);
	                
	                ccc = document.createElement("div");
	                ccc.classList.add("yearBoxBody");
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	          
	            yoil = getYoil(getThisDay(today.year, today.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[today.month];
	          	
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("myearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			afterYoil = NowMonth;
	           			cc = document.createElement("div");
	                    cc.classList.add("yearBoxDummy"); 
	                    cc.innerHTML = "";
                        
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxTitleDummy");
	                    
	                    cccc = document.createElement("span");
	                    cccc.classList.add("yearBoxTitleBoxDummy");
	                    ccc.appendChild(cccc);
	                    
	                    cc.appendChild(ccc);
	                    
	                    ccc = document.createElement("div");
	                    ccc.classList.add("yearBoxBodyDummy");
	                    cc.appendChild(ccc);
	               		
	                    c.appendChild(cc);
	           		}
	           	}
	           	v.appendChild(c);
			}
			return v;
		}
		
	</script>
</html>