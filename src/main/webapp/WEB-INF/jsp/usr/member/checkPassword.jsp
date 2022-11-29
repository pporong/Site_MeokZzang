<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀 번호 확인" />
<%@ include file="../common/head.jspf"%>

<section class="mt-8 text-xl ">
	<div class="container mx-auto px-3 ">
		<form class="" method="POST" action="../member/doCheckPw">
		<input type="hidden" name="replaceUri" value="${param.replaceUri}"/>
			<div class="">
				<table class="table table-compact w-full">
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr>
							<th>▶ 아이디 </th>
							<td>${rq.loginedMember.loginId }</td>
						</tr>
						<tr>
							<th>▶ 비밀번호 확인</th>
							<td>
								<input name="loginPw" required="required" placeholder="비밀번호를 입력해주세요"/>
							</td>	
						</tr>
						<tr>
							<th></th>
							<td><button class="btn btn-ghost btn-sm btn-outline" type="submit" value="비밀번호 확인">비밀번호 확인</button></td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>

	<div class="container mx-auto btns flex justify-end">
		<button class="btn-text-link btn btn-outline btn-sm" type="button" onclick="history.back();">뒤로가기</button>
	</div>
</section>

</body>
</html>