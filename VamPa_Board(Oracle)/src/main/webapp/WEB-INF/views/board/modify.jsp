<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--  jstl의 'core'와 'fmt'를 사용하기 위해서 라이브러리 코드추가 -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head> <!-- 헤드 태그에 스타일 태그 추가하여 css설정 -->
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery사용을 위해 jquery라이브러리 코드 추가 -->
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <style>
<style type="text/css">
.input_wrap{
	padding: 5px 20px;
}
label{
    display: block;
    margin: 10px 0;
    font-size: 20px;	
}
input{
	padding: 5px;
    font-size: 17px;
}
textarea{
	width: 800px;
    height: 200px;
    font-size: 15px;
    padding: 10px;
}
.btn{
  	display: inline-block;
    font-size: 22px;
    padding: 6px 12px;
    background-color: #fff;
    border: 1px solid #ddd;
    font-weight: 600;
    width: 140px;
    height: 41px;
    line-height: 39px;
    text-align : center;
    margin-left : 30px;
    cursor : pointer;
}
.btn_wrap{
	padding-left : 80px;
	margin-top : 50px;
}
#delete_btn{
    background-color: #f3e3e7;
}
 
</style>
</head>
<body>
<h1>수정 페이지</h1>
	<form id="modifyForm" action="/board/modify" method="post">
<!-- 게시판 내용이 출력되는 부분의 경우, <input>,<textarea> 태그의 "value"속성에 
서버로부터 전달받은 ${pageinfo} 객체에 담긴 데이터들을 속성 값으로 부여하여 페이지에 출력되도록.
'조회 페이지'에서는 기존의 데이터를 수정할 수 없어야 하기 때문에 "readonly"속성 부여함. -->
	<div class="input_wrap">
		<label>게시판 번호</label>
		<input name="bno" readonly="readonly" value='<c:out value="${pageInfo.bno}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 제목</label>
		<input name="title"  value='<c:out value="${pageInfo.title}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 내용</label>
		<textarea rows="3" name="content" ><c:out value="${pageInfo.content}"/></textarea>
	</div>
	<div class="input_wrap">
		<label>게시판 작성자</label>
		<input name="writer" readonly="readonly" value='<c:out value="${pageInfo.writer}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 등록일</label>
		<input name="regdater" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.regdate}"/>' >
	</div>
	<div class="input_wrap">
		<label>게시판 수정일</label>
		<input name="updateDate" readonly="readonly" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${pageInfo.updateDate}"/>' >
	</div>		
	<div class="btn_wrap">
	<!-- 버튼의 경우 url경로에 직접 서버로 전송할 데이터를 작성할 수도 있음. 
		 하지만 추 후 '페이징'적용,'검색조건' 적용 등 여러 기능이 추가에 따라 유연하게 다양한
		 상황을 처리하기 위해 <form>태그를 사용-->
		<a class="btn" id="list_btn">목록 페이지</a> 
		<a class="btn" id="modify_btn">수정 하기</a>
		<a class="btn" id="delete_btn">삭제</a>
		<a class="btn" id="cancel_btn">수정 취소</a>
	</div>
	</form>
	<form id="infoForm" action="/board/modify" method="get">
		<input type="hidden" id="bno" name="bno" value='<c:out value="${pageInfo.bno}"/>'>
		<input type="hidden" name="pageNum" value="${cri.pageNum }">
		<input type="hidden" name="amount" value="${cri.amount }"> 
		<input type="hidden" name="keyword" value="${cri.keyword }">     
	</form>
	
<!-- 버튼이 동작하도록 <script>태그와 JS코드를 작성  -->
<script>

	let form = $("#infoForm");        // 페이지 이동 form(리스트 페이지 이동, 조회 페이지 이동)
	let mForm = $("#modifyForm");    // 페이지 데이터 수정 from
	
	/* 목록 페이지 이동 버튼 */
	$("#list_btn").on("click", function(e){
	    form.find("#bno").remove();
	    form.attr("action", "/board/list");
	    form.submit();
	});
	
	/* 수정 하기 버튼 */
	$("#modify_btn").on("click", function(e){
	    mForm.submit(); // 화면에서 수정한 input데이터들 날리기
	});

	
	/* 취소 버튼 */
	$("#cancel_btn").on("click", function(e){
	    form.attr("action", "/board/get"); // 수정화면에서 상세보기로 이동
	    form.submit();
	});    
	
	/* 삭제 버튼 */
    $("#delete_btn").on("click", function(e){
        form.attr("action", "/board/delete");
        form.attr("method", "post");
        form.submit();
    });
 


</script>	
</body>
</html>