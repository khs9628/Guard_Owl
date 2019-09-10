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
                     <a href="/mainPage/">
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
                         <form method ="post" action ="/userEdit">
                         <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                               <table class="table table-striped table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
                                       <tbody>
                                       <tr>
                                       <td style="width:110px;"><h5>아이디</h5></td>
                                       <td><input type = "text" class="form-control"  id ="mem_id" name ="mem_id" maxlength ="20" value='<sec:authentication property="principal.username"/>' readonly="readonly"></td>
                                       </tr>        
                                                               
                                       <tr>
                                       <td style="width:110px;"><h5>이름</h5></td>
                              <td colspan="2"><input type = "text" class="form-control" placeholder ="이름" name ="mem_name" id = "mem_name" maxlength ="20" value='<sec:authentication property="principal.user.mem_name"/>'></td>      
                                       </tr>
                                        
                                        <tr>
                                       <td style="width:110px;"><h5>이메일</h5></td>
                              <td colspan="2"><input type = "email" class="form-control" placeholder ="e-mail" id="mem_email" name ="mem_email" maxlength ="50" value='<sec:authentication property="principal.user.mem_email"/>'></td>
                                       </tr>
                                       
                                       <tr>                          
                                       <td style="width:110px;"><h5>핸드폰</h5></td>
                              <td colspan="2"><input type = "text" class="form-control" placeholder ="핸드폰" id="mem_phone" name ="mem_phone" maxlength ="50" value='<sec:authentication property="principal.user.mem_phone"/>'></td>
                                       </tr>

                                         <tr>
                                         <td colspan="3" style ="text-align:left">
                                         <p class="result"> <span class="msg"></span>
                                         <h5 style="color:red;" id="passwordCheckMessage"></h5>
                                         <input class ="btn btn-primary pull-right" type ="submit" id="submit" value ="정보변경">
                                         </td>
                                        </tr>          
                                     </tbody>
                                     </table>
                                     </form>
                    </div>
                    
                    <div class="panel-body">
                         <form id="passwordForm" method ="post" action ="/changePassword">
                         <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                               <table class="table table-striped table-bordered table-hover" style="text-align:center; border: 1px solid #dddddd">
                                       <tbody>
                                       <input type = "hidden" class="form-control"  id ="mem_id" name ="mem_id" maxlength ="20" value='<sec:authentication property="principal.username"/>' readonly="readonly">
                                       <tr>
                                       <td style="width:110px;"><h5>기존 비밀번호</h5></td>
                              <td colspan="2"><input type = "password" class="form-control" placeholder ="기존 비밀번호" name ="oldPassword" id = "oldPassword" maxlength ="20"></td>      
                                       </tr>
                                           <tr>
                                       <td style="width:110px;"><h5>새 비밀번호</h5></td>
                              <td colspan="2"><input type = "password" class="form-control" placeholder ="새 비밀번호" id="mem_pwd" name ="mem_pwd" maxlength ="50"></td>
                                       </tr>
                                       <tr>
                                       <td style="width:110px;"><h5>비밀번호 확인</h5></td>
                              <td colspan="2"><input type = "password" class="form-control" placeholder ="비밀번호 확인" id="confirmPassword" name ="confirmPassword" maxlength ="50"></td>
                                       </tr>

                                         <tr>
                                         <td colspan="3" style ="text-align:left">
                                         
                                         <input class ="btn btn-primary pull-right" type ="submit" id="submit" value ="정보변경">
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
</script>
<script>
	$(function(){
		

		if($("#passwordForm").submit(function(){		
			if($("#mem_pwd").val() !== $("#confirmPassword").val()){
				alert("비밀번호가 다릅니다.");
				$("#mem_pwd").val("").focus();
				$("#confirmPassword").val("");
				console.log("씨발");
				return false;
			}else if ($("#mem_pwd").val().length < 8) {
				alert("비밀번호는 8자 이상으로 설정해야 합니다.");
				$("#mem_pwd").val("").focus();
				console.log("비밀번호 8자 이상 설정");
				return false;
			}else if($.trim($("#mem_pwd").val()) != $("#mem_pwd").val()){
				alert("공백은 입력이 불가능합니다.");
				console.log("공백 입력 불가");
				return false;
			}
		}));
	})
</script>
</body>

</html>
