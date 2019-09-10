<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.board.Android.*"%>
<%@ include file="../../includes/nav.jsp" %>


<div class="tim-title">
                  <h2>사진 <small>(목록)</small></h2>
 </div>

<div class ="row">
	<div class="panel panel-info">
    	<div class="panel-heading">
      		카메라 파일
  		</div>
   		<div class="panel-body">
  		<!--이미지 출력-->
 <%
 String Path = "/usr/local/tomcat9/upload/Arduino";
 

/*  String Path = "/usr/local/tomcat9/upload/Arduino"; */  
 	List<File> list = ImageGetter.getImgFileList(Path);
  
  for(File f : list) {
      System.out.println(f.getName()); //파일 이름 출력
      String url = "http://ec2-52-79-50-43.ap-northeast-2.compute.amazonaws.com:8080/img/" + f.getName();
      /* 
      String url = "htt[]"
       */
   	  String strImgConFormat1 = 
      "<div class=\"col-md-4\">" +
      "<img width='320' height ='320' src =\"%s\"/></div>";
      
      out.print(String.format(strImgConFormat1,url));
  }
  /* 
  response.sendRedirect("http://192.168.43.10/clear");  */
%>
    
		</div>
	</div>
<div>



</div>
</div>
<%@ include file="../../includes/footer.jsp" %>   

<script>
$(".btn-logout").on("click", function(e){
   e.preventDefault();
   $("form").submit();
});
</script>

</body>
</html> 