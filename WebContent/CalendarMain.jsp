<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Calendar</title>
        <link rel="stylesheet" href="CalendarCss.css">
        <link rel="stylesheet" href="style.css">
	</head>
	<body style="margin:0;">
		<jsp:include page="header.jsp"/>
		<div id="calendar">
			
		</div>
		<jsp:include page="footer.jsp"/>
	</body>
	<script>
	
/* ====================================================================
 * ==== 기본 데이터 구성 확인 ===============================================
 * ====================================================================*/        
 		userKey = <%=userKey%>
 		
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
        	let day;
        	if(date.getDate()<10){
        		day = "0"+date.getDate();
        	}
        	else{
        		day = date.getDate();
        	}
        	
        	
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
            cc.classList.add("calendarSearchBarLeft");
            
            ccc = document.createElement("div");
           	ccc.classList.add("calendarSearchBarArea")
           	cc.appendChild(ccc);
           	
			cccc = document.createElement("div");
           	cccc.classList.add("calendarSearchBar");
           	cccc.setAttribute("contenteditable", "true");
           	ccc.appendChild(cccc);
           	
           	cccc = document.createElement("div");
           	cccc.classList.add("calendarSearchResult");
           	ccc.appendChild(cccc);
           	cc.appendChild(ccc);
           	c.appendChild(cc);
           	
           	cc = document.createElement("div");
            cc.classList.add("calendarSearchBarRight");

           	ccc = document.createElement("div");
           	ccc.classList.add("calendarSearchBtn");
           	cc.appendChild(ccc);
           	
           	ccc = document.createElement("div");
           	ccc.classList.add("calendarXBtn");
           	ccc.innerHTML = "X";
           	cc.appendChild(ccc);
           	
           	c.appendChild(cc);
           	v.appendChild(c);
    		
           	c = document.createElement("div");
           	c.classList.add("calendarHeadBar");
           	
            cc = document.createElement("div");
            cc.classList.add("calendarHeadMenu");
            cc.addEventListener("click", calendarMenu);
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("value", "false");
            ccc.classList.add("calendarHeadMenuFlag");
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadNow");
            cc.addEventListener("click", goCalendarToday);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadPre");
            cc.addEventListener("click", goCalendarPrevious);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadNext");
            cc.addEventListener("click", goCalendarNext);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadDate");
            
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadSelect");
            ccc = document.createElement("select");
            ccc.classList.add("selectForm");
            cccc = document.createElement("option");
            cccc.innerHTML = "년";
            cccc.setAttribute("value", "Y");
            ccc.appendChild(cccc);
            
            cccc = document.createElement("option");
            cccc.innerHTML = "월";
            cccc.setAttribute("value", "M");
            cccc.setAttribute("selected", "true");
            ccc.appendChild(cccc);
            /*
            cccc = document.createElement("option");
            cccc.innerHTML = "주";
            cccc.setAttribute("value", "W");
            ccc.appendChild(cccc);
            */
            cccc = document.createElement("option");
            cccc.innerHTML = "일";
            cccc.setAttribute("value", "D");
            ccc.appendChild(cccc);
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("calendarHeadSearch");
            cc.addEventListener("click", visiableCalendarSearch);
            
            ccc = document.createElement("input");
            ccc.classList.add("calendarHeadSearchFlag");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("value", "false");
            
            cc.appendChild(ccc);
            c.appendChild(cc);
            v.appendChild(c);
    
            return v;
        }
        let calendarXBtn = document.getElementsByClassName("calendarXBtn")[0];
        calendarXBtn.addEventListener("click", function(){
        	let calendarSearch = document.getElementsByClassName("calendarSearch")[0];
			let calendarHeadBar = document.getElementsByClassName("calendarHeadBar")[0];
			let calendarHeadSearchFlag = document.getElementsByClassName("calendarHeadSearchFlag")[0];
			
			if(calendarHeadSearchFlag.value=="true"){
				calendarHeadSearchFlag.setAttribute("value", "false");
				calendarHeadBar.setAttribute("style", "display:block");
				calendarSearch.setAttribute("style", "display:none");
			}
        });
        function calendarMenu(){
        	// 메뉴를 누르면 > 레프트 박스가 보이고 안보이고가 결정됨 
        }
