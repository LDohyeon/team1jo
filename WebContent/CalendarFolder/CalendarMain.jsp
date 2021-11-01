<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- LoginUserKey: loginUserId -->
<% 
	// 유저키를 세션에서 가져옴
	String userKey = null;

	try{
		userKey = "'"+session.getAttribute("loginUserId").toString()+"'"; 
	}
	catch(Exception e){
		System.out.println("Session get Error: calendarMain.jsp: line 10: >>" +e);
	}
%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Calendar</title>
        <link rel="stylesheet" href="CalendarCss.css">
        <link rel="stylesheet" href="style.css">
	</head>
	<body>
		<jsp:include page="../header.jsp"/>
		<div id="calendar">
			
		</div>
	</body>
	<script type="text/javascript">
	
/* ====================================================================
 * ==== 기본 데이터 구성 확인 ===============================================
 * ====================================================================*/        

		// 세션 데이터를 전역 변수로 할당하여 사용함 
		let userKey = <%=userKey%>;
		let calendar = document.getElementById("calendar");
   		
		// DAY의 구성을 미리 정의함 
        let monthDayTitle = ["일", "월", "화", "수", "목", "금", "토"];
        
		// 벤치 마크 데이를 기준으로 현재 요일을 구할 수 있음
		// 요일은 어떠한 경우에서든 7의 배수로 나오기 때문에 그 사이의 날짜를 구하고 7로 나누면 됨
        // 아래 기준은 월요일이다.
		let benchmarkDay = {
       		year: 1900, 
           	month: 1, 
           	day: 1,
           	hour: 00, 
           	minites: 00
        }; 
      
        let tempData; 
        // 특정 기능에서 데이터를 전역으로 할당하여 임시로 불러오는 경우에 사용함 
        
        // Date 타입을 키: 밸류로 설정하여 STRING 형태로 변환해야하는 경우 사용함 
        function getTodayDateString(){
        	let date = new Date();
        	let year = date.getFullYear();
        	let month = (1 + date.getMonth());
        	let day = date.getDate();
        
			let str = year+"-"+month+"-"+day;
			return str;
        }
        
        // Date 타입을 키: 밸류로 설정하여 STRING 형태로 변환해야하는 경우 사용함 
        function getTodayTimeString(){
        	let date = new Date();
        	let hour = ("0" + date.getHours()).slice(-2);
			let minute = ("0" + date.getMinutes()).slice(-2);
			
			let str = hour+":"+minute;
			return str;
        }
        
        // 오늘 날짜를 반환함. Date 객체를 사용하여 구현, month는 0~11로 표현되어 1을 더하여야 한다.
       	console.log("오늘 날짜를 Date 타입으로 변경하는 펑션");
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
        
        // 특정 날짜를 표현함
        // 날짜를 직접 매개변수에 넣으면 해당 데이터 형식을 리턴해줌 
        console.log("특정 날짜를 date 형식으로 반환하는 펑션");
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
        // 요일은 7의 배수이므로 구성이나 간격이 변하지 않음
        // 결과적으로 윤년만 정확히 계산하면 날짜에 따른 요일은 반드시 구할 수 있음.
        console.log("데이트 입력시 요일 구하는 펑션");
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
        // 윤년 규칙은 4년에 한번, 100년으로 나눠지나, 100년의 나눠지나 400년으로 나눠지나에 따라 결정됨
        // 해당 규칙에 따라 알고리즘을 구성함 
       	console.log("윤년 여부를 구하는 펑션");
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
        // 윤년은 벤치 마크가 없어도 해당 년을 4,100,400으로 나눴을땨 결정됨
        // 때문에 년도만 입력하면 해당 년도의 월 단위를 알려줌 
        console.log("월의 구조를 구하는 펑션");
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
        
/* ====================================================================
 * ===== 노드 단위로 달력 구현 ==============================================
 * ====================================================================/        
/*
       요소 만들기 변수
       p = parent
       c = child
       pp = parentparent
       cc = child
       v = 기준 요소
       v 에 특별한 의미 없이 그냥 내가 좋아해서 사용함 
*/
        // 달력 만들기 실행
        createToCalendar();

        // 달력 모양 만들기
        function createToCalendar(){
            let calendar = document.getElementById("calendar");
            calendar.appendChild(createToHeaderLayout());
            calendar.appendChild(createToBodyLayout()); 
            changeForm("M"); //달력 초기 모양 Month 
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
            c.classList.add("calendarSearch");
           	
			cc = document.createElement("div");
           	cc.classList.add("calendarSearchBar");
           	cc.setAttribute("contenteditable", "true");
           	c.appendChild(cc);
           	
           	cc = document.createElement("div");
           	cc.classList.add("calendarSearchResult");
           	c.appendChild(cc);
           	
           	cc = document.createElement("div");
           	cc.classList.add("calendarSearchBtn");
           	cc.innerHTML = "검색"
           	c.appendChild(cc);
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
            /*
            ccc = document.createElement("option");
            ccc.innerHTML = "주";
            ccc.setAttribute("value", "W");
            cc.appendChild(ccc);
            */
            ccc = document.createElement("option");
            ccc.innerHTML = "일";
            ccc.setAttribute("value", "D");
            cc.appendChild(ccc);
            
            c.appendChild(cc);
            v.appendChild(c);
            return v;
        }
        
