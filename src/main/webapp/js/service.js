/**
 * service.js
 */
 
 function qna_check(){
 
	if($.trim($("#cq_title").val())==""){
		alert("글제목을 입력하세요!");
		$("#cq_title").val("").focus();
		return false;
	}
	
	if($.trim($("#cq_pwd").val())==""){
		alert("비밀번호를 입력하세요!");
		$("#cq_pwd").val("").focus();
		return false;
	}
	
	if($.trim($("#cq_cont").val())==""){
		alert("글내용을 입력하세요!");
		$("#cq_cont").val("").focus();
		return false;
	}
 }