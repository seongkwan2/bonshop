//전역 변수로 아이디 중복 체크 상태 저장, 작성한 아이디가 사용가능이면 true로 변환
let isIdChecked = false;
//아이디 정규식 체크 (아이디가 4글자 이상 16이하, 영문,숫자 포함이면 OK)
let idType = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{4,16}$/;
//비밀번호 정규식 체크
let pwdType = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;


//모든 폼을 입력했는지 체크하는 함수 joinCheck()
function joinCheck(){
	  if($.trim($("#m_id").val())== ""){
		  alert("아이디를 입력하세요!");
		  $("#m_id").val("").focus();
		  return false;
	  }
	  
	  if(!idType.test(m_id.value)){ //아이디 값이 정규식 패턴과 일치하지 않으면
		  alert("아이디는 영문자+숫자 조합 \n 4이상~16자리 이하로만 사용해야합니다. ");
		  $("#m_id").val("").focus();
		  return false;
	  }
	  
	  if($.trim($("#m_pwd").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#m_pwd").val("").focus();
		  return false;
	  }
	  if($.trim($("#pwd_ck").val())== ""){
		  alert("비밀번호를 입력하세요!");
		  $("#pwd_ck").val("").focus();
		  return false;
	  }
	  
	  //비밀번호 검증
	  if(!pwdType.test(pwd_ck.value)){
		  alert("비밀번호는 영문자+숫자+특수문자 조합 \n 8이상~12자리 이하로만 사용해야합니다. ");
		  $("#pwd_ck").val("").focus();
		  return false;
	  }
	  
	  //비밀번호 일치 테스트
	 if(m_pwd.value !== pwd_ck.value ){
		 alert("비밀번호가 일치하지 않습니다!");
		  $("#pwd_ck").val("").focus();
		  return false;
	 }
	  
	  
	  
	  //그 외 입력해야 할 폼들
	  
	  if($.trim($("#m_name").val())== ""){
		  alert("이름을 입력하세요!");
		  $("#m_name").val("").focus();
		  return false;
	  }
	  
	  
	 // 생년월일 검증
	    let birthValue = $.trim($("#m_birth").val());
	    if(!/^[0-9]{8}$/.test(birthValue)){
	        alert("생년월일은 8자리의 숫자만 입력해야 합니다.");
	        $("#m_birth").val("").focus();
	        return false;
	    }

   	// 전화번호 검증
	    let phoneValue = $.trim($("#m_phone").val());
	    if(!/^[0-9]+$/.test(phoneValue)){
	        alert("전화번호는 숫자만 입력해야 합니다.");
	        $("#m_phone").val("").focus();
	        return false;
    	}
    
	  if($.trim($("#m_email").val())== ""){
		  alert("이메일을 입력하세요!");
		  $("#m_email").val("").focus();
		  return false;
	  }

	  
    
      //통신사 선택
    
	  let m_tel = $('#m_tel').val();

      if(!m_tel){
          alert("선택된 항목이 없습니다.");
          $('#m_tel').focus();
          return false;
      }
	  
  	
      // 모든 조건을 통과한 후 아이디 중복 체크를 했는지 확인
      if (!isIdChecked) {
          alert("아이디 중복 확인을 해주세요.");
          return false;
      }
      
      // 모든 조건을 통과하면 form 제출
      sendForm();
}

//사용가능한 아이디인지 검증
function checkid(){
	
   //아이디 영역을 숨김
   $m_id=$.trim($("#m_id").val());
   
   //입력글자 길이 체크
   if($m_id.length < 4){
      $newtext='<font color="red" size="3"><b>아이디는 4자 이상이어야 합니다.</b></font>';
      $("#idcheck").text('');
      //idcheck 아이디 영역 문자열을 초기화
      $("#idcheck").show();
      //idcheck 아이디 영역을 보이게 함.
      $("#idcheck").append($newtext);
      //idcheck영역에 문자열을 추가
      $("#m_id").val('').focus();
      return false;
   };
   
   if($m_id.length > 16){
      $newtext='<font color="red" size="3"><b>아이디는16자 이하이어야 합니다.</b></font>';
      $("#idcheck").text('');
      $("#idcheck").show();
      $("#idcheck").append($newtext);
      $("#m_id").val('').focus();
      return false;
   };
   
   //영문 숫자조합
   if(!idType.test($m_id)){
      $newtext='<font color="red" size="3"><b>아이디는 영문소문자+숫자 조합으로 만들어주세요.</b></font>';
      $("#idcheck").text('');
      $("#idcheck").show();
      $("#idcheck").append($newtext);
      $("#m_id").val('').focus();
      return false;
   };

   
   //아이디 중복확인
    $.ajax({//$는 jQuery란 뜻. $.ajax 뜻은 jQuery 내의 아작스 실행
        type:"POST",//데이터를 서버로 보내는 방법
       //url:"./member/member_idcheck.jsp",    
        url:"/member/member_idcheck", //url 패턴 매핑주소 경로
        data: {"m_id":$m_id},  //m_id의 데이터를 m_id라는 변수(키)에 담아서 보냄
        dataType:"text",//서버의 실행된 결과값을 사용자로 받아오는 자료형
        success: function (data) {//success는 아작스로 받아오는것이 성공했을경우
           //서버 데이터를 data변수에 저장
           if(data==1){//중복 아이디가 있다면
          	 $newtext='<font color="#EB0000" size="3"><b>중복 아이디입니다.</b></font>';
          	 $("#idcheck").text('');
          	 $("#idcheck").show();
          	 $("#idcheck").append($newtext);                
             $("#m_id").val('').focus();
             
             return false;
        
           }else{//중복 아이디가 아니면
            $newtext='<font color="#1E90FF" size="3"><b>사용가능한 아이디입니다.</b></font>';
            $("#idcheck").text('');
            $("#idcheck").show();
            $("#idcheck").append($newtext);
            $("#m_pwd").focus();
            isIdChecked = true; // 사용 가능한 아이디일 경우 true로 변경
           }              
        },
         error:function(){//비동기식 아작스로 서버디비 데이터를
            //못가져와서 에러가 발생했을 때 호출되는 함수이다.
            alert("data error");
         }
      });//$.ajax
 /* end */   
}