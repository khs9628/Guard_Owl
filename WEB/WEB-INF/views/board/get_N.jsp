<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


<!-- 글 목록 -->
<div class="row">
     <div class="col-lg-12">
        <h1 class="page-header">글조회</h1>
     </div>
     <!-- /.col-lg-12 -->
     </div>
     <!-- /.row -->
            
  <div class="row">
      <div class="col-lg-12">
           <div class="panel panel-default">
             <div class="panel-heading">글 조회</div><!-- /.panel-heading -->
             <div class="panel-body">
                        
              <div class="form-group">
				<label>번호</label> <input class="form-control" name="brd_id" 
				value='<c:out value="${board.brd_id }"/>' readonly = "readonly">
			  </div>
			  
			  <div class="form-group">
				<label>제목</label> <input class="form-control" name="brd_sub" 
				value='<c:out value="${board.brd_sub }"/>' readonly = "readonly">
			  </div>
			  
			  <div class="form-group">
				<label>내용</label> 
				<textarea class="form-control" name="brd_content" readonly = "readonly" rows="15"><c:out value="${board.brd_content }"/></textarea>
			  </div>
			  
			  <div class="form-group">
				<label>작성자</label> <input class="form-control" name="brd_writer" 
				value='<c:out value="${board.brd_writer }"/>' readonly = "readonly">
			  </div>
			  
			  <sec:authentication property="principal" var="pinfo"/>
			  <sec:authorize access="isAuthenticated()">
			  <c:if test="${pinfo.username eq board.brd_writer}">
			  <button data-oper='modify' class="btn btn-danger"  onclick="location.href='/board/modify_N?brd_id=<c:out value="${board.brd_id }"/>'">
			  수정하기
			   </button>
			   </c:if>
			   </sec:authorize>
			   
			  <button data-oper='list' class="btn btn-default" onclick="location.href='/board/list_N'">
			목록으로</button>
			 
			 <form id="operForm" action="/board/modify_N" method="get">
			 	<input type="hidden" id="brd_id" name="brd_id" value='<c:out value="${board.brd_id}"/>'>
			 	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
				<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
				<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
				<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
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
				
				<div class="uploadResult">
					<ul>
	
					</ul>
				</div> <!-- /uploadResut -->
			</div>
			</div> <!-- panel-default -->
		</div>
</div> <!-- /row -->
			
<!-- 댓글 목록 -->
<div class="row">
	<div class="col-lg=12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>댓글
				
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn" class="btn btn primary btn-xs pull-right">댓글쓰기</button>
				</sec:authorize>
			</div>
			
			<div class="panel-body">
				<ul class="chat">	
				</ul>
				<div class="panel-footer">
				
				</div>
			</div>
		</div>
	</div>
</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">댓글쓰기</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>댓글</label>
						<input class="form-control" name="cmt_content" value="댓글">
					</div>
					
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="cmt_writer" value="작성자" readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>작성 시간</label>
						<input class="form-control" name="cmt_date" value="">
					</div>
				</div>
				<div class="modal-footer">
				<button id="modalModBtn" type="button" class="btn btn-warning">수정하기</button>
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제하기</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록하기</button>
				<button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
<%@include file="../../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
$(document).ready(function(){
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
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str + "</li>";
			} else{
				str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
				str += "<span>"+attach.fileName+"</span><br/>";
				str += "<img src='/resources/img/attach.png'>";
				str += "</div>";
				str + "</li>";
			}	
		});
		
		$(".uploadResult ul").html(str);
		
	
	}); //getJSON 종료
})(); //end function


//첨부 파일 클릭시 이미지 파일은 원본 이미지, 일반 파일 다운로드 처리
$(".uploadResult").on("click", "li", function(e){
	
	console.log("view image");
	var liObj = $(this);
	
	var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid")+"_"+liObj.data("filename"));
	
	if(liObj.data("type")){
		showImage(path.replace(new RegExp(/\\/g), "/"));
	} else{
		self.location = "/download?fileName="+path;
	}
});

//원본 이미지 효과
function showImage(fileCallPath) {
	alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	
	$(".bigPicture")
	.html("<img src='/display?fileName="+fileCallPath+"'>")
	.animate({width:'100%', height:'100%'}, 1000);
}

