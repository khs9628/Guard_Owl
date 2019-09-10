<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/nav.jsp"%>

        
          <div id="page-wrapper">
            <!-- 금고 상세 보기 -->
             <div class="row">
             <br>
                <div class="panel panel-primary">
                  <div class="panel-heading">
                    <div class="container">
                      <h4 class="pull-left"><span class="glyphicon glyphicon-tags"></span>&nbsp;&nbsp; 금고 정보</h4>
                        <button type="button" class="btn btn-info btn-fill pull-right" onclick = "location.href='/chest/chestMain'">목록</button>      
                        <button type="button" class="btn btn-success btn-fill pull-right" onclick = "location.href='/chest/chestDetailUpdate?item_safe_no=<c:out value="${chest.item_safe_no }"/> '">수정</button>
                      </div>
                    </div>
                    <div class="panel-body">
                      <div class="row">
                        <div class="container">
                          <!-- 상품 사진 -->
                          <div class="col-sm-6">
                            <img src="../assets/img/logob.png" alt="Rounded Image" class="img-rounded" width="50%" height="50%">
                          </div>    
                          <div class="col-sm-6">
                            <h2 class="pull-right">금고 이름</h2>
                          </div>
                        </div>
                        <br>
                        <div class="container">
                          <h3>기본정보</h3>
                        <div class="well well-lg">
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 고유번호 </button>  
                          <p style="display: inline;">  : ${chest.item_no } </p>  <br><br>
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 금고번호</button>  
                          <p style="display: inline;">  : ${chest.item_safe_no } </p>  <br><br>
                          <button type="button" class="btn btn-danger btn-fill btn-round"> 상품이름 </button>  
                          <p style="display: inline;">  : ${chest.item_name } </p>  <br><br>        
                          </div>
                          
                          <h3>분류 및 비고</h3>
                          <div class="well well-lg">
                             <button type="button" class="btn btn-success btn-fill btn-round"> 분류 </button>  
                            <p style="display: inline;">  : ${chest.item_class } </p> <br><br>
                            <button type="button" class="btn btn-success btn-fill btn-round"> 비고 </button>  
                            <p style="display: inline;">  : ${chest.item_remark } </p>
                            
                          </div>     

                          <h3>보관 기간</h3>
                          <div class="well well-lg">
                            <button type="button" class="btn btn-info btn-fill btn-round"> 시작 </button>  
                            <p style="display: inline;">  :  <fmt:formatDate pattern="yyyy-MM-dd"
							value="${chest.item_keep_start }"/></p>  <br><br>
                            <button type="button" class="btn btn-info btn-fill btn-round"> 만료 </button>  
                            <p style="display: inline;">  :  <fmt:formatDate pattern="yyyy-MM-dd"
							value="${chest.item_keep_end }"/></p>
                          </div>

                                                
                        </div>
                      </div>
                    </div>
                  <div class="panel-footer">
                    <a href = "chest.html" class="pull-left">GO_Chest</a>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
      </div>
      
      
    <%@ include file="../../includes/footer.jsp" %>   


</html>