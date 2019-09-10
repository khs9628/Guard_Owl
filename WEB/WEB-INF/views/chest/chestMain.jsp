<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../includes/nav.jsp"%>

			  <div class="tim-title">
                  <h2>금고 <small>(분류)</small></h2>
              </div>

          <div class="row">

<div class="panel panel-info">
   <div class="panel-heading">
      <h3>금고위치 / 금고검색</h3>
  </div>
   <div class="panel-body">
  <!--금고 위치 UI-->
  <div class="col-md-6">
  		<c:forEach var="chest" items="${chests}">
  			<c:choose>
  				<c:when test="${chest.item_safe_no > 0 and chest.item_stat eq 'E'.charAt(0)}">
  					<div class="col-md-4">
					    <button class="btn btn-primary btn-lg btn-tooltip" data-toggle="tooltip" data-placement="left"
					title="빈금고" onclick = "location.href='/chest/chestDetail?item_safe_no=<c:out value="${chest.item_safe_no }"/>'"><img class="btn-img" src="/mainresources/assets/img/chest_E.png"></button>
					 </div>
  				</c:when>
  				 <c:otherwise>
  					<div class="col-md-4">
				       <button class="btn btn-primary btn-lg btn-tooltip" data-toggle="tooltip" data-placement="left"
				title="금고" onclick = "location.href='/chest/chestDetail?item_safe_no=<c:out value="${chest.item_safe_no }"/>'"><img class="btn-img" src="/mainresources/assets/img/chest.png"></button>
				  	</div>
  				</c:otherwise>
  			</c:choose>
  		</c:forEach>
  
<!--     <div class="col-md-4">
    <button class="btn btn-primary btn-lg btn-tooltip" data-toggle="tooltip" data-placement="left"
title="빈금고" onclick = "location.href='/chest/chestDetail?item_safe_no=1'"><img class="btn-img" src="/mainresources/assets/img/chest_E.png"></button>
  	</div>
  	    <div class="col-md-4">
       <button class="btn btn-primary btn-lg btn-tooltip" data-toggle="tooltip" data-placement="left"
title="빈금고" onclick = "location.href='/chest/chestDetail?item_safe_no=1'"><img class="btn-img" src="/mainresources/assets/img/chest.png"></button>
  	</div> -->
  	    <!-- <div class="col-md-4">
    <button class="btn btn-primary btn-lg btn-tooltip" data-toggle="tooltip" data-placement="left"
title="빈금고" onclick = "location.href='/chest/chestDetail?item_safe_no=1'">1번</button>
  	</div> -->
  </div>
    					
  
<!--금고 검색 UI-->
<div class="col-md-6">
   <div class="panel panel-primary">
      <div class="panel-body">
<!-- panel로 받아서 보내자 -->
         <form method = "post" action ="검색" enctype="multipart/form-data">
        <table class = "table table-striped" style = "text-align : center;">
               <thead>
             <tr>
                <th colspan ="3" style = "text-align : center;"> 물품 검색 </th>
             </tr>
          </thead>
          <tbody>
            <tr>
                <td> <button class="btn btn-primary btn-round btn-sm">이름</button> </td>
                     <td> <input type="text" value="" placeholder="이름" class="form-control" /> </td>
                  </tr>
            <tr>
                     <td> <button class="btn btn-primary btn-round btn-sm">종류</button> </td>
                     <td> <input type="text" value="" placeholder="종류" class="form-control" /> </td>
                  </tr>
            <tr>
                     <td> <button class="btn btn-primary btn-round btn-sm">날짜</button> </td>
                     <td>
                <div class="col-sm-6">
                <input type="date" class="form-control" />  
                </div>
                <div class="col-sm-6">
                <input type="date" class="form-control" /> 
                </div>
              </td>
                  </tr>
                  <tr>
                <td colspan="2" style ="text-align:left"> <input type="submit" value="검색" class="form-control" /></td>
             </tr>
          </tbody>
        </table>
      </form>
    </div>
  </div>
</div>
<!--/금고 검색 UI-->


            
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

<script type="text/javascript">

$('.btn-tooltip').tooltip();
$('.label-tooltip').tooltip();
$('.pick-class-label').click(function(){
      var new_class = $(this).attr('new-class');
      var old_class = $('#display-buttons').attr('data-class');
      var display_div = $('#display-buttons');
      if(display_div.length) {
      var display_buttons = display_div.find('.btn');
      display_buttons.removeClass(old_class);
      display_buttons.addClass(new_class);
      display_div.attr('data-class', new_class);
      }
});
$( "#slider-range" ).slider({
range: true,
min: 0,
max: 500,
values: [ 75, 300 ],
});
$( "#slider-default" ).slider({
   value: 70,
   orientation: "horizontal",
   range: "min",
   animate: true
});
$('.carousel').carousel({
   interval: 4000
});

$(".move").on("click", function(e){
	e.preventDefault();
	actionForm.append("<input type='hidden' name='item_safe_no' value='" + $(this).attr("href")+"'>");
	actionForm.attr("action","/chest/chestDetail");
	actionForm.submit();
});

</script>
</html>	