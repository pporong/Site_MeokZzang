<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시물 수정" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiLib.jspf"%>

<script>
let ArticleModify__submitDone = false;
function ArticleModify__submit(form) {
	
	if (ArticleModify__submitDone) {
		return;
	}
	
	 if(form.title.value == 0){
		    alert('제목을 입력해주세요');
		    return;
		  }
	 
	const editor = $(form).find('.toast-ui-editor').data('data-toast-editor');
	
	const markdown = editor.getMarkdown().trim();
	
	if (markdown.length == 0) {
		alert('내용을 입력해주세요');
		editor.focus();
		return;
	}
	
	form.body.value = markdown;
	ArticleModify__submitDone = true;
	
	form.submit();
}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="table-box-type-1" method="POST" action="../article/doModify" onsubmit="ArticleModify__submit(this); return false;">
			<input type="hidden" name="id" value="${article.id }" />
			<input type="hidden" name="replaceUri" value="${param.replaceUri }" />
			<input type="hidden" name="body" />
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th>번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th>작성날짜</th>
						<td>${article.regDate }</td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td>${article.updateDate }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>
							<span class="badge article-detail__hit-count">${article.hitCount }</span>
						</td>
					</tr>
					<tr>
						<th>추천</th>
						<td>
							<span class="badge ">${article.goodReactionPoint }</span>
						</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${article.extra__writerName }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input class="w-full" type="text" name="title" placeholder="제목을 입력해주세요" value="${article.title }" /></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template">${article.body}</script>
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><button type="submit" value="수정">수정</button></td>
					</tr>
				</tbody>

			</table>
		</form>

		<div class="btns my-3">
			<a class="btn-text-link btn btn-outline btn-sm" href="${param.replaceUri }">뒤로가기</a>
		</div>
	</div>
</section>
</body>
</html>