$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	setTimeout(function(){
		$('.bigPictureWrapper').hide();
	}, 1000);
});


}); //$(document).ready end
</script>
<script> 
$(document).ready(function(){


var bnoValue = '<c:out value="${board.brd_id}"/>';
var replyUL = $(".chat");
	showList(1);
	
	//댓글 목록 이벤트 처리
	function showList(page){
		console.log("show list : " + page);
		replyService.getList({cmt_board:bnoValue, page : page || 1}, function(cmt_cnt, list){
			
			console.log("cmt_cnt : " + cmt_cnt );
			console.log("list : " + list);
			console.log(list);
			
			if(page == -1) {
				pageNum = Math.ceil(cmt_cnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str="";
			if(list == null || list.length == 0){
				return;
			}
			for(var i =0, len = list.length || 0; i< len; i++) {
				str +="<li class='left clearfix' data-cmt_id='"+list[i].cmt_id+"'>";
				str +="<div><div class='header'><strong class='primary-font'>["
					+list[i].cmt_id+"]"+list[i].cmt_writer+"</strong>";
				str +="<small class='pull-right text-muted'>"
					+replyService.displayTime(list[i].cmt_date)+"</small></div>";
				str +="<p>"+list[i].cmt_content+"</p></div></li>";	
			}
		for(var i =0, len = list.length || 0; i < len; i++) {
			
		}
		replyUL.html(str);
		showReplyPage(cmt_cnt);
		}); //end function
	} //end showList
	
	//댓글 추가 시작시 버튼 이벤트 처리
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='cmt_content']");
	var modalInputReplyer = modal.find("input[name='cmt_writer']");
	var modalInputReplyDate = modal.find("input[name='cmt_date']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	var cmt_writer = null;
	
	//이클립스 에러나도 정상작동하는 코드
	<sec:authorize access="isAuthenticated()">
	cmt_writer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
	 var csrfHeaderName = "${_csrf.headerName}";
	 var csrfTokenValue = "${_csrf.token}";
	 
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modal.find("input[name='cmt_writer']").val(cmt_writer);
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		$(".modal").modal("show");
	});
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	//새로운 댓글 추가 처리
	modalRegisterBtn.on("click", function(e){
		var cmt_content = {
				cmt_content : modalInputReply.val(),
				cmt_writer : modalInputReplyer.val(),
				cmt_board:bnoValue
		};
		replyService.add(cmt_content, function(result){
			alert(result);
			modal.find("input").val("");
			modal.modal("hide");
			showList(-1);
		});
	});
	
	//댓글 수정
	modalModBtn.on("click", function(e){
		var originalReplyer = modalInputReplyer.val();
		
		var cmt_content = {
				cmt_id:modal.data("cmt_id"), 
				cmt_content:modalInputReply.val(),
				cmt_writer:originalReplyer};
		
		if(!cmt_writer){
			alert("로그인 후 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		console.log("Original Replyer : " + originalReplyer);
		
		if(cmt_writer != originalReplyer){
			alert("자신이 작성한 댓글만 수정이 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(cmt_content, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	//댓글 삭제
	modalRemoveBtn.on("click", function(e){
	var cmt_id = modal.data("cmt_id");
	
	console.log("cmt_id : " + cmt_id);
	console.log("REPLYER : " + cmt_writer);
	
	if(!cmt_writer){
		alert("로그인 후 삭제가 가능합니다.");
		modal.modal("hide");
		return;
	}
	
	var originalReplyer = modalInputReplyer.val();
	console.log("Original Replyer : " + originalReplyer);
	
	if(cmt_writer != originalReplyer){
		alert("자신이 작성한 댓글만 삭제가 가능합니다.");
		modal.modal("hide");
		return;
	}
	
	replyService.remove(cmt_id, originalReplyer, function(result){
		alert(result);
		modal.modal("hide");
		showList(pageNum);
	});
	});
	
	//댓글 조회 클릭 이벤트 처리
	$(".chat").on("click", "li", function(e){
		var cmt_id = $(this).data("cmt_id");
		console.log(cmt_id);
		replyService.get(cmt_id, function(reply){
			modalInputReply.val(reply.cmt_content);
			modalInputReplyer.val(reply.cmt_writer);
			modalInputReplyDate.val(replyService.displayTime(reply.cmt_date))
			.attr("readonly", "readonly");
			modal.data("cmt_id", reply.cmt_id);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			$(".modal").modal("show");
		});		
});
	//댓글 페이지 번호
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(cmt_cnt){
	      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9; 
	      
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= cmt_cnt){
	        endNum = Math.ceil(cmt_cnt/10.0);
	      }
	      
	      if(endNum * 10 < cmt_cnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
	        var active = pageNum == i? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }
	     
	    replyPageFooter.on("click","li a", function(e){
	       e.preventDefault();
	       console.log("page click");
	       
	       var targetPageNum = $(this).attr("href");
	       
	       console.log("targetPageNum: " + targetPageNum);
	       
	       pageNum = targetPageNum;
	       
	       showList(pageNum);
	     });     
});
</script>


<script type="text/javascript">
$(document).ready(function() {
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify_N").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#brd_id").remove();
		operForm.attr("action", "/board/list_N");
		operForm.submit();
	});
});
</script> 