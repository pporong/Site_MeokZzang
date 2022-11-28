<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="댓글 수정" />
<%@ include file="../common/head.jspf"%>

<!-- 댓글 function -->
<script>
	// 댓글 중복 submit 방지
	let ReplyModify__submitFormDone = false;
	
	function ReplyModify__submitForm(form) {
		
		if (ReplyModify__submitFormDone) {
			return;
		}
		
		form.body.value = form.body.value.trim();
		 		if (form.body.value.length == 0) {
		 			alert('댓글을 입력해주세요');
		 			form.body.focus();
		 			return;
		 		}
	
		ReplyModify__submitFormDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1 overflow-x-auto" method="POST" action="../reply/doModify" onsubmit="ReplyModify__submit(this); return false;">
			<input type="hidden" name="id" value="${reply.id }" />
				<table class="table table-compact w-full">
					<colgroup>
						<col width="200" />
					</colgroup>
	
					<tbody>
						<tr>
							<th>게시물 번호</th>
							<td>
								<div class="badge">${reply.relId }</div>
							</td>
						</tr>
						<tr>
							<th>게시물 제목</th>
							<td>
								<div class="badge">${relDataTitle }</div>
							</td>
						</tr>
						<tr>
							<th class="text-indigo-700">작성날짜</th>
							<td>${reply.regDate }</td>
						</tr>
						<tr>
							<th class="text-indigo-700">수정날짜</th>
							<td>${reply.updateDate }</td>
						</tr>
						<tr>
							<th class="text-indigo-700">작성자</th>
							<td>${reply.extra__writerName }</td>
						</tr>
						<tr>
							<th class="text-indigo-700">내용</th>
							<td><textarea class="w-full input input-bordered" style="height: 400px;" name="body" placeholder="내용을 입력해주세요">${reply.body }</textarea></td>
						</tr>
						<tr>
							<th class="text-indigo-700"></th>
							<td><button type="submit" value="수정">수정</button></td>
						</tr>
					</tbody>
				</table>
		</form>

		<div class="btns flex justify-end my-3">
			<button class="btn-text-link btn btn-outline btn-sm" type="button" onclick="history.back();">뒤로가기</button>
		</div>
		
	</div>
</section>
</body>
</html>