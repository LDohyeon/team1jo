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
        	
        	if(typeof(date)!="undefined"||date!=null){
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
        	
      		if(typeof(y)!='undefined'||y!=null){
    			
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
            changeForm("M");
        }
        
        // 달력 조작 헤더 요소 만들기
        function createToHeaderLayout(){
            let v; 
            let c;
            let cc;
            let ccc;
            let cccc;
            
            v = document.createElement("div");
            v.classList.add("calendarHeader");
            
            c = document.createElement("input");
            c.setAttribute("type", "hidden");
    		c.classList.add("calendarHeadDateInfo");
    		v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadMenu");
            c.innerHTML="메뉴";
            c.addEventListener("click", calendarMenu);
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadNow");
            c.innerHTML="오늘";
            c.addEventListener("click", goCalendarToday);
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadPre");
            c.innerHTML="과거";
            c.addEventListener("click", goCalendarPrevious);
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadNext");
            c.innerHTML="미래";
            c.addEventListener("click", goCalendarNext);
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadDate");
            
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("calendarHeadSearch");
            c.innerHTML="찾기";
            c.addEventListener("click", visiableCalendarSearch);
            v.appendChild(c);
            
            
            c = document.createElement("div");
            c.classList.add("calendarHeadSelect");
            cc = document.createElement("select");
            cc.classList.add("selectForm");
            ccc = document.createElement("option");
            ccc.innerHTML = "년";
            ccc.setAttribute("value", "Y");
            cc.appendChild(ccc);
            
            
            ccc = document.createElement("option");
            ccc.innerHTML = "월";
            ccc.setAttribute("value", "M");
            ccc.setAttribute("selected", "true");
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "주";
            ccc.setAttribute("value", "W");
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "일";
            ccc.setAttribute("value", "D");
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
        
        function calendarMenu(){
        	
        }
        function goCalendarToday(){
			select = document.getElementsByClassName("selectForm")[0].value;
        	
        	if(select=="Y"){
				let date = getToday();
				
				changeForm("Y", date);
        	}
        	else if(select=="M"){
				let date = getToday();
				
				changeForm("M", date);
        	}
			else if(select=="W"){
        		// 현재의 구간을 구하고, 해당 구간을 기준으로 더라기 빼기 
        	}
			else if(select=="D"){
				
			}
        }

        function goCalendarPrevious(){
        	select = document.getElementsByClassName("selectForm")[0].value;
        	
        	if(select=="Y"){
        		let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear-1;
				let changeMonth = inputMonth;
				let changeDay = inputDay;
				
				let date = getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				
				changeForm("Y", date);
        	}
        	else if(select=="M"){
        		let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear;
				let changeMonth = inputMonth-1;
				let changeDay = inputDay;
				
				if(changeMonth<1){
					changeMonth=12;
					changeYear=changeYear-1;
				}
				
				let date = getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				
				changeForm("M", date);
        	}
			else if(select=="W"){
        		// 현재의 구간을 구하고, 해당 구간을 기준으로 더라기 빼기 
        	}
			else if(select=="D"){
				
			}
        }

        function goCalendarNext(){
			select = document.getElementsByClassName("selectForm")[0].value;
        	
        	if(select=="Y"){
        		let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear+1;
				let changeMonth = inputMonth;
				let changeDay = inputDay;
				
				let date = getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				
				changeForm("Y", date);
        	}
        	else if(select=="M"){
        		let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear;
				let changeMonth = inputMonth+1;
				let changeDay = inputDay;
				
				if(changeMonth>12){
					changeMonth=1;
					changeYear=changeYear+1;
				}
				
				let date = getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				
				changeForm("M", date);
        	}
			else if(select=="W"){
        		
        	}
			else if(select=="D"){
				
			}
        }

        function visiableCalendarSearch(){
        	
        }
        
        function whatIsDateInfo(form, date){
        	let v = document.getElementsByClassName("calendarHeadDate")[0];
        	
        	while(v.hasChildNodes()){
        		v.removeChild(v.firstChild);
        	}
        	
        	if(form=="Y"){
        		v.innerHTML += date.year+"년";
        		let info = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let month = date.month;
        		let day = date.day;
        		
        		if(date.month<10){
        			month = "0"+date.month;
        		}
        		if(date.day<10){
        			day = "0"+date.day;
        		}
        		
        		info.value = date.year+""+month+""+date.day;
        	}
        	else if(form="M"){
        		v.innerHTML += date.year+"년 "+date.month+"월";
        		let info = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let month = date.month;
        		let day = date.day;
        		
        		if(date.month<10){
        			month = "0"+date.month;
        		}
        		if(date.day<10){
        			day = "0"+date.day;
        		}
        		
        		info.value = date.year+""+month+""+date.day;
        	}
        	else if(form="W"){
        		v.innerHTML += date.year+"년 "+date.month+"월";
        		let info = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let month = date.month;
        		let day = date.day;
        		
        		if(date.month<10){
        			month = "0"+date.month;
        		}
        		if(date.day<10){
        			day = "0"+date.day;
        		}
        		
        		info.value = date.year+""+month+""+date.day;
        	}
        	else if(form="D"){
        		v.innerHTML += date.year+"년 "+date.month+"월 "+date.day+"일";
        		let info = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let month = date.month;
        		let day = date.day;
        		
        		if(date.month<10){
        			month = "0"+date.month;
        		}
        		if(date.day<10){
        			day = "0"+date.day;
        		}
        		// 달비교하고 초과할 경우에 대한 변수도 마련해야함
        		info.value = date.year+""+month+""+date.day;
        	}
        }

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
            
            centerBox.appendChild(createScheduleLayout());
            centerBox.appendChild(createCalanderLayout());
            
            let leftBox = document.createElement("div");
            leftBox.classList.add("leftBox");
            leftBox.appendChild(createNaviLayout());
            
            v.appendChild(rightBox);
            v.appendChild(centerBox);
            v.appendChild(leftBox);
            
            return v;
        }
        
        // 플랜 스케쥴 기능 
        function createScheduleLayout(){
			v = document.createElement("div");
			v.classList.add("calendarSchedule");
			
            c = document.createElement("div");
            c.classList.add("scheduleForm");
            
            cc = document.createElement("input");
            cc.setAttribute("type", "text");
            cc.setAttribute("name", "title");
            cc.setAttribute("placeholder", "제목 추가");
            cc.classList.add("scheduleFormTitle");
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "date");
            cc.setAttribute("name", "start");
            cc.setAttribute("min", "1900-01-01");
            cc.classList.add("scheduleFormStart");
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "date");
            cc.setAttribute("name", "end");
            cc.setAttribute("min", "1900-01-01");
            cc.classList.add("scheduleFormEnd");
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleFormContentVsiable");
            cc.innerHTML = "상세 설명";
            cc.addEventListener("click", scContentVisable);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.setAttribute("contenteditable", "true");
            cc.setAttribute("name", "content");
            cc.classList.add("scheduleFormContent");
            c.appendChild(cc);
            
           	cc = document.createElement("div");
            cc.classList.add("scheduleFormGroups");
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleColor");
            
            ccc = document.createElement("div");
            ccc.classList.add("scheduleColorSmall");
            
            let c4;
            let c5;
            let c6;
            
            c4 = document.createElement("div");
            c5 = document.createElement("span");
            c5.classList.add("smallColor")
            
            c6 = document.createElement("span");
            c6.classList.add("colors");
            c6.setAttribute("background-color", "rgb(244, 201, 107)");
            c5.appendChild(c6);
            
            c6 = document.createElement("span");
            c6.classList.add("colorsPointer");
            c5.appendChild(c6);
            
            c4.appendChild(c5);
            
            ccc.appendChild(c4);
            cc.appendChild(ccc);
            
            ccc = document.createElement("div");
            ccc.classList.add("scheduleColorBig");
            
            c4 = document.createElement("div");
            c5 = document.createElement("span");
            c5.classList.add("BigColor")
            
            for(let i = 0; i<10; i++){
            	c6 = document.createElement("span");
                c6.classList.add("colors");
                c6.classList.add("colorsData")
                c6.setAttribute("background-color", "rgb(244, 201, 107)");
                c5.appendChild(c6);
            }
            
            c4.appendChild(c5);
            ccc.appendChild(c4);
            cc.appendChild(ccc);
            
            ccc=document.createElement("input");
            ccc.setAttribute("type", "text");
            ccc.setAttribute("name", "color")
            ccc.classList.add("scheduleFormColor");
            ccc.classList.add("scheduleFormHidden");
            
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            v.appendChild(c);
            
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
		function changeForm(selectForm, date){
			if(selectForm=='undefined'){
				console.log('undefined');
			}
			if(typeof(date)!='undefined'||date!=null){
				if(selectForm=="Y"){
					YearForm(date);
					whatIsDateInfo(selectForm, date);
				}
				else if(selectForm=="M"){
					MonthForm(date);
					scheduleCheckMonth();
					whatIsDateInfo(selectForm, date);
				}
				else if(selectForm=="W"){
					WeekForm(date);	
					whatIsDateInfo(selectForm, date);	
				}
				else if(selectForm=="D"){
					DayForm(date);
					whatIsDateInfo(selectForm, date);
				}
			}
			else{
				if(selectForm=="Y"){
					YearForm();
					whatIsDateInfo(selectForm, getToday());
				}
				else if(selectForm=="M"){
					MonthForm();
					scheduleCheckMonth();
					whatIsDateInfo(selectForm, getToday());
				}
				else if(selectForm=="W"){
					WeekForm();		
					whatIsDateInfo(selectForm, getToday());
				}
				else if(selectForm=="D"){
					DayForm();
					whatIsDateInfo(selectForm, getToday());
				}
			}	
		}
        
		// Form 모양생성
		function YearForm(date){
			let div = document.getElementsByClassName("calendarDiv")[0];
			let divc = document.createElement("div");
            
			while(div.hasChildNodes()){
				div.removeChild(div.firstChild);
			}
            
			if(typeof(date)!='undefined'&&date!=null){
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
			if(typeof(date)!='undefined'&&date!=null){
				let div = document.getElementsByClassName("calendarDiv")[0];
				
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
				}
	            div.appendChild(createMonthFormElement(date));
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

		// 월 폼의 요소 만들기
		function createMonthFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            
			if(typeof(date)!='undefined'||date!=null){
				
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
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, date, NowMonth));
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("monthBox"); 
	                
	                let thisTimeDate="";
	                
					if(i<10){
						if(date.month<10){
							thisTimeDate = date.year+"0"+date.month+"0"+i
						}
						else{
							thisTimeDate = date.year+""+date.month+"0"+i
						}
					}
					else{
						if(date.month<10){
							thisTimeDate = date.year+"0"+date.month+""+i	
						}	
						else{
							thisTimeDate = date.year+""+date.month+""+i;
						}
					}					

	                cc.addEventListener("click", visibleSchedule);

	                ccc = document.createElement("div");
	                ccc.classList.add("monthBoxTitle");
	                
					if(i==1){
						cccc = document.createElement("span");
		                cccc.classList.add("monthBoxTitleBoxOne");
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
	                
	                cccc = document.createElement("input");
					cccc.classList.add("dateTag");
					cccc.setAttribute("type", "text");
					
					cccc.setAttribute("value", thisTimeDate);
					ccc.appendChild(cccc);
					
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[date.month];
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			c.appendChild(monthAfterFormDate(i, date));
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
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			c.appendChild(monthBeforeFormDate(i, getToday(), NowMonth));
	           		}
	           	}
	           	v.appendChild(c);
	            
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("monthBox"); 
	                
	                let thisTimeDate = "";
	                
	                if(i<10){
						thisTimeDate = getToday().year+""+getToday().month+"0"+i
					}
					else{
						thisTimeDate = getToday().year+""+getToday().month+""+i;
					}
	                
	                cc.addEventListener("click", visibleSchedule);
	                
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
	                
	                cccc = document.createElement("input");
					cccc.classList.add("dateTag");
					cccc.setAttribute("type", "text");
					
					cccc.setAttribute("value", thisTimeDate);
					ccc.appendChild(cccc);
	                
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	          
	            yoil = getYoil(getThisDay(today.year, today.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[today.month];
	          	
	          	
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	                    c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			c.appendChild(monthAfterFormDate(i, getToday()));
	           		}
	           	}
	           	v.appendChild(c);
			}
			return v;
		}
		
		// 몬스 폼에서 해당 월 마지막날 이후
		function monthAfterFormDate(i, date){
			if(typeof(i)=='undefined'||null){
				return;
			}
			let cc;
			let ccc;
			let cccc;
			
			if(date.month==12){
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
				let thisTimeDate = "";
				
				if(i<10){
					thisTimeDate = (date.year+1)+"0"+1+"0"+i
				}
				else{
					thisTimeDate = (date.year+1)+"0"+1+""+i;
				}
				cc.addEventListener("click", visibleSchedule);
				
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxTitle");
	            
	            cccc = document.createElement("span");
	            cccc.classList.add("monthBoxTitleBox");
	            cccc.innerHTML = i +"";
	            ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
		
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
			}
			else{
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
				let thisTimeDate = "";
				
				if(date.month<10){
					if(i<10){
						thisTimeDate = date.year+"0"+(date.month+1)+"0"+i;
					}
					else{
						thisTimeDate = date.year+"0"+(date.month+1)+""+i;
					}
				}
				else{
					if(i<10){
						thisTimeDate = date.year+""+(date.month+1)+"0"+i;
					}
					else{
						thisTimeDate = date.year+""+(date.month+1)+""+i;
					}
				}
				cc.addEventListener("click", visibleSchedule);
				
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxTitle");
	            
	            cccc = document.createElement("span");
	            cccc.classList.add("monthBoxTitleBox");
	            cccc.innerHTML = i +"";
	            ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
			}
            return cc;
		}
		
		// monthform에서 해당 월 1일 이전
		function monthBeforeFormDate(i, date, NowMonth){
			
			if(typeof(i)=='undefined'||null){
				return;
			}
			let cc;
			let ccc;
			let cccc;
			
			if(date.month==1){
				
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
	            let thisTimeDate = "";
	            
	            if(i>10){
					thisTimeDate = (date.year-1)+""+12+"0"+(NowMonth-i);
				}
				else{
					thisTimeDate = (date.year-1)+""+12+""+(NowMonth-i);
				}
				
	            cc.addEventListener("click", visibleSchedule);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxTitle");
	            
	            cccc = document.createElement("span");
	            cccc.classList.add("monthBoxTitleBox");
	            cccc.innerHTML = (NowMonth-i) +"";
	            ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
				
	            cc.appendChild(ccc);
			}
			else{
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
	            let thisTimeDate = "";
	            
	            if(date.month<10){
					if(i>10){
						thisTimeDate = date.year+"0"+(date.month-1)+"0"+(NowMonth-i);
					}
					else{
						thisTimeDate = date.year+"0"+(date.month-1)+""+(NowMonth-i);
					}
				}
				else{
					if(i>10){
						thisTimeDate = date.year+"0"+(date.month-1)+"0"+(NowMonth-i);
					}
					else{
						thisTimeDate = date.year+"0"+(date.month-1)+""+(NowMonth-i);
					}
				}
	            
	            cc.addEventListener("click", visibleSchedule);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxTitle");
	            
	            cccc = document.createElement("span");
	            cccc.classList.add("monthBoxTitleBox");
	            cccc.innerHTML = (NowMonth-i) +"";
	            ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
				
	            cc.appendChild(ccc);
			}
            return cc;
		}
		
		// 년 폼 요소 만들기 
		function createYearFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            
			if(typeof(date)!='undefined'||date!=null){
				
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
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i > -1 ; i--){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 2; i > -1 ; i--){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 3; i > -1 ; i--){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 4; i > -1 ; i--){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 5; i > -1 ; i--){
	           			c.appendChild(yearDummyForm());
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
	                
	                cccc = document.createElement("input");
					cccc.classList.add("dateTag");
					cccc.setAttribute("type", "text");
					let thisTimeDate = "";
					
					if(date.month<10){
						if(i<10){
							thisTimeDate = date.year+"0"+date.month+"0"+i;
						}
						else{
							thisTimeDate = date.year+"0"+date.month+""+i;
						}
					}
					else{
						if(i<10){
							thisTimeDate = date.year+""+date.month+"0"+i;
						}
						else{
							thisTimeDate = date.year+""+date.month+""+i;
						}
					}
				
					cccc.setAttribute("value", thisTimeDate);
					ccc.appendChild(cccc);
					
	                cc.appendChild(ccc);
	           		
	                c.appendChild(cc);
	            }
	            
	            v.appendChild(c);
	            
	            yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
	 			let afterYoil;
	            NowMonth = months[date.month];
	            
	            // 배열 값이 없는 항목을 참조: 할때 실행, 말을 12로 설정함 (1월일 경우 실행됨)
	            if(NowMonth==NaN||NowMonth==null){
	            	NowMonth = months[11];
	            }
	            
	           	if(yoil=="월"){
	           		for(let i = 1; i < 7; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="화"){
	           		for(let i = 1; i < 6 ; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="수"){
	           		for(let i = 1; i < 5 ; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="목"){
	           		for(let i = 1; i < 4 ; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="금"){
	           		for(let i = 1; i < 3 ; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	else if(yoil=="토"){
	           		for(let i = 1; i < 2 ; i++){
	           			c.appendChild(yearDummyForm());
	           		}
	           	}
	           	v.appendChild(c);
			}
			else{
				
			}
			return v;
		}
		
		function yearDummyForm(){
			let c;
			let cc;
			let ccc;
			
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
       		
            return cc;
		}
		
		// 현재 그룹의 스케줄을 체크 
	
		// AJAX 기본 세팅
		var XHRCalendar;//XHR + cal
		// let으로 선언하는 경우 > 레퍼런스 오류; create 단계에서 해당 변수 차몾를 해야하는데 변수 스코프를 벗어남
		// 레퍼런스 오류가 발생, 호이스팅 우선 순위 생각해서 var로 고쳐서 해결, 만약 let으로 사용해야하면 함수 선언 시점에 대한 알고리즘을 짜야함
		let xmlParser;
		let scheduleData = [];

		function createXHRCalendar(){
			if(window.ActiveXObject){ 
				XHRCalendar=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRCalendar=new XMLHttpRequest();
			}
		}
		
		// GroupCheck
		function checkGroup(){
			
			
		}
		
		function getGroup(user, date){
			let xmlGroup;
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	xmlParser = new DOMParser();
		            	xmlGroup = xmlParser.parseFromString(XHRCalendar.responseText, "text/xml");
		            	
		            	groups = xmlGroup.getElementsByTagName("group");
						
		            	for(let i = 0; i < groups.length; i++){
		            		schedules = groups[i].getElementsByTagName("schedule");
		            		
		            		for(let j = 0; j < schedules.length; j++){
		            			let temp = {
		            				key: groups[i].getElementsByTagName("key")[0].innerHTML,
		            				name: groups[i].getElementsByTagName("name")[0].innerHTML,
		            				num: schedules[j].getElementsByTagName("num")[0].innerHTML,
		            				title: schedules[j].getElementsByTagName("title")[0].innerHTML,
		            				start: schedules[j].getElementsByTagName("start")[0].innerHTML,
		            				end: schedules[j].getElementsByTagName("end")[0].innerHTML,
		            				content: schedules[j].getElementsByTagName("content")[0].innerHTML,
		            				user: schedules[j].getElementsByTagName("user")[0].innerHTML
		            			}
		            			scheduleData.push(temp);
		            		}
		            	}
		            	createScheduleElement(scheduleData, date);
		            	checkMonthScheduleFirst();
		            	scheduleData = []; // 배열 초기화하지 않으면 같은 스케줄이 해당 함수 실행시마다 추가됨
		            }
				}
			};
			XHRCalendar.open("POST", "../getGroup", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("userKey="+user);
		}
		
		function createScheduleElement(scheduleData, date){
			let nowYear = date.year;
			let nowMonth = date.month;
			let nowDay = date.day;
			let dateTags = document.getElementsByClassName("dateTag");
			
			for(let i = 0; i < scheduleData.length; i++){
				
				let startYear = parseInt(scheduleData[i].start.substring(0,4));
				let startMonth = parseInt(scheduleData[i].start.substring(4,6));
				let startDay = parseInt(scheduleData[i].start.substring(8,10));
				// 추후 팀원 중 주 및 일 일정은 day 변수까지 사용
				
				let endYear = parseInt(scheduleData[i].end.substring(0,4));
				let endMonth = parseInt(scheduleData[i].end.substring(5,7));
				let endDay = parseInt(scheduleData[i].end.substring(8,10));
				// 추후 팀원 중 주 및 일 일정은 day 변수까지 사용
				
				// 이어와 몬스에 따라 리턴해서 불필요한 경우 포문이 계속 돌게함 
				if(endYear<nowYear){
					continue;
				}
				else if(endYear==nowYear){
					if(endMonth<nowMonth){
						continue;
					}
				}
				
				if(startYear>nowYear){
					continue;
				}
				else if(startYear==nowYear){
					if(startMonth>nowMonth){
						continue;
					}
				}
				
				for(let j = 0; j < dateTags.length; j++){
					let dateTagYear = parseInt(dateTags[j].value.substring(0,4));
					let dateTagMonth = parseInt(dateTags[j].value.substring(4,6));
					let dateTagDay = parseInt(dateTags[j].value.substring(6,8));
					
					if(dateTagYear>startYear){
						if(dateTagYear<endYear){
							// 가운데 끼는 상황, 전체 반복해서 월에 다 표시
							createScheduleBox(scheduleData[i], dateTags[j]);
						}
						else if(dateTagYear==endYear){
							// 몬스 값을 비교해야함
							if(dateTagMonth<endMonth){
								// 가운데 끼는 상활, 전체 월에 표시
								createScheduleBox(scheduleData[i], dateTags[j]);
							}
							else if(dateTagMonth==endMonth){
								// 일 비교
								if(dateTagDay<=endDay){
									createScheduleBox(scheduleData[i], dateTags[j]);
									// 해당 요소에서 가장 처음에 모양 넣어주는 메서드를 따로 만들어서 한번 돌리는 식으로 해야함
								}
								else{
									continue;
								}
							}
							else{
								// 몬스 비교했는데 끝나는 달이 지금 달보다 전이면 넘김
								continue;
							}
						}
						else{
							//시작하는 년보다 현재 년이 높기는 한데, 끝나는 년이 현재 년보다 전이면 넘김
							// 이미 위에 해당 알고리즘을 넣었으나 같이 협업하는 팀원의 이해를 돕기 위해 넣음.
							continue;
						}
					}
					else if(dateTagYear==startYear){
						if(dateTagMonth>startMonth){
							// 일정이 시작 안한 상태랑 같음 >
							continue;
						}
						else if(dateTagMonth==startMonth){
							// 일정 달이 겹치므로 일 비교해야함 
							// 해당 일정이 해당 달에 시작하기 때문에 값이 일치하는 부분에서 포문으로 한번 그려주면 끝
							if(dateTagDay==startDay){
								if(dateTagMonth==endMonth){
									// 현재 월수가 끝나는 월가 같으면 일을 비교
									if(dateTagDay==endDay){
										// 현재 일수랑 끝나는 일수 같으면 1줄짜리로 그리면 됨 
										createScheduleBox(scheduleData[i], dateTags[j]);
									}
									else if(dateTagDay<endDay){
										// 끝나는 일수가 더 크면, 요일에 따라 해당 숫자의 차이만큼 7로 나누고 나머지로 모양 그려줘야함
										let calcDay = endDay-startDay;
										
										for(let l = j; l <=j+calcDay; l++){
											createScheduleBox(scheduleData[i], dateTags[l]);
										}
									}
								}
								else if(dateTagMonth<endMonth){
									// 현재 월보다 끝나는 월이 크면 마지막 일수까지 그리면 됨
									for(let l = j; l < dateTags.length; l++){
										createScheduleBox(scheduleData[i], dateTags[l]);
									}
								}
							}
							else{
								continue;
							}
						}	
					}
				}
			}
		}
		
		function createScheduleBox(scheduleData, dateTags){
			let p;
			let v;
			let c;
			let cc;
			let ccc;
			
			p = dateTags.parentNode; 
			
			v = document.createElement("div");
			v.classList.add("scheduleBox"); 
            
			c = document.createElement("span");
			c.classList.add("scheduleInfos"); 
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupKey"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.key);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupName"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.name);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleNum"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.num);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleTitle"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.title);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleStart"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.start);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleEnd"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.end);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleContent"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.content);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleUser"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.user);
			
			c.appendChild(cc);
			
			v.appendChild(c);
			p.appendChild(v);
		}
		
		function checkMonthScheduleFirst(){
			let scheduleBoxs = document.getElementsByClassName("scheduleBox");
			let scheduleNums = document.getElementsByClassName("scheduleNum");
			let scheduleTotal = [];
			
			for(let i = 0; i<scheduleNums.length; i++){
				let sn = parseInt(scheduleNums[i].value);//스케쥴 넘버의 값
				scheduleTotal.push(sn);
			}
			// 현재 페이지의 스케쥴 태그의 넘버를 가져옴 
			scheduleTotal = Array.from(new Set(scheduleTotal));
			
			for(let i = 0; i<scheduleTotal.length; i++){
				let boxArray = [];
				
				for(let j = 0; j <scheduleBoxs.length; j++){
					let sv = scheduleBoxs[j].getElementsByClassName("scheduleNum");
					
					if(sv.length==1){
						sv = sv[0].value;
					}
				
					if(scheduleTotal[i]==sv){
						boxArray.push(scheduleBoxs[j]);
					}
				}
				
				let flagSize = 0;
				let flagYoil;
				let flagDrawn = 0;
				
				for(let l = 0; l<boxArray.length; l++){
					// 해당 태그의 첫 요소의 데이터를 가져와서, 날짜를 파악> 요일 구해서 요일따라 길이 정해야함
					let dateTag = boxArray[l].parentElement.getElementsByClassName("dateTag")[0];
					let dateTagYear = parseInt(dateTag.value.substring(0,4));
					let dateTagMonth = parseInt(dateTag.value.substring(4,6));
					let dateTagDay = parseInt(dateTag.value.substring(6,8));
					
					let dateTagYoil = getYoil(getThisDay(dateTagYear, dateTagMonth, dateTagDay, 0, 0));
					
					if(l==0||flagDrawn==0){
						
						if(dateTagYoil=="일"){
							flagSize = 7;
							flagDrawn = 7;
						}
						else if(dateTagYoil=="월"){
							flagSize = 6;
							flagDrawn = 6;
						}
						else if(dateTagYoil=="화"){
							flagSize = 5;
							flagDrawn = 5;
						}
						else if(dateTagYoil=="수"){
							flagSize = 4;
							flagDrawn = 4;
						}
						else if(dateTagYoil=="목"){
							flagSize = 3;
							flagDrawn = 3;
						}
						else if(dateTagYoil=="금"){
							flagSize = 2;
							flagDrawn = 2;
						}
						else if(dateTagYoil=="토"){
							flagSize = 1;
							flagDrawn = 1;
						}
						
						if(flagSize>boxArray.length-l){
							// 사이즈칸 짜리 플래그 넣어주면 됨.
							flagSize=boxArray.length-l;
							
							boxArray[l].classList.add(checkMonthPlanBar(flagSize));
							let temp1 = boxArray[l].getElementsByClassName("scheduleInfos")[0];
							let temp2 = temp1.getElementsByClassName("scheduleTitle")[0].value;
					
							c = document.createElement("span");
							c.classList.add("scheduleTitleInSpan")
							c.innerHTML = temp2;
							boxArray[l].appendChild(c);
						}
						else{
							// 사이즈 만큼 그리고 빈 수만큼 
							boxArray[l].classList.add(checkMonthPlanBar(flagSize));
							let temp1 = boxArray[l].getElementsByClassName("scheduleInfos")[0];
							let temp2 = temp1.getElementsByClassName("scheduleTitle")[0].value;
							
							c = document.createElement("span");
							c.classList.add("scheduleTitleInSpan")
							c.innerHTML = temp2;
							boxArray[l].appendChild(c);
						}
					}
					else{
						boxArray[l].classList.add("cmpb0");
					}
					flagDrawn--;
				}
			}
		}
		
		
		function checkMonthPlanBar(flagSize){
			let name;
			
			if(flagSize==1){
				name="cmpb1";
			}
			else if(flagSize==2){
				name="cmpb2";
			}
			else if(flagSize==3){
				name="cmpb3";			
			}
			else if(flagSize==4){
				name="cmpb4";
			}
			else if(flagSize==5){
				name="cmpb5";
			}
			else if(flagSize==6){
				name="cmpb6";
			}
			else if(flagSize==7){
				name="cmpb7";
			}	
			return name;
		}
		
		// 스케줄 추가
		
		function visibleSchedule(){
			// 클릭했을때 현제 요소를 가져오고 안에 숨겨논 잇풋 감 가져옴
			// 가져온 값을 기초로 현재 폼에 지정된 데이터를 변경할 수 있다.
			
			let formStart = document.getElementsByClassName("scheduleFormStart")[0];
			let formEnd = document.getElementsByClassName("scheduleFormEnd")[0];
			
			let thisElement = event.currentTarget;
			
			let thisDay = thisElement.getElementsByClassName("dateTag")[0].value;
		
			let tempYear = thisDay.substring(0,4);
			let tempMonth = thisDay.substring(4,6);
			let tempDay = thisDay.substring(6,8);
			
			formStart.value = tempYear+"-"+tempMonth+"-"+tempDay;
			formEnd.value = tempYear+"-"+tempMonth+"-"+tempDay;
		
		}
		
		function scContentVisable(){
			console.log("work")
			
		}
		
		function toDoList(){
			
		}
		
		function toDoListComplete(){
			
		}
		
		function toDoLostDelete(){
			
		}
		
		function toDoListChange(){
			
		}
		
		
		// 년 형식 스케줄
		function scheduleCheckYear (date, user, group){
			if(typeof(date)!='undefined'||typeof(user)!='undefined'||typeof(group)!='undefined'){
				
			}
			else{
				
			}
		}
		
		// 월 형식 스케줄
		function scheduleCheckMonth (date, user){
			if(typeof(date)!='undefined'||typeof(user)!='undefined'||typeof(group)!='undefined'){
				user = window.sessionStorage.getItem("loginUserId");
				// 해당 페이지로 로드될 때 세션 값을 세팅해줘야함.
				
				getGroup(user, date);
			}
			else{
				date = getToday();
				user = window.sessionStorage.getItem("loginUserId");
				// 해당 페이지로 로드될 때 세션 값을 세팅해줘야함.
				
				if(user=='undefined'||user==null){
					user = "DEMOUSER"
				}
				getGroup(user, date);
			}
		}
		
	</script>
	
	
	<script> //제민_ 일간/주간 form.
	// for, if 쓰실때 {}, () 확인하고 잘닫아주셔야 합니다.
		function createWeekFormElement(){
			
			let v;
            let c;
            let cc;
            let ccc;    
            
			if((typeof(date)!='undefined'||date!=null)){
				v = document.createElement("div");
		        v.classList.add("calendarArea");
		        		         
				c = document.createElement("div");
	            c.classList.add("WeekAreaHead");
	            
	            for(let i = 0; i < 7; i++){
	                cc = document.createElement("div");
	                cc.classList.add("weekAreaHeadTitle");
	                cc.innerHTML = monthDayTitle[i];
	                c.appendChild(cc);
	            }
			}
			v.appendChild(c); //주간 form Head 생성
			
			c=document.createElement("div");
			c.classList.add("weekAreaBody");
			
			for(let i=0; i<7; i++){
				cc=document.createElement("div");
				cc.classList.add("weekDayBox");
				for(let j=0; j<24; j++){
					ccc=document.createElement("div");
					ccc.classList.add("WeekDayTimeBox");
					cc.appendChild(ccc);
				}
				c.appendChild(cc);
			}
			v.appendChild(c);//주간 form body 생성
			
		}//주간 formElement
		
		function createDayFormElement(){
			
			let v;
            let c;
            let yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
            
			if((typeof(date)!='undefined'||date!=null)){
				
				v = document.createElement("div");
		        v.classList.add("calendarArea");
		        		         
				c = document.createElement("div");
	            c.classList.add("DayAreaHead");
	           	
	            cc= document.createElement("div");
	            cc.classList.add("DayAreaHeadTitle");
	            cc.innerHTML= yoil+"";
	            
	            c.appendChild(cc);
			}
			v.appendChild(c); //일간 form head 생성
         
		}//일간 formElement
	</script>
</html>