<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- LoginUserKey: loginUserId -->
<% 
	String userKey = null;

	try{
		userKey = "'"+session.getAttribute("loginUserId").toString()+"'"; 
	}
	catch(Exception e){
		System.out.println("Session get Error: calendarMain.jsp: line 10: >>" +e);
	}
	
	if(userKey==null){
		userKey="'DEMOUSER'";
	}
%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>calendar</title>
        <link href="calendarCss.css" rel="stylesheet">
	</head>
	<body>
		<div id="calendar">
			
		</div>
	</body>
	<script>
		let userKey = <%=userKey%>;
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
        
        let tempData; 
        
        function getTodayDateString(){
        	let date = new Date();
        	let year = date.getFullYear();
        	let month = (1 + date.getMonth());
        	let day = date.getDate();
        
			let str = year+"-"+month+"-"+day;
			return str;
        }
        function getTodayTimeString(){
        	let date = new Date();
        	let hour = ("0" + date.getHours()).slice(-2);
			let minute = ("0" + date.getMinutes()).slice(-2);
			
			let str = hour+":"+minute;
			return str;
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
        
        // 달력 만들기 실행
        createToCalendar();
        
        
        // 달력 모양 만들기
        function createToCalendar(){
            let calendar = document.getElementById("calendar");
            calendar.appendChild(createToHeaderLayout());
            calendar.appendChild(createToBodyLayout()); 
            changeForm("M");
            createToDoListBasic();
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
				let changeDay = 10;
				
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
		
        // 캘린더 다음
        function goCalendarNext(){
			select = document.getElementsByClassName("selectForm")[0].value;
        	
        	if(select=="Y"){
        		let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear+1;
				let changeMonth = inputMonth;
				let changeDay = 10;
				
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
				let changeDay = 10;
				
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
		
        // 캘린더 검색
        function visiableCalendarSearch(){
        	
        }
        
        // 캘린더 현재 월이나 년수 표현
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
        
        // 스케줄 추가하기. 
        function createScheduleLayout(){
			v = document.createElement("div");
			v.classList.add("calendarSchedule");
			
            c = document.createElement("div");
            c.classList.add("scheduleForm");
            
            cc = document.createElement("input");
            cc.setAttribute("type", "hidden");
            cc.setAttribute("name", "scheduleNum");
            cc.classList.add("scheduleFormNum");
            c.appendChild(cc);
            
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
            cc.classList.add("scheduleFormContentVisiable");
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
            
            ccc = document.createElement("select");
            ccc.classList.add("scheduleFormGroupSelect");
            cc.appendChild(ccc);
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("name", "groupnum");
            ccc.classList.add("scheduleFormGroupnum");
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleColor");
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "color");
            ccc.setAttribute("name", "color");
            ccc.classList.add("scheduleFormColor");
            
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "button");
 			cc.setAttribute("value", "제출");
            cc.classList.add("scheduleFormSubmit");
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
            
            c = document.createElement("div");
            c.classList.add("goToCalendar");
            c.addEventListener("click", gotoCalendar);
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("goToCategory");
            c.addEventListener("click", gotoCategory);
            v.appendChild(c);
            
            return v;
        }
        
        function gotoCalendar(){
        	
        }
        
		function gotoCategory(){
        	
        }
        
        // 달력 그룹 항목 만들기
        function createGroupLayout(){
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("groupDiv");
            
            c = document.createElement("div");
            c.classList.add("groupMenu");
            
            cc = document.createElement("div");
            cc.classList.add("groupName");
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("groupAdd");
            cc.innerHTML = "추가";
            c.appendChild(cc);
            
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("groupMain");
            v.appendChild(c);
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
					scheduleCheckMonth(date);
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
					scheduleCheckMonth(getToday());
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
					
					cccc = document.createElement("input");
					cccc.classList.add("dateTag");
					cccc.setAttribute("type", "text");
					
					cccc.setAttribute("value", thisTimeDate);
					ccc.appendChild(cccc);
					
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
					cccc = document.createElement("input");
					cccc.classList.add("dateTag");
					cccc.setAttribute("type", "text");
					
					cccc.setAttribute("value", thisTimeDate);
					ccc.appendChild(cccc);
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
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
		
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
				
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
	            cc.appendChild(ccc);
			}
			else{
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
				let thisTimeDate = "";
				
				if(date.month<9){
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
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
	            
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");

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
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
				
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");

	            cc.appendChild(ccc);
			}
			else{
				cc = document.createElement("div");
	            cc.classList.add("monthBox"); 
	            
	            let thisTimeDate = "";
	            
	            if(date.month<=10){
					if(i>10){
						thisTimeDate = date.year+"0"+(date.month-1)+"0"+(NowMonth-i);
					}
					else{
						thisTimeDate = date.year+"0"+(date.month-1)+""+(NowMonth-i);
					}
				}
				else{
					if(i>10){
						thisTimeDate = date.year+""+(date.month-1)+"0"+(NowMonth-i);
					}
					else{
						thisTimeDate = date.year+""+(date.month-1)+""+(NowMonth-i);
					}
				}
	            
	            cc.addEventListener("click", visibleSchedule);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxTitle");
	            
	            cccc = document.createElement("span");
	            cccc.classList.add("monthBoxTitleBox");
	            cccc.innerHTML = (NowMonth-i) +"";
	            ccc.appendChild(cccc);
	            
	            cccc = document.createElement("input");
				cccc.classList.add("dateTag");
				cccc.setAttribute("type", "text");
				
				cccc.setAttribute("value", thisTimeDate);
				ccc.appendChild(cccc);
				
	            cc.appendChild(ccc);
	            
	            ccc = document.createElement("div");
	            ccc.classList.add("monthBoxBody");
	            
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
		
		// 년도의 표시되지 않으나 영역을 차지하는 폼 
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
		
		// TodoList용 AJAX
		var XHRTodolist;
		function createXHRTodolist(){
			if(window.ActiveXObject){ 
				XHRTodolist=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRTodolist=new XMLHttpRequest();
			}
		}
		
		// 스케줄 자세한 정보 창
		function scheduleDetailInfo(){
			let target = event.target;
			console.log(target);
			if(target.childElementCount!=0){
				
			}
			else if(target.childElementCount==0){
				target = target.parentElement;
			}
			
			let Infos = target.getElementsByClassName("scheduleInfos")[0];
			let num = Infos.getElementsByClassName("scheduleNum")[0].value;
			let title = Infos.getElementsByClassName("scheduleTitle")[0].value;
			let content = Infos.getElementsByClassName("scheduleContent")[0].value;
			let start = Infos.getElementsByClassName("scheduleStart")[0].value;
			let end = Infos.getElementsByClassName("scheduleEnd")[0].value;
			let color = Infos.getElementsByClassName("scheduleColor")[0].value;
			let groupnum = Infos.getElementsByClassName("groupNum")[0].value;
			let groupname = Infos.getElementsByClassName("groupName")[0].value;
			
			let data = {
				num: num,
				title: title,
				content: content,
				start: start,
				end: end,
				color: color,
				groupnum: groupnum,
				groupname: groupname
			}
			tempData = data;
			
			let body = document.getElementsByTagName("body")[0];

			body.appendChild(createScheduleDetail(data));
		}
		
		// 스케줄 자세한 정보 창 만들기
		function createScheduleDetail(data){
			let v;
			let c;
			let cc;
			let ccc;
			
			let body = document.getElementsByTagName("body")[0];
			let sDetails = document.getElementsByClassName("sDetail");
			
			// 자식 노드에 이전 노드가 있으면 다 삭제해버림
			while(body.getElementsByClassName("sDetail").length!=0){
				body.removeChild(sDetails[0]);
			}
			
			v = document.createElement("div"); 
			v.classList.add("sDetail");
			
			c = document.createElement("div"); 
			c.classList.add("sDetailMenu");
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMenuEmpty");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMenuFix");
			cc.addEventListener("click", scheduleDetailInfoFix);
			// 아이콘 만들어지면 삭제
			cc.innerHTML="수정";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMenuDelete");
			cc.addEventListener("click", delGroupSchedule);
			// 아이콘 만들어지면 삭제
			cc.innerHTML="삭제";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMenuQuit");
			cc.addEventListener("click", quitScheduleDetail);
			// 아이콘 만들어지면 삭제
			cc.innerHTML="끄기";
			c.appendChild(cc);
			v.appendChild(c);
			
			c = document.createElement("div"); 
			c.classList.add("sDetailMain");
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMainColor");
			
			ccc = document.createElement("div");
			ccc.classList.add("sDetailMainColorBox");
			let t = "background-color"+data.color;
			ccc.setAttribute("style", t);
			cc.appendChild(ccc);
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailMainTitle");
			cc.innerHTML = data.title;
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("sDetailTime");
			
			let startDay = data.start.substring(0,10);
			let startTime = data.start.substring(11,20);
			let endDay = data.end.substring(0,10);
			let endTime = data.end.substring(11,20);
			
			if(startDay==endDay){
				t = startDay + " " + startTime + " ~ " + endTime;
				cc.innerHTML = t;
			}
			else{
				t = data.start + " ~ " + data.end;
				cc.innerHTML = t;
			}
			c.appendChild(cc);
			v.appendChild(c);
			
			c = document.createElement("div"); 
			c.classList.add("sDetailContent");
			
			cc = document.createElement("div");
			cc.classList.add("sDetailContentLogo");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailContentText");
			cc.innerHTML = data.content;
			c.appendChild(cc);
			v.appendChild(c);
			
			c = document.createElement("div"); 
			c.classList.add("sDetailGroup");
			
			cc = document.createElement("div");
			cc.classList.add("sDetailGroupLogo");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("sDetailGroupName");
			cc.innerHTML = data.groupname;
				
			c.appendChild(cc);
			
			v.appendChild(c);
			
			return v;
		}
		
		function quitScheduleDetail(){
			console.log("quit ");
		}
		
		// 스케줄 수정
		function scheduleDetailInfoFix(){
			let data = tempData;
			
			let startDay = data.start.substring(0,10);
			let startTime = data.start.substring(11,20);
			
			let endDay = data.end.substring(0,10);
			let endTime = data.end.substring(11,20);
			
			let form = document.getElementsByClassName("scheduleForm")[0];
			let formnum = form.getElementsByClassName("scheduleFormNum")[0];
			let formtitle = form.getElementsByClassName("scheduleFormTitle")[0];
			let formcontent = form.getElementsByClassName("scheduleFormContent")[0];
			let formstart = form.getElementsByClassName("scheduleFormStart")[0];
			let formend = form.getElementsByClassName("scheduleFormEnd")[0];
			let formcolor = form.getElementsByClassName("scheduleFormColor")[0];
			let formgroupSelect = form.getElementsByClassName("scheduleFormGroupSelect")[0];
			let options = formgroupSelect.getElementsByClassName("scheduleFormGroupSelectOption");
			
			formnum.setAttribute("value", data.num);
			formtitle.setAttribute("value", data.title);
			formcontent.setAttribute("value", data.content);
			formstart.setAttribute("value", startDay);
			formstart.value=startDay;
			formend.setAttribute("value", endDay);
			formend.value=endDay;
			formcolor.setAttribute("value", data.color);
			
			for(let i = 0; i<options.length; i++){
				if(options[i].value==data.groupnum){
					options[i].setAttribute("selected", "true");
				}
			}
		}
		
		// 스케줄 수정 창 보이기: 현재 클릭 요소 날짜 세팅
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
			let s = tempYear+"-"+tempMonth+"-"+tempDay;
			let e = tempYear+"-"+tempMonth+"-"+tempDay
			formStart.value = s;
			formStart.setAttribute("value", s);
			
			formEnd.value = s;
			formEnd.setAttribute("value", s);
		}
		
		console.log("그룹 기능 개발중, 그룹 멤버 추가, 수정 삭제 등 전반 기능 구현 필요")
		// 스케줄 데이터에 따른 Group 데이터 > div로 생성 
		function createGroupDivs(groupDivs){
			let v = document.getElementsByClassName("groupMain")[0];
			
			while(v.hasChildNodes()){
				return;
			}
			
	        let c;
	        let cc;
	        let ccc;

			for(let i = 0; i<groupDivs.length; i++){
				c = document.createElement("div");
				c.classList.add("groupElement");
				
				cc = document.createElement("div");
				cc.classList.add("groupCheckBox");
				cc.addEventListener("click", viewGroupForSchedule);
				cc.innerHTML = "보기/끄기";
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupNameVisible");
				cc.innerHTML = groupDivs[i].groupname;
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupCheckBox");
				cc.addEventListener("click", viewGroupTool);
				cc.innerHTML = "설정";
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataName");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", groupDivs[i].groupname);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataName");
				cc.setAttribute("type", "color");
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupMemberList");
				
				ccc = document.createElement("div");
				ccc.classList.add("groupMemberAdd");
				ccc.innerHTML="멤버 추가";
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupMemberSearch");
				ccc.setAttribute("contenteditable", "true");
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupMembers");
				ccc.innerHTML=groupDivs[i].groupmembers;
				cc.appendChild(ccc);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataDelBtn");
				cc.setAttribute("type", "button");
				cc.setAttribute("value", "삭제");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataAddBtn");
				cc.setAttribute("type", "button");
				cc.setAttribute("value", "완료");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataNum");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", groupDivs[i].groupnum);
				c.appendChild(cc);
				
				// 그룹 요소를 클릭할 경우, 해당 요소가 보일지 말지를 결정
				cc = document.createElement("input");
				cc.classList.add("groupDataFlag");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", "true");
				c.appendChild(cc);
				
				v.appendChild(c);
			}
			
			let select = document.getElementsByClassName("scheduleFormGroupSelect")[0];
			
			while(select.hasChildNodes()){
				return;
			}
			
			for(let i = 0; i<groupDivs.length; i++){
				c = document.createElement("option");
				c.classList.add("scheduleFormGroupSelectOption");
				c.setAttribute("value", groupDivs[i].groupnum);
				c.innerHTML = groupDivs[i].groupname;
				select.appendChild(c);
			}
		}
		function viewGroupTool(){
			
		}
		// 그룹 클릭에 따라 스케줄 보이거나 감추기
		function viewGroupForSchedule(){
			let clicked = event.target;
			let groupDiv = clicked.parentNode;
			let num = groupDiv.getElementsByClassName("groupDataNum")[0].value;
			let flag = groupDiv.getElementsByClassName("groupDataFlag")[0];
			
			if(flag.value=="true"){
				flag.setAttribute("value", "false"); // 안보이는 상태
				groupDiv.classList.add("lineThrough");
			}
			else if(flag.value=="false"){
				flag.setAttribute("value", "true"); // 보이는 상태 
				groupDiv.classList.remove("lineThrough");
				console.log("d");
			}
			
			viewScheduleElementFlag();
		}
		
		// 스케줄 보이거나 감추기 작동
		function viewScheduleElementFlag(){
			let groupDiv = document.getElementsByClassName("groupElement");
			
			let schedules = document.getElementsByClassName("scheduleBox");
			
			for(let i = 0; i < groupDiv.length; i++){
				let flag = groupDiv[i].getElementsByClassName("groupDataFlag")[0].value+"";
				let num = groupDiv[i].getElementsByClassName("groupDataNum")[0].value+"";;
				for(let j = 0; j <schedules.length; j++){
					let scheduleNum = schedules[j].getElementsByClassName("groupNum")[0].value+"";
					
					if(num==scheduleNum){
						if(flag=="true"){
							schedules[j].classList.remove("hiddenElement");
						}
						else if(flag=="false"){
							schedules[j].classList.add("hiddenElement");
						}
					}
				}
			}
		}
		
		
		function scContentVisable(){
			console.log("work")
		}
		
		//TO DO LIST
		function toDoList(){
			createXHRTodolist();
			console.log(XHRTodolist);
			
			XHRTodolist.onreadystatechange=function(){
				if(XHRTodolist.readyState==4){
		            if(XHRTodolist.status==200){
		            	let jsons = JSON.parse(XHRTodolist.responseText, "text/json");

		            	createToDoList(jsons);
		            }
				}
			}
			XHRTodolist.open("POST", "../todolistSelect", true);
			XHRTodolist.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRTodolist.send("userKey="+userKey);
		}
		
		function createToDoListBasic(){
			let toDoListDiv = document.getElementsByClassName("toDoListDiv")[0];
			
			v = document.createElement("div");
			v.classList.add("toDoListElements");
			
			c = document.createElement("div");
			c.classList.add("toDoListMenu");
			
			cc = document.createElement("div");
			cc.classList.add("toDoListTitle");
			cc.innerHTML = "오늘 할 일";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListAdd");
			cc.addEventListener("click", todolistAdd);
			// 아이콘 만들어지면 지울거
			cc.innerHTML = "추가";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListCom");
			cc.addEventListener("click", todolistCom);
			// 아이콘 만들어지면 지울거
			cc.innerHTML = "완료된 것 삭제";
			c.appendChild(cc);
			v.appendChild(c);
			
			c = document.createElement("div");
			c.classList.add("toDoListMain");
			v.appendChild(c);
			
			toDoListDiv.appendChild(v);
		}
		
		function createToDoList(jsons){
			
			let v;
			let c;
			let cc;
			let ccc;
			let cccc;
			
			v = document.getElementsByClassName("toDoListMain")[0];
			
        	while(v.hasChildNodes()){
        		v.removeChild(v.firstChild);
        	}
        	
			// 매개변수 객체 가져와서 데이터 정제 > 정제한 데이터로 폼 모양 그림
			// 정제는 DB에서 값 던질때 함 
			for(let i = 0; i<jsons.length; i++){
				c = document.createElement("div");
				c.classList.add("toDoLists");
				
				cc = document.createElement("span");
				cc.classList.add("toDoListCheckBox");
				cc.innerHTML = "완료하기";
				cc.addEventListener("click", todolistCheckedBtn);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].title);
				cc.classList.add("toDoListTitle");
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListFixBtn");
				cc.addEventListener("click", todolistFixBtn);
				// 아이콘 만들어지면 지울거
				cc.innerHTML = "수정";
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].content);
				cc.classList.add("toDoListContent");
				cc.classList.add("toDoListView");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].date);
				cc.classList.add("toDoListDate");
				cc.classList.add("toDoListView");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].time);
				cc.classList.add("toDoListTime");
				cc.classList.add("toDoListView");
				c.appendChild(cc);
				
				cc = document.createElement("select");
				cc.classList.add("toDoListImportance");
				cc.classList.add("toDoListView");
				
				for(let j = 1; j < 5; j++){
					ccc = document.createElement("option");
					ccc.classList.add("toDoListImportanceOption");
					ccc.setAttribute("value", j);
					ccc.innerHTML = j;
					cc.appendChild(ccc);
					
					if(ccc.value==jsons[i].importance){
						ccc.setAttribute("selected", "true");
					}
				}
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].num);
				cc.classList.add("toDoListNum");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].id);
				cc.classList.add("toDoListId");
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].checked);
				cc.classList.add("toDoListChecked");
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListDelBtn");
				cc.addEventListener("click", todolistDelBtn);
				// 아이콘 만들어지면 지울거
				cc.innerHTML = "삭제";
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListAddBtn");
				cc.addEventListener("click", todolistAddBtn);
				// 아이콘 만들어지면 지울거
				cc.innerHTML = "완료";
				c.appendChild(cc);
				
				v.appendChild(c);
			}
		}
		
		function toDoListDelete(data){
			if(data.length==null){
				return;
			}
			
			createXHRTodolist();
			
			XHRTodolist.onreadystatechange=function(){
				if(XHRTodolist.readyState==4){
		            if(XHRTodolist.status==200){
		            	// 통신이 완료된 뒤 실행해야 변경상항 확인가능
		            	toDoList();
		            }
				}
			}
			XHRTodolist.open("POST", "../todolistDelete", true);
			XHRTodolist.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRTodolist.send(data);
		}
		
		function toDoListInsert(data){
			createXHRTodolist();
			
			XHRTodolist.onreadystatechange=function(){
				if(XHRTodolist.readyState==4){
		            if(XHRTodolist.status==200){
		            	// 통신이 완료된 뒤 실행해야 변경상항 확인가능
		            	toDoList();
		            }
				}
			}
			XHRTodolist.open("POST", "../todolistInsert", true);
			XHRTodolist.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRTodolist.send(data);
		}
		
		function todolistAdd (){
			let v;
			let c;
			let cc;
			let ccc;
			
			v = document.getElementsByClassName("toDoListMain")[0];
			
			c = document.createElement("div");
			c.classList.add("toDoLists");
			
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			
			cc.classList.add("toDoListNum");
			c.appendChild(cc);
			
			cc = document.createElement("span");
			cc.classList.add("toDoListCheckBox");
			cc.innerHTML = "완료하기";
			cc.addEventListener("click", todolistCheckedBtn);
			c.appendChild(cc);
			
			cc = document.createElement("input");
			let temp = cc;
			cc.setAttribute("type", "text");
			cc.classList.add("toDoListTitle");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListFixBtn");
			cc.addEventListener("click", todolistFixBtn);
			// 아이콘 만들어지면 지울거
			cc.innerHTML = "수정";
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "text");
			cc.classList.add("toDoListContent");
			cc.classList.add("toDoListView");
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "date");
			cc.setAttribute("value", getTodayDateString());
			cc.innerHTML = getTodayDateString();
			cc.classList.add("toDoListDate");
			cc.classList.add("toDoListView");
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "text");
			cc.setAttribute("value", getTodayTimeString());
			cc.classList.add("toDoListTime");
			cc.classList.add("toDoListView");
			c.appendChild(cc);
			
			cc = document.createElement("select");
			cc.classList.add("toDoListImportance");
			cc.classList.add("toDoListView");
			
			for(let j = 1; j < 5; j++){
				ccc = document.createElement("option");
				ccc.classList.add("toDoListImportanceOption");
				ccc.setAttribute("value", j);
				ccc.innerHTML = j;
				cc.appendChild(ccc);
			}
			c.appendChild(cc);
			
			ccc = document.createElement("input");
			ccc.setAttribute("type", "hidden");
			ccc.classList.add("toDoListNum");
			cc.appendChild(ccc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", userKey);
			cc.classList.add("toDoListId");
			c.appendChild(cc);
	
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", "false");
			cc.classList.add("toDoListChecked");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListDelBtn");
			cc.addEventListener("click", todolistDelBtn);
			// 아이콘 만들어지면 지울거
			cc.innerHTML = "삭제";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListAddBtn");
			cc.addEventListener("click", todolistAddBtn);
			// 아이콘 만들어지면 지울거
			cc.innerHTML = "완료";
			c.appendChild(cc);

			
			v.appendChild(c);
			
			temp.focus();
		}
		
		function todolistDelBtn(){
			let target = event.target;
			let v = target.parentNode;
			
			let num = v.getElementsByClassName("toDoListNum")[0].value; 
			let temp = [];
			temp.push(num);
			data={
				key: temp
			};
			
			let json = JSON.stringify(data);
			toDoListDelete(json);
		}
		
		function todolistAddBtn(){
			let target = event.target;
			let v = target.parentNode;
			
			let title = v.getElementsByClassName("toDoListTitle")[0].value; 
			let content = v.getElementsByClassName("toDoListContent")[0].value; 
			let date = v.getElementsByClassName("toDoListDate")[0].value; 
			let time = v.getElementsByClassName("toDoListTime")[0].value; 
			let importance = v.getElementsByClassName("toDoListImportance")[0].value; 
			let num = v.getElementsByClassName("toDoListNum")[0].value; 
			let id = v.getElementsByClassName("toDoListId")[0].value; 
			let checked = v.getElementsByClassName("toDoListChecked")[0].value; 
			
			let data = createJsonTodolist(num, title, content, id, date, time, importance, checked);
			let json = JSON.stringify(data);
			toDoListInsert(json);
		}
		
		function todolistFixBtn(){
			let target = event.target;
			let v = target.parentNode;
		}
		
		function todolistCheckedBtn(){
			let target = event.target;
			let v = target.parentNode;
			let checked = v.getElementsByClassName("toDoListChecked")[0]; 
			console.log(checked);
			
			if(checked.value=='true'){
				checked.setAttribute("value", "false");
			}
			else{
				checked.setAttribute("value", "true");
			}
			checked = v.getElementsByClassName("toDoListChecked")[0].value;
			
			let title = v.getElementsByClassName("toDoListTitle")[0].value; 
			let content = v.getElementsByClassName("toDoListContent")[0].value; 
			let date = v.getElementsByClassName("toDoListDate")[0].value; 
			let time = v.getElementsByClassName("toDoListTime")[0].value; 
			let importance = v.getElementsByClassName("toDoListImportance")[0].value; 
			let num = v.getElementsByClassName("toDoListNum")[0].value; 
			let id = v.getElementsByClassName("toDoListId")[0].value; 
			
			let data = createJsonTodolist(num, title, content, id, date, time, importance, checked);
			let json = JSON.stringify(data);
			
			toDoListInsert(json);
		}
		
		function todolistCom(){
			let tdl = document.getElementsByClassName("toDoLists");
			let data;
			let temp=[];
			for(let i = 0; i < tdl.length; i++){
				let checked = tdl[i].getElementsByClassName("toDoListChecked")[0].value;
				// 체크된 상태
				if(checked=="true"&&checked!='undefined'){
					let num = tdl[i].getElementsByClassName("toDoListNum")[0].value;
					temp.push(num);
				}
			}
			data = {
				key: temp	
			}
			let json = JSON.stringify(data);
			toDoListDelete(json);
		};
		
		// 년 형식 스케줄
		function scheduleCheckYear (date, userKey, group){
			if(typeof(date)!='undefined'||typeof(userKey)!='undefined'||typeof(userKey)!=null||typeof(group)!='undefined'){
				
			}
			else{
				
			}
		}
		
		// 월 형식 스케줄
		function scheduleCheckMonth (date){
			console.log(date);
			if(typeof(userKey)=='undefined'||userKey==null){
				userKey = "DEMOUSER"
			}
			if(typeof(date)!='undefined'){
				getGroupSchedule(userKey, date);
			}
			else{
				date = getToday();
				getGroupSchedule(userKey, date);
			}
			
			
		}
		
		// 유저키와 데이터로 그룹 및 스케줄 데이터 가져옴 
		function getGroupSchedule(userKey, date){
			let xmlGroup;
			let scheduleTitleInSpans = document.getElementsByClassName("scheduleTitleInSpan");
			
			/*
			if(typeof(scheduleTitleInSpans)!='undefined'){
				for(let i = 0; i < scheduleTitleInSpans.length; i++){
					if(scheduleTitleInSpans[i].hasChildNodes()){
						scheduleTitleInSpans[i].removeChild(scheduleTitleInSpans[i].firstChild);
					}
				}
			}
			*/
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==3){
					toDoList();
				}
				if(XHRCalendar.readyState==4){
					
		            if(XHRCalendar.status==200){
		            	clearMonthBoxBody();
		            	xmlParser = new DOMParser();
		            	xmlGroup = xmlParser.parseFromString(XHRCalendar.responseText, "text/xml");
		            	
		            	groups = xmlGroup.getElementsByTagName("group");
		            	groupDivs = [];
		            	console.log(XHRCalendar);
		            	
		            	for(let i = 0; i < groups.length; i++){
		            		schedules = groups[i].getElementsByTagName("schedule");
		            		
		            		for(let j = 0; j < schedules.length; j++){
		            			let temp = {
		            				groupnum: groups[i].getElementsByTagName("groupnum")[0].innerHTML,
		            				groupname: groups[i].getElementsByTagName("groupname")[0].innerHTML,
		            				groupcolor: groups[i].getElementsByTagName("groupcolor")[0].innerHTML,
		            				groupmembers: groups[i].getElementsByTagName("groupmembers")[0].innerHTML,
		            				modifier: groups[i].getElementsByTagName("modifier")[0].innerHTML,
		            				num: schedules[j].getElementsByTagName("num")[0].innerHTML,
		            				title: schedules[j].getElementsByTagName("title")[0].innerHTML,
		            				start: schedules[j].getElementsByTagName("start")[0].innerHTML,
		            				end: schedules[j].getElementsByTagName("end")[0].innerHTML,
		            				content: schedules[j].getElementsByTagName("content")[0].innerHTML,
		            				writer: schedules[j].getElementsByTagName("writer")[0].innerHTML,
		            				color: schedules[j].getElementsByTagName("color")[0].innerHTML
		            			} 
		            			scheduleData.push(temp);
		            			//console.log(temp);
		            		}
		            		
		            		let tempDiv = {
		            			groupnum: groups[i].getElementsByTagName("groupnum")[0].innerHTML,
			            		groupname: groups[i].getElementsByTagName("groupname")[0].innerHTML,
			            		groupmembers: groups[i].getElementsByTagName("groupmembers")[0].innerHTML
		            		}
		            		groupDivs.push(tempDiv);
		            	}
		            	createScheduleElement(scheduleData);
		            	checkMonthScheduleFirst();
		            	scheduleData = []; // 배열 초기화하지 않으면 같은 스케줄이 해당 함수 실행시마다 추가됨
		            	createGroupDivs(groupDivs);
		            	viewScheduleElementFlag();
		            	changeScheduleBoxs();
		            }
				}
			};
			XHRCalendar.open("POST", "../scheduleSelect", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("userKey="+userKey);
		}
		
		// 스케줄 요소를 제작
		function createScheduleElement(scheduleData){
			let dateTags = document.getElementsByClassName("dateTag");
			
			
			for(let i = 0; i < scheduleData.length; i++){
				
				let startYear = parseInt(scheduleData[i].start.substring(0,4));
				let startMonth = parseInt(scheduleData[i].start.substring(5,7));
				let startDay = parseInt(scheduleData[i].start.substring(8,10));
				// 추후 팀원 중 주 및 일 일정은 day 변수까지 사용
				
				let endYear = parseInt(scheduleData[i].end.substring(0,4));
				let endMonth = parseInt(scheduleData[i].end.substring(5,7));
				let endDay = parseInt(scheduleData[i].end.substring(8,10));
				// 추후 팀원 중 주 및 일 일정은 day 변수까지 사용
				
				// 이어와 몬스에 따라 리턴해서 불필요한 경우 포문이 계속 돌게함 

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
							if(dateTagMonth>endMonth){
								// 일정 끝남 
							}
							else if(dateTagMonth<endMonth){
								createScheduleBox(scheduleData[i], dateTags[j]);
							}
							else if(dateTagMonth==endMonth){
								if(dateTagDay>endDay){
									
								}
								else if(dateTagDay<=endDay){
									createScheduleBox(scheduleData[i], dateTags[j]);
								}
							}
						}
						else if(dateTagYear>endYear){
							// 끝난 일정
						}
					}
					else if(dateTagYear==startYear){
						if(dateTagYear<endYear){
							// 가운데 끼는 상황, 전체 반복해서 월에 다 표시
							if(dateTagMonth<startMonth){
							
							}
							else if(dateTagMonth>startMonth){
								createScheduleBox(scheduleData[i], dateTags[j]);
							}
							else if(dateTagMonth==startMonth){
								if(dateTagDay<startDay){
									
								}
								else if(dateTagDay=>startDay){
									createScheduleBox(scheduleData[i], dateTags[j]);
								}
							}
						}
						else if(dateTagYear==endYear){
							if(dateTagMonth<startMonth){
								// 일정이 시작 안한 상태랑 같음 >
							}
							else if(dateTagMonth>startMonth){
								if(dateTagMonth>endMonth){
									// 일정 끝남 
								}
								else if(dateTagMonth==endMonth){
									// 날짜를 비교함
									if(dateTagDay>endDay){
										// 끝 날짜보다 크면 그리지 말아야함
									}
									else if(dateTagDay<=endDay){
										// 같거나 끝나짜가 크면 그려야함
										createScheduleBox(scheduleData[i], dateTags[j]);
									}
								}
								else if(dateTagMonth<endMonth){
									// 현재 달이 끝나는 달보다 크므로 모두 그려줌
									createScheduleBox(scheduleData[i], dateTags[j]);
								}
							}
							else if(dateTagMonth==startMonth){
								// 일정 달이 겹치므로 일 비교해야함 
								// 해당 일정이 해당 달에 시작하기 때문에 값이 일치하는 부분에서 포문으로 한번 그려주면 끝
								if(dateTagMonth==endMonth){
									if(dateTagDay<startDay){
										// 일정 시작 안함 
									}
									else if(dateTagDay=>startDay){
										// 일정은 시작됨, 마지막 날 비교
										if(dateTagDay>endDay){
											
										}
										else if(dateTagDay<=endDay){
											createScheduleBox(scheduleData[i], dateTags[j]);
										}
									}
								}
								else if(dateTagMonth<endMonth){
									// 시작 날짜 비교
									if(dateTagDay<startDay){
										// 일정 시작 안함 
									}
									else if(dateTagDay=>startDay){
										// 일정은 시작됨, 마지막 날 비교
										createScheduleBox(scheduleData[i], dateTags[j]);
									}
								}
							}	
						}
						else if(dateTagYear>endYeat){
							// 존재할 수 없는 경우
						}	
					}
					else if(dateTagYear<startYear){
						// 일정 시작 안함
					}
				}
			}
		}
		
		// 스케줄 박스 요소 제작
		function createScheduleBox(scheduleData, dateTags){
			let p;
			let v;
			let c;
			let cc;
			let ccc;
			
			p = dateTags.parentNode;
			pp = p.parentNode;
			
			let monthBoxBody = pp.getElementsByClassName("monthBoxBody")[0];
			
			v = document.createElement("div");
			v.classList.add("scheduleBox"); 
			v.addEventListener("click", scheduleDetailInfo)
			v.setAttribute("style", "background-color:"+scheduleData.color);
            
			c = document.createElement("span");
			c.classList.add("scheduleInfos"); 
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupNum"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.groupnum);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupName"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.groupname);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupColor"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.groupcolor);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("modifier"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.modifier);
			
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
			cc.classList.add("scheduleWriter"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.writer);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleColor"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.color);
			
			c.appendChild(cc);
			
			v.appendChild(c);
			monthBoxBody.appendChild(v);
		}
		
		// 스케줄의 첫 요소 확인,
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
					let dateTag = boxArray[l].parentElement.parentElement.getElementsByClassName("dateTag")[0];
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
							let temp3 = temp1.getElementsByClassName("groupColor")[0].value;
							
							c = document.createElement("span");
							c.classList.add("scheduleGroupColor")
							let thisColor = "background-color: "+temp3;
							c.setAttribute("style", thisColor);
							boxArray[l].appendChild(c);
							
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
							let temp3 = temp1.getElementsByClassName("groupColor")[0].value;
							
							c = document.createElement("span");
							c.classList.add("scheduleGroupColor")
							let thisColor = "background-color: "+temp3;
							c.setAttribute("style", thisColor);
							boxArray[l].appendChild(c);
							
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
		
		// 현재 스케줄의 Bar 길이를 확인
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
		
		// 스케줄 추가 버튼
		let scheduleFormBtn = document.getElementsByClassName("scheduleFormSubmit")[0];
		
		scheduleFormBtn.addEventListener("click", function (){
			let temp = document.getElementsByClassName("calendarHeadDateInfo")[0].value;
			let year = parseInt(temp.substring(0,4));
			let month = parseInt(temp.substring(4,6));
			let day = parseInt(temp.substring(6,8));
			let date = getThisDay(year, month, day, 0, 0);
			addGroupSchedule(temp);
		})
		
		// 스케줄 추가 
		function addGroupSchedule(date){
			let jsonSchedule;
			
			let num = document.getElementsByClassName("scheduleFormNum")[0].value;
			let title = document.getElementsByClassName("scheduleFormTitle")[0].value;
			let content = document.getElementsByClassName("scheduleFormContent")[0].innerHTML;
			let start = document.getElementsByClassName("scheduleFormStart")[0].value;
			let end = document.getElementsByClassName("scheduleFormEnd")[0].value;
			let color = document.getElementsByClassName("scheduleFormColor")[0].value;
			let writer = userKey;
			let groupnum = document.getElementsByClassName("scheduleFormGroupSelect")[0].value;
			
			jsonSchedule = JSON.stringify(createJsonSchedule(num, title, content, start, end, color, writer, groupnum));
			
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	getGroupSchedule(userKey, date);
		            }
				}
			};
			XHRCalendar.open("POST", "../scheduleInsert", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send(jsonSchedule);
		}
		
		// 스케줄 삭제 기능
		function delGroupSchedule(date){
			let data = tempData;
			createXHRCalendar();
			
			if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
			}
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	getGroupSchedule(userKey, date);
		            }
				}
			};
			XHRCalendar.open("POST", "../scheduleDelete", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("num="+data.num);
		}
		
		// JSON SCHEDULE 객체 데이터 생성 
		function createJsonSchedule(num, title, content, start, end, color, writer, groupnum){
			let json = {
				num: num,
				title: title,
				content: content,
				start: start,
				end: end,
				color: color,
				writer: writer,
				groupnum: groupnum
			}
			return json;
		}
		
		// JSON To Do List객체 데이터 생성 
		function createJsonTodolist(num, title, content, id, date, time, importance, checked){
			let json = {
				num: num,
				title: title,
				content: content,
				id: id,
				date: date,
				time: time,
				importance: importance,
				checked: checked
			}
			return json;
		}
		
		// 스케줄 Box 영역 초기화
		function clearMonthBoxBody(){
			let v = document.getElementsByClassName("monthBoxBody");
			
			for(let i = 0; i < v.length; i++){
				while(v[i].hasChildNodes()){
					v[i].removeChild(v[i].firstChild);
				}
			}
		}
		// 스케줄 BOX 면적용 요소 위로 올리기
		function changeScheduleBoxs(){
			let v;
			let p;
			let pp;
			
			v = document.getElementsByClassName("cmpb0");
			for(let i = 0; i<v.length; i++){
				v[i].removeAttribute("style");
				p = v[i].parentNode;
				p.insertBefore(v[i], p.firstChild);
			}
			/*
			v = document.getElementsByClassName("scheduleNum");
			for(let i = 0; i<v.length; i++){
				p = v[i].parentNode;
				pp = p.parentNode;
				
				p.insertBefore(v[i], p.firstChild);
			}*/
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
					ccc.classList.add("weekDayTimeBox");
					cc.appendChild(ccc);
				}
				c.appendChild(cc);
			}
			v.appendChild(c);//주간 form body 생성
			
		}//주간 formElement
		
		function createDayFormElement(){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            let yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
            let day=date.getDate();
            
			if((typeof(date)!='undefined'||date!=null)){
				
				v = document.createElement("div");
				v.classList.add("calendarArea");
				
				c = document.createElement("div");
				c.classList.add("dayTimeWrap");
	           	
	            cc= document.createElement("div");
	            cc.classList.add("dayHeadSize"); // dayAreahead와 같은 height값으로 공간 차지
	            c.appendChild(cc);
	            
	            cc=document.createElement("div");
	            cc.classList.add(dayScheduleTime);
	            cc.innerHTML="일정"; //schedule 표시되는 time 위에 고정라인. 스크롤에서 빠져야함.
	            c.appendChild(cc);
	            
	            for(let i=0; i<25; i++){
	            	if(i==0){
	            		cc=document.createElement("div");
	            		cc.classList.add("dayTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("dayTime");
	            		ccc.innerHTML="일정";
	            		cc.appendChild(ccc); //firstChild로 속성 따로줌. 일정표시줄
	            	}else if(i==1){
	            		cc=document.createElement("div");
	            		cc.classList.add("dayTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("dayTime");
	            		ccc.innerHTML="오전"+12+"시";
	            		cc.appendChild(ccc);//오전 12시 표시
	            	}else if(i<13){
	            	}
	            		cc=document.createElement("div");
	            		cc.classList.add("dayTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("dayTime");
	            		ccc.innerHTML="오전"+(i-1)+"시";
	            		cc.appendChild(ccc);//오전 1~11시 표시
	            	}else if(i==13){
	            		cc=document.createElement("div");
	            		cc.classList.add("dayTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("dayTime");
	            		ccc.innerHTML="오후"+12+"시";
	            		cc.appendChild(ccc);//12시 표시
	            	}else{
	            		cc=document.createElement("div");
	            		cc.classList.add("dayTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("dayTime");
	            		ccc.innerHTML="오후"+(i-13)+"시";
	            		cc.appendChild(ccc);//오후1~12시 표시
	            	}
	            	c.appendChild(cc);
	            }
	            v.appendChild(c);//dayTimeBox end
	            
	            c=document.createElement("div");
	            c.classList.add("dayArea");
	            
	            cc=document.createElement("div");
	            cc.classList.add("dayAreaHead");
	            
	            ccc=document.createElement("div");
	            ccc.classList.add("dayAreaHeadYoil");
	            ccc.innerHTML= yoil+"";
	            cc.appendChild(ccc); // head 요일표시
	            
	            ccc=document.createElement("div");
	            ccc.classList.add("dayAreaHeadDate");
	            ccc.innerHTML= day+"";
	            cc.appendChild(ccc); // head 날짜표시
	            
	            c.appendChild(cc); //dayAreaHead end
	            
	            c=document.createElement("div");
	            c.classList.add("dayAreaBody");
	            
	            cc=document.createElement("div");
	            cc.classList.add("dayBodyWrap");
	            
	            ccc=document.createElement("div");
	            ccc.classList.add("dayScheduleLeftLineWrap");
	            for(let i=0; i<25; i++){
	            	cccc=document.createElement("div");
	            	cccc.classList.add("dayScheduleLeftLine");
	            	ccc.appendChild(cccc);
	            }//여기서 first child는 일정표시줄 좌측라인.줄은 time왼쪽이지만 border는 right로 줘야함.
	            cc.appendChild(ccc);
	            
	            ccc=document.createElement("div");
	            ccc.classList.add("dayScheduleWrap");
	            for(let i=0; i<25; i++){
	            	cccc=document.createElement("div");
	            	cccc.classList.add("daySchedule");
	            	ccc.appendChild(cccc);
	            }//여기서 first child는 일정표시줄. line은 ::after로 표시.
	            cc.appendChild(ccc);
	            
			}
			
         	
			
		}//일간 formElement
		
		
	</script>
</html>