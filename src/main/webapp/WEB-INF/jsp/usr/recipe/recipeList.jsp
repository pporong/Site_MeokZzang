<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 게시판" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl con">
	<div class="container mx-auto px-3">
		<div class="list_nav flex justify-between mt-4 my-2">
		
		<!-- 검색 박스 -->
		<div> 레시피 갯수 : <span class="badge"> ${recipiesCount } 개</span></div>
			<div class="search-box">
				<form name="search">
					<table class="pull-right">
						<tr>
							<td>
								<select class="text-center" name="recipeCategory" data-value="${param.recipeCategory}">
									<option value="0" selected="${param.recipeCategory}"> 카테고리 선택 </option>
									<option value="1">한식</option>
									<option value="2">양식</option>
									<option value="3">중식</option>
									<option value="4">일식</option>
									<option value="5">기타</option>
								</select>
							</td>
						
							<td>
							<select class="text-center" name="searchKeywordTypeCode" data-value="${param.searchKeywordTypeCode}">
									<option value="disabled">검색 선택</option>
									<option value="recipeName">레시피 이름</option>
									<option value="recipeStuff">레시피 재료</option>
									<option value="recipeName,recipeName">이름 + 재료</option>
								</select>
							</td>
							<td><input class="text-center" type="text" placeholder="검색어 입력" name="searchKeyword" maxlength="30" value="${param.searchKeyword}"></td>
							<td><button type="submit" class="btn btn-active btn-sm">검색</button></td>
						</tr>
					</table>
				</form>	
			</div>
		</div>
		
		<!-- recipe list body -->
		<div class="table-box-type-1 overflow-x-auto">
			<table class="table table-compact w-full">
				<colgroup>
					<col width="5%" />
					<col width="20%" />
					<col width="20%" />
					<col width="40%" />
					<col width="10%" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
					<tr class="text-indigo-700">
						<th>번호</th>
						<th>레시피 이미지</th>
						<th>날짜</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>스크랩수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="recipe" items="${recipies }">
						<input type="hidden" value="${recipe.recipeId}"/>
						<tr class="hover">
							<td>${recipe.recipeId}</td>
							<td>
								<a class="hover:underline" href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">
									<img src="${rq.getMainRecipeImgUri(recipe.recipeId)}" alt="레시피 사진" />
								</a>
							</td>
							<td>${recipe.forPrintType1RegDate}</td>
							<td>
								<a class="hover:underline" href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">${recipe.recipeName}</a>
							</td>
							<td>${recipe.extra__writerName}</td>
							<td>
								<span class="article-detail__hit-count">${recipe.recipeHitCount }</span>
							</td>
							<td>${recipe.recipePoint}</td>
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
						
					<c:set var="pageBaseUri" value="?recipeCategory=${recipeCategory }" />
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