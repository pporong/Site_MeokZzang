<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name }" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl con">
	<div class="container mx-auto px-3">
		<div class="list_nav flex justify-between mt-4 my-2">
		<!-- 검색 박스 -->
		<div> 게시물 갯수 : <span class="badge"> ${articlesCount } 개</span></div>
			<div class="search-box">
				<form method="get" name="search" action="../article/list?boardId=${boardId }
					&searchKeywordTypeCode=${searchKeywordTypeCode}&searchKeyword=${searchKeyword}">
					<table class="pull-right">
						<tr>
							<td>
								<select class="text-center" name="boardId" data-value="${param.boardId}">
									<option value="1" selected="${param.boardId}"> 게시판 선택 </option>
									<option value="1">공 지 사 항</option>
									<option value="2">자 유 게 시 판</option>
									<option value="3">질 문 게 시 판</option>
								</select>
							</td>
							<td>
							<select class="text-center" name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode}">
									<option value="disabled">검색 선택</option>
									<option value="title">제목</option>
									<option value="body">내용</option>
									<option value="title,body">제목 + 내용</option>
								</select>
							</td>
							<td><input class="text-center" type="text" placeholder="검색어 입력" name="searchKeyword" maxlength="30" value="${param.searchKeyword}"></td>
							<td><button type="submit" class="btn btn-active btn-sm">검색</button></td>
						</tr>
					</table>
				</form>	
			</div>
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
								<a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article) }">${article.title}</a>
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
			
			<!-- 페이징 -->
		 	<div class="page-menu flex justify-center">
			 	<div class="btn-group mx-0 my-10 grid grid-cols-2">
					<c:set var="pageMenuLen" value="6" />
					<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
					<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
						
					<c:set var="pageBaseUri" value="?boardId=${boardId }" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
					<c:set var="pageBaseUri" value="${pageBaseUri }&searchKeyword=${param.searchKeyword}" />
						
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