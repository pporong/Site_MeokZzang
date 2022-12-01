<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 목록" />
<%@ include file="../common/head.jspf"%>


<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<div class="list_nav flex justify-between">
			<div class="flex">
				<div> 회원 수 : <span class="badge"> ${membersCount } 명</span></div>
				<div class="flex-grow"></div>
			</div>
			
			<!-- 검색 박스 -->
			<div class="search-box">
				<form name="search">
					<table class="">
						<tr>							
							<td>
								<select class="text-center" name="authLevel" data-value="${authLevel}">
									<option value="0">검색 타입</option>
									<option value="3">일 반 회 원</option>
									<option value="7">관 리 자</option>
	 								<option value="0">전 체 회 원</option>
								</select>
							</td>
							<td>
 							    <select data-value="${param.searchKeywordTypeCode}" name="searchKeywordTypeCode" class="text-center">
							        <option disabled="disabled">검색 타입</option>
									<option value="loginId">아이디</option>
									<option value="name">이름</option>
									<option value="nickname">닉네임</option>
									<option value="loginId,name,nickname">전부 포함</option>
      							</select> 
							</td>
							
								<td><input class="text-center" type="text" placeholder="검색어 입력" name="searchKeyword" maxlength="30" value="${param.searchKeyword}"></td>
								<td><button type="submit" class="btn btn-sm">검색</button></td>

						</tr>
					</table>
				</form>	
			</div>
		</div>
		
		<!-- 회원 리스트 -->
		<div class="table-box-type-1 overflow-x-auto">
			<table class="table table-compact w-full">
				<colgroup>
					<col width="50" />
					<col width="130" />
					<col width="130" />
					<col width="80" />
					<col width="50" />
					<col width="80" />
					<col width="80" />
				</colgroup>
				<thead>
					<tr class="text-indigo-700">
						<th>번호</th>
						<th>가입 날짜</th>
						<th>갱신 날짜</th>
						<th>아이디</th>
						<th>분류번호 <br />(3: 일반 / 7 : 관리자)</th>
						<th>이름</th>
						<th>닉네임</th>
					</tr>
				</thead>
	
				<tbody>
					<c:forEach var="member" items="${members}">
					<tr class="hover">
						<td class="text-green-600">${member.id}</td>
						<td>${member.forPrintType1RegDate}</td>
						<td>${member.forPrintType1updateDate}</td>
						<td>${member.loginId}</td>
						<td class="">${member.authLevel}</td>
						<td>${member.name}</td>
						<td>${member.nickname}</td>
						<tr>
					</c:forEach>
				</tbody>
			</table>
				
			<!-- 게시물 페이징 -->	
	 		<div class="page-menu flex justify-center">
		 		<div class="btn-group mx-0 my-10 grid grid-cols-2">
					<c:set var="pageMenuLen" value="6" />
					<c:set var="startPage" value="${page - pageMenuLen >= 1 ? page- pageMenuLen : 1}" />
					<c:set var="endPage" value="${page + pageMenuLen <= pagesCount ? page + pageMenuLen : pagesCount}" />
					
					<c:set var="pageBaseUri" value="?authLevel=${authLevel }" />
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