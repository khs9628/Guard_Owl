<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;  charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>로그인</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">
    
    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


   
</head>

<body>

    
    
  
        
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                
                    <div class="panel-heading">
                     <a class="underbar" href="/mainPage/">
                     <div class="logo-container" style="text-align: center;">
                        <div class="logo">
                            <img src="<c:url value="/mainresources/assets/img/logo.png"/>">
                        </div>
                        <div class="brand">
                            GOWL
                        </div>
                    </div>
                	</a>              
                    </div>
                    
                    <div class="panel-body">
                         <form method ="post" action ="/signUpComplete">
                         <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                               <table class="table table-striped table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
                                       <tbody>
                                       <tr>
                                       <td style="width:110px;"><h5>아이디</h5></td>
                                       <td><input type = "text" class="form-control" placeholder ="아이디" id ="mem_id" name ="mem_id" maxlength ="20"></td>
                                       <td style="width:110px;"><button class ="btn btn-primary" id="idCheck" type="button">중복 체크</button></td>
                                       </tr>
                                       <tr>
                                       <td style="width:110px;"><h5>비밀번호</h5></td>
                                       <td colspan="2"><input type = "password" class="form-control" placeholder ="비밀번호" name ="mem_pwd" id ="mem_pwd" onkeyup="passwordCheckFunction();" maxlength ="20"></td>
                                       </tr>
                                        <tr>
                                       <td style="width:110px;"><h5>비밀번호 확인</h5></td>
                              <td colspan="2"><input type = "password" class="form-control" placeholder ="비밀번호 확인" name ="mem_pwd2" id ="mem_pwd2" onkeyup="passwordCheckFunction();" maxlength ="20"></td>
                                       </tr>
                                          <tr>
                                       <td style="width:110px;"><h5>이름</h5></td>
                              <td colspan="2"><input type = "text" class="form-control" placeholder ="이름" name ="mem_name" id = "mem_name" maxlength ="20"></td>
                                       </tr>
                                           <tr>
                                       <td style="width:110px;"><h5>이메일</h5></td>
                              <td colspan="2"><input type = "email" class="form-control" placeholder ="e-mail" id="mem_email" name ="mem_email" maxlength ="50"></td>
                                       </tr>
                                       <tr>
                                       <td style="width:110px;"><h5>핸드폰</h5></td>
                              <td colspan="2"><input type = "text" class="form-control" placeholder ="핸드폰" id="mem_phone" name ="mem_phone" maxlength ="50"></td>
                                       </tr>
                                         <tr>
                                         <td colspan="3" style ="text-align:left">
                                         <p class="result"> <span class="msg"></span>
                                         <h5 style="color:red;" id="passwordCheckMessage"></h5>
                                         <input class ="btn btn-primary pull-right" type ="submit" id="submit" disabled="disabled" value ="회원가입">
                                         </td>
                                        </tr>
                                        
                                        <tr>
                                         <td colspan="3" style ="text-align:right">
                                         <a href="/find">비밀번호 찾기</a>                     
                                         </td>
                                        </tr>
                                     </tbody>
                                     </table>
                                     </form>
                    </div>
                </div>
            </div>
 
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
 var csrfHeaderName = "${_csrf.headerName}";
 var csrfTokenValue = "${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options){
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
$("#idCheck").click(function(){
	   var query = {mem_id : $("#mem_id").val()};
	   console.log(query);
	   $.ajax({
	    url : "/idCheck",
	    type : "post",
	    data : query,
	    success : function(data) {
	    
	    	if(data=="yes") { //(yes==null), (no==notnull)
	    		$(".result .msg").text("아이디 사용 불가");
	    		$(".result .msg").attr("style", "color:#f00"); 
	    		$("#submit").attr("disabled","disabled");
				console.log("사용불가")
				
	    		} else {
	    		$(".result .msg").text("아이디 사용 가능");
	    		$(".result .msg").attr("style", "color:#00f");
	    		$("#submit").removeAttr("disabled");
	    		console.log("사용가능");
	    	
	     }
	    },
	   error : function(xhr, status, error) {
        alert("에러발생 - status : " + status + ", xhr : " + xhr + ", error : "+ error);
  }
	   });  // ajax 끝
	   
	   $("#mem_id").keyup(function(){
		   $(".result .msg").text("아이디를 확인해주십시오.");
		   $(".result .msg").attr("style", "color:#000");
		   
		   $("#submit").attr("disabled", "disabled");
		   
		  });
	  });
</script>
<!-- 회원가입 체크  -->
   <script type="text/javascript">
   
   function passwordCheckFunction(){
      var userPassword = $('#mem_pwd').val();
      var userPassword2 = $('#mem_pwd2').val();

      if((userPassword != userPassword2) || (userPassword == null)){
         $('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
         $("#submit").attr("disabled", "disabled");
      }else{
         $('#passwordCheckMessage').html('비밀번호가 서로 일치 합니다.');
         $("#submit").removeAttr("disabled");
      }
   }
   </script>
</body>

</html>