/* ====================================================================
 * ==== Hearder 내 동작 부여 =============================================
 * ====================================================================*/        
		console.log("헤더 동작을 부여");
		
		let calendarHeadMenu = document.getElementsByClassName("calendarHeadMenu")[0];
		calendarHeadMenu.addEventListener("click", calendarHeadMenuClidked);
		function calendarHeadMenuClidked(){
			let flag = document.getElementsByClassName("calendarHeadMenuFlag")[0];
			let leftBox = document.getElementsByClassName("leftBox")[0];
			let calendarBody = document.getElementsByClassName("calendarBody")[0];
			if(flag.value=="false"){
				flag.setAttribute("value", "true");
				leftBox.setAttribute("style", "display:none;");
				calendarBody.setAttribute("style", "padding-left: 10px; padding-right: 10px;");
			}
			else{
				flag.setAttribute("value", "false");
				leftBox.removeAttribute("style");
				calendarBody.removeAttribute("style");
			}
		}
		
		
        let selectForm = document.getElementsByClassName("selectForm")[0];
        selectForm.addEventListener("change", function(){
        	changeForm(selectForm.value);
        });

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
				let date = getToday();
				changeForm("D", date);
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
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
				let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear = inputYear;
				let changeMonth = inputMonth;
				let changeDay = inputDay-1;
				
				//아래는 날짜가 이전달로 이동할 경우에 적용.
				if(changeDay<1){
					changeMonth=inputMonth-1
					//changeMonth값을 먼저 구하고 이후 Day값 설정실행.
					
					if(changeMonth<1){
						changeMonth=12; // 1월 1일에서 뒤로 갔을 경우 적용. 년도 값-1, month값 12.
						changeYear=changeYear-1;
						changeDay=31;
					}
					if(changeMonth==1||changeMonth==3||changeMonth==5||changeMonth==7||changeMonth==8||changeMonth==10){
						
						changeDay=31; //31일이 마지막인 달은 31일로 Day값 적용
					}else if(changeMonth==4||changeMonth==6||changeMonth==9||changeMonth==11){
						changeDay=30; //30일이 마지막인 달은 30일로 Day값 적용
					}else{
						//2월의 경우 윤년여부 판단해야함.
						if(getYunNyen(changeYear)==true){
							changeDay=29; // 윤년의 경우 29일로 적용.
						}else{
							changeDay=28; // 윤년이 아닐경우 28일로 적용.
						}
					}
				}
				
				let date= getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				changeForm("D", date);
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
				let input = document.getElementsByClassName("calendarHeadDateInfo")[0];
				let inputYear = parseInt(input.value.substring(0,4));
				let inputMonth = parseInt(input.value.substring(4,6));
				let inputDay = parseInt(input.value.substring(6,8));
				
				let changeYear=inputYear;
				let changeMonth=inputMonth;
				let changeDay=inputDay+1;
				
				if(changeMonth==1||changeMonth==3||changeMonth==5||changeMonth==7||changeMonth==8||changeMonth==10){
					if(changeDay>31){
						//31일까지 있는 월 중 12월은 제외한 나머지월 말일에서 넘어갈 때 처리.
						changeMonth=changeMonth+1;
						changeDay=1;
					}
				}else if(changeMonth==12){
					if(changeDay>31){
						//12월 31일에서 넘어갈 때 처리
						changeYear=changeYear+1;
						changeMonth=1;
						changeDay=1;	
					}
				}else if(changeMonth==4||changeMonth==6||changeMonth==9||changeMonth==11){
					
					if(changeDay>30){
						//30일까지 있는 월의 마지막 날에서 넘어갈 때 처리.
						changeMonth=changeMonth+1;
						changeDay=1;
					}
				}else{
					//2월의 경우 윤년에따라 넘어갈 날짜 설정.
					if(getYunNyen(changeYear)==true){
						//윤년인 경우 29일에서 넘어갈 때 실행. 28일에서 넘어가면 29일
						if(changeDay>29){
							changeMonth=changeMonth+1;
							changeDay=1;
						}
					}else{
						//윤년이 아닌 경우 28일에서 넘어갈 때 실행. 29일이 아닌 3월 1일로 진행.
						if(changeDay>28){
							changeMonth=changeMonth+1;
							changeDay=1;
						}
					}
				}
				let date = getThisDay(changeYear, changeMonth, changeDay, 0, 0);
				changeForm("D", date);
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
        		
        		info.value = date.year+""+month+""+day;
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
        		
        		info.value = date.year+""+month+""+day;
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
        		info.value = date.year+""+month+""+day;
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
            centerBox.appendChild(createScheduleInfo())
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
            cc.setAttribute("value", "false");
            cc.classList.add("scheduleFlag");
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "hidden");
            cc.setAttribute("name", "scheduleNum");
            cc.classList.add("scheduleFormNum");
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleFormDiv");
            
            ccc = document.createElement("div");
            ccc.classList.add("scheduleFormX");
            ccc.addEventListener("click", visibleScheduleForm);
            ccc.innerHTML = "X";
            cc.appendChild(ccc);
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "text");
            cc.setAttribute("name", "title");
            cc.setAttribute("placeholder", "제목 추가");
            cc.classList.add("scheduleFormTitle");
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleFormAllday");
            cc.innerHTML = "종일";
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("value", "false");
            ccc.classList.add("scheduleFormAlldayInput");
            cc.appendChild(ccc);
            c.appendChild(cc);
            
        	cc = document.createElement("div");
            cc.classList.add("scheduleFormGroups");
            
            ccc = document.createElement("div");
            ccc.classList.add("scheduleFormGroupsTitle");
            ccc.innerHTML = "그룹 설정";
            cc.appendChild(ccc);
            
            ccc = document.createElement("select");
            ccc.classList.add("scheduleFormGroupSelect");
            cc.appendChild(ccc);
			
            ccc = document.createElement("input");
            ccc.setAttribute("type", "color");
            ccc.setAttribute("name", "color");
            ccc.setAttribute("value" , "#fdfd96");
            ccc.innerHTML = "#fdfd96";
            ccc.classList.add("scheduleFormColor");
            cc.appendChild(ccc);
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("name", "groupnum");
            ccc.classList.add("scheduleFormGroupnum");
            cc.appendChild(ccc);
            c.appendChild(cc);
    
            cc = document.createElement("div");
            cc.classList.add("scheduleFormDiv");
            cc.innerHTML = "시작 날짜";
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "date");
            cc.setAttribute("name", "start");
            cc.setAttribute("min", "1900-01-01");
            cc.classList.add("scheduleFormStart");
          
            c.appendChild(cc);
            
            cc = document.createElement("select");
            cc.classList.add("scheduleFormStartTime");
            cc.setAttribute("name", "starttime");
            
            for(let i = 0; i < 24; i++){
            	for(let j = 0; j < 4; j++){
            		let time = ""; 
            		if(i<10){
            			time = "0"+i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		else{
            			time = i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		ccc = document.createElement("option");
            		ccc.setAttribute("value", time);
            		ccc.innerHTML=time;
            		cc.appendChild(ccc);
            	}
            }
            c.appendChild(cc);
            
            cc = document.createElement("div");
            cc.classList.add("scheduleFormDiv");
            cc.innerHTML = "종료 날짜";
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "date");
            cc.setAttribute("name", "end");
            cc.setAttribute("min", "1900-01-01");
            cc.classList.add("scheduleFormEnd");
            
            c.appendChild(cc);
            
            cc = document.createElement("select");
            cc.classList.add("scheduleFormEndTime");
            cc.setAttribute("name", "endtime");
            for(let i = 0; i < 24; i++){
            	for(let j = 0; j < 4; j++){
            		let time = ""; 
            		if(i<10){
            			time = "0"+i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		else{
            			time = i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		ccc = document.createElement("option");
            		ccc.setAttribute("value", time);
            		ccc.innerHTML=time;
            		cc.appendChild(ccc);
            	}
            }
            c.appendChild(cc);
            
            cc = document.createElement("textarea");
            cc.setAttribute("placeholder", "상세 내용");
            cc.setAttribute("name", "content");
            cc.classList.add("scheduleFormContent");
            c.appendChild(cc);
            
            cc = document.createElement("input");
            cc.setAttribute("type", "button");
 			cc.setAttribute("value", "제출");
            cc.classList.add("scheduleFormSubmit");
            c.appendChild(cc);
            
            v.appendChild(c);
            
            return v;
        }
        
        let scheduleFormAlldayBtn = document.getElementsByClassName("scheduleFormAllday")[0];
        
        scheduleFormAlldayBtn.addEventListener("click", function(){
        	let value = scheduleFormAlldayBtn.getElementsByClassName("scheduleFormAlldayInput")[0];
        	let btn = document.getElementsByClassName("scheduleFormAllday")[0];
        	let sels = document.getElementsByClassName("scheduleFormStartTime")[0];
        	let sele = document.getElementsByClassName("scheduleFormEndTime")[0];
        	let datestart = document.getElementsByClassName("scheduleFormStart")[0];
        	let dateend = document.getElementsByClassName("scheduleFormEnd")[0];
        	
        	if(value.value=="false"){
        		value.setAttribute("value", "true");
        		sels.setAttribute("style", "visibility: hidden;");
        		sele.setAttribute("style", "visibility: hidden;");
        		sels.setAttribute("value", "00:00")
        		sels.value="00:00";
        		sele.setAttribute("value", "23:45")
        		sele.value="23:45";
        		btn.setAttribute("style", "background-color: #7dc5ea")
        	}
        	else{
        		value.setAttribute("value", "false");
        		sels.removeAttribute("style");
        		sele.removeAttribute("style");
        		btn.removeAttribute("style");
        	}
        });
        
        let scheduleFormStartTimeBtn = document.getElementsByClassName("scheduleFormStartTime")[0];
        scheduleFormStartTimeBtn.addEventListener("change", function(){
        	let scfet = event.target;
        	let scfst = document.getElementsByClassName("scheduleFormEndTime")[0];
        	let options = scfst.getElementsByTagName("option");
        	let tempdate = scfst.value;
        	console.log(tempdate);
        	let time = scfet.value;
        	let hour = time.substring(0,2);
        	let min = time.substring(3,5);
    		let tempflag = false;
    		
        	for(let i = 0; i < options.length; i++){
        		let temptime = options[i].value;
        		let temphour = temptime.substring(0,2);
            	let tempmin = temptime.substring(3,5);
            	if(temphour==hour){
            		if(tempmin>=min){
            			options[i].setAttribute("style", "display:block;");
            		}
            		else if(tempmin<min){
            			options[i].setAttribute("style", "display:none;");
            		}
            	}
            	else if(temphour<hour){
            		options[i].setAttribute("style", "display:none;");
            	}
            	else{
            		options[i].setAttribute("style", "display:block;");
            	}
            	if(tempdate<scfet.value&&tempflag==false){
            		let str = temphour+":"+tempmin
            		scfst.setAttribute("value", str);
            		scfst.value = str;
            		
            		if(str==scfet.value){
            			tempdate = true;
            		}
            	}
        	}
        });
        
        let scheduleFormEndTimeBtn = document.getElementsByClassName("scheduleFormEndTime")[0];
        scheduleFormEndTimeBtn.addEventListener("change", function(){
        	let scfet = event.target;
        	let scfst = document.getElementsByClassName("scheduleFormStartTime")[0];
        	let options = scfst.getElementsByTagName("option");
        	
        	let time = scfet.value;
        	let hour = time.substring(0,2);
        	let min = time.substring(3,5);
    
        	for(let i = 0; i < options.length; i++){
        		let temptime = options[i].value;
        		let temphour = temptime.substring(0,2);
            	let tempmin = temptime.substring(3,5);
            	if(temphour==hour){
            		if(tempmin<=min){
            			options[i].setAttribute("style", "display:block;");
            		}
            		else if(tempmin>min){
            			options[i].setAttribute("style", "display:none;");
            		}
            	}
            	else if(temphour>hour){
            		options[i].setAttribute("style", "display:none;");
            	}
            	else{
            		options[i].setAttribute("style", "display:block;");
            	}
        	}
        });
        
        
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
            c.classList.add("groupTitle");
            c.innerHTML = "내 그룹";
            v.appendChild(c);
            
            c = document.createElement("div");
            c.classList.add("groupMenu");

            cc = document.createElement("div");
            cc.classList.add("groupAdd");
            cc.addEventListener("click", addGroupBtn);
            
            ccc = document.createElement("input");
            ccc.setAttribute("type", "hidden");
            ccc.setAttribute("value", "false");
            ccc.classList.add("groupAddFlag");
            cc.appendChild(ccc);
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
					getGroupSchedule(userKey, getToday());
					whatIsDateInfo(selectForm, date);
				}
				else if(selectForm=="M"){
					MonthForm(date);
					getGroupSchedule(userKey, date);
					whatIsDateInfo(selectForm, date);
				}
				else if(selectForm=="D"){
					DayForm(date);
					getGroupSchedule(userKey, date);
					whatIsDateInfo(selectForm, date);
				}
			}
			else{
				if(selectForm=="Y"){
					YearForm();
					getGroupSchedule(userKey, getToday());
					whatIsDateInfo(selectForm, getToday());
				}
				else if(selectForm=="M"){
					MonthForm();
					getGroupSchedule(userKey, getToday());
					whatIsDateInfo(selectForm, getToday());
				}
				else if(selectForm=="D"){
					DayForm();
					getGroupSchedule(userKey, date);
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
		function DayForm(date){
			if(typeof(date)!='undefined'&&date!=null){
				let div = document.getElementsByClassName("calendarDiv")[0];
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);
				}
				div.appendChild(createDayFormElement(date));
			}else{
				let div = document.getElementsByClassName("calendarDiv")[0];
				while(div.hasChildNodes()){
					div.removeChild(div.firstChild);					
				}
				div.appendChild(createDayFormElement());
			}
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
	                cc.classList.add("yearBoxYoil");
	                cc.addEventListener("click", yearBoxGoto)
	                
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
	            
	            function yearBoxGoto(){
	            	let target = event.target;
	            	let dateTag = target.parentNode.parentNode.getElementsByClassName("dateTag")[0];
	            	
	            	let year = parseInt(dateTag.value.substring(0,4));
					let month = parseInt(dateTag.value.substring(4,6));
					let day = parseInt(dateTag.value.substring(6,8));
					
					let date = getThisDay(year, month, day, 0, 0);
					changeForm("D", date);
					
					let selectForm = document.getElementsByClassName("selectForm")[0];
					let options = selectForm.getElementsByTagName("option");
					for(let i = 0; i<options.length; i++){
						if(options[i].value=="D"){
							options[i].setAttribute("selected", "true");
						}
					}
	            }
	            
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
            cc.classList.add("yearBoxYoil");
            
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
			
			viewScheduleDetail(data);
			visibleScheduleForm();
			quitScheduleDetail();
		}
	
		function createScheduleInfo(data){
			let v;
			let c;
			let cc;
			let ccc;
			
			v = document.createElement("div"); 
			v.classList.add("schedulInfoArea");
			
			c = document.createElement("input");
			c.classList.add("scAreaFlag");
			c.setAttribute("type", "hidden");
			c.setAttribute("value", "false");
			v.appendChild(c);
			
			c = document.createElement("div"); 
			c.classList.add("schedulInfoHead");
			
			cc = document.createElement("div");
			cc.classList.add("schedulInfoHeadTitle");
			cc.innerHTML = "스케줄 세부 정보";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("schedulInfoQuit");
			cc.addEventListener("click", quitScheduleDetail);
			cc.innerHTML="X";
			c.appendChild(cc);
			v.appendChild(c);
		
			cc = document.createElement("div");
			cc.classList.add("schedulInfoFix");
			cc.addEventListener("click", scheduleDetailInfoFix);
			c.appendChild(cc);

			cc = document.createElement("div");
			cc.classList.add("schedulInfoDelete");
			cc.addEventListener("click", delGroupSchedule);
			c.appendChild(cc);
			
			c = document.createElement("div"); 
			c.classList.add("schedulInfoBody");
			
			cc = document.createElement("div"); 
			cc.classList.add("schedulInfoGroup");
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "color");
			cc.classList.add("schedulInfoColor");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("schedulInfoTitle");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("blockBoxAllDay");
			cc.innerHTML = "종일";
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("blockBox");
			cc.innerHTML = "그룹 이름";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("schedulInfoGroupName");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("blockBoxDummy");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("blockBox");
			cc.innerHTML = "시작 날짜";
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("schedulInfoStartDay");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("schedulInfoStartTime");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("blockBox");
			cc.innerHTML = "종료 날짜";
			c.appendChild(cc);
		    
			cc = document.createElement("div"); 
			cc.classList.add("schedulInfoEndDay");
			c.appendChild(cc);
			
			cc = document.createElement("div"); 
			cc.classList.add("schedulInfoEndTime");
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("schedulInfoContentText");
			c.appendChild(cc);
			v.appendChild(c);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("schedulInfoScheduleNum");
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("schedulInfoGroupNum");
			c.appendChild(cc);

			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("schedulInfoGroupModifier");
			c.appendChild(cc);
			v.appendChild(c);
			
			return v;
		}
		
		// 스케줄 자세한 정보 창 ELEMENT 만들기
		function viewScheduleDetail(data){
			console.log(data);
			let target = event.target;
			let p = document.getElementsByClassName("schedulInfoArea")[0];
			
			let fixBtn = document.getElementsByClassName("schedulInfoFix")[0];
			let delBtn = document.getElementsByClassName("schedulInfoDelete")[0];
			let offBtn = document.getElementsByClassName("schedulInfoQuit")[0];
			
			let groupname = document.getElementsByClassName("schedulInfoGroupName")[0];
			let groupnum = document.getElementsByClassName("schedulInfoArea")[0];
			let groupmodifier = document.getElementsByClassName("schedulInfoArea")[0];// 검증필요
			
			let allDay = document.getElementsByClassName("blockBoxAllDay")[0];
			let schedulenum = document.getElementsByClassName("schedulInfoScheduleNum")[0];
			let color = document.getElementsByClassName("schedulInfoColor")[0];
			let title = document.getElementsByClassName("schedulInfoTitle")[0];
			let content = document.getElementsByClassName("schedulInfoContentText")[0];
			let scStartDay = document.getElementsByClassName("schedulInfoStartDay")[0];
			let scStartTime = document.getElementsByClassName("schedulInfoStartTime")[0];
			let scEndDay = document.getElementsByClassName("schedulInfoEndDay")[0];
			let scEndTime = document.getElementsByClassName("schedulInfoEndTime")[0];
			
			groupname.innerHTML = data.groupname;
			groupnum.setAttribute("value", data.groupnum);
			
			schedulenum.setAttribute("value", data.num);
			color.setAttribute("value", data.color);
			color.innerHTML = data.color;
			title.innerHTML = data.title;
			content.innerHTML = data.content;
			
			let startDay = data.start.substring(0,10);
			let startTime = data.start.substring(11,20);
			let endDay = data.end.substring(0,10);
			let endTime = data.end.substring(11,20);
			
			scStartDay.innerHTML = startDay;
			scStartTime.innerHTML = startTime;
			scEndDay.innerHTML = endDay;
			scEndTime.innerHTML = endTime;
			
			let modifier = "notModifier"; 
			let groups = document.getElementsByClassName("groupDataInfos");
			
			for(let i = 0; i < groups.length; i++){
				let gn = groups[i].getElementsByClassName("groupDataNum")[0];
				if(gn.value==data.groupnum){
					let md = groups[i].getElementsByClassName("groupDataModifierListName");
					
					for(let j = 0; j <md.length; j++){
						let str = (md[j].innerHTML+"").replace(")", ' ');
						let modifiId = str.split("(");
						let strId = modifiId[1].trim();
						userKey.trim();
						/*
						console.log(":"+modifiId+":")
						console.log(":"+strId+":")
						console.log(":"+userKey+":")
						공백 있는지 보려고 찍은 콘솔
						*/
						if(strId==userKey){
							modifier = strId;
						}
					}
				}
			}
			
			if(startTime=="00:00"&&endTime=="23:45"){
				scEndTime.setAttribute("style", "visibility: hidden;");
				scStartTime.setAttribute("style", "visibility: hidden;");
				allDay.setAttribute("style", "visibility: visible;");		
			}
			else{
				scEndTime.removeAttribute("style");
				scStartTime.removeAttribute("style");
				allDay.removeAttribute("style");
			}
			
			if(modifier==userKey){
				fixBtn.removeAttribute("style");
				fixBtn.addEventListener("click", scheduleDetailInfoFix);
				delBtn.removeAttribute("style");
				delBtn.addEventListener("click", delGroupSchedule);
			}
			else{
				fixBtn.setAttribute("style", "visibility: hidden;");
				fixBtn.removeEventListener("click", scheduleDetailInfoFix);
				delBtn.setAttribute("style", "visibility: hidden;");
				delBtn.removeEventListener("click", delGroupSchedule);
			}
		}
		
		function quitScheduleDetail(){
			let area = document.getElementsByClassName("schedulInfoArea")[0];
			let flag = document.getElementsByClassName("scAreaFlag")[0];
			
			if(flag.value=='false'){
				area.setAttribute("style", "display:block;");
				flag.setAttribute("value", "true");
			}
			else{
				area.removeAttribute("style");
				flag.setAttribute("value", "false");
			}
			
			if(flag=="true"){
				visibleScheduleForm();
			}
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
			let formstarttime = form.getElementsByClassName("scheduleFormStartTime")[0];
			let formend = form.getElementsByClassName("scheduleFormEnd")[0];
			let formendtime = form.getElementsByClassName("scheduleFormEndTime")[0];
			let formcolor = form.getElementsByClassName("scheduleFormColor")[0];
			let formgroupSelect = form.getElementsByClassName("scheduleFormGroupSelect")[0];
			let options = formgroupSelect.getElementsByClassName("scheduleFormGroupSelectOption");
			
			formnum.setAttribute("value", data.num);
			formtitle.setAttribute("value", data.title);
			formcontent.setAttribute("value", data.content);
			formstart.setAttribute("value", startDay);
			formstart.value=startDay;
			formstarttime.setAttribute("value", startTime);
			formstarttime.value=startTime;
			formend.setAttribute("value", endDay);
			formendtime.setAttribute("value", endTime);
			formendtime.value=endTime;
			formend.value=endDay;
			formcolor.setAttribute("value", data.color);
			
			for(let i = 0; i<options.length; i++){
				if(options[i].value==data.groupnum){
					options[i].setAttribute("selected", "true");
				}
			}
			quitScheduleDetail();

			let flag = document.getElementsByClassName("scheduleFlag")[0].value;
			console.log(flag);
			if(flag=="false"){
				visibleScheduleForm();
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
			
			visibleScheduleForm();
		}
		
		function visibleScheduleForm(){
			let form = document.getElementsByClassName("scheduleForm")[0];
			let flag = form.getElementsByClassName("scheduleFlag")[0];
			
			if(flag.value=="false"){
				flag.setAttribute("value", "true");
				form.setAttribute("style", "display:block;");

			}
			else{
				flag.setAttribute("value", "false");
				form.removeAttribute("style");
			}
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
				cc.classList.add("groupDataTitle");
				
				ccc = document.createElement("div");
				ccc.classList.add("groupDataCheckBox");
				ccc.addEventListener("click", viewGroupForSchedule);
				ccc.innerHTML = "보기";
				cc.appendChild(ccc);
				
				ccc = document.createElement("input");
				ccc.classList.add("groupDataName");
				ccc.setAttribute("type", "text");
				ccc.setAttribute("placeholder", "그룹의 이름을 입력하세요.")
				ccc.setAttribute("value", groupDivs[i].groupname);
				ccc.setAttribute("readonly", "true");
				cc.appendChild(ccc);
				
				if(groupDivs[i].master==userKey){
					ccc = document.createElement("div");
					ccc.classList.add("groupDataTool");
					ccc.addEventListener("click", viewGroupTool);
					cc.appendChild(ccc);
				}
				else{
					ccc = document.createElement("div");
					ccc.classList.add("groupDataTool");
					ccc.addEventListener("click", viewGroupTool);
					cc.appendChild(ccc);
				}
				
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("groupDataInfos");
				cc.setAttribute("style", "display:none");
				
				if(groupDivs[i].master==userKey){
					ccc = document.createElement("input");
					ccc.classList.add("groupDataColor");
					ccc.setAttribute("type", "color");
					ccc.setAttribute("value", groupDivs[i].groupcolor);
					ccc.innerHTML = groupDivs[i].groupcolor;
					cc.appendChild(ccc);
					
					ccc = document.createElement("select");
					ccc.classList.add("groupDataSearchable");
					cccc = document.createElement("option");
					cccc.classList.add("groupDataSearchOption");
					cccc.setAttribute("value", "disable");
					cccc.innerHTML = "비공개";
					ccc.appendChild(cccc);
					cccc = document.createElement("option");
					cccc.classList.add("groupDataSearchOption");
					cccc.setAttribute("value", "able");
					cccc.innerHTML = "공개";
					ccc.appendChild(cccc);
					ccc.setAttribute("value", groupDivs[i].searchable);
					cc.appendChild(ccc);
					
					ccc = document.createElement("div");
					ccc.classList.add("groupDataMemberAdd");
					
					cccc = document.createElement("span");
					cccc.classList.add("titleBlock");
					cccc.innerHTML = " 멤버 검색";
					ccc.appendChild(cccc);
					cc.appendChild(ccc);
					
					cccc = document.createElement("div");
					cccc.classList.add("groupDataMemberSearch");
					cccc.setAttribute("contenteditable", "true");
					cccc.setAttribute("placeholder", "멤버를 검색하여 추가");
					cccc.addEventListener("keyup", searchGroupMember)
					ccc.appendChild(cccc);
					
					cccc = document.createElement("div");
					cccc.classList.add("groupDataMemberResult");
					ccc.appendChild(cccc);
					cc.appendChild(ccc);
					
				}
				
				
				ccc = document.createElement("input");
				ccc.setAttribute("type","hidden");
				ccc.classList.add("groupDataMaster");
				ccc.setAttribute("value", groupDivs[i].master);
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("titleBlock");
				ccc.innerHTML = "그룹에 속한 멤버"
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupDataMembers");
				
				let memberList = groupDivs[i].members;
				
				for(let j = 0; j<memberList.length; j++){
					if(memberList==""){
						
					}
					else{
						let tempstr = memberList[j].replace(")", "");
						let tempstrArr = tempstr.split("(");

						if(tempstrArr[1]==userKey){
							let tempDiv = document.createElement("ul");
							tempDiv.classList.add("groupDataMembersList");
							if(i!=0){
								tempDiv.classList.add("topBoderCenter");
							}
							
							let tempChild = document.createElement("li");
							tempChild.classList.add("groupDataMemebersListName");
							tempChild.innerHTML = memberList[j];
							
							tempDiv.appendChild(tempChild);
							
							tempChild = document.createElement("input");
							tempChild.setAttribute("type", "hidden");
							tempChild.setAttribute("value", tempstrArr[0]);
							tempChild.classList.add("groupDataMemebersListInputName");
							tempDiv.appendChild(tempChild);
							
							tempChild = document.createElement("input");
							tempChild.setAttribute("type", "hidden");
							tempChild.setAttribute("value", tempstrArr[1]);
							tempChild.classList.add("groupDataMemebersListInputId");
							tempDiv.appendChild(tempChild);
	
							ccc.appendChild(tempDiv);
						}
						else{
							let tempDiv = document.createElement("ul");
							tempDiv.classList.add("groupDataMembersList");
							if(i!=0){
								tempDiv.classList.add("topBoderCenter");
							}
							
							let tempChild = document.createElement("li");
							tempChild.classList.add("groupDataMemebersListName");
							tempChild.innerHTML = memberList[j];
							tempDiv.appendChild(tempChild);
							
							tempChild = document.createElement("div");
							tempChild.classList.add("groupDataMemebersListNameDummy");
							tempDiv.appendChild(tempChild);
							
							tempChild = document.createElement("input");
							tempChild.setAttribute("type", "hidden");
							tempChild.setAttribute("value", tempstrArr[0]);
							tempChild.classList.add("groupDataMemebersListInputName");
							tempDiv.appendChild(tempChild);
							
							tempChild = document.createElement("input");
							tempChild.setAttribute("type", "hidden");
							tempChild.setAttribute("value", tempstrArr[1]);
							tempChild.classList.add("groupDataMemebersListInputId");
							tempDiv.appendChild(tempChild);
							
							if(groupDivs[i].master==userKey){
									
								tempChild = document.createElement("div");
								tempChild.classList.add("groupDataMemebersListFix");
								
								let tempGrandChild = document.createElement("div");
								tempGrandChild.classList.add("groupDataMembersListFixModify");
								tempGrandChild.addEventListener("click", groupDataModifierFix);
								tempGrandChild.innerHTML = "수정자 권한";
								tempChild.appendChild(tempGrandChild);
								
								tempGrandChild = document.createElement("div");
								tempGrandChild.classList.add("groupDataMembersListFixDelete");
								tempGrandChild.addEventListener("click", groupDataMemberDelete);
								tempGrandChild.innerHTML = "멤버 삭제";
								tempChild.appendChild(tempGrandChild);
								tempDiv.appendChild(tempChild);
							}

							ccc.appendChild(tempDiv);
						}
					}
				}
				
				cc.appendChild(ccc);
				
				ccc = document.createElement("div");
				ccc.classList.add("groupDataModifier");
				
				let modifierList = groupDivs[i].modifiers;
				
				let tempDiv = document.createElement("div");
				tempDiv.classList.add("groupDataModifierList");

				let tempChild = document.createElement("div");
				tempChild.classList.add("titleBlock");
				tempChild.innerHTML = " 스케줄 수정 가능 멤버";
				tempDiv.appendChild(tempChild);
				
				tempChild = document.createElement("div");
				tempChild.classList.add("groupNodifierBlock");
				
				
				for(let i = 0; i<modifierList.length; i++){
					if(modifierList==""){
						
					}
					else{
						let tempgChild = document.createElement("div");
						tempgChild.classList.add("groupDataModifierListName");
						if(i!=0){
							tempgChild.classList.add("topBoderCenter");
						}
						
						tempgChild.innerHTML = modifierList[i];
						tempChild.appendChild(tempgChild);
						tempDiv.appendChild(tempChild);
						ccc.appendChild(tempDiv);
					}
				}
				cc.appendChild(ccc);
				
				ccc = document.createElement("input");
				ccc.classList.add("groupDataDelBtn");
				ccc.setAttribute("type", "button");
				ccc.setAttribute("value", "그룹 삭제");
				ccc.addEventListener("click", delGroup);
				cc.appendChild(ccc);
				
				if(groupDivs[i].master==userKey){
					ccc = document.createElement("input");
					ccc.classList.add("groupDataAdd");
					ccc.setAttribute("type", "button");
					ccc.setAttribute("value", "정보 수정");
					ccc.addEventListener("click", addGroup)
					cc.appendChild(ccc);
				}
				ccc = document.createElement("input");
				ccc.classList.add("groupDataNum");
				ccc.setAttribute("type", "hidden");
				ccc.setAttribute("value", groupDivs[i].groupnum);
				cc.appendChild(ccc);
				
				// 그룹 요소를 클릭할 경우, 해당 요소가 보일지 말지를 결정
				// 얘는 스케줄보는거, 아래는 해당 설정 창 보는거 
				ccc = document.createElement("input");
				ccc.classList.add("groupDataFlag");
				ccc.setAttribute("type", "hidden");
				ccc.setAttribute("value", "true");
				cc.appendChild(ccc);
				
				ccc = document.createElement("input");
				ccc.classList.add("groupDataInfosFlag");
				ccc.setAttribute("type", "hidden");
				ccc.setAttribute("value", "false");
				cc.appendChild(ccc);
				
				c.appendChild(cc);
				
				v.appendChild(c);
			}
			
			let select = document.getElementsByClassName("scheduleFormGroupSelect")[0];
			
			while(select.hasChildNodes()){
				select.removeChild(select.firstChild);
			}
			
			for(let i = 0; i<groupDivs.length; i++){
				for(let j = 0; j<groupDivs[i].modifiers.length; j++){
					let str = groupDivs[i].modifiers[j].replace(")", "");
					let str2 = str.split("(");
					let str3 = str2[1];
					
					if(str3==userKey){
						c = document.createElement("option");
						c.classList.add("scheduleFormGroupSelectOption");
						c.setAttribute("value", groupDivs[i].groupnum);
						c.innerHTML = groupDivs[i].groupname;
						select.appendChild(c);
					}
				}
			}
		}
		
		// 그룹에 있는 설정 항목을 누를시 활성화될 항목
		// 그룹에서 안보여줘도 될 데이터들을 은닉하거나 보여주는 용도임
		function viewGroupTool(){
			let target = event.target;
			let p = target.parentNode.parentNode;
			let v = p.getElementsByClassName("groupDataInfos")[0];
			let flag = v.parentNode.getElementsByClassName("groupDataInfosFlag")[0];
			let groupDataName = p.getElementsByClassName("groupDataName")[0];
			
			
			if(flag.value=="false"){
				flag.setAttribute("value", "true");
				groupDataName.removeAttribute("readonly");
				v.setAttribute("style", "display:block;")
			}
			else{
				flag.setAttribute("value", "false");
				groupDataName.setAttribute("readonly", "true");
				v.setAttribute("style", "display:none;")
			}
		}
		
		// 그룹 클릭에 따라 스케줄 보이거나 감추기
		// 그룹을 클릭하면 해당 그룹 데이터를 기반으로 모든 스케줄 요소를 For문으로 돌려서 안보이거나 보이게함
		function viewGroupForSchedule(){
			let clicked = event.target;
			let groupDiv = clicked.parentNode;
			let num = groupDiv.parentNode.getElementsByClassName("groupDataNum")[0].value;
			let flag = groupDiv.parentNode.getElementsByClassName("groupDataFlag")[0];
			
			if(flag.value=="true"){
				flag.setAttribute("value", "false"); // 안보이는 상태
				clicked.setAttribute("style", "background-color: #ff3409;");
				clicked.innerHTML="끄기";
			}
			else if(flag.value=="false"){
				flag.setAttribute("value", "true"); // 보이는 상태 
				clicked.removeAttribute("style");
				clicked.innerHTML="보기";
			}
			
			viewScheduleElementFlag();
		}
		
		// 스케줄 보이거나 감추기 작동
		// 스케줄을 보일때와 안보일때를 실제로 동작하는 구분 
		// 위의 펑션과 연결되어 사용함 
		function viewScheduleElementFlag(){
			let selectForm = document.getElementsByClassName("selectForm")[0];
			let groupDiv = document.getElementsByClassName("groupElement");
			
			if(selectForm.value=="Y"){
				let yearformEls = document.getElementsByClassName("yearformEl");
				
				for(let i = 0; i < groupDiv.length; i++){
					
					let flag = groupDiv[i].getElementsByClassName("groupDataFlag")[0].value+"";
					let num = groupDiv[i].getElementsByClassName("groupDataNum")[0].value+"";;
				
					for(let l = 0; l <yearformEls.length; l++){
						let scHidden = yearformEls[l].getElementsByClassName("scHidden");
						
						for(let j = 0; j <scHidden.length; j++){
							let scHiddenNum = scHidden[j].getElementsByClassName("groupNum")[0].value+"";
							
							if(num==scHiddenNum){
								if(flag=="true"){
									scHidden[j].parentNode.classList.remove("hiddenElement");
								}
								else if(flag=="false"){
									scHidden[j].parentNode.classList.add("hiddenElement");
								}
							}
						}
					}
				}
			}
			else if(selectForm.value=="M"){
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
			else if(selectForm.value=="D"){
				
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
			let selectForm = document.getElementsByClassName("selectForm")[0];
			let jsons;
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==2){
					toDoList();
				}
				if(XHRCalendar.readyState==4){
		
		            if(XHRCalendar.status==200){
		            	clearMonthBoxBody();
		            	jsons = JSON.parse(XHRCalendar.responseText, "text/json");
		            	
		            	for(let i = 0; i < Object.keys(jsons).length; i++){
		            		
		            		// 제이손 형태 데이터를 그룹 별로 구분하고, 이걸 다시 스케줄 별로 구분함 
		            		// 이렇게 생성된 데이터를 기준으로 스케줄 그림 
		            		for(let j = 0; j < Object.keys(jsons[i].schedule).length; j++){
		            			let temp = {
		            				groupnum: jsons[i].groupnum,
		            				groupname: jsons[i].groupname,
		            				groupcolor: jsons[i].groupcolor,
		            				members: jsons[i].members,
		            				modifiers: jsons[i].modifiers,
		            				
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
		            	// 그룹 Div로 그룹 모양 구현 
		            	createGroupDivs(groupDivs);
		            	
		            	if(selectForm.value=="Y"){
		            		createYearSchedule(scheduleData);
		            	}
		            	else if(selectForm.value=="M"){
		            		// 스케줄 먼저 그림
			            	createScheduleElement(scheduleData);
			            	// 스케줄 그리고 각 첫 요소 파악해서 첫요소 길이를 차등 부여
			            	checkMonthScheduleFirst(); 
			            	// 배열 초기화하지 않으면 같은 스케줄이 해당 함수 실행시마다 추가됨
			            	viewScheduleElementFlag();
			            	// 스케줄의 영역 차지 박스를 바꿈 > 추후 모양 CSS에 따라 필요없을 수 있음
			            	checkFirstElement();
		            	}
		            	else if(selectForm.value=="D"){
		            		//	DAY스케줄 그리기
		            		createDayScheduleElement(scheduleData);
		            		//	갯수에 따라 위치 조정.
		            		scheduleBoxMarginLeft();
		            		//	alldaySchedule 갯수에 따라 div 크기 조정.
		            		alldayScheduleHeight();
		            	}

		            	// 배열 초기화하지 않으면 같은 스케줄이 해당 함수 실행시마다 추가됨
		            	scheduleData = []; 
		            	checkInvite();
		            }
				}
			}
			XHRCalendar.open("POST", "scheduleSelect", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("userKey="+userKey);
		}
		
		function createYearSchedule(scheduleData){
	
			let yearBoxBodys = document.getElementsByClassName("yearBoxBody");
			
			for(let i = 0; i < scheduleData.length; i++){
				
				let startYear = scheduleData[i].start.substring(0, 4);
				let startMonth = scheduleData[i].start.substring(5, 7);
				let startDay = scheduleData[i].start.substring(8, 10);
				
				let endYear = scheduleData[i].end.substring(0, 4);
				let endMonth = scheduleData[i].end.substring(5, 7);
				let endDay = scheduleData[i].end.substring(8, 10);
				
				for(let j = 0; j < yearBoxBodys.length; j++){
					let yfd = yearBoxBodys[j].getElementsByClassName("dateTag")[0].value;
					let yfdYear =  yfd.substring(0, 4);
					let yfdMonth =  yfd.substring(4, 6);
					let yfdDay =  yfd.substring(6, 8);
					
					
					if(startYear>yfdYear){
						// 일정 시작 안함
						// 건너감 
					}
					else if(startYear==yfdYear){
						// 일정 시작을 했음 
						if(endYear>yfdYear){
							// 월 하고 날 찾고 그뒤로 다들어감 
							if(startMonth>yfdMonth){
								// 작동 안함 
							}
							else if(startMonth==yfdMonth){
								// 년간폼이면 그냥 넣음 일을 비교해서
								if(startDay>yfdDay){
									// 안그림 
								}
								else if(startDay<=yfdDay){
									// 일정 시작 > 년도 끝까지 // 시간을 비교후 
								}
								else if(startDay<yfdDay){
									// 일정 시작 > 년도 끝까지 // 종일 
								}
							}
							else if(startMonth<yfdMonth){
								// 시작 함 
								// 다 그림 // 종일 
							}
						}
						else if(endYear==yfdYear){
							// 월하고 날을 비교 해서 구간을 정해야함 
							if(startMonth>yfdMonth){
								// 안함 // 시작 안함 
							}
							else if(startMonth==yfdMonth){
								// 년간폼이면 그냥 넣음 일을 비교해서
								if(endMonth>yfdMonth){
									// 전체 그림 > 일간은 종일 
									if(startDay>yfdDay){
										// 시작 안함 
									}
									else if(startDay==yfdDay){
										// 시작 함 > 월 끝 // 시작 날짜 시간 비교 
										createYearElement(yearBoxBodys[j], scheduleData[i]);
									}
									else if(startDay<yfdDay){
										// 시작함 > 월 끝 // 종일 
										createYearElement(yearBoxBodys[j], scheduleData[i]);
									}
								}
								else if(endMonth==yfdMonth){
									// 시작날짜, 끝 날짜를 비교해서 구간을 설정 
									if(startDay>yfdDay){
										// 시작 안함 
									}
									else if(startDay==yfdDay){
										// 시작 함 > 끝 날짜 탐색 // 시간봐야함 
										if(endDay>yfdDay){
											// 그림  //
											createYearElement(yearBoxBodys[j], scheduleData[i]);
										}
										else if(endDay==yfdDay){
											// 그림
											createYearElement(yearBoxBodys[j], scheduleData[i]);
											
										}
										else if(endDay<yfdDay){
											// 안그림 > 끝난 일정 
										}
									}
									else if(startDay<yfdDay){
										// 시작함 > 끝나는 날짜까지 가는중 
										if(endDay>yfdDay){
											// 그림 
											createYearElement(yearBoxBodys[j], scheduleData[i]);
										}
										else if(endDay==yfdDay){
											// 그림
											createYearElement(yearBoxBodys[j], scheduleData[i]);
										}
										else if(endDay<yfdDay){
											// 안그림 > 끝난 일정 
										}
									}
								}
								else if(endMonth<yfdMonth){
									// 일정이 끝남 
								}
							}
							else if(startMonth<yfdMonth){
								// 일을 비교하고 구간 
								if(endMonth>yfdMonth){
									// 전체 그림 	
									createYearElement(yearBoxBodys[j], scheduleData[i]);
								}
								else if(endMonth==yfdMonth){
									// 날짜비교> 언제 끝나는지 찾음 
									if(endDay>yfdDay){
										// 그림 
										createYearElement(yearBoxBodys[j], scheduleData[i]);
									}
									else if(endDay==yfdDay){
										// 그림
										createYearElement(yearBoxBodys[j], scheduleData[i]);
									}
									else if(endDay<yfdDay){
										// 안그림 > 끝난 일정 
									}
								}
								else if(endMonth<yfdMonth){
									// 일정이 끝남 
								}
							}
						}
						else if(endYear<yfdYear){
							// 불가능한 경우 
						}
					}
					else if(startYear<yfdYear){
						// 일정 시작을 했음 
						if(endYear>yfdYear){
							// 전체 들어감 (년도에 한해서)
							createYearElement(yearBoxBodys[j], scheduleData[i]);
						}
						else if(endYear==yfdYear){
							// 뭘 하고 날짜 비교해서 끝나는 구간 설정 
							if(endMonth>yfdMonth){
								// 전체 
								createYearElement(yearBoxBodys[j], scheduleData[i]);
							}
							else if(endMonth==yfdMonth){
									// 날짜 비교 
								if(endDay>yfdDay){
									// 그려야 함 
									createYearElement(yearBoxBodys[j], scheduleData[i]);
								}
								else if(endDay==yfdDay){
									// 그려야 함/ 끝나는 시점
									createYearElement(yearBoxBodys[j], scheduleData[i]);
								}
								else if(endDay<yfdDay){
									// 안그림 
								}
							}
							else if(endMonth<yfdMonth){
									// 일정이 끝남 
							}
						}
						else if(endYear<yfdYear){
							// 이미 끝난 일정 // 동작 안함 
						}
					}
				}
			}
		}
		
		function createYearElement(yearBoxBodys, scheduleData){
			
			let numberChilds = yearBoxBodys.parentNode.childNodes.length;
			
			let p = yearBoxBodys.parentNode;
			let v;
			let c;
			let cc;
			let ccc;
			
			v = document.createElement("div");
			v.classList.add("yearformEl");
			
			c = document.createElement("div");
			c.classList.add("yearFormSC");
			c.innerHTML = ".";
			v.appendChild(c);
			
			c = document.createElement("div");
			c.classList.add("scHidden");
			c.setAttribute("style", "display: none;")
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupNum"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.groupnum);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupName"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.groupname);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("groupColor"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.groupcolor);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("modifier"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.modifier);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleNum"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.num);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleTitle"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.title);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleStart"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.start);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleEnd"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.end);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleContent"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.content);
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleWriter"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.writer);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleColor"); 
			cc.setAttribute("type", "hidden");
			cc.setAttribute("value", scheduleData.color);
			
			c.appendChild(cc);
			
			v.appendChild(c);
			p.insertBefore(v, p.firstChild);
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
			// 현재 페이지의 스케쥴 태그의 넘버를 가져옴 // 중복값은 생략해서 가져옴
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
				let flagBefore = 0;
				
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
							//flagBefore = 0;
						}
						else if(dateTagYoil=="월"){
							flagSize = 6;
							flagDrawn = 6;
							//flagBefore = 1;
						}
						else if(dateTagYoil=="화"){
							flagSize = 5;
							flagDrawn = 5;
							//flagBefore = 2;
						}
						else if(dateTagYoil=="수"){
							flagSize = 4;
							flagDrawn = 4;
							//flagBefore = 3;
						}
						else if(dateTagYoil=="목"){
							flagSize = 3;
							flagDrawn = 3;
							//flagBefore = 4;
						}
						else if(dateTagYoil=="금"){
							flagSize = 2;
							flagDrawn = 2;
							//flagBefore = 5;
						}
						else if(dateTagYoil=="토"){
							flagSize = 1;
							flagDrawn = 1;
							//flagBefore = 6;
						}
						/*
						let grandfa = boxArray[l].parentNode.parentNode;
						let pregrandfa;
						// 새로 보강한 알고리즘
						for(let t = 0; t < flagBefore; t++){
							pregrandfa = grandfa.previousSibling;
							grandfa = pregrandfa;
					
							let pregrandfabox = pregrandfa.getElementsByClassName("monthBoxBody")[0];
							
							let boxx = document.createElement("div");
							boxx.classList.add("cmpb0");
							
							pregrandfabox.appendChild(boxx);
						}
						*/
						
						
						if(flagSize>boxArray.length-l){
							// 사이즈칸 짜리 플래그 넣어주면 됨.
							flagSize=boxArray.length-l;
							
							boxArray[l].classList.add(checkMonthPlanBar(flagSize));
							boxArray[l].classList.add("firstElementSchedule");
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
							boxArray[l].classList.add("firstElementSchedule");
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
						boxArray[l].classList.add("cmpbzero");
					}
					flagDrawn--;
				}
			}
		}
		
		function checkFirstElement(){
			let monthBoxBodys = document.getElementsByClassName("monthBoxBody");
			let height = 22;
			
			let flag = [0, 0, 0, 0, 0, 0, 0];
			//      block 0  1  2  3  4  5  6 
			let block = 0; 
			let reset = 0; 
			// 2중 배열을 사용하면 스케줄이 바둑판 식으로 정확하게 배치가 될 수 있으나 2중 배열이 브라우저 속도를 저하할 가능성이 높기 때문에
			// 특정 상황에서 빈공간이 생겨도 이를 건너 뛰고 그리도록 진행하는 것이 유리함 
			
			for(let i = 0; i < monthBoxBodys.length; i++){
				block = (i%7);
				reset++;
				
				let scheduleBoxs = monthBoxBodys[i].getElementsByClassName("scheduleBox");
				let bar7 = monthBoxBodys[i].getElementsByClassName("cmpb7");
				let bar6 = monthBoxBodys[i].getElementsByClassName("cmpb6");
				let bar5 = monthBoxBodys[i].getElementsByClassName("cmpb5");
				let bar4 = monthBoxBodys[i].getElementsByClassName("cmpb4");
				let bar3 = monthBoxBodys[i].getElementsByClassName("cmpb3");
				let bar2 = monthBoxBodys[i].getElementsByClassName("cmpb2");
				let bar1 = monthBoxBodys[i].getElementsByClassName("cmpb1");
				let barzero = monthBoxBodys[i].getElementsByClassName("cmpbzero");
			
				for(let j = 0; j < bar7.length; j++){
					let getAtt = bar7[j].getAttribute("style")+";";

					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar7[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+7 ; l++){
						flag[l]+=1;
					}
				}
				for(let j = 0; j < bar6.length; j++){
					let getAtt = bar6[j].getAttribute("style")+";";

					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar6[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+6 ; l++){
						flag[l]+=1;
					}	
				}
				for(let j = 0; j < bar5.length; j++){
					let getAtt = bar5[j].getAttribute("style")+";";
	
					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar5[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+5 ; l++){
						flag[l]+=1;
					}
				}
				for(let j = 0; j < bar4.length; j++){
					let getAtt = bar4[j].getAttribute("style")+";";
	
					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar4[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+4 ; l++){
						flag[l]+=1;
					}
				}
				for(let j = 0; j < bar3.length; j++){
					let getAtt = bar3[j].getAttribute("style")+";";
	
					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar3[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+3 ; l++){
						flag[l]+=1;
					}
				}
				for(let j = 0; j < bar2.length; j++){
					let getAtt = bar2[j].getAttribute("style")+";";

					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar2[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+2 ; l++){
						flag[l]+=1;
					}
				}
				for(let j = 0; j < bar1.length; j++){
					let getAtt = bar1[j].getAttribute("style")+";";
					
					let hg = "margin-top:"+(height*flag[block])+"px;";
					bar1[j].setAttribute("style", getAtt+hg);
					
					for(let l = block; l < block+1 ; l++){
						flag[l]+=1;
					}
				}

				if(reset==7){
					block = 0;
					flag = [0,0,0,0,0,0,0];
					reset = 0;
				}
			}	
				
				
				/*
					
					let p = scheduleBox[i].parentNode;
					let cmpb0 = p.getElementsByClassName("cmpb0");
					let fr = p.getElementsByClassName("firstElementSchedule");
					
					let height = 22;
					
					for(let j = 0; j < fr.length; j++){
						let getAtt = fr[j].getAttribute("style")+";";
						let num = cmpb0.length+j;

						let hg = "margin-top:"+(height*num)+"px;";
					    
						fr[j].setAttribute("style", getAtt+hg);
						
					}
				}
				let pnum = scheduleBox[i].parentNode.childElementCount;
				if(temp<pnum){
					temp = pnum;
				}
			}
			
			let monthBoxs = document.getElementsByClassName("monthBox");
			
			for(let i = 0; i < monthBoxs.length; i++){
				
				let hg = temp*22;
				hg = hg+22;
				monthBoxs[i].setAttribute("style", "height:"+hg+"px;");
			}
			*/
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
			visibleScheduleForm();
		})

		// 스케줄 추가 
		// AJAX로 구현, 실행 후에 스케줄 재차 로딩
		function addGroupSchedule(){
			let jsonSchedule;
			
			let num = document.getElementsByClassName("scheduleFormNum")[0].value;
			let title = document.getElementsByClassName("scheduleFormTitle")[0].value;
			let content = document.getElementsByClassName("scheduleFormContent")[0].value;
			let start = document.getElementsByClassName("scheduleFormStart")[0].value;
			let starttime = document.getElementsByClassName("scheduleFormStartTime")[0].value;
			let end = document.getElementsByClassName("scheduleFormEnd")[0].value;
			let endtime = document.getElementsByClassName("scheduleFormEndTime")[0].value;
			let color = document.getElementsByClassName("scheduleFormColor")[0].value;
			let writer = userKey;
			let groupnum = document.getElementsByClassName("scheduleFormGroupSelect")[0].value;
			
			//20211010/15:15
			start+="/"+starttime;
			end+="/"+endtime;

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
		            	getGroupSchedule(userKey, date);
		            }
				}
			};
			XHRCalendar.open("POST", "scheduleInsert", true);
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
		            	quitScheduleDetail();
		            	getGroupSchedule(userKey, date);
		            }
				}
			};
			XHRCalendar.open("POST", "scheduleDelete", true);
			XHRCalendar.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRCalendar.send("num="+data.num);
		}
		
		let calendarHeadSearch = document.getElementsByClassName("calendarHeadSearch")[0];
		calendarHeadSearch.addEventListener("click", function(){
			let calendarSearch = document.getElementsByClassName("calendarSearch")[0];
			let calendarHeadBar = document.getElementsByClassName("calendarHeadBar")[0];
			let calendarHeadSearchFlag = document.getElementsByClassName("calendarHeadSearchFlag")[0];
			
			if(calendarHeadSearchFlag.value=="false"){
				calendarHeadSearchFlag.setAttribute("value", "true");
				calendarHeadBar.setAttribute("style", "display:none");
				calendarSearch.setAttribute("style", "display:block");
			}
		});
		
		// 스케줄 검색 기능
		let CalendarHeadSearchbar = document.getElementsByClassName("calendarSearchBar")[0];
		CalendarHeadSearchbar.addEventListener("keyup", function(){
			searchSchedule();
		});
		
		function searchSchedule(){
			let v = document.getElementsByClassName("calendarSearchBar")[0];
			let word = v.innerHTML;
			let rs = document.getElementsByClassName("calendarSearchResult")[0];
			
			if(word==""||word=="null"||word==null){
				while(rs.hasChildNodes()){
					rs.removeChild(rs.firstChild);
				}
				rs.removeAttribute("style");
				return;
			}
			
			rs.setAttribute("style", "display: block");
			createXHRCalendar();
			
			XHRCalendar.onreadystatechange=function(){
				if(XHRCalendar.readyState==4){
		            if(XHRCalendar.status==200){
		            	let jsons = JSON.parse(XHRCalendar.responseText, "text/json");
		            	searchScheduleCreateBox(jsons);
		            }
				}
			};
			XHRCalendar.open("POST", "scheduleSearch", true);
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
				c.innerHTML = "제목: "+jsons[i].title;
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
			
			let bar = document.getElementsByClassName("calendarSearchBar")[0];
			bar.innerHTML = "";
			searchSchedule();
			viewScheduleDetail(data);
			quitScheduleDetail();
		
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

		// 년 형식 스케줄을 체크하고 구현
		function scheduleCheckYear (date, userKey, group){
			if(typeof(date)!='undefined'||typeof(userKey)!='undefined'||typeof(userKey)!=null||typeof(group)!='undefined'){
				
			}
			else{
				
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
			XHRTodolist.open("POST", "todolistSelect", true);
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
			cc.classList.add("toDoListTitleHead");
			cc.innerHTML = "오늘 할 일";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListAdd");
			cc.addEventListener("click", todolistAdd);
			
			ccc = document.createElement("input");
			ccc.classList.add("toDoListAddFlag");
			ccc.setAttribute("type", "hidden");
			ccc.setAttribute("value", "false");
			cc.appendChild(ccc);
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListCom");
			cc.addEventListener("click", todolistCom);
			// 아이콘 만들어지면 지울거
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
				cc.addEventListener("click", todolistCheckedBtn);
				c.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].title);
				cc.setAttribute("readonly", "true");
				cc.classList.add("toDoListTitle");
				cc.classList.add("toDolistTitleSecond");
				
				if(jsons[i].checked=="true"){
					cc.classList.add("checkedTodoStmt");
				}
				cc.setAttribute("placeholder", "일정 제목을 입력하세요.");
				cc.setAttribute("style", "width: calc(100% - 62px);");
				c.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListFixBtn");
				cc.addEventListener("click", todolistFixBtn);
				
				ccc = document.createElement("input");
				ccc.classList.add("toDoListFixBtnFlag");
				ccc.setAttribute("type", "hidden");
				ccc.setAttribute("value", "false");
				cc.appendChild(ccc);
				c.appendChild(cc);
				
				let vi = document.createElement("div");
				vi.classList.add("toDoListView")
				
				cc = document.createElement("input");
				cc.setAttribute("type", "text");
				cc.setAttribute("value", jsons[i].content);
				cc.classList.add("toDoListContent");
				vi.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "date");
				cc.setAttribute("value", jsons[i].date);
				cc.classList.add("toDoListDate");
				
				vi.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListTimeTitle");
				cc.innerHTML = "시간 설정";
				vi.appendChild(cc);
				
				cc = document.createElement("select");
				cc.classList.add("toDoListTime");
				
				for(let i = 0; i < 24; i++){
	            	for(let j = 0; j < 4; j++){
	            		let time = ""; 
	            		if(i<10){
	            			time = "0"+i+":";
	            			if(j==0){
	            				time += "00";
	            			}
	            			else {
	            				time += (j*15);
	            			}
	            		}
	            		else{
	            			time = i+":";
	            			if(j==0){
	            				time += "00";
	            			}
	            			else {
	            				time += (j*15);
	            			}
	            		}
	            		ccc = document.createElement("option");
	            		ccc.setAttribute("value", time);
	            		ccc.innerHTML=time;
	            		cc.appendChild(ccc);
	            	}
	            }
				cc.setAttribute("value", jsons[i].time);
				
				vi.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListImportanceTitle");
				cc.innerHTML = "중요도";
				vi.appendChild(cc);
				
				cc = document.createElement("select");
				cc.classList.add("toDoListImportance");
				
				for(let j = 1; j < 5; j++){
					ccc = document.createElement("option");
					ccc.classList.add("toDoListImportanceOption");
					ccc.setAttribute("value", j);
					
					if(j==1){
						ccc.innerHTML = "하면 좋음"
					}
					else if(j==2){
						ccc.innerHTML = "보통";
					}
					else if(j==3){
						ccc.innerHTML = "중요";
					}
					else if(j==4){
						ccc.innerHTML = "매우 중요";
					}
					cc.appendChild(ccc);
					
					if(ccc.value==jsons[i].importance){
						ccc.setAttribute("selected", "true");
					}
					
					
				}
				vi.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].num);
				cc.classList.add("toDoListNum");
				vi.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].id);
				cc.classList.add("toDoListId");
				vi.appendChild(cc);
				
				cc = document.createElement("input");
				cc.setAttribute("type", "hidden");
				cc.setAttribute("value", jsons[i].checked);
				cc.classList.add("toDoListChecked");
				vi.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListDelBtn");
				cc.addEventListener("click", todolistDelBtn);
				// 아이콘 만들어지면 지울거
				cc.innerHTML = "삭제";
				vi.appendChild(cc);
				
				cc = document.createElement("div");
				cc.classList.add("toDoListAddBtn");
				cc.addEventListener("click", todolistAddBtn);
				// 아이콘 만들어지면 지울거
				cc.innerHTML = "저장하기";
				vi.appendChild(cc);
				c.appendChild(vi);
				v.appendChild(c);
			}
			checkBtnState();
		}

		// 투두리스트를 추가하기 위한 폼 생성
		function todolistAdd (){
			let button = document.getElementsByClassName("toDoListAdd")[0];
			let flag = document.getElementsByClassName("toDoListAddFlag")[0];
			
			if(flag.value=="false"){
				flag.setAttribute("value", "true");
				button.classList.add("Xbutton");
			}
			else{
				let p = document.getElementsByClassName("toDoListMain")[0];
				flag.setAttribute("value", "false");
				p.removeChild(p.firstChild);
				button.classList.remove("Xbutton");
				return;
			}
			
			v = document.getElementsByClassName("toDoListMain")[0];
			
			c = document.createElement("div");
			c.classList.add("toDoLists");
			
			cc = document.createElement("input");
			cc.setAttribute("type", "hidden");
			
			cc.classList.add("toDoListNum");
			c.appendChild(cc);
	
			cc = document.createElement("input");
			let temp = cc;
			cc.setAttribute("type", "text");
			cc.classList.add("toDoListTitle");
			cc.setAttribute("placeholder", "일정 제목을 입력하세요.");
			c.appendChild(cc);
		
			cc = document.createElement("input");
			cc.setAttribute("type", "text");
			cc.classList.add("toDoListContent");
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.setAttribute("type", "date");
			cc.setAttribute("value", getTodayDateString());
			console.log(getTodayDateString());
			//cc.innerHTML = getTodayDateString();
			console.log(cc);
			cc.classList.add("toDoListDate");
			c.appendChild(cc);

			cc = document.createElement("div");
			cc.classList.add("toDoListTimeTitle");
			cc.innerHTML = "시간 설정";
			c.appendChild(cc);
							
			cc = document.createElement("select");
			
			cc.classList.add("toDoListTime");
			for(let i = 0; i < 24; i++){
            	for(let j = 0; j < 4; j++){
            		let time = ""; 
            		if(i<10){
            			time = "0"+i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		else{
            			time = i+":";
            			if(j==0){
            				time += "00";
            			}
            			else {
            				time += (j*15);
            			}
            		}
            		ccc = document.createElement("option");
            		ccc.setAttribute("value", time);
            		ccc.innerHTML=time;
            		cc.appendChild(ccc);
            	}
            }
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListImportanceTitle");
			cc.innerHTML = "중요도";
			c.appendChild(cc);
	
			cc = document.createElement("select");
			cc.classList.add("toDoListImportance");
			
			for(let j = 1; j < 5; j++){
				ccc = document.createElement("option");
				ccc.classList.add("toDoListImportanceOption");
				ccc.setAttribute("value", j);
				if(j==1){
					ccc.innerHTML = "하면 좋음"
				}
				else if(j==2){
					ccc.innerHTML = "보통";
				}
				else if(j==3){
					ccc.innerHTML = "중요";
				}
				else if(j==4){
					ccc.innerHTML = "매우 중요";
				}
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
			cc.addEventListener("click", todolistOffBtn);
			cc.innerHTML = "끄기";
			c.appendChild(cc);
			
			cc = document.createElement("div");
			cc.classList.add("toDoListAddBtn");
			cc.addEventListener("click", todolistAddBtn);
			cc.innerHTML = "저장하기";
			c.appendChild(cc);
			
			v.insertBefore(c, v.firstChild);
			temp.focus();
		}
		function todolistOffBtn(){
			let target = event.target;
			let p = target.parentNode.parentNode; 
			let flag = document.getElementsByClassName("toDoListAddFlag")[0];
			let button = document.getElementsByClassName("toDoListAdd")[0];
			button.classList.remove("Xbutton");
			flag.setAttribute("value", "false");
			p.removeChild(p.firstChild);
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
			XHRTodolist.open("POST", "todolistInsert", true);
			XHRTodolist.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRTodolist.send(data);
		}

		function todolistAddBtn(){
			let target = event.target;
			let v = target.parentNode.parentNode;
			
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
			todolistOffBtn();
		}
		
		// 수정을 누를 경우 수정을 위한 폼이 보이도록 해야함 
		// CSS 넢으면서 추가 
		function todolistFixBtn(){
			let target = event.target;
			let v = target.parentNode;
			let title = v.getElementsByClassName("toDolistTitleSecond")[0];
			let area = v.getElementsByClassName("toDoListView")[0];
			let flag = target.getElementsByClassName("toDoListFixBtnFlag")[0];
			
			if(flag.value=="false"){
				flag.setAttribute("value", "true");
				area.setAttribute("style", "display:block;");
				title.removeAttribute("readonly");
			}
			else{
				flag.setAttribute("value", "false");
				area.removeAttribute("style");
				title.setAttribute("readonly", "true");
			}
		}
		function checkBtnState(){
			let box = document.getElementsByClassName("toDoListCheckBox");
			let checked = document.getElementsByClassName("toDoListChecked");
			
			for(let i = 0; i<box.length; i++){
				if(checked[i].value=="true"){
					box[i].setAttribute("style", "background-image: url(./imgSource/checkafter.png);")
				}
				else{
					box[i].removeAttribute("style");
				}	
			}
		}
		// 투두리스트를 완료함
		// 완료한 투두리스트는 안보이거나 흐리게 보이게 CSS 수정해야함
		// 한번에 삭제 필요 
		function todolistCheckedBtn(){
			let target = event.target;
			let v = target.parentNode;
			let checked = v.getElementsByClassName("toDoListChecked")[0]; 

			if(checked.value=='true'){
				checked.setAttribute("value", "false");
			}
			else{
				checked.setAttribute("value", "true");
			}
			checkBtnState();
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
			XHRTodolist.open("POST", "todolistDelete", true);
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
			let flag = document.getElementsByClassName("groupAddFlag")[0];
			let button = document.getElementsByClassName("groupAdd")[0];
			if(flag.value=="true"){
				let p = document.getElementsByClassName("groupMain")[0];
				flag.setAttribute("value", "false");
				p.removeChild(p.firstChild);
				button.classList.remove("Xbutton");
				return;
			}
			else{
				flag.setAttribute("value", "true");
				button.classList.add("Xbutton");
			}
			
			c = document.createElement("div");
			c.classList.add("groupElement");
			
			cc=document.createElement("input");
			cc.setAttribute("type", "hidden");
			cc.classList.add("groupDataNum");
			c.appendChild(cc);
			
			cc=document.createElement("input");
			cc.setAttribute("type", "text");
			cc.classList.add("groupDataName");
			cc.setAttribute("placeholder", "그룹의 이름을 입력하세요.")
			cc.setAttribute("style", "width: calc(100% - 10px);")
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
		
			cc = document.createElement("input");
			cc.classList.add("groupDataClose");
			cc.setAttribute("type", "button");
			cc.setAttribute("value", "닫기");
			cc.addEventListener("click", closeGroupAdd)
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("groupDataAdd2");
			cc.setAttribute("type", "button");
			cc.setAttribute("value", "만들기");
			cc.addEventListener("click", addGroup)
			c.appendChild(cc);
			
			v.insertBefore(c, v.firstChild);
		}
		
		// 그룹 추가 버튼 요소를 제거
		function closeGroupAdd(){
			let flag = document.getElementsByClassName("groupAddFlag")[0];
			let button = document.getElementsByClassName("groupAdd")[0];
			
			if(flag.value=="true"){
				let p = document.getElementsByClassName("groupElement")[0].parentNode;
				p.removeChild(p.firstChild);
				flag.setAttribute("value", "false");
				button.classList.remove("Xbutton");
			}
			else{
				return;
			}
		}
				// 그룹 추가 폼에서 완료버튼 누를시 데이터를 전송함 
		// AJAX로 처리
		function addGroup(date){
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode;
			let p = v.parentNode;
			let flag = document.getElementsByClassName("groupAddFlag")[0];
			let button = p.parentNode.getElementsByClassName("groupAdd")[0];
			
			if(flag.value=="true"){
				flag.setAttribute("value", "false");
				button.classList.remove("Xbutton");
			}
			let num = v.getElementsByClassName("groupDataNum")[0].value;
			let name = v.parentNode.getElementsByClassName("groupDataName")[0].value;
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
    				let str = memberlist[i].innerHTML.replace(")", "");
    				str = str.split("(");
            		members.push(str[1]);
        		}
    		}
    		
			if(typeof(modifierlist)=='undefined'){
				modifiers.push("");
    		}
    		else{
    			for(let i = 0; i < modifierlist.length; i++){
    				let str = modifierlist[i].innerHTML.replace(")", "");
    				str = str.split("(");
        			modifiers.push(str[1]);
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
		            	getGroupSchedule(userKey, date);
		            }
				}
			}
			XHRGroup.open("POST", "groupInsert", true);
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
			let name = v.parentNode.getElementsByClassName("groupDataName")[0].value;
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
    				let str = memberlist[i].innerHTML.replace(")", "");
    				str = str.split("(");
            		members.push(str[1]);
        		}
    		}
    		
			if(typeof(modifierlist)=='undefined'){
				modifiers.push("");
    		}
    		else{
    			for(let i = 0; i < modifierlist.length; i++){
    				let str = modifierlist[i].innerHTML.replace(")", "");
    				str = str.split("(");
        			modifiers.push(str[1]);
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
		            	getGroupSchedule(userKey, date);
		            }
				}
			}
			XHRGroup.open("POST", "groupDelete", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send(json);
		}

		function addGroupMember(date){
			
			let target = event.target;
			let v = target.parentNode; //memerListBox
			let p = v.parentNode; //groupDataMemberResult
			let pp = p.parentNode; //groupDataMemberAdd
			let ppp = pp.parentNode; //groupElement
			
			let groupnum = ppp.getElementsByClassName("groupDataNum")[0].value;
			let master = ppp.getElementsByClassName("groupDataMaster")[0].value;
			
			let list = document.getElementsByClassName("groupDataMemberResult")[0];
			list.innerHTML = "";
			searchGroupMember();
			
			if(userKey!=master){
				return;
			}
			
			let memberId = v.getElementsByClassName("memerListId")[0].innerHTML;
			
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
		            	webSocket.send(memberId);
		            	console.log(webSocket);
		            }
				}
			}
			XHRGroup.open("POST", "groupMemberInsert", true);
			XHRGroup.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRGroup.send("userKey="+userKey+"&groupnum="+groupnum+"&target="+memberId+"&master="+master);
		}
		
		// 그룹에 추가할 검색기능을 구현
		// 멤버 검색시에 요소가 자동완성 처럼 보이게 함 
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
			XHRMember.open("POST", "groupMemberSearch", true);
			XHRMember.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
			XHRMember.send("userKey="+userKey+"&word="+word);
		}
		
		// 멤버들 LIST를 표현할 ELEMENT
		function createSearchGroupMember(v, json){
			let p = v.parentNode;
			let pp = p.parentNode;
			let list = p.getElementsByClassName("groupDataMemberResult")[0];
			let members = pp.getElementsByClassName("groupDataMembers");
			let idArr = []; 
		
			for(let i = 0; i<members.length; i++){
				console.log(members)
				if (members.length>1){
					let checkId = members[i].getElementsByClassName("groupDataMemebersListInputId")[0].value;
					idArr.push(checkId);
				}
				else{
					
				}
			}
			while(list.hasChildNodes()){
				list.removeChild(list.firstChild);
			}
			console.log(idArr);
			for(let i = 0; i < Object.keys(json).length; i++){
				let c;
				let cc;
				let ccc;
				
				let tempFlag = true;
				
				for(let j = 0; j < idArr.length; j++){
					if(idArr[j]==json[i].id){
						tempFlag = false
					}
				}
				console.log(tempFlag);
				if(tempFlag==true){
					
					c = document.createElement("div");
					c.classList.add("memerListBox");
					
					cc = document.createElement("div");
					cc.classList.add("memerListData");
					
					ccc = document.createElement("div");
					ccc.classList.add("memerListIdTitle"); 
					ccc.innerHTML ="아이디";
					cc.appendChild(ccc);
					
					ccc = document.createElement("div");
					ccc.classList.add("memerListId"); 
					ccc.innerHTML = json[i].id;
					cc.appendChild(ccc);
					
					ccc = document.createElement("div");
					ccc.classList.add("memerListNameTitle"); 
					ccc.innerHTML ="닉네임";
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
					cc.innerHTML = "초대하기";
					cc.addEventListener("click", addGroupMember);
					
					c.appendChild(cc);
					
					list.appendChild(c);
					console.log(c);
				}
			}
		}
		
		// Group 멤버를 삭제하는 것
		function groupDataMemberDelete(date){
			createXHRGroup();
			
			let target = event.target;
			let v = target.parentNode
			let p = v.parentNode;
			let t = p.getElementsByClassName("groupDataMemebersListInputId")[0].value;
			let gp = p.parentNode.parentNode;
		
			let num = gp.getElementsByClassName("groupDataNum")[0].value;
			let name = gp.parentNode.getElementsByClassName("groupDataName")[0].value;

			let memberlist = gp.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = gp.getElementsByClassName("groupDataModifierListName");
    		let color = gp.getElementsByClassName("groupDataColor")[0].value;
    		let master = gp.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = gp.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			for(let i = 0; i < memberlist.length; i++){
				let str = memberlist[i].innerHTML.replace(")", "");
				str = str.split("(");
        		members.push(str[1]);
        	}
    		
    		for(let i = 0; i < modifierlist.length; i++){
    			let str = modifierlist[i].innerHTML.replace(")", "");
				str = str.split("(");
    			modifiers.push(str[1]);
        	}
    		
    		let data = createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable);
    		data.target = t;
    		console.log(data);
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
		            	getGroupSchedule(userKey, date);
		            }
				}
			}
			XHRGroup.open("POST", "groupMemberDelete", true);
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
			let t = p.getElementsByClassName("groupDataMemebersListInputId")[0].value;
			let gp = p.parentNode.parentNode;
			let num = gp.getElementsByClassName("groupDataNum")[0].value;
			let name = gp.parentNode.getElementsByClassName("groupDataName")[0].value;
    		let memberlist = gp.getElementsByClassName("groupDataMemebersListName");
    		let modifierlist = gp.getElementsByClassName("groupDataModifierListName");
    		let color = gp.getElementsByClassName("groupDataColor")[0].value;
    		let master = gp.getElementsByClassName("groupDataMaster")[0].value;
    		let searchable = gp.getElementsByClassName("groupDataSearchable")[0].value;
			
    		let members=[];
    		let modifiers=[];
    	
			for(let i = 0; i < memberlist.length; i++){
				let str = memberlist[i].innerHTML.replace(")", "");
				str = str.split("(");
        		members.push(str[1]);
        	}
    		
    		for(let i = 0; i < modifierlist.length; i++){
    			let str = modifierlist[i].innerHTML.replace(")", "");
				str = str.split("(");
    			modifiers.push(str[1]);
        	}
    		
    		let data = createJsonGroup(userKey, num, name, members, modifiers, color, master, searchable);
    		data.target = t;
    		
    		let json = JSON.stringify(data);
    		console.log(data);
    		
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
		            	getGroupSchedule(userKey, date);
		            }
				}
			}
			XHRGroup.open("POST", "groupModifier", true);
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
		function createJsonAddMemeber(userKey, groupnum, id){
			let json = {
				userKey: userKey,
				groupnum: groupnum,
				id: id
			}
			return json;
		}
		console.log("========= 종현 끝 ==========")
		console.log("========= 제민 시작 ==========")
		function createDayFormElement(date){
			
			let v;
            let c;
            let cc;
            let ccc;
            let cccc;
            let ccccc;
            let cccccc;
                       
            if(typeof(date)!='undefined'||date!=null){
            	
            	let yoil = getYoil(getThisDay(date.year, date.month, date.day, 0, 0));
                let today=getToday();
                let thisDayToday=false;
                let thisTimeDate=""; 
            	
            	v = document.createElement("div");
				v.classList.add("calendarArea");
				
				//선택된 날짜가 오늘날짜인지 확인.
				if(date.year==today.year){
					if(date.month==today.month){
						if(date.day==today.day){
							thisDayToday=true;
						}
					}
				}
				c = document.createElement("div");
				c.classList.add("dayTimeWrap");
	           	
	            cc= document.createElement("div");
	            cc.classList.add("dayHeadSize"); // dayAreahead와 같은 height값으로 공간 차지
	            c.appendChild(cc);
	            
	            for(let i=0; i<25; i++){
	            	if(i==0){
	            		cc=document.createElement("div");
	            		cc.classList.add("scheduleTimeBox");
	            		ccc=document.createElement("span");
	            		ccc.classList.add("scheduleTime");
	            		ccc.innerHTML="일정";
	            		cc.appendChild(ccc);
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
	            ccc.innerHTML= date.day+"";
	            cc.appendChild(ccc); // head 날짜표시
	            
	            c.appendChild(cc); 
	           
	            
	            cc=document.createElement("div");
	            cc.classList.add("dayAreaBody");
	            
	            ccc=document.createElement("div");
	            ccc.classList.add("dayBodyWrap");
	            
	            cccc=document.createElement("div");
	            cccc.classList.add("dayScheduleLeftLineWrap");
	            for(let i=0; i<25; i++){
	            	ccccc=document.createElement("div");
	            	ccccc.classList.add("dayScheduleLeftLine");
	            	cccc.appendChild(ccccc);
	            }
	            
	            ccc.appendChild(cccc);
	            cc.appendChild(ccc);
	                                  
	            ccc=document.createElement("div");
	            ccc.classList.add("dayScheduleWrap");
	                        
	            for(let i=0; i<25; i++){
	            	
	            	if(i==0){
	            		cccc=document.createElement("div");
	                    cccc.classList.add("alldaySchedule");
	                    ccc.appendChild(cccc);
	            	}else{
	            		cccc=document.createElement("div");
	                   	cccc.classList.add("daySchedule");
	                   	
	                   	for(let j=0; j<4; j++){
	                   		ccccc=document.createElement("div");
	                       	ccccc.classList.add("dayScheduleCheck");
	                       	
	                       	if(thisDayToday==true){
	                       		if(i==(1+today.hour)){
	                       			if(today.minute<15&&j==0){
	                       				cccccc=document.createElement("div");
	                       				cccccc.classList.add("thisTimeDot");
	                       				ccccc.appendChild(cccccc);
	                       			}else if(today.minute<30&&j==1){
	                       				cccccc=document.createElement("div");
	                       				cccccc.classList.add("thisTimeDot");
	                       				ccccc.appendChild(cccccc);
	                       			}else if(today.minute<45&&j==2){
	                       				cccccc=document.createElement("div");
	                       				cccccc.classList.add("thisTimeDot");
	                       				ccccc.appendChild(cccccc);
	                       			}else{
	                       				cccccc=document.createElement("div");
	                       				cccccc.classList.add("thisTimeDot");
	                       				ccccc.appendChild(cccccc);
	                       			}
	                       		}
	                       	}
	                      	
	                      	if(i<11){
	                      		if(date.month<10){
	                      			if(date.day<10){
	                      				if(j==0){
	                      					thisTimeDate=date.year+"0"+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"00";		
	                      				}else if(j==1){
	                      					thisTimeDate=date.year+"0"+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"15";
	                      				}else if(j==2){
	                      					thisTimeDate=date.year+"0"+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"30";
	                      				}else{
	                      					thisTimeDate=date.year+"0"+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"45";
	                      				}
	                      			}else{
	                      				if(j==0){
	                      					thisTimeDate=date.year+"0"+date.month+""+date.day+"/"+"0"+(i-1)+":"+"00";		
	                      				}else if(j==1){
	                      					thisTimeDate=date.year+"0"+date.month+""+date.day+"/"+"0"+(i-1)+":"+"15";
	                      				}else if(j==2){
	                      					thisTimeDate=date.year+"0"+date.month+""+date.day+"/"+"0"+(i-1)+":"+"30";
	                      				}else{
	                      					thisTimeDate=date.year+"0"+date.month+""+date.day+"/"+"0"+(i-1)+":"+"45";
	                      				}
	                      			}	
	                      		}else{
	                      			if(date.day<10){
	                      				if(j==0){
	                      					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"00";		
	                      				}else if(j==1){
	                      					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"15";
	                      				}else if(j==2){
	                      					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"30";
	                      				}else{
	                      					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+"0"+(i-1)+":"+"45";
	                      				}
	                      			}else{
	                      				if(j==0){
	                      					thisTimeDate=date.year+""+date.month+""+date.day+"/"+"0"+(i-1)+":"+"00";		
	                      				}else if(j==1){
	                      					thisTimeDate=date.year+""+date.month+""+date.day+"/"+"0"+(i-1)+":"+"15";
	                      				}else if(j==2){
	                      					thisTimeDate=date.year+""+date.month+""+date.day+"/"+"0"+(i-1)+":"+"30";
	                      				}else{
	                      					thisTimeDate=date.year+""+date.month+""+date.day+"/"+"0"+(i-1)+":"+"45";
	                      				}
	                      			}
	                      		}
	                      	}
	                      	else{
	                  			if(date.day<10){
	                  				if(j==0){
	                  					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+""+(i-1)+":"+"00";		
	                  				}else if(j==1){
	                  					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+""+(i-1)+":"+"15";
	                  				}else if(j==2){
	                  					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+""+(i-1)+":"+"30";
	                  				}else{
	                  					thisTimeDate=date.year+""+date.month+"0"+date.day+"/"+""+(i-1)+":"+"45";
	                  				}
	                  			}
	                  			else{
	                  				if(j==0){
	                  					thisTimeDate=date.year+""+date.month+""+date.day+"/"+""+(i-1)+":"+"00";		
	                  				}else if(j==1){
	                  					thisTimeDate=date.year+""+date.month+""+date.day+"/"+""+(i-1)+":"+"15";
	                  				}else if(j==2){
	                  					thisTimeDate=date.year+""+date.month+""+date.day+"/"+""+(i-1)+":"+"30";
	                  				}else{
	                  					thisTimeDate=date.year+""+date.month+""+date.day+"/"+""+(i-1)+":"+"45";
	                  				}
	                  			}
	                      	}
	                      	cccccc=document.createElement("input");
		                	cccccc.classList.add("dateTag");
		                  	cccccc.setAttribute("type","text");
		                  	cccccc.setAttribute("value", thisTimeDate);
		                  	ccccc.appendChild(cccccc);
		                   	cccc.appendChild(ccccc);// 15분 단위로 dayScheduleCheck[0]: 0~15 / dayScheduleCheck[1] : 15~30 / dayScheduleCheck[2]: 30~45 / dayScheduleCheck[3]: 45~60
	                    }
	                      	
	               	}
	            	ccc.appendChild(cccc);
				}
	            cc.appendChild(ccc);
	            c.appendChild(cc);
	            v.appendChild(c);
            }//day formdate defined end
            else{
               	let yoil = getYoil(getToday());
           	 	let today=getToday();
            	let thisDayToday=true;
           	 	let thisTimeDate=""; 
               	
               	
            	v = document.createElement("div");
   				v.classList.add("calendarArea");
   				
   				c = document.createElement("div");
   				c.classList.add("dayTimeWrap");
   	           	
   	            cc= document.createElement("div");
   	            cc.classList.add("dayHeadSize"); // dayAreahead와 같은 height값으로 공간 차지
   	            c.appendChild(cc);
   	            
   	            for(let i=0; i<25; i++){
   	            	if(i==0){
   	            		cc=document.createElement("div");
   	            		cc.classList.add("scheduleTimeBox");
   	            		ccc=document.createElement("span");
   	            		ccc.classList.add("scheduleTime");
   	            		ccc.innerHTML="일정";
   	            		cc.appendChild(ccc);
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
   	            ccc.innerHTML= today.day+"";
   	            cc.appendChild(ccc); // head 날짜표시
   	            
   	            c.appendChild(cc); 
   	           
   	            
   	            cc=document.createElement("div");
   	            cc.classList.add("dayAreaBody");
   	            
   	            ccc=document.createElement("div");
   	            ccc.classList.add("dayBodyWrap");
   	            
   	            cccc=document.createElement("div");
   	            cccc.classList.add("dayScheduleLeftLineWrap");
   	            for(let i=0; i<25; i++){
   	            	ccccc=document.createElement("div");
   	            	ccccc.classList.add("dayScheduleLeftLine");
   	            	cccc.appendChild(ccccc);
   	            }//여기서 first child는 일정표시줄 좌측라인.줄은 time왼쪽이지만 border는 right로 줘야함.
   	            
   	            ccc.appendChild(cccc);
   	            cc.appendChild(ccc);
   	                                  
   	            ccc=document.createElement("div");
   	            ccc.classList.add("dayScheduleWrap");
   	                        
   	            for(let i=0; i<25; i++){
   	            	
   	            	if(i==0){
   	            		cccc=document.createElement("div");
   	                    cccc.classList.add("alldaySchedule"); //::after의 line처리 안됨 ==> daySchedule:secondchild before로 해결
   	                    ccc.appendChild(cccc);
   	            	}else{
   	            		cccc=document.createElement("div");
   	                   	cccc.classList.add("daySchedule");
   	                   	
   	                   	for(let j=0; j<4; j++){
   	                   		ccccc=document.createElement("div");
   	                       	ccccc.classList.add("dayScheduleCheck");
   	                       	
   	                       	if(thisDayToday==true){
   	                       		if(i==(1+today.hour)){
   	                       			if(today.minute<15&&j==0){
   	                       				cccccc=document.createElement("div");
   	                       				cccccc.classList.add("thisTimeDot");
   	                       				ccccc.appendChild(cccccc);
   	                       			}else if(today.minute<30&&j==1){
   	                       				cccccc=document.createElement("div");
   	                       				cccccc.classList.add("thisTimeDot");
   	                       				ccccc.appendChild(cccccc);
   	                       			}else if(today.minute<45&&j==2){
   	                       				cccccc=document.createElement("div");
   	                       				cccccc.classList.add("thisTimeDot");
   	                       				ccccc.appendChild(cccccc);
   	                       			}else{
   	                       				cccccc=document.createElement("div");
   	                       				cccccc.classList.add("thisTimeDot");
   	                       				ccccc.appendChild(cccccc);
   	                       			}
   	                       		}
   	                       	}
   	                      	
   	                      	if(i<11){
   	                      		if(today.month<10){
   	                      			if(today.day<10){
   	                      				if(j==0){
   	                      					thisTimeDate=today.year+"0"+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"00";		
   	                      				}else if(j==1){
   	                      					thisTimeDate=today.year+"0"+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"15";
   	                      				}else if(j==2){
   	                      					thisTimeDate=today.year+"0"+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"30";
   	                      				}else{
   	                      					thisTimeDate=today.year+"0"+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"45";
   	                      				}
   	                      			}else{
   	                      				if(j==0){
   	                      					thisTimeDate=today.year+"0"+today.month+""+today.day+"/"+"0"+(i-1)+":"+"00";		
   	                      				}else if(j==1){
   	                      					thisTimeDate=today.year+"0"+today.month+""+today.day+"/"+"0"+(i-1)+":"+"15";
   	                      				}else if(j==2){
   	                      					thisTimeDate=today.year+"0"+today.month+""+today.day+"/"+"0"+(i-1)+":"+"30";
   	                      				}else{
   	                      					thisTimeDate=today.year+"0"+today.month+""+today.day+"/"+"0"+(i-1)+":"+"45";
   	                      				}
   	                      			}	
   	                      		}else{
   	                      			if(today.day<10){
   	                      				if(j==0){
   	                      					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"00";		
   	                      				}else if(j==1){
   	                      					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"15";
   	                      				}else if(j==2){
   	                      					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"30";
   	                      				}else{
   	                      					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+"0"+(i-1)+":"+"45";
   	                      				}
   	                      			}else{
   	                      				if(j==0){
   	                      					thisTimeDate=today.year+""+today.month+""+today.day+"/"+"0"+(i-1)+":"+"00";		
   	                      				}else if(j==1){
   	                      					thisTimeDate=today.year+""+today.month+""+today.day+"/"+"0"+(i-1)+":"+"15";
   	                      				}else if(j==2){
   	                      					thisTimeDate=today.year+""+today.month+""+today.day+"/"+"0"+(i-1)+":"+"30";
   	                      				}else{
   	                      					thisTimeDate=today.year+""+today.month+""+today.day+"/"+"0"+(i-1)+":"+"45";
   	                      				}
   	                      			}
   	                      		}
   	                      	}
   	                      	else{
   	                  			if(today.day<10){
   	                  				if(j==0){
   	                  					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+""+(i-1)+":"+"00";		
   	                  				}else if(j==1){
   	                  					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+""+(i-1)+":"+"15";
   	                  				}else if(j==2){
   	                  					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+""+(i-1)+":"+"30";
   	                  				}else{
   	                  					thisTimeDate=today.year+""+today.month+"0"+today.day+"/"+""+(i-1)+":"+"45";
   	                  				}
   	                  			}
   	                  			else{
   	                  				if(j==0){
   	                  					thisTimeDate=today.year+""+today.month+""+today.day+"/"+""+(i-1)+":"+"00";		
   	                  				}else if(j==1){
   	                  					thisTimeDate=today.year+""+today.month+""+today.day+"/"+""+(i-1)+":"+"15";
   	                  				}else if(j==2){
   	                  					thisTimeDate=today.year+""+today.month+""+today.day+"/"+""+(i-1)+":"+"30";
   	                  				}else{
   	                  					thisTimeDate=today.year+""+today.month+""+today.day+"/"+""+(i-1)+":"+"45";
   	                  				}
   	                  			}
   	                      	}
   	                      	cccccc=document.createElement("input");
   		                	cccccc.classList.add("dateTag");
   		                  	cccccc.setAttribute("type","text");
   		                  	cccccc.setAttribute("value", thisTimeDate);
   		                  	ccccc.appendChild(cccccc);
   		                   	cccc.appendChild(ccccc);// 15분 단위로 dayScheduleCheck[0]: 0~15 / dayScheduleCheck[1] : 15~30 / dayScheduleCheck[2]: 30~45 / dayScheduleCheck[3]: 45~60
   	                    }
   	                      	
   	               	}
   	            	ccc.appendChild(cccc);
   				}
   	            cc.appendChild(ccc);
   	            c.appendChild(cc);
   	            v.appendChild(c);
            }//day form undefined or null date end
            return v;
            console.log(ScheduleData);
		}//createDayformElement(date) end
		
		
		//checkDate 와 스케줄을 비교. 종일에 해당되면 createAlldaySchedule(), 해당 일자에 시작 혹은 종료인 경우 createDaySchedule()을 통해 스케줄 구현.
		function createDayScheduleElement(scheduleData){
			
			let daySchedule = document.getElementsByClassName("dayScheduleCheck");
			
			for(let i=0; i<scheduleData.length; i++){
				
				let startYear = scheduleData[i].start.substring(0, 4);
				let startMonth = scheduleData[i].start.substring(5, 7);
				let startDay = scheduleData[i].start.substring(8, 10);
				let startHour= scheduleData[i].start.substring(11, 13); 
				let startMin = scheduleData[i].start.substring(14);  
				
				let endYear = scheduleData[i].end.substring(0, 4);
				let endMonth= scheduleData[i].end.substring(5, 7);
				let endDay= scheduleData[i].end.substring(8, 10);
				let endHour= scheduleData[i].end.substring(11, 13);
				let endMin= scheduleData[i].end.substring(14);
				
				for(let j=0; j<daySchedule.length; j++){
					let checkDate = daySchedule[j].getElementsByClassName("dateTag")[0].value;
					let checkDateYear = checkDate.substring(0, 4);
					let checkDateMonth = checkDate.substring(4, 6);
					let checkDateDay = checkDate.substring(6, 8);
					let checkDateHour = checkDate.substring(9, 11);
					let checkDateMin = checkDate.substring(12); 
					
					//아래부터 if시작. 대전제 => StartYear,checkDateYear 비교. 값 확인을 위해 else는 사용하지않고 마지막 항까지 else if처리.
					if(startYear>checkDateYear){
						// 아직 시작하지 않은 스케줄. 구현x
					}//StartYear>checkDateYear end
					
					else if(startYear==checkDateYear){
						//올해 시작한 스케줄. month 비교에 따라 현재 진행여부 확인.
						if(startMonth>checkDateMonth){
							//아직 시작하지 않은 스케줄. 구현x
						}else if(startMonth==checkDateMonth){
							//시작년도, 시작 월이 현재 날짜와 동일. day값 비교에 따라 구현여부 판단.
							if(startDay>checkDateDay){
								//아직 시작하지 않은 스케줄. 구현 x
							}else if(startDay==checkDateDay){
								//오늘 시작하는 스케줄. 시간값 찾아서 구현. 00시 00분 시작으로 endDay가 checkDateDay 넘어가면 종일처리, 그 외에는 시작부터 그려야함. endDay도 오늘일 경우 시간 처리해야함.
								if(startHour=="00"&&startMin=="00"){
									if(endDay>checkDateDay){
										//오늘 00시00분 시작으로 오늘 이후에 끝나는 경우. 종일처리.
										//종일처리는 for문이 처음 돌 때(시간값이 00:00일때만 진행하도록 한다. 그렇지 않으면 모든 시간대에 무한반복됨.)
										if(j==0){
											createAlldaySchedule(scheduleData);//종일 처리구현 else if절 부터 값 비교 구현.
										}
									}else if(endDay==checkDateDay){
										//오늘 00시 00분 시작으로 오늘 내에 끝나는 경우. 종료값이 24:00인 경우에만 종일처리.
										if(endHour==24){
											if(j==0){
												createAlldaySchedule(scheduleData[i]);
											}
										}else{
											//00시 00분부터 종료시간까지 schedule표시.
											if(j==0){
												createDaySchedule(scheduleData[i]);
											}
										}
									}else if(endDay<checkDateDay){
										//존재할 수 없는 값. 오늘 시작했는데 오늘보다 전에 끝날 수 없음.
									}
								} // 00시 00분 시작하는 경우 end
								else if(startHour>checkDateHour){
									//아직 시작하지 않은 스케줄. 구현x
								}else if(startHour==checkDateHour){
									if(startMin==checkDateMin){
										//시작시간, 분이 동일하므로 여기서 구현.
										createDaySchedule(scheduleData[i]);
									}
									//min값 비교후 구현.
								}else if(startHour<checkDateHour){
									//이미 createSchedule으로 스케줄이 생성되어 있었어야 함.
								}
							}
							else if(startDay<checkDateDay){
								//해당 월에 이미 시작한 스케줄. endDay가 checkday와 동일하면 createDaySchedule(), endDay가 이후이면 createAllDaySchedule()
								if(endDay>checkDateDay){
									//종료일자가 checkDay보다 이후 이므로 종일처리.
									if(j==0){
										createAlldaySchedule(scheduleData[i]);
									}
								}else if(endDay==checkDateDay){
									//종료일자가 오늘. 24:00 종료인 경우에만 종일 스케줄. 그 외에는 createDaySchedule/시작점은 00:00.
									if(endHour==24){
										if(j==0){
											createAlldaySchedule(scheduleData[i]);
										}
									}else{
										if(j==0){
											createDaySchedule(scheduleData[i]);
										}
									}
								}else if(endDay<checkDateDay){
									//종료일자가 이미 지난 스케줄. 구현x
								}
							}
						}
						//startYear == checkDateYear && startMonth==checkDateMonth end
						
						else if(startMonth<checkDateMonth){
							//시작은 함. end값 비교에 따라 구현 여부 판단.
							if(endYear>checkDateYear){
								//아직 진행중인 스케줄. 모든 날짜에 종일처리.
								if(j==0){
									createAlldaySchedule(scheduleData[i]);
								}
							}else if(endYear==checkDateYear){
								//올해 시작해서 올해 끝나는 스케줄. end month, endDay 비교. endMonth,Day까지 동일하면 시간값 비교.
								if(endMonth>checkDateMonth){
									//아직 끝나는 달 이전. 종일스케줄처리.
									if(j==0){
										createAlldaySchedule(scheduleData[i]);
									}
								}else if(endMonth==checkDateMonth){
									//day값 비교로 이전이면 종일처리, 이후면 구현x , 당일이면 createDaySchedule 처리
									if(endDay>checkDateDay){
										//아직 끝나기 전이므로 종일처리.
										if(j==0){
											createAlldaySchedule(scheduleData[i]);
										}
									}else if(endDay==checkDateDay){
										//종료날짜=checkDateDay -- 시간값비교 및 처리. 24시 종료인 경우에는 종일처리 나머지는 00시부터 daySchedule처리
										if(endHour==24){
											if(j==0){
												createAlldaySchedule(scheduleData[i]);
											}
										}else{
											if(j==0){
												createDaySchedule(scheduleData[i]);
											}
										}
									}else if(endDay<checkDateDay){
										//이미 종료된 스케줄. 구현x
									}
								}else if(endMonth<checkDateMonth){
									//이미 종료된 스케줄. 구현x
								}								
							}
						}//startYear==checkYear Month값 비교 end
					}//startYear==checkDateYear end
					
					else if(startYear<checkDateYear){
						//이미 시작한 스케줄 endYear과 endMonth값 endDay값에 따라 현재 진행여부확인. ==> 이미 종료, 현재 진행, 종료일자.
						if(endYear>checkDateYear){
							//끼인 연도. 모두 종일처리
							if(j==0){
								createAlldaySchedule(scheduleData[i]);
							}
						}else if(endYear==checkDateYear){
							//올해 끝나는 스케줄. 월 day 비교 필요
							if(endMonth>checkDateMonth){
								//아직 끝나지 않음. 모두 종일처리
								if(j==0){
									createAlldaySchedule(scheduleData[i]);
								}
							}else if(endMonth==checkDateMonth){
								//day값 비교해서 종일 혹은 스케줄로 처리
								if(endDay>checkDateDay){
									//끝나는 날 이전에는 종일처리
									if(j==0){
										createAlldaySchedule(scheduleData[i]);
									}
								}else if(endDay==checkDateDay){
									//끝나는 당일에는 00시부터 스케줄 처리. 24시 종료인 경우에만 종일처리
									if(endHour==24){
										if(j==0){
											createAlldaySchedule(scheduleData[i]);
										}
									}else{
										if(j==0){
											createDaySchedule(scheduleData[i]);
										}
									}
								}else if(endDay<checkDateDay){
									//이미 끝난 스케줄. 구현x
								}
							}else if(endMonth<checkDateMonth){
								//이미 끝난 스케줄. 구현x
							}
						}
						//startYear<checkDateYear && endYear==checkDateYear end
						
						else if(endYear<checkDateYear){
							//이미 끝난 스케줄. 구현x
						}
					}//startYear<checkDateYear end
					
				}//checkDate for문 종료
			}//scheduleDate for 종료
		}//createDayScheduleElement end
		
		// 종일 스케줄 모양 구현.
		function createAlldaySchedule(scheduleData){
			
			//	갯수에 따라 .alldaySchedule/ .scheduleTimeBox의 높이 값을 바꿔야함.
			//	alldaySchedule은 ScheduleData를 매개변수로 받아서 실행해야되는 날짜에 alldaySchdule div에 들어감.			
					
			let alldaySchedule = document.getElementsByClassName("alldaySchedule")[0];
			
			let v;
			let c;
			
			
			v=document.createElement("div");
			v.classList.add("alldayScheduleBox");
			
			c = document.createElement("span"); // sceduleData의 값을 넣을 span
			c.classList.add("scheduleInfos"); // class명 month폼과 통일. 내부 data input도 통일. css문제로 필요시 변경.
			
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
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleColor"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.color);
			
			c.appendChild(cc); // scheduleInfos end
			v.appendChild(c);  // alldayScheduleBox end
			
			alldaySchedule.appendChild(v);
			
			/*alldayScheduleBox가 여러개일때 처리 아직 미구현.*/
			
		}//createAlldaySchedule end
		
		
		// 일일 스케줄 모양 구현.
		function createDaySchedule(scheduleData){
			
			/*  
				시작점 잡는것 구현해야함. ==> dayScheduleBox를 시작점에 해당하는 dayScheduleCheck에 appendChild시켜야한다.
			 	전체 dayScheduleCheck를 끌어와서 for문잡고 돌리고 if절을 잡아서 append를 시킨다..?
				그렇다면 if절의 조건을 어떻게 잡아야 정확히 해당하는 날짜에 들어갈 수 있을까. ==> daySchedule로 돌려서 시간찾고 그 daySchedule의 하위요소 dayScheduleCheck 4개중에 맞는 Minutes 찾고 거기서 append?
				예를들어 startMin이 0이면 dayScheduleCheck[0] 에 appendChild 하는식으로?
				append하는 함수를 따로하는게 나은가..? 맞나? 아닌것 같기도하고...
				if(startHour==)
				그럼 createDayScheduleElement를 돌리는 이유는? ==> 그릴지 말지를 결정해야되니까.
			*/
			
			let daySchedules = document.getElementsByClassName("daySchedule");
			let dayScheduleChecks= daySchedules[0].getElementsByClassName("dayScheduleCheck");
			
			let dsStartYear = scheduleData.start.substring(0, 4);
			let dsStartMonth = scheduleData.start.substring(5, 7);
			let dsStartDay = scheduleData.start.substring(8, 10);
			let dsStartHour= scheduleData.start.substring(11, 13); 
			let dsStartMin = scheduleData.start.substring(14);  
			
			let dsEndYear = scheduleData.end.substring(0, 4);
			let dsEndMonth= scheduleData.end.substring(5, 7);
			let dsEndDay= scheduleData.end.substring(8, 10);
			let dsEndHour= scheduleData.end.substring(11, 13);
			let dsEndMin= scheduleData.end.substring(14);
			
			// ScheduleBox
			// {그리기 시작하는 시간값 - 스케줄이 끝나는 시간값 x4 (1 hour가 4칸을 가지므로)} + {그리기 시작하는 분값 - 스케줄이 끝나는 분값/15(15분당 1칸이므로)}
			
			let boxHeight = 4*(parseInt(dsEndHour)-parseInt(dsStartHour))+(parseInt(dsEndMin)-parseInt(dsStartMin))/15
			
			let v;
			let c;
			let cc;
			
			v = document.createElement("div");
			v.classList.add("dayScheduleBox");
			
			
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
			
			c.appendChild(cc);
			
			cc = document.createElement("input");
			cc.classList.add("scInfo"); 
			cc.classList.add("scheduleColor"); 
			cc.setAttribute("type", "text");
			cc.setAttribute("value", scheduleData.color);
			
			c.appendChild(cc);
			v.appendChild(c);
			
			dayScheduleChecks[0].appendChild(v);
			
			// dayScheduleBox Starting point에 append시키는 작업.
			/*
				daySchedule = 1시간단위 div
				dayScheduleCheck = 15분단위 div
				dateTag = dayScheduleCheck의 하위 요소인 input
				let daySchedules = document.getElementsByclassName("daySchedule");
				let dayScheduleChecks;
			*/
			
			/* 잠깐 가리고 테스트중. 박스는 그려지는데 아래 if절에 문제가 있는 것으로 확인.
			for(let i=0; i<daySchedules.length; i++){
				//	시간단위로 쪼개진 횟수만큼 실행 (그 안에서 15분 단위로 또 실행.)
				dayScheduleChecks = daySchedules[i].getElementsByClassName("dayScheduleCheck");
				//	시간 1단위 체크당 15분단위를 4번씩 끌어올 것임.
				for(let j=0; j<dayScheduleChecks.length; j++){
					// 15분단위 div안에 있는 dateTag의 값을 통해 checkTime을 설정
					let startCheck = dayScheduleChecks[j].getElementsByClassName("dateTag")[0].value;
					let startCheckHour = startCheck.substring(10,12);
					let startCheckMin = startCheck.substring(13);
					
					// 먼저 start와 맞는 시간값을 찾는다. 일 단위까지는 createDayScheduleElement 에서 걸러짐.
					if(startCheckHour==dsStartHour){
						//분 단위까지 동일한 값을 찾는다.
						if(startCheckMin==dsStartMin){
							//찾은 값에서 div설정 후 appendChild(v)를 통해 dayScheduleBox를 자식요소로 심어준다.
							dayScheduleChecks[j].appendChild(v);
						}
					}
				}
			}
			*/
			
			//	자신이 몇번째 schedule인지에 따라 left 위치값을 바꿔줘야함. schedule.style.left
			//	다 그린 후에 dayScheduleBox 를 getElementByClassName 으로 묶은 변수를 만들고 해당 변수의 길이만큼 for문을 돌면서 몇번째인지에 따라 left값을 바꾸는 방식은 어떨까...
			//	scheduleBoxMarginLeft()로 설정함.
			
			//	daySchedule==dataTags
			//	daySchedule.parentNode(p) == dayScheduleCheck[15분 단위 div] ==> 여기서 scheduleBox를 appendChild한다.
			//	dayScheduleCheck(p).parentNode(pp) == daySchedule[1시간 단위 div]
		}
		//createDaySchedule end
		
		//scheduleBox의 left값 처리. DayForm이 그려질 때 마다 실행.
		function scheduleBoxMarginLeft(){
			let scheduleBoxes = document.getElementsByClassName("dayScheduleBox");
			let boxWidth = 100/scheduleBoxes.length;
			// 이렇게 처리가 될까...
			for(let i = 0; i<scheduleBoxes.length; i++){
				scheduleBoxes[i].style.marginLeft = 20; // *40은 임의 값. 세부조정가능.
				
			}
		}//scheduleBoxMarginLeft end
		
		
		//.alldaySchedule div와 .scheduleTimeBox div의 높이값 처리 dayForm이 그려질 때 마다 실행.
		function alldayScheduleHeight(){
			// .alldaySchedule div와 .scheduleTimeBox div의 높이값을 alldaySchedule의 갯수에 따라 조정.
			let alldaySchedule = document.getElementsByClassName("alldaySchedule")[0];
			let scheduleTimeBox = document.getElementsByClassName("scheduleTimeBox")[0];
			let alldayScheduleBoxes = document.getElementsByClassName("alldayScheduleBox");
			
			let divHeight = (alldayScheduleBoxes.length)*40; // *40은 임의값. alldayScheduleBox의 height와 margin값에 따라 바꿔서 적용해줘야함.
			
			alldaySchedule.style.height = divHeight;
			scheduleTimeBox.style.height = divHeight;
		}// alldayScheduleHeight end
	</script>
</html>