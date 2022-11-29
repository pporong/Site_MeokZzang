<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />
<%@ include file="../common/head.jspf"%>

<script>
	let MemberJoin__submitDone = false;
	let validLoginId = "";
	
	function MemberJoin__submit(form) {
		
		if (MemberJoin__submitDone) {
			alert('처리중입니다');
			return;
		}
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
		if (form.loginId.value != validLoginId) {
			alert('!! 사용할 수 없는 아이디입니다. !!');
			form.loginId.focus();
			return;
		}
		
		let validLoginId = "";
		
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
	
	let callCount = 0;
	// lodash debounced 활용하여 loginId 중복체크시 일정시간(1초) 뒤에 한번만 실행할 수 있도록
	// 너무 많은 함수가 전달되지 않도록 조절
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 300);
	
	function checkLoginIdDup(el) {
		
		console.log('checkLoginIdDup called : ' + ++callCount);
		console.log(el.value)
		
		const form = $(el).closest('form').get(0);
		
		if (form.loginId.value.length == 0) {
			validLoginId = '';
			return;
		}
		if (validLoginId == form.loginId.value) {
			return;
		}
		
		$('.loginIdMsg').html('<div class="mt-2">확인중...</div>');
		
		$.get('../member/doCheckLoginId', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {
			$('.loginIdMsg').html('<div class="mt-2">' + data.msg + '</div>');
			$('.loginIdMsg, .inputLoginId').addClass('has-fail');
			$('.loginIdMsg, .inputLoginId').removeClass('has-success');
			
			if (data.success) {
				validLoginId = data.data1;
				$('.loginIdMsg, .inputLoginId').addClass('has-success');
				$('.loginIdMsg, .inputLoginId').removeClass('has-fail');
				
			} else {
				validLoginId = '';
			} if (data.resultCode == 'F-B'){
				alert(data.msg);
				location.replace('/');
			}
		}, 'json');
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
						<td>
							<input class="w-96 inputLoginId" name="loginId" type="text" placeholder="아이디를 입력 해 주세요." onkeyup="checkLoginIdDupDebounced(this);" autocomplete="off"/>
							<div class="loginIdMsg"></div>
						</td>
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
							<button class="btn btn-ghost btn-sm btn-outline" type="submit">회원 가입</button>
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