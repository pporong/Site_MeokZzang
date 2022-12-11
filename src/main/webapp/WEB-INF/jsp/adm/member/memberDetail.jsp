<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 글 목록" />
<%@ include file="../common/head.jspf"%>


<section class="mt-8 text-xl con">
	<div class="container mx-auto px-3">
		<div class="list_nav flex justify-between mt-4 my-2">
		<!-- 검색 박스 -->
			<div> 게시물 갯수 : <span class="badge"> ${articlesCount } 개</span></div>
		</div>
		
		<!-- list body -->
		<div class="table-box-type-1 overflow-x-auto">
			<table class="table table-compact w-full">
				<colgroup>
					<col width="10%" />
					<col width="20%" />
					<col width="40%" />
					<col width="10%" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
					<tr class="text-indigo-700">
						<th>번호</th>
						<th>날짜</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>추천수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles }">
						<tr class="hover">
							<td>${article.id}</td>
							<td>${article.forPrintType1RegDate}</td>
							<td>
								<a class="hover:underline fc_redH" href="../../usr/article/detail?id=${article.id}">${article.title}</a>
							</td>
							<td>${article.extra__writerName}</td>
							<td>
								<span class="article-detail__hit-count">${article.hitCount }</span>
							</td>
							<td>${article.goodReactionPoint}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<div class="btn-box flex justify-end mt-4">
                    <button class="back_btn fc_redH" type="button" onclick="history.back();">뒤로가기</button>
      		</div>
			
			<!-- 페이징 -->
		 	<div class="page-menu flex justify-center">
			 	<div class="btn-group mx-0 my-10 grid grid-cols-2">
					
				<c:set var="pageMenuLen" value="6" />
				<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
				<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
				
				<c:set var="pageBaseUri" value="?id=${rq.getLoginedMemberId()}" />
				
				
				<c:if test="${startPage > 1}">
					<a class="btn btn-sm" href="${pageBaseUri }&page=1">1</a>
					<c:if test="${startPage > 2}">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
				</c:if>
				<c:forEach begin="${startPage }" end="${endPage }" var="i">
					<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="${pageBaseUri }&page=${i }">${i }</a>
				</c:forEach>
				<c:if test="${endPage < pagesCount}">
					<c:if test="${endPage < pagesCount - 1}">
						<a class="btn btn-sm btn-disabled">...</a>
					</c:if>
					<a class="btn btn-sm" href="${pageBaseUri }&page=${pagesCount }">${pagesCount }</a>
				</c:if>
				</div>
			</div>
			
		</div>
	</div>
</section>

</body>
</html>