x<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../../includes/nav.jsp" %>
<style>
.uploadResult {
	width: 100%;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img {
	width: 100px;
}
</style>

<style>
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>
			<div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">글수정</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-defualt">
			<div class="panel-heading"></div>
			<div class="panel-body">
			
				<form role="form" action="/board/modify" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
				<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
				<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
				<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
					<div class="form-group">
					<label>번호</label> 
					<input class="form-control" name="brd_id" value='<c:out value="${board.brd_id}"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					<label>제목</label> 
					<input class="form-control" name="brd_sub" value='<c:out value="${board.brd_sub }"/>'>
					</div>
					
					<div class="form-group">
					<label>내용</label> <textarea class="form-control" name="brd_content" rows="15"><c:out value="${board.brd_content }"/></textarea>
					</div>
					 
					<div class="form-group">
					<label>작성자</label> 
					<input class="form-control" name="brd_writer" value='<c:out value="${board.brd_writer }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					<input type="hidden" class="form-control" name="brd_date" 
					value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.brd_date }"/>'
					 readonly="readonly">
					</div>
					
					<div class="form-group">
					 
					<input type="hidden" class="form-control" name="brd_updateDate" 
					value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.brd_updateDate }"/>' readonly="readonly">
					</div>
					
					<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
					<button type="submit" data-oper="modify" class="btn btn-danger">수정하기</button>
					<button type="submit" data-oper="remove" class="btn btn-warning">삭제하기</button>
					</sec:authorize>
					<button type="submit" data-oper="list" class="btn btn-default">목록으로</button>
					
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 첨부 파일 원본 이미지를 보여주는 div -->
<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<!-- 첨부 파일 목록 -->
<div class="row">
      <div class="col-lg-12">
           <div class="panel panel-default">
             <div class="panel-heading">첨부파일</div><!-- /.panel-heading -->
             <div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple="multiple">
				</div>
				
				<div class="uploadResult">
					<ul>
	
					</ul>
				</div> <!-- /uploadResut -->
			</div>
			</div> <!-- panel-default -->
		</div>
</div> <!-- /row -->

<script type="text/javascript">
$(document).ready(function(){
	//첨부 파일 보여주기
	(function(){
		var brd_id = '<c:out value="${board.brd_id}"/>';
		$.getJSON("/board/getAttachList", {brd_id: brd_id}, function(arr){
			console.log(arr);
			
			var str = "";
			$(arr).each(function(i, attach){
				
				// 이미지 파일 여부를 통해 첨부파일 조회
				if(attach.fileType){
					
					var fileCallPath = encodeURIComponent(attach.uploadPath+ "/s_" + attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br/>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				} else{
					str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
					str += "<span>"+attach.fileName+"</span><br/>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'"
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br/>";
					str += "<img src='/resources/img/attach.png'>";
					str += "</div>";
					str + "</li>";
				}	
			});
			
			$(".uploadResult ul").html(str);
			
		
		}); //getJSON 종료
	})(); //end function
	
	// 첨부 파일의 x 버튼 클릭시 사용자 화면에서 삭제
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		if(confirm("파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	})
	
	//해당 파일의 확장자 파일 등록 불가능, 파일 최대 크기 5MB
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
	  
	  function checkExtension(fileName, fileSize){
	    
	    if(fileSize >= maxSize){
	      alert("파일 사이즈 초과");
	      return false;
	    }
	    
	    if(regex.test(fileName)){
	      alert("해당 종류의 파일은 업로드할 수 없습니다.");
	      return false;
	    }
	    return true;
	  }
	  
	  var csrfHeaderName = "${_csrf.headerName}";
	  var csrfTokenValue = "${_csrf.token}";
	  
	  $("input[type='file']").change(function(e){

	    var formData = new FormData();
	    
	    var inputFile = $("input[name='uploadFile']");
	    
	    var files = inputFile[0].files;
	    
	    for(var i = 0; i < files.length; i++){

	      if(!checkExtension(files[i].name, files[i].size) ){
	        return false;
	      }
	      formData.append("uploadFile", files[i]);
	      
	    }
	    
	    $.ajax({
	      url: '/uploadAjaxAction',
	      processData: false, 
	      contentType: false,data: 
	      formData,type: 'POST',
	      beforeSend: function(xhr){
	    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	      },
	      dataType:'json',
	        success: function(result){
	          console.log(result); 
			  showUploadResult(result); //업로드 결과 처리 함수 

	      }
	    }); //$.ajax
	    
	  }); // $("input[type='file']").change(function(e)) 종료
	  
	  function showUploadResult(uploadResultArr){
		    
	    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
	    
	    var uploadUL = $(".uploadResult ul");
	    
	    var str ="";
	    
	    $(uploadResultArr).each(function(i, obj){
	    
	     	if(obj.image){
				var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str +"</li>";
			}else{
				var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			      
				str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
				str += "<span> "+ obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
			}

	    });
	    
	    uploadUL.append(str);
	  } //showUploadResult 종료

	  
	// 수정시 파라미터 값 전달
	var formObj = $("form");
	
	$("button").on("click", function(e){
		e.preventDefault();
		
		var operation = $(this).data("oper");

		console.log(operation);
		
		if(operation === "remove"){
			formObj.attr("action", "/board/remove"); //form에 action 경로 /board/remove로 변경
		}else if(operation === "list"){
			formObj.attr("action", "/board/list").attr("method", "get"); //form에 action 경로 /board/list, method get으로 변경
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			
			formObj.empty();
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		} else if(operation === "modify"){
			console.log("submit clicked");
			
			var str = "";
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				console.dir(jobj);
				
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			}); //$(".uploadResult ul li").each(function(i, obj) 종료
				formObj.append(str).submit();
		}
		formObj.submit();
		
	});
});

</script>  
<%@ include file="../../includes/footer.jsp" %> 