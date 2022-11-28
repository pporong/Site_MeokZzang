<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시글 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- 조회수 function -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount(){
		const localStorageKey = 'airtlce__' + params.id + '__alreadyView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd?', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		ArticleDetail__increaseHitCount();
	});
	
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="table-box-type-1">
			<table>
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th class="text-indigo-700">번호</th>
						<td>${article.id }</td>
					</tr>
					<tr>
						<th class="">게시판</th>
						<td class="">${article.boardId }</td>
					</tr>
					<tr>
						<th class="">조회수</th>
						<td>
							<span class="badge article-detail__hit-count">${article.hitCount }</span>
						</td>
					<tr>
					<tr>
						<th class="">현재 추천수</th>
						<td>
							<span class=" gap-2 btn-sm mx-2 btn-like" onclick=""> 👍 좋아요 
								<div class="badge badge-secondary ">${article.goodReactionPoint}</div>
							</span>
							<span class=" gap-2 btn-sm btn-hate"> 👎 싫어요 
		 						 <div class="badge">${article.badReactionPoint}</div>
		 					</span>
						</td>
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
						<th>작성자</th>
						<td>${article.extra__writerName }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td>${article.title }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${article.body }</td>
					</tr>
					<tr>
						<th class="">느낌 남기기</th>
						<td>				
							<!-- 추천 기능 사용 가능? -->
							<c:if test="${actorCanMakeReaction }">		
								<div class="btns my-3 flex justify-center">
									<!-- 추천 버튼 -->
									<a id="" href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" 
										class="btn gap-2 btn-sm mx-2 btn-like btn-outline" onclick="f_clickLikeBtn"> 👍 좋아요 </a>
									<a id="" href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" 
										class="btn gap-2 btn-sm btn-hate btn-outline"> 👎 싫어요 </a>
								</div>
							</c:if>

							<!-- 싫어요를 누르고싶다면 좋아요를 취소 해! -->
							<c:if test="${actorCanDelGoodRp }">
						 		<div class="btns my-3 flex justify-center">
									<!-- 추천 버튼 -->
									<a id="" href="/usr/reactionPoint/doDeleteGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" 
										class="btn gap-2 btn-sm mx-2 btn-like btn-warning"> 👍 좋아요 </a>
									<a onclick="alert(this.title); return false;" title="싫어요를 누르고 싶다면 좋아요를 취소 해 주세요!" id="" href="#" 
										class="btn gap-2 btn-sm btn-hate btn-outline"> 👎 싫어요 </a>
								</div> 
						 	</c:if>

						 	<!-- 좋아요를 누르고싶다면 싫어요를 취소 해! -->
							<c:if test="${actorCanDelBadRp }">
							 	<div class="btns my-3 flex justify-center">
									<!-- 추천 버튼 -->
									<a onclick="alert(this.title); return false;" title="좋아요를 누르고 싶다면 싫어요를 취소 해 주세요!" id="" href="#" 
										class="btn gap-2 btn-sm mx-2 btn-like btn-outline"> 👍 좋아요 </a>
									<a href="/usr/reactionPoint/doDeleteBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}" 
										class="btn gap-2 btn-sm btn-hate btn-warning"> 👎 싫어요 </a>
								</div> 
						 	</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		


		<!-- 뒤로가기, 삭제 버튼 -->
		<div class="btns">
			<button type="button" onclick="history.back();">뒤로가기</button>
			<c:if test="${article.extra__actorCanModify }">
				<a class="btn-text-link" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.extra__actorCanDelete }">
				<a class="btn-text-link" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>


</body>
</html>