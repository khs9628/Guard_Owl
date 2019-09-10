<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../includes/nav.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">&nbsp;&nbsp;승인대기 목록</h1>
	</div>
	<div class="panel-body">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#R" data-toggle="tab">수령 요청</a></li>
			<li><a href="#K" data-toggle="tab">보관 요청</a></li>
			<li><a href="#M" data-toggle="tab">회원가입 요청</a></li>
		</ul>
	</div>
	<!-- Tab panes -->
	<!-- Tab panes -->
	<div class="tab-content">
		<div class="tab-pane fade in active" id="R">
			<table width="100%"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>요청 번호</th>
						<th>요청한 금고 번호</th>
						<th>요청한 멤버 번호</th>
						<th>요청 아이템 번호</th>
						<th>요청 사유</th>
						<th>요청 타입(R, K)</th>
						<!-- R 수령, K 보관 -->
						<th>요청 시간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr class="odd gradeX">
						<c:forEach var="app_R" items="${ apps_R}">
							<tr>
								<td>${ app_R.app_no }</td>
								<td>${ app_R.app_safe_no }</td>
								<td>${ app_R.app_mem }</td>
								<td>${ app_R.app_item_no}</td>
								<td>${ app_R.app_content }</td>
								<td>${ app_R.app_type }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${app_R.app_date }" /></td>
								<td>
									<form style="display: inline;" method="post"
										action="/request/page/receipt/approvalReceipt">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> 
											<input type="hidden"
											name="item_safe_no" value='<c:out value="${app_R.app_safe_no }"/>'>
											<input type="hidden"
											name="app_no" value='<c:out value="${app_R.app_no }"/>'>
										<input type="hidden" name="app_mem"
											value='<c:out value="${app_R.app_mem }"/>'> <input
											type="submit" class="btn btn-primary" value="승인">
									</form>

									<form style="display: inline;" method="post"
										action="/request/page/receipt/denyApprovalReceipt">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> 				
											<input type="hidden"
											name="item_safe_no" value='<c:out value="${app_R.app_safe_no }"/>'>			
											<input type="hidden"
											name="app_no" value='<c:out value="${app_R.app_no }"/>'>
										<input type="hidden" name="app_mem"
											value='<c:out value="${app_R.app_mem }"/>'> <input
											type="submit" class="btn btn-warning" value="거절">
									</form>
								</td>

							</tr>
						</c:forEach>
					</tr>

				</tbody>
			</table>
		</div>

		<div class="tab-pane fade" id="K">
			<table width="100%"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>요청 번호</th>
						<th>요청한 금고 번호</th>
						<th>요청한 멤버 번호</th>
						<th>요청 아이템 번호</th>
						<th>요청 사유</th>
						<th>요청 타입(R, K)</th>
						<!-- R 수령, K 보관 -->
						<th>요청 시간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr class="odd gradeX">
						<c:forEach var="app_K" items="${ apps_K }">
							<tr>
								<td>${ app_K.app_no }</td>
								<td>${ app_K.app_safe_no }</td>
								<td>${ app_K.app_mem }</td>
								<td>${ app_K.app_item_no}</td>
								<td>${ app_K.app_content }</td>
								<td>${ app_K.app_type }</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
									value="${app_K.app_date }" /></td>
								<td>
									<form style="display: inline;" method="post"
										action="/request/page/keep/approvalKeep">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> 
											<input type="hidden"
											name="item_safe_no"
											value='<c:out value="${app_K.app_safe_no }"/>'>
											<input type="hidden"
											name="app_item_no"
											value='<c:out value="${app_K.app_item_no }"/>'> <input
											type="hidden" name="app_mem"
											value='<c:out value="${app_K.app_mem }"/>'> <input
											type="submit" class="btn btn-primary" value="승인">
									</form>

									<form style="display: inline;" method="post"
										action="/request/page/keep/denyApprovalKeep">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> 
											<input type="hidden"
											name="item_safe_no"
											value='<c:out value="${app_K.app_safe_no }"/>'>
											<input type="hidden"
											name="app_item_no"
											value='<c:out value="${app_K.app_item_no }"/>'> <input
											type="hidden" name="app_mem" value="${app_K.app_mem }" /> <input
											type="submit" class="btn btn-warning" value="거절">
									</form>
								</td>

							</tr>
						</c:forEach>
					</tr>

				</tbody>
			</table>
		</div>

		<div class="tab-pane fade" id="M">
			<table width="100%"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>번호</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<tr class="odd gradeX">
						<c:forEach var="user" items="${ users }">
							<tr>
								<td>${ user.mem_no }</td>
								<td>${ user.mem_id }</td>
								<td>${ user.mem_name }</td>
								<td>${ user.mem_email }</td>
								<td>${ user.mem_phone }</td>
								<td>
									<form style="display: inline;" method="post"
										action="/request/page/approvalMember">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> <input type="hidden"
											name="mem_id" value='<c:out value="${user.mem_id }"/>'>
										<input type="submit" class="btn btn-primary" value="승인">
									</form>

									<form style="display: inline;" method="post"
										action="/request/page/denyApprovalMember">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }" /> <input type="hidden"
											name="mem_id" value="${user.mem_id }" /> <input
											type="submit" class="btn btn-warning" value="거절">
									</form>
								</td>

							</tr>
						</c:forEach>
					</tr>
				</tbody>
			</table>
		</div>

	</div>
</div>
</div>
</div>

<%@ include file="../../includes/footer.jsp"%>
