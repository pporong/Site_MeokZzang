<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
			 <table class="table table-compact w-full">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th class=>▶ 아이디 </th>
						<td>${rq.loginedMember.loginId }</td>
					</tr>
					<tr>
						<th class="">▶ 가입 날짜</th>
						<td>${rq.loginedMember.regDate }</td>
					</tr>
					<tr>
						<th class="">▶ 이름</th>
						<td>${rq.loginedMember.name }</td>
					</tr>
					<tr>
						<th class="">▶ 닉네임</th>
						<td>${rq.loginedMember.nickname }</td>
					</tr>
					<tr>
						<th class="">▶ 전화 번호</th>
						<td>${rq.loginedMember.cellphoneNum }</td>
					</tr>
					<tr>
						<th class="">▶ 이메일</th>
						<td>${rq.loginedMember.email }</td>
					</tr>
					<tr>
						<th></th>
						<td><a href="../member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modify') }" 
							class="btn btn-outline btn-ghost btn-sm">회원 정보 수정</a>
						</td>
					</tr>
				</tbody>
			</table>
	</div>

	<div class="container mx-auto btns flex justify-end">
		<button class="btn-text-link btn btn-outline btn-sm"" type="button" onclick="history.back();">뒤로가기</button>
	</div>
</section>

</body>
</html>
