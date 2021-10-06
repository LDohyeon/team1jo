<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
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
        
        // 견본 콘텍스트 
        let calendarData = {
            date: "2021-10-06 00:00:00", // 오늘 날짜 > 시스템에서 받아옴
            form: "M", // 선택한 Form 데이터, 헤더 컨트롤에서 변경 데이터를 onChange로 설정
            id: "testcalendar", // 유저 Id 
            group: thisGroup // 유저가 속한 그룹 데이터 > 이를 기반으로 DB와 통신
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
            //cc.classList.add("");
            ccc = document.createElement("option");
            ccc.innerHTML = "년"
            ccc.setAttribute("value", "Y")
            cc.appendChild(ccc);
            
            ccc = document.createElement("option");
            ccc.innerHTML = "월"
            ccc.setAttribute("value", "Y")
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
		function changeForm(){
			if(calendarData.form=="Y"){
				YearForm();
			}
			else if(calendarData.form=="M"){
				MonthForm();
			}
			else if(calendarData.form=="W"){
				WeekForm();			
			}
			else if(calendarData.form=="D"){
				DayForm();
			}	
		}
        
		// Form 모양생성
		function YearForm(){
			let div = document.getElementsByClassName("calendarDiv");
            div.removeChild();
            
            
		}
		
		function MonthForm(){
			let div = document.getElementsByClassName("calendarDiv");
            div.removeChild();
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