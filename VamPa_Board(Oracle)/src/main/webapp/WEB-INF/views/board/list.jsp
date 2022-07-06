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
  a{
  	text-decoration : none;
  }
  table{
 	border-collapse: collapse;
 	width: 1000px;    
 	margin-top : 20px;
 	text-align: center;
  }
  td, th{
  	border : 1px solid black;
  	height: 50px;
  }
  th{
  	font-size : 17px;
  }
  thead{
  	font-weight: 700;
  }
  .table_wrap{
  	margin : 50px 0 0 50px;
  }
  .bno_width{
  	width: 12%;
  }
  .writer_width{
  	width: 20%;
  }
  .regdate_width{
  	width: 15%;
  }
  .updatedate_width{
  	width: 15%;
  }
  .top_btn{
  	font-size: 20px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
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
		<!-- 앞서 추가한 <a>태그 'href'속성의 속성 값을 게시판 번호(bno) 값만 저장되도록 변경
			<body>태그 내부에 <form>태그 추가. 
			<form>태그엔 id속성, method속성(속성값 "get")을 추가. -->
		<form id="moveForm" method="get">    
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

		}

	});
	
	/* <a>태그가 동작하도록 Javascript코드 추가 */
	let moveForm = $("#moveForm");
	 
    $(".move").on("click", function(e){
        e.preventDefault();
        
        moveForm.append("<input type='hidden' name='bno' value='"+ $(this).attr("href")+ "'>");
        moveForm.attr("action", "/board/get");
        moveForm.submit();
    });
 	/* javascript내용 : 클릭한<a>태그 기능 정지 => <form>태그 내부 bno값 저장하는 <input>태그 생성
 					=> <form>태그 action속성 추가 => <form>태그 내부 데이터 서버 전송 */

</script>

</body>
</html>