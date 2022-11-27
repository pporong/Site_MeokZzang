<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${board.name }" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl">
		<div class="container mx-auto px-3">
			<div>총 게시물 수 ${articlesCount } 개</div>
		<div class="table-box-type-1 overflow-x-auto">
			  <table class="table table-compact w-full">
					<colgroup>
						<col width="80" />
						<col width="140" />
						<col />
						<col width="140" />
					</colgroup>
					<thead>
						<tr class="text-indigo-700">
							<th>번호</th>
							<th>날짜</th>
							<th>제목</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles }">
							<tr>
								<td  class="text-green-600">${article.id}</td>
								<td>${article.regDate.substring(2,16)}</td>
								<td><a class="hover:underline" href="../article/detail?id=${article.id}">${article.title}</a></td>
								<td>${article.extra__writerName}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div class="page-menu flex justify-center">
				 	<div class="btn-group mx-0 my-10 grid grid-cols-2">
					 	<c:set var="pageMenuLen" value="6" />
						<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
						<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
						<c:if test="${startPage > 1}">
							<a class="btn btn-sm" href="?page=1&boardId=${boardId }">1</a>
							<c:if test="${startPage > 2}">
								<a class="btn btn-sm btn-disabled">...</a>
							</c:if>
						</c:if>
						<c:forEach begin="${startPage }" end="${endPage }" var="i">
							<a class="btn btn-sm ${page == i ? 'btn-active' : '' }" href="?page=${i }&boardId=${boardId }">${i }</a>
						</c:forEach>
						<c:if test="${endPage < pagesCount}">
							<c:if test="${endPage < pagesCount - 1}">
								<a class="btn btn-sm btn-disabled">...</a>
							</c:if>
							<a class="btn btn-sm" href="?page=${pagesCount }&boardId=${boardId }">${pagesCount }</a>
						</c:if>
					</div>
				</div>
				<div class="btn-box">
	
				</div>
			</div>
		</div>
</section>
</body>
</html>