/* ====================================================================
 * ==== Hearder 내 동작 부여 =============================================
 * ====================================================================*/        
		console.log("헤더 동작을 부여");
		
        let selectForm = document.getElementsByClassName("selectForm")[0];
       
        selectForm.addEventListener("change", function(){
        	changeForm(selectForm.value);
        });
        
        // 메뉴 
        function calendarMenu(){
        	// 메뉴를 누르면 > 레프트 박스가 보이고 안보이고가 결정됨 
        }
        
        // 오늘로 이동 
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
		
        // 이전으로 이동 
        function goCalendarPrevious(){
        	select = document.getElementsByClassName("selectForm")[0].value;
        	
        	// 년도의 경우 -1을 년에 월은 월에 해줌 
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
		
        // 캘린더 다음으로 이동 (위와 같음)
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
		
        // 캘린더 검색창 활성화
        function visiableCalendarSearch(){
        	// 이미 생성된 DIV를 보이고 안보이고를 정하나 
        	// 보이는 경우 헤더에 위치한 다른 메뉴가 안보이게 해야함
        }
        
        // 캘린더 현재 월이나 년수 표현
        // 해당 데이터를 기점으로 캘린더 이동이 진행됨 
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
            
            // 네비 박스는 일종의 메뉴 역할 
            // 실제 필요할지는 미지수 
            // 사이트 레이아웃에 따라 구현 혹은 누락 
            let naviBox = document.createElement("div");
            naviBox.classList.add("naviBox");
            naviBox.appendChild(createNaviLayout());
            
            let leftBox = document.createElement("div");
            leftBox.classList.add("leftBox");
            leftBox.appendChild(createToDoLayout());
            leftBox.appendChild(createGroupLayout());
            
            let centerBox = document.createElement("div");
            centerBox.classList.add("centerBox");
           
            centerBox.appendChild(createScheduleLayout());
            centerBox.appendChild(createCalanderLayout());

            v.appendChild(naviBox);
            v.appendChild(leftBox);
            v.appendChild(centerBox);

            return v;
        }
        
        // 스케줄 레이아웃 추가하기 
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
        
        // 달력 TodoList 영역 만들기 
        function createToDoLayout(){   
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("toDoListDiv");
            
            return v;
        }
        
        // 달력 네비게이션 만들기 > 네비 게이션 클릭시 특정 항목으로 이동  
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
        
        // 네비게이션 사용한다면 캘린더로 이동
        function gotoCalendar(){
        	
        }
        
        // 네비게이션 사용할 경우 글 목록으로 이동 
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
            cc.addEventListener("click", addGroupBtn);
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
        
