<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<!-- Login User Key: loginUserId -->
<html>
	<head>
		<meta charset="utf-8">
		<title>Insert title here</title>
        <link href="calendarCss.css" rel="stylesheet">
	</head>
	<body>
		<div id="calendar">
			
		</div>
	</body>
	<script>
		let calendar = document.getElementById("calendar");
   		
        let thisGroup = ["1", "A", "B", "C"];
        let monthDayTitle = ["일", "월", "화", "수", "목", "금", "토"];
        
        let benchmarkDay = "1900-01-01 00:00:00";
        
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
        	let month = ("0" + (1 + date.getMonth())).slice(-2);
        	let day = ("0" + date.getDate()).slice(-2);
        	let hour = ("0" + date.getHours()).slice(-2);
			let minites = ("0" + date.getMinutes()).slice(-2);
			
            let toDay = {
            	year: year, 
            	month: month, 
            	day: day,
            	hour: hour, 
            	minites: minites	
            }
        	return toDay;
        }
        // 오늘 요일 
        function getTodayString(){
        	
        }
        
        // 윤년 여부 보기
        function getYunNyen(){
        	let date = getToday();
        	let year = (Number)date.year;
        	let yunNyen; 
        	
        	if(year%4==0){
        		if(year%100==0){
        			if(year%400==0){
        				yunNyen = true;
        			}
        			else{
        				yunNyen = false;
        			}
        		}
        		yunNyen = true;
        	}
        	return yunNyen;
        }
        
        
        console.log(getToday().day);
        
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
        
        let selectForm = document.getElementsByClassName("selectForm")[0];
        console.log(selectForm);
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
		function YearForm(){
			let div = document.getElementsByClassName("calendarDiv");
            div.removeChild();
            
            
		}
        
        
		function MonthForm(){
			let div = document.getElementsByClassName("calendarDiv")[0];
            
            
            let v;
            let c;
            let cc;
            let ccc;

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
            
            for(let i = 0; i < dateAlgorism(); i++){
                cc = document.createElement("div");
                cc.classList.add("monthBox"); 
                cc.innerHTML = i +"";
                c.appendChild(cc);
            }
            v.appendChild(c);
            
            console.log(v);
            div.appendChild(v);
		}
		
		function WeekForm(){
			let div = document.getElementsByClassName("calendarDiv");
            div.removeChild();
		}
		
		function DayForm(){
			let div = document.getElementsByClassName("calendarDiv");
            div.removeChild();
            
            let v;
            let c;
            let cc;
            let ccc;
            
            v = document.createElement("div");
            v.classList.add("calendarArea");
            
            
		}
		
        // 날짜를 구하는 알고리즘
        function dateAlgorism(){
            let i = 31;
            
            return i;
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
	</script>
</html>