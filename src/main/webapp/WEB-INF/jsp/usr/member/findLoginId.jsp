<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="아이디 찾기" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberFindLoginId__submitDone = false;
	function MemberFindLoginId__submit(form) {
		if (MemberFindLoginId__submitDone) {
			alert('처리중입니다');
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		MemberFindLoginId__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl ">
	<div class="container mx-auto px-3 ">
		<form class="" method="POST" action="../member/goFindLoginId"
		 onsubmit="MemberFindLoginId__submit(this) ; return false;">
		<input type="hidden" name="afterFindLoginIdUri" value="${param.afterFindLoginIdUri}" />
			<div class="">
				<table class="table table-compact w-full">
					<colgroup>
						<col width="200" />
					</colgroup>

					<tbody>
						<tr class="hover">
							<th>▶ 이름</th>
							<td><input class="w-96" name="name" type="text" placeholder="이름을 입력해주세요" /></td>
						</tr>
						<tr class="hover">
							<th>▶ 이메일</th>
							<td><input class="w-96" name="email" type="text" placeholder="이메일을 입력해주세요" /></td>
						</tr>
						<tr class="">
							<th></th>
							<td><button class="btn btn-ghost btn-sm btn-outline" type="submit" >아이디 찾기</button></td>
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