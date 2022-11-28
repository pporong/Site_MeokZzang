<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberJoin__submitDone = false;
	function MemberJoin__submit(form) {
		
		if (MemberJoin__submitDone) {
			return;
		}
		
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPwConfirm.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요');
				form.loginPwConfirm.focus();
				return;
			}
			
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPw.focus();
				return;
			}
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length == 0) {
			alert('비밀번호를 입력해주세요');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요');
			form.name.focus();
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length == 0) {
			alert('닉네임을 입력해주세요');
			form.nickname.focus();
			return;
		}
		
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value.length == 0) {
			alert('전화번호를 입력해주세요');
			form.cellphoneNum.focus();
			return;
		}
		
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		 
		MemberJoin__submitDone = true;
		form.submit();
	}
</script>

<section class="mt-8 text-xl">
	<div class="container mx-auto px-3">
		<form class="" method="POST" action="../member/doJoin" onsubmit="MemberJoin__submit(this); return false;">
			 <table class="table table-compact w-full center-box">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr class="hover">
						<th>▶ 아이디 </th>
						<td><input class="w-96" name="loginId" type="text" placeholder="아이디를 입력 해 주세요." /></td>
					</tr>

					<tr class="hover">
						<th class="">▶ 비밀번호 </th>
						<td><input class="w-96" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요" /></td>
					</tr>
					<tr class="hover">
						<th class="">▶ 비밀번호 확인 </th>
						<td><input class="w-96" name="loginPwConfirm" type="password" placeholder="비밀번호를 다시 한 번 입력해주세요" /></td>
					</tr> 
					<tr class="hover">
						<th class="">▶ 이름 </th>
						<td><input class="w-96" name="name" type="text" placeholder="이름을 입력 해 주세요." /></td>
					</tr>
					<tr class="hover">
						<th class="">▶ 닉네임 </th>
						<td><input class="w-96" name="nickname" type="text" placeholder="닉네임을 입력해주세요" /></td>
					</tr>
					<tr class="hover">
						<th class="">▶ 전화 번호 </th>
						<td><input class="w-96" name="cellphoneNum" type="text" placeholder="전화번호를 입력해주세요" /></td>
					</tr>
					<tr class="hover">
						<th class="">▶ 이메일 </th>
						<td><input class="w-96" name="email" type="text" placeholder="이메일을 입력해주세요" /></td>
					</tr>

					<tr class="">
						<th></th>
						<td class="">
							<button class="btn btn-ghost btn-sm btn-outline" 
							onclick="if(confirm('입력 내용이 정확합니까?') == false) return false;" 
							type="submit" value="회원 가입">회원 가입</button>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="container mx-auto btns flex justify-end">
				<button class="btn-text-link btn btn-outline btn-sm" type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>

</body>
</html>