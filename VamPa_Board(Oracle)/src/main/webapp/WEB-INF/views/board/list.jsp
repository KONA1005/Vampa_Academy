<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    <!-- 년/월/일 형식으로 출력되도록 변경에 대한 라이브러리 코드 -->
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
a {
	text-decoration: none;
}

table {
	border-collapse: collapse;
	width: 1000px;
	margin-top: 20px;
	text-align: center;
}

td, th {
	border: 1px solid black;
	height: 50px;
}

th {
	font-size: 17px;
}

thead {
	font-weight: 700;
}

.table_wrap {
	margin: 50px 0 0 50px;
}

.bno_width {
	width: 12%;
}

.writer_width {
	width: 20%;
}

.regdate_width {
	width: 15%;
}

.updatedate_width {
	width: 15%;
}

.top_btn {
	font-size: 20px;
	padding: 6px 12px;
	background-color: #fff;
	border: 1px solid #ddd;
	font-weight: 600;
}

.pageInfo {
	list-style: none;
	display: inline-block;
	margin: 50px 0 0 100px;
}

.pageInfo li {
	float: left;
	font-size: 20px;
	margin-left: 18px;
	padding: 7px;
	font-weight: 500;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

.active {
	background-color: #9282CD;
}

.search_area {
	display: inline-block;
	margin-top: 30px;
	margin-left: 260px;
}

.search_area input {
	height: 30px;
	width: 250px;
}

.search_area button {
	width: 100px;
	height: 36px;
}
</style>
</head>
<body>
<h1>목록페이지입니다.</h1>

<div class="table_wrap">
	<a href="/board/enroll" class="top_btn">게시판 등록</a>
	<table>
		<thead>
			<tr>
				<th class="bno_width">번호</th>
				<th class="title_width">제목</th>
				<th class="writer_width">작성자</th>
				<th class="regdate_width">작성일</th>
				<th class="updatedate_width">수정일</th>
			</tr>
		</thead>
			<!-- 아까 빽단에서 list란 이름으로 넘겨준거.
			items를 반복하면서 하나의 요소를 list로 쓰겠다. -->
			<c:forEach items="${list}" var="list">
				<tr>
					<td><c:out value="${list.bno}" /></td>
					<td>
						<!-- 목록페이지에서 제목 클릭했을 때 해당 조회페이지(get.jsp)
							 페이지로 이동할 수 있도록 <a>태그 추가 -->
						<%-- <a class="move" href='/board/get?bno=<c:out value="${list.bno}"/>'>
	                        <c:out value="${list.title}"/>
	                    </a> --%>
	                    <a class="move" href='<c:out value="${list.bno}"/>'>
					        <c:out value="${list.title}"/>
					    </a>
					</td>
					<%-- <td><c:out value="${list.title}" /></td> --%>
					<td><c:out value="${list.writer}" /></td>
					<%-- <td><c:out value="${list.regdate}" /></td>
					<td><c:out value="${list.updateDate}" /></td> --%>
					<!-- 변경코드. 년도/월/일 형식으로 출력되도록-->
					<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.regdate}"/></td>
                	<td><fmt:formatDate pattern="yyyy/MM/dd" value="${list.updateDate}"/></td>
				</tr>
			</c:forEach>
		</table>
		<!-- 검색영역 -->
		<div class="search_wrap">
			<div class="search_area">
				<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
				<button>Search</button>
			</div>
		</div>
		<!-- 페이징 영역 -->
	    <div class="pageInfo_wrap" >
	        <div class="pageInfo_area">
	        	<ul id="pageInfo" class="pageInfo">
	        	
	            <!-- 이전페이지 버튼 -->
                <c:if test="${pageMaker.prev}">
                    <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
                </c:if>
                
		        	<!-- 각 번호 페이지 버튼 -->
		        	<!-- 시작은 컨트롤에서 넘어온 스타트페이지부터~ -->
	                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	                    <!-- 아래 코드는 컨트롤러에서 전달된 페이지 번호가 현재 반복문을 돌다가
	                    	 나온 페이지 번호이면 active라는 클래스 동적추가 -->
	                    <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
	                    <!-- 숫자를 보여주기만 하는게 아니라 눌러 선택할 수 있게 끔 -->
	                </c:forEach>
	                
	                 <!-- 다음페이지 버튼 -->
	                <c:if test="${pageMaker.next}">
	                    <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
	                </c:if>   
 			    </ul>
	        </div>
	    </div>
		
		<!-- 앞서 추가한 <a>태그 'href'속성의 속성 값을 게시판 번호(bno) 값만 저장되도록 변경
			<body>태그 내부에 <form>태그 추가. 
			<form>태그엔 id속성, method속성(속성값 "get")을 추가. -->
		<form id="moveForm" method="get">
		      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		      <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		      <input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">     
    	</form>
</div>

<script>
	$(document).ready(function() {
		// 넘겨준 result 받아오는거.
		let result = '<c:out value="${result}"/>';

		checkAlert(result); // alret함수 만들고 호출해주기.

		function checkAlert(result) {

			if (result === '') {
				return;
			}

			if (result === "enrol success") {
				alert("등록이 완료되었습니다.");
			}
			
			if(result === "modify success"){
		        alert("수정이 완료되었습니다.");
		    }
			
			if(result === "delete success"){
	            alert("삭제가 완료되었습니다.");
	        }

		}

	});
	
	/* <a>태그가 동작하도록 Javascript코드 추가 */
	let moveForm = $("#moveForm");
	 
    $(".move").on("click", function(e){
        e.preventDefault();
        
        // 비어있는 moveForm에 동적으로 hidden으로 
        moveForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
        moveForm.attr("action", "/board/get");
        moveForm.submit();
    });
 	/* javascript내용 : 클릭한<a>태그 기능 정지 => <form>태그 내부 bno값 저장하는 <input>태그 생성
 					=> <form>태그 action속성 추가 => <form>태그 내부 데이터 서버 전송 */
 	
 					
 	/* 페이지 이동 번호'가 동작시키기 위해 JS코드 작업
 	   페이지번호(a태그) 클릭했을 때 동작하는 메소드 */	
 //	  "a태그 동작 멈춤"  =>  "<form> 태그 내부 pageNum과 관련된 <input>태그의 vlaue 속성값을 클릭한 <a> 태그의 페이지 번호를 삽입"  =>   "<form>태그 action 속성 추가 및 '/board/list'을 속성값으로 추가"  
 //	 =>   "<form>태그 서버 전송"
 	 
	$(".pageInfo a").on("click", function(e) {
	        e.preventDefault();
	     // name이 pageNum인 input태그의 값에 걔의 href값으로 대입해라.
	        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	     
	        moveForm.attr("action", "/board/list"); // action속성 추가
	        moveForm.submit(); 
	});
 	/* 웹화면쪽에 있는 class가 태그 안에 띄워져있음면 다수의 클래스를 가지고 있는거고
 	   css파일이나 쿼리 선택자에 있으면 자손을 말하는거임. */
	$(".search_area button").on("click", function(e){
        e.preventDefault();
        let val = $("input[name='keyword']").val();
        moveForm.find("input[name='keyword']").val(val);
        moveForm.find("input[name='pageNum']").val(1);
        moveForm.submit();
    });
 
 					
</script>
</body>
</html>