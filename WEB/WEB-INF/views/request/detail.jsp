<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../includes/nav.jsp"%>



          <div id="page-wrapper">
            <!-- 금고 상세 보기 -->
             <div class="row">
             <div class="col-lg-12">
        	<h1 class="page-header">&nbsp;&nbsp; 상세보기</h1>
		 </div>
             <br>
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <div class="container">
                      <h4 class="pull-left"><span class="glyphicon glyphicon-tags"></span>&nbsp;&nbsp; 금고 정보</h4>
                        <button type="button" class="btn btn-danger btn-fill pull-right" onclick = "location.href=''">삭제</button>      
                        <button type="button" class="btn btn-success btn-fill pull-right" onclick = "location.href=''">수정</button>
                      </div>
                    </div>
                    <div class="panel-body">
                      <div class="row">
                        <div class="container">   
                          <div class="col-sm-6">
                            <h2 class="pull-right">금고 이름</h2>
                          </div>
                        </div>
                        <br>
                        <div class="container">
                          <h3>요청 내용</h3>
                          <div class="well well-lg">
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 상품이름 </button>  
                          <p style="display: inline;">  : ------------------ </p>  <br><br>
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 고유번호 </button>  
                          <p style="display: inline;">  : ------------------ </p>  <br><br>
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 금고번호</button>  
                          <p style="display: inline;">  : ------------------ </p>
                          </div>

                          <h3>기간</h3>
                          <div class="well well-lg">
                            <button type="button" class="btn btn-info btn-fill btn-round"> 시작 </button>  
                            <p style="display: inline;">  : ------------------ </p>  <br><br>
                            <button type="button" class="btn btn-info btn-fill btn-round"> 만료 </button>  
                            <p style="display: inline;">  : ------------------ </p>
                          </div>

                                                  
                        </div>
                      </div>
                    </div>
                    
                  <div class="panel-footer">
                    <a href = "chest.html" class="pull-left">GO_REQUSET</a>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
      </div>
   
              
           
	       
<%@ include file="../../includes/footer.jsp" %>   

<script>
$(".btn-logout").on("click", function(e){
	e.preventDefault();
	$("form").submit();
});
</script>


</html>