/* ====================================================================
 * ==== 달력 모양 생성하기 =================================================
 * ====================================================================*/        
 		console.log("달력 모양을 생성");
 		
		// ChangeForm: 매개변수에 따라 현재 달력 폼을 변경
		// 달력의 모든 처리 및 구현 모양은 해당 펑션을 따름 
		function changeForm(selectForm, date){
			console.log("달력 모양 변경 펑션");
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
					scheduleCheck(date);
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
					scheduleCheck (getToday());
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
        
		// 입력받는 날짜에 따라 년도가 그려짐 
		function YearForm(date){
			console.log("년도 모양 달력 펑션");
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
        
		// 입력받는 날짜에 따라 월이 그려짐 
		function MonthForm(date){
			console.log("월 모양 달력 펑션");
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
			
		}
		
		// 일 폼 만들기 
		function DayForm(){

		}

		// 월 폼의 Element 만들기
		function createMonthFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            // date 매개 변수에 따라 그려야할 날짜 지정
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
	            
	            // 월, 요일 등 데이터를 가져옴 
	            let months = getMonthStructure();
	            let flag = months[date.month-1];
	            let yoil = getYoil(getThisDay(date.year, date.month, 1, 0, 0));
	            let beforeYoil;
	            let NowMonth = months[date.month-2];
	            
	            // 해당 월 1일이 무슨 요일이냐에 따라 일요일부터 몇개의 이전 요소가 그려질지를 결정할 수 있음
	            // 마찬가지로 해당 월 마지막 날짜에 따라 그려져야할 데이터가 상이함
	            // 결국 해당 월의 스트럭쳐(월 구조 구하는 펑션 참조)에 따라서 그 월은 그려주되, 전후로 그려야할 데이터가 상이함 
	            
	            if(NowMonth==NaN||NowMonth==null){
	            	NowMonth = months[11];
	            }
	          	// 해당 월 1일 전에 그리는 요소 
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
	            
	           	// 해당 월을 그리는 요소
	            for(let i = 1; i < flag+1; i++){
	            	
	                cc = document.createElement("div");
	                cc.classList.add("monthBox"); 
	                
	                let thisTimeDate="";
	                08 > 8
					if(i<10){
						if(date.month<10){
							thisTimeDate = date.year+"0"+date.month+"0"+i
						}
						else{
							thisTimeDate = date.year+""+date.month+"0"+i
						}
					}202188
					else{
						if(date.month<10){
							thisTimeDate = date.year+"0"+date.month+""+i	
						}	
						else{
							thisTimeDate = date.year+""+date.month+""+i;
						}
					}				
					console.log("중요! 해당 위의 구문과 같이 모든 데이터를 처리하는 별도 태그가 해당 폼의 요소에 포함되어 정보를 식별해야함");
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
	            
	            // 31일이나 30, 28, 29일 이후에 그려야할 요소
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
				// ELSE 도 결국 같은 원리이나 날짜 데이터만 다름
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
		
		// 몬스 폼에서 해당 월 마지막날 이후 ELEMENT를 그림
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
		
		// monthform에서 해당 월 1일 이전의 ELEMENT를 그림
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
		// 년은 결국 월의 집합으로 월 폼을 참고하여 구현
		// 월폼에 따른 기본 알고리즘을 채택하여 월을 반복하여 데이터를 삽입
		// 12번 반복하되, before과 after 요소를 안보이게 하여 깔끔하게 구현
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
		// 해당 폼은 Dummy 역할을 하여 데이터를 가지고 있지도 않고 그냥 모양만 잡음
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
		
/* ====================================================================
 * ==== AJAX 사용 ======================================================
 * ====================================================================*/        
		
		
	
		// AJAX 기본 세팅
		// XHR + 각 객체 이름으로 구성함
		
		// AJAX를  let으로 선언하는 경우 > 레퍼런스 오류가 발생함; 
		// create 단계에서 해당 변수 참조를 해야하는데 변수 스코프를 벗어나기 때문에 let으로 선언해야 한다면 {} 안에서 사용할 것
		// 다만 '종현'은 같은 객체를 여러번 사용해야 해서 그냥 전역으로 놔둠
		
		console.log("AJAX를 위한 기본 설정 및 정보")
		let scheduleData = [];
		
		// 캘린더에 대한 XmlHttpRequest
		var XHRCalendar;
		function createXHRCalendar(){
			if(window.ActiveXObject){ 
				XHRCalendar=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRCalendar=new XMLHttpRequest();
			}
		}
		
		// 캘린더에 대한 XmlHttpRequest
		var XHRTodolist;
		function createXHRTodolist(){
			if(window.ActiveXObject){ 
				XHRTodolist=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRTodolist=new XMLHttpRequest();
			}
		}
		
		// Group 대한 XmlHttpRequest
		var XHRGroup;
		function createXHRGroup(){
			if(window.ActiveXObject){ 
				XHRGroup=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRGroup=new XMLHttpRequest();
			}
		}
		
		// Member 대한 XmlHttpRequest
		var XHRMember;
		function createXHRMember(){
			if(window.ActiveXObject){ 
				XHRMember=new ActiveXObject("Microsoft.XMLHTTP");
			}
			else if(window.XMLHttpRequest){
				XHRMember=new XMLHttpRequest();
			}
		}
		
/* ====================================================================
 * ==== 스케줄에 대한 전반 기능 ==============================================
 * ====================================================================*/        
						
		// 스케줄 자세한 정보 창을 표현
		// 해당 div를 띄워서 클릭한 곳 위에 표현해야함 
		// 추후 CSS 등 구현
		function scheduleDetailInfo(){
			let target = event.target;
			
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
		
		// 스케줄 자세한 정보 창 ELEMENT 만들기
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
		
		// 스케줄 정보창을 끄도록 해야함
		// remove 사용할 것이나 추후 구현
		function quitScheduleDetail(){
			console.log("quit ");
		}
		
		// 스케줄 수정 기능
		// 스케줄 수정을 위한 데이터를 수집함 
		// 펑션으로 데이터를 가져오소 설정함 
		// 전역의 템프 데이터를 가져와서 만들어진 스케줄 수정 항목에 세팅하는 용도임
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
		// 클릭했을때 현제 요소를 가져오고 안에 숨겨논 잇풋 감 가져옴
		// 가져온 값을 기초로 현재 폼에 지정된 데이터를 변경할 수 있다.
		function visibleSchedule(){

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
	
		// 스케줄 데이터에 따른 Group 데이터를 가져옴
		// 이 데이터를 기반으로 Group 폼을 생성함 
		function createGroupDivs(groupDivs){
			let v = document.getElementsByClassName("groupMain")[0];
			
			while(v.hasChildNodes()){
				v.removeChild(v.firstChild)
			}
			
	        let c;
	        let cc;
	        let ccc;

			for(let i = 0; i<groupDivs.length; i++){
				c = document.createElement("div");
				c.classList.add("groupElement");
				
				cc = document.createElement("div");
				cc.classList.add("groupDataCheckBox");
				cc.addEventListener("click", viewGroupForSchedule);
				cc.innerHTML = "보기/끄기";
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataName");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", groupDivs[i].groupname);
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupDataTool");
				cc.addEventListener("click", viewGroupTool);
				cc.innerHTML = "설정";
				c.appendChild(cc);

				cc = document.createElement("input");
				cc.classList.add("groupDataColor");
				cc.setAttribute("type", "color");
				cc.setAttribute("value", groupDivs[i].groupcolor);
				cc.innerHTML = groupDivs[i].groupcolor;
				c.appendChild(cc);
				
				cc = document.createElement("select");
				cc.classList.add("groupDataSearchable");
				ccc = document.createElement("option");
				ccc.classList.add("groupDataSearchOption");
				ccc.setAttribute("value", "disable");
				ccc.innerHTML = "비공개";
				cc.appendChild(ccc);
				ccc = document.createElement("option");
				ccc.classList.add("groupDataSearchOption");
				ccc.setAttribute("value", "able");
				ccc.innerHTML = "공개";
				cc.appendChild(ccc);
				cc.setAttribute("value", groupDivs[i].searchable);
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupDataMemberAdd");
				cc.innerHTML="멤버 추가";
				c.appendChild(cc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupDataMemberSearch");
				ccc.setAttribute("contenteditable", "true");
				ccc.addEventListener("keyup", searchGroupMember)
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupDataMemberResult");
				cc.appendChild(ccc);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type","hidden");
				cc.classList.add("groupDataMaster");
				cc.setAttribute("value", groupDivs[i].master);
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupDataMembers");
				
				let memberList = groupDivs[i].members;
				console.log(memberList);
				console.log(groupDivs[i]);
				
				for(let i = 0; i<memberList.length; i++){
					if(memberList==""){
						
					}
					else{
						let tempDiv = document.createElement("div");
						tempDiv.classList.add("groupDataMembersList");
						
						let tempChild = document.createElement("div");
						tempChild.classList.add("groupDataMemebersListName");
						tempChild.innerHTML = memberList[i];
						tempDiv.appendChild(tempChild);
						
						tempChild = document.createElement("div");
						tempChild.classList.add("groupDataMemebersListFix");
						
						let tempGrandChild = document.createElement("div");
						tempGrandChild.classList.add("groupDataMembersListFixModify");
						tempGrandChild.addEventListener("click", groupDataModifierFix);
						tempGrandChild.innerHTML = "수정자 권한 부여";
						tempChild.appendChild(tempGrandChild);
						
						tempGrandChild = document.createElement("div");
						tempGrandChild.classList.add("groupDataMembersListFixDelete");
						tempGrandChild.addEventListener("click", groupDataMemberDelete);
						tempGrandChild.innerHTML = "멤버 삭제";
						tempChild.appendChild(tempGrandChild);
						tempDiv.appendChild(tempChild);
						
						cc.appendChild(tempDiv);
					}
				}
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupDataModifier");
				
				let modifierList = groupDivs[i].modifiers;
				
				for(let i = 0; i<modifierList.length; i++){
					if(modifierList==""){
						
					}
					else{
						let tempDiv = document.createElement("div");
						tempDiv.classList.add("groupDataModifierList");
						tempDiv.innerHTML = modifierList[i];
						cc.appendChild(tempDiv);
					}
				}
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataDelBtn");
				cc.setAttribute("type", "button");
				cc.setAttribute("value", "삭제");
				cc.addEventListener("click", delGroup);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("groupDataAdd");
				cc.setAttribute("type", "button");
				cc.setAttribute("value", "완료");
				cc.addEventListener("click", addGroup)
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
				select.removeChild(select.firstChild);
			}
			
			for(let i = 0; i<groupDivs.length; i++){
				c = document.createElement("option");
				c.classList.add("scheduleFormGroupSelectOption");
				c.setAttribute("value", groupDivs[i].groupnum);
				c.innerHTML = groupDivs[i].groupname;
				select.appendChild(c);
			}
		}
		
		// 그룹에 있는 설정 항목을 누를시 활성화될 항목
		// 그룹에서 안보여줘도 될 데이터들을 은닉하거나 보여주는 용도임
		function viewGroupTool(){
			
		}
		
		// 그룹 클릭에 따라 스케줄 보이거나 감추기
		// 그룹을 클릭하면 해당 그룹 데이터를 기반으로 모든 스케줄 요소를 For문으로 돌려서 안보이거나 보이게함
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
		// 스케줄을 보일때와 안보일때를 실제로 동작하는 구분 
		// 위의 펑션과 연결되어 사용함 
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
		
		// 스케줄의 콘텐츠를 보이거나 보이지 않게 할때 사용할 펑션
		// CSS 넣으면서 구현 예정 
		function scContentVisable(){
			console.log("work")
		}
		
		/* ==== 스케줄 AJAX 사용 =========================================================================*/        
		console.log("스케줄 모양을 생성");	
		
		// 유저키와 데이터로 그룹 및 스케줄 데이터 가져옴 
		function getGroupSchedule(userKey, date){
			let scheduleTitleInSpans = document.getElementsByClassName("scheduleTitleInSpan");
			let groupDivs = [];
			
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==2){
					toDoList();
				}
				if(XHRCalendar.readyState==4){
		
		            if(XHRCalendar.status==200){
		            	clearMonthBoxBody();
		            	let jsons = JSON.parse(XHRCalendar.responseText, "text/json");
		            	
		            	for(let i = 0; i < Object.keys(jsons).length; i++){
		            		
		            		// 제이손 형태 데이터를 그룹 별로 구분하고, 이걸 다시 스케줄 별로 구분함 
		            		// 이렇게 생성된 데이터를 기준으로 스케줄 그림 
		            		for(let j = 0; j < Object.keys(jsons[i].schedule).length; j++){
		            			let temp = {
		            				groupnum: jsons[i].groupnum,
		            				groupname: jsons[i].groupname,
		            				groupcolor: jsons[i].groupcolor,
		            				members: jsons[i].members,
		            				modifiers: jsons[i].modifier,
		            				
		            				num: jsons[i].schedule[j].num,
		            				title: jsons[i].schedule[j].title,
		            				start: jsons[i].schedule[j].start,
		            				end: jsons[i].schedule[j].end,
		            				content: jsons[i].schedule[j].content,
		            				writer: jsons[i].schedule[j].writer,
		            				color: jsons[i].schedule[j].color
		            			} 
		            			scheduleData.push(temp);
		            		}
		            		
		            		// 템프 DIV를 모아서 그룹 DIV로 만들고 이 데이터로 그룹 멤버 모양을 표시함
		            		let tempDiv = {
		            			groupnum: jsons[i].groupnum,
			            		groupname: jsons[i].groupname,
			            		members: jsons[i].members,
		            			master: jsons[i].master,
		            			searchable: jsons[i].searchable,
		            			groupcolor: jsons[i].groupcolor,
		            			modifiers: jsons[i].modifiers
		            		}
		            		groupDivs.push(tempDiv);
		            	}
		            	// 스케줄 먼저 그림
		            	createScheduleElement(scheduleData);
		            	// 스케줄 그리고 각 첫 요소 파악해서 첫요소 길이를 차등 부여
		            	checkMonthScheduleFirst(); 
		            	// 배열 초기화하지 않으면 같은 스케줄이 해당 함수 실행시마다 추가됨
		            	scheduleData = []; 
		            	// 그룹 Div로 그룹 모양 구현 
		            	createGroupDivs(groupDivs);
		            	// 그룹에 부여된 데이터를 기반으로 보일지 정함
		            	viewScheduleElementFlag();
		            	// 스케줄의 영역 차지 박스를 바꿈 > 추후 모양 CSS에 따라 필요없을 수 있음
		            	changeScheduleBoxs();
		            }
				}
			}
			XHRCalendar.open("POST", "../scheduleSelect", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("userKey="+userKey);
		}
		
		// 스케줄 요소를 제작
		// 스케줄 데이터에 따라 스케줄이 그려질 영역을 구현함
		// 스케줄 시작 및 끝 데이터를 각각 비교하며 경우의 수를 따져야함
		// if 문 사용이 많을 수 밖에 없음
		function createScheduleElement(scheduleData){
			let dateTags = document.getElementsByClassName("dateTag");
			
			
			for(let i = 0; i < scheduleData.length; i++){
				// 추후 팀원 중 주 및 일 일정은 day 변수까지 사용
				let startYear = parseInt(scheduleData[i].start.substring(0,4));
				let startMonth = parseInt(scheduleData[i].start.substring(5,7));
				let startDay = parseInt(scheduleData[i].start.substring(8,10));
	
				let endYear = parseInt(scheduleData[i].end.substring(0,4));
				let endMonth = parseInt(scheduleData[i].end.substring(5,7));
				let endDay = parseInt(scheduleData[i].end.substring(8,10));

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
								// 일정 끝남: 몬스가 엔드 몬스보다 뒤면 일정이 끝났음
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
			
			// 월간폼에서 막대 길이로 스케줄 영역을 확인할 수 있음
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
		
		// 스케줄 Form에서 추가 버튼을 누를 경우 
		let scheduleFormBtn = document.getElementsByClassName("scheduleFormSubmit")[0];
		scheduleFormBtn.addEventListener("click", function (){
			addGroupSchedule();
		})

		// 스케줄 추가 
		// AJAX로 구현, 실행 후에 스케줄 재차 로딩
		function addGroupSchedule(){
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
			
			if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0);
			}
			
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	 scheduleCheck(date);
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
				
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0);
			}
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	 scheduleCheck(date);
		            }
				}
			};
			XHRCalendar.open("POST", "../scheduleDelete", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("num="+data.num);
		}
		
		// 스케줄 검색 기능
		let CalendarHeadSearchbar = document.getElementsByClassName("calendarSearchBar")[0];
		CalendarHeadSearchbar.addEventListener("keyup", function(){
			searchSchedule();
		});
		
		function searchSchedule(){
			let v = document.getElementsByClassName("calendarSearchBar")[0];
			let word = v.innerHTML;
			
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	let jsons = JSON.parse(XHRCalendar.responseText, "text/json");
		            	searchScheduleCreateBox(jsons);
		            }
				}
			};
			XHRCalendar.open("POST", "../scheduleSearch", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("userKey="+userKey+"&word="+word);
		}
		
		// 스케줄을 검색할 경우 해당 데이터를 자동 완성하여 보여줌 
		// 보여지는 요소를 선택하면 해당 데이터를 반영하여 이동 
		// 별도 페이지를 만들지 폼을 수정하도록 구현할지 추후 결정
		function searchScheduleCreateBox(jsons){
			let v = document.getElementsByClassName("calendarSearchResult")[0];
			let c;
			let cc;
			let ccc;
			
			while(v.hasChildNodes()){
				v.removeChild(v.firstChild);
			}

			for(let i = 0; i < Object.keys(jsons).length; i++){
			
				c = document.createElement("div");
				c.classList.add("scheduleSearchLists");
				c.innerHTML = "제목:"+jsons[i].title;
				c.addEventListener("click", goToSearchResult);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsNum")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].num);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsTitle")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].title);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsContent")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].content);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsStart")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].start);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsEnd")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].end);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsColor")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].color);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsGroupnum")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].groupnum);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.classList.add("scheduleSearchListsGroupname")
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].groupname);
				c.appendChild(cc);
				
				v.appendChild(c);
        	}
		}
		
		// 검색한 스케줄 데이터로 이동함 
		function goToSearchResult(){
			let target = event.target;
			let num = target.getElementsByClassName("scheduleSearchListsNum")[0].value;
			let title = target.getElementsByClassName("scheduleSearchListsTitle")[0].value;
			let content = target.getElementsByClassName("scheduleSearchListsContent")[0].value;
			let start = target.getElementsByClassName("scheduleSearchListsStart")[0].value;
			let end = target.getElementsByClassName("scheduleSearchListsEnd")[0].value;
			let color = target.getElementsByClassName("scheduleSearchListsColor")[0].value;
			let groupnum = target.getElementsByClassName("scheduleSearchListsGroupnum")[0].value;
			let groupname = target.getElementsByClassName("scheduleSearchListsGroupname")[0].value;
			
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
	
		// 스케줄 Box 영역 초기화
		// 스케줄을 모두 지워줌
		function clearMonthBoxBody(){
			let v = document.getElementsByClassName("monthBoxBody");
			
			for(let i = 0; i < v.length; i++){
				while(v[i].hasChildNodes()){
					v[i].removeChild(v[i].firstChild);
				}
			}
		}
		
		// 스케줄 BOX 면적용 요소 위로 올리기
		// 면적 차지 방식을 float 등을 혼합하여 구현시 필요없을 가능성 있음
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
		// 년 형식 스케줄을 체크하고 구현
		function scheduleCheckYear (date, userKey, group){
			if(typeof(date)!='undefined'||typeof(userKey)!='undefined'||typeof(userKey)!=null||typeof(group)!='undefined'){
				
			}
			else{
				
			}
		}
		
		function scheduleCheck (date){
			let form = document.getElemetsByClassName("selectForm")[0].value;
			
			if(form=="Y"){
				
			}
			else if(form=="M"){
				scheduleCheckMonth(date);
			}
			else if(form=="D"){
				
			}
		}
		
		
		// 월 형식 스케줄을 체크하고 구현
		function scheduleCheckMonth (date){
			
			if(typeof(date)!='undefined'){
				getGroupSchedule(userKey, date);
			}
			else{
				date = getToday();
				getGroupSchedule(userKey, date);
			}
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
		
/* ====================================================================
 * ==== TodoList 대한 전반 기능 ===========================================
 * ====================================================================*/        
		console.log("투두리스트 생성");
		
 		// 투두리스트 모양을 그려줌 
		function toDoList(){
			createXHRTodolist();

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
		
		// 투두리스트의 기본 형태 (즉 폼, 레이아웃)을 그려줌
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
		
		// 투두리스트를 JSON 데이터에 따라 그림
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

		// 투두리스트를 추가하기 위한 폼 생성
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
		
		// 투두리스트를 추가함
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
		
		// 수정을 누를 경우 수정을 위한 폼이 보이도록 해야함 
		// CSS 넢으면서 추가 
		function todolistFixBtn(){
			let target = event.target;
			let v = target.parentNode;
		}
		
		// 투두리스트를 완료함
		// 완료한 투두리스트는 안보이거나 흐리게 보이게 CSS 수정해야함
		// 한번에 삭제 필요 
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
		
		// 삭제 버튼을 누를시 삭제되어야할 데이터를 가져다가 딜리트에 전달하고,
		// AJAX에서 이를 처리함 
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
		
		// 투두리스트를 삭제함 
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
		
		// 투두리스트 한번에 삭제 
		function todolistCom(){
			let tdl = document.getElementsByClassName("toDoLists");
			let data;
			let temp=[];
			for(let i = 0; i < tdl.length; i++){
				let checked = tdl[i].getElementsByClassName("toDoListChecked")[0].value;
				// 체크된 상태를 확인하여 이를 배열로 만들고 삭제 데이터를 전달함 
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
		
/* ====================================================================
 * ==== 그룹에 대한 전반 기능 ==============================================
 * ====================================================================*/        
 		console.log("그룹 모양을 생성");
 		
		// 그룹 추가 버튼 누를시 폼을 생성함
		function addGroupBtn(){
			let v = document.getElementsByClassName("groupMain")[0];
			
			c = document.createElement("div");
			c.classList.add("groupElement");
			
			cc=document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("groupDataNum");
			c.appendChild(cc);
			
			cc=document.createElement("input");
			cc.setAttribute("type", "text");
			cc.classList.add("groupDataName");
			c.appendChild(cc);
			
			cc=document.createElement("input");
			cc.setAttribute("type", "color");
			cc.classList.add("groupDataColor");
			c.appendChild(cc);
			
			cc=document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("groupDataMaster");
			c.appendChild(cc);

			cc = document.createElement("select");
			cc.classList.add("groupDataSearchable");
			ccc = document.createElement("option");
			ccc.classList.add("groupDataSearchOption");
			ccc.setAttribute("value", "disable");
			ccc.innerHTML = "비공개";
			cc.appendChild(ccc);
			ccc = document.createElement("option");
			ccc.classList.add("groupDataSearchOption");
			ccc.setAttribute("value", "able");
			ccc.innerHTML = "공개";
			cc.appendChild(ccc);

			c.appendChild(cc);
			
			cc=document.createElement("div");
			cc.classList.add("groupDataMemberList");
			
			ccc = document.createElement("div");
			ccc.classList.add("groupDataMemberSearch");
			ccc.setAttribute("contenteditable", "true");
			ccc.addEventListener("keyup", searchGroupMember)
			cc.appendChild(ccc);
			
			ccc = document.createElement("input");
			ccc.setAttribute("type", "text");
			ccc.classList.add("groupDataMembers");
			
			cc.appendChild(ccc);
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("groupDataAdd");
			cc.setAttribute("type", "button");
			cc.setAttribute("value", "완료");
			cc.addEventListener("click", addGroup)
			c.appendChild(cc);
			
			v.insertBefore(c, v.firstChild);
		}
				// 그룹 추가 폼에서 완료버튼 누를시 데이터를 전송함 
		// AJAX로 처리
		function addGroup(date){
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode;
			
			let num = v.getElementsByClassName("groupDataNum")[0].value;
			let name = v.getElementsByClassName("groupDataName")[0].value;
    		let memberlist = v.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = v.getElementsByClassName("groupDataModifierList");
    		let color = v.getElementsByClassName("groupDataColor")[0].value;
    		let master = v.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = v.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			if(typeof(memberlist)=='undefined'){
    			members.push("");
    		}
    		else{
    			for(let i = 0; i < memberlist.length; i++){
        			members.push(memberlist[i].innerHTML);
        		}
    		}
    		
			if(typeof(modifierlist)=='undefined'){
				modifiers.push("");
    		}
    		else{
    			for(let i = 0; i < modifierlist.length; i++){
    				modifiers.push(modifierlist[i].innerHTML);
        		}
    		}
			
    		let json = JSON.stringify(createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable));
    		
    		if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0)
			}
    		
			XHRGroup.onreadystatechange=function(){
				if(XHRGroup.readyState==4){
		            if(XHRGroup.status==200){
		            	 scheduleCheck(date);
		            }
				}
			}
			XHRGroup.open("POST", "../groupInsert", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send(json);
		}
		
		// 그룹을 삭제하는 기능 
		// 매개변수는 추후 date를 따른 스케줄 폼 생성을 위해 넣음 
		function delGroup(date){
			// 검증식 넣어 마스터와 유저키가 일치할 경우: 그룹 삭제
			// 우선 서버에서 검증하게 함
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode;
			
			let num = v.getElementsByClassName("groupDataNum")[0].value;
			let name = v.getElementsByClassName("groupDataName")[0].value;
    		let memberlist = v.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = v.getElementsByClassName("groupDataModifierList");
    		let color = v.getElementsByClassName("groupDataColor")[0].value;
    		let master = v.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = v.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			if(typeof(memberlist)=='undefined'){
    			members.push("");
    		}
    		else{
    			for(let i = 0; i < memberlist.length; i++){
        			members.push(memberlist[i].innerHTML);
        		}
    		}
    		
			if(typeof(modifierlist)=='undefined'){
				modifiers.push("");
    		}
    		else{
    			for(let i = 0; i < modifierlist.length; i++){
    				modifiers.push(modifierlist[i].innerHTML);
        		}
    		}
			
    		let json = JSON.stringify(createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable));
    		
    		if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0)
			}

			XHRGroup.onreadystatechange=function(){
				
				if(XHRGroup.readyState==4){
		            if(XHRGroup.status==200){
		            	 scheduleCheck(date);
		            }
				}
			}
			XHRGroup.open("POST", "../groupDelete", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send(json);
		}

		function addGroupMember(date){
			
			
			let target = event.target;
			let v = target.parentNode;
		
			let num = v.getElementsByClassName("groupDataNum")[0].value;
			let master = v.getElementsByClassName("groupDataMaster")[0].value;
    		
    		if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0)
			}
    		
    		
    		createXHRGroup();
    		
			XHRGroup.onreadystatechange=function(){
				if(XHRGroup.readyState==4){
		            if(XHRGroup.status==200){
		            	
		            }
				}
			}
			XHRGroup.open("POST", "../", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send("userKey="+userKey+"&num="+num+"&master="+master);
		}
		
		// 그룹에 추가할 검색기능을 구현
		// 멤버 검색시에 요소가 자동완석 처럼 보이게 함 
		function searchGroupMember(){
			let v = event.target;
			let word = v.innerHTML;
			let p = v.parentNode;
			let list = p.getElementsByClassName("groupDataMemberResult")[0];
			
			if(word.length==0){
				while(list.hasChildNodes()){
					list.removeChild(list.firstChild);
				}
				return;
			}
			createXHRMember();
			XHRMember.onreadystatechange=function(){
				if(XHRMember.readyState==4){
		            if(XHRMember.status==200){
		            	let json = JSON.parse(XHRMember.responseText, "text/json");
		            	createSearchGroupMember(v, json);
		            }
				}
			}
			XHRMember.open("POST", "../groupMemberSearch", true);
			XHRMember.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRMember.send("userKey="+userKey+"&word="+word);
		}
		
		// 멤버들 LIST를 표현할 ELEMENT
		function createSearchGroupMember(v, json){
			let p = v.parentNode;
			let list = p.getElementsByClassName("groupDataMemberResult")[0];
			
			console.log(json);
			
			while(list.hasChildNodes()){
				list.removeChild(list.firstChild);
			}
			
			for(let i = 0; i < Object.keys(json).length; i++){
				let c;
				let cc;
				let ccc;
				console.log(json[i]);
				c = document.createElement("div");
				c.classList.add("memerListBox");
				
				cc = document.createElement("div");
				cc.classList.add("memerListData");
				
				ccc = document.createElement("div");
				ccc.classList.add("memerListId"); 
				ccc.innerHTML = json[i].id;
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("memerListName"); 
				ccc.innerHTML = json[i].name;
				cc.appendChild(ccc);
				
				ccc = document.createElement("input");
				ccc.classList.add("memerListNum"); 
				ccc.setAttribute("type", "hidden");
				ccc.setAttribute("value", json[i].num);
				cc.appendChild(ccc);
				
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("memerListAddBtn");
				cc.innerHTML = "추가";
				cc.addEventListener("click", addGroupMember);
				
				c.appendChild(cc);
				
				list.appendChild(c);
			}
		}
		
		// Group 멤버를 삭제하는 것
		function groupDataMemberDelete(date){
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode
			let p = v.parentNode;
			let t = p.getElementsByClassName("groupDataMemebersListName")[0].innerHTML;
			let gp = p.parentNode.parentNode;
			
			let num = gp.getElementsByClassName("groupDataNum")[0].value;
			let name = gp.getElementsByClassName("groupDataName")[0].value;
    		let memberlist = gp.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = gp.getElementsByClassName("groupDataModifierList");
    		let color = gp.getElementsByClassName("groupDataColor")[0].value;
    		let master = gp.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = gp.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			for(let i = 0; i < memberlist.length; i++){
        		members.push(memberlist[i].innerHTML);
        	}
    		
    		for(let i = 0; i < modifierlist.length; i++){
    			modifiers.push(modifierlist[i].innerHTML);
        	}
    		
    		let data = createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable);
    		data.target = t;
    		let json = JSON.stringify(data);
    		
    		if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0)
			}

			XHRGroup.onreadystatechange=function(){
				
				if(XHRGroup.readyState==4){
		            if(XHRGroup.status==200){
		            	 scheduleCheck(date);
		            }
				}
			}
			XHRGroup.open("POST", "../groupMemberDelete", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send(json);
		}
		
		// Group 구성원에게 수정자 권한을 조정함
		// 수정자가 이미 부여시 철회
		// 수정자가 안부여되면 부여함
		function groupDataModifierFix (){
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode
			let p = v.parentNode;
			let t = p.getElementsByClassName("groupDataMemebersListName")[0].innerHTML;
			let gp = p.parentNode.parentNode;
			
			let num = gp.getElementsByClassName("groupDataNum")[0].value;
			let name = gp.getElementsByClassName("groupDataName")[0].value;
    		let memberlist = gp.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = gp.getElementsByClassName("groupDataModifierList");
    		let color = gp.getElementsByClassName("groupDataColor")[0].value;
    		let master = gp.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = gp.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			for(let i = 0; i < memberlist.length; i++){
        		members.push(memberlist[i].innerHTML);
        	}
    		
    		for(let i = 0; i < modifierlist.length; i++){
    			modifiers.push(modifierlist[i].innerHTML);
        	}
    		
    		let data = createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable);
    		data.target = t;
    		
    		let json = JSON.stringify(data);
    		
    		if(typeof(date)=="undefined"){
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
        		let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				date = getThisDay(inputYear, inputMonth, inputDay, 0, 0)
			}

			XHRGroup.onreadystatechange=function(){
				
				if(XHRGroup.readyState==4){
		            if(XHRGroup.status==200){
		            	 scheduleCheck(date);
		            }
				}
			}
			XHRGroup.open("POST", "../groupModifier", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send(json);
		}
		
		// JSON 그룹 형식 데이터 생성
		function createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable){
			let json = {
				userKey: userKey,
				num: num,
				name: name,
				members: members,
				modifiers: modifiers,
				color: color,
				master: master,
				searchable: searchable
			}
			return json;
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
			
		}//주간 formElement 여기는 아직
		
		function createDayFormElement(){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            let yoil = getYoil(getThisDay(date.year, date.month+1, 1, 0, 0));
            let day=date.getDate();
            let today=getToday();
            let thisTimeDate="";
            				
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
            		cc.appendChild(ccc); //firstChild로 속성 따로줌. 일정표시줄 여기도 그 맨위에 고정하는 칸은 따로 만들어야될것같아요
            	}else if(i==1){
            		cc=document.createElement("div");
            		cc.classList.add("dayTimeBox");
            		ccc=document.createElement("span");
            		ccc.classList.add("dayTime");
            		ccc.innerHTML="오전"+12+"시";
            		cc.appendChild(ccc);//오전 12시 표시
            	}else if(i<13){
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
	            
            c.appendChild(cc);
            v.appendChild(c);
            
            return v;
			
		}//일간 formElement
	</script>
</html>