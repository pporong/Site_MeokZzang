<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 정보 수정" />
<%@ include file="../common/head.jspf"%>

<script>

	let MemberModify__submitDone = false;
	function MemberModify__submit(form) {
		
		if (MemberModify__submitDone) {
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
		 
		// 프로필 이미지 용량 제한
		const maxSizeMb = 10;
		const maxSize = maxSizeMb * 1204 * 1204;
		
		const profileImgFileInput = form["file__member__0__extra__profileImg__1"];
		
		if( profileImgFileInput.value ) {
			if ( profileImgFileInput.files[0].size > maxSize ) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				profileImgFileInput.focus();
				
				return;
			}
		}
		
		if ( form.newLoginPw.value.lenth > 0 ) {
			form.loginPw.value = sha256(form.newLoginPw.value);
			form.newLoginPw.value = '';
			form.loginPwConfirm.value = '';
		}
		
		MemberModify__submitDone = true;
		form.submit();
	}
	
</script>


<!-- 내 정보 수정 시작 -->
<section class="modifyInfo_section text-xl con">
    <div class="menual">
       ** ▷ : 수정 가능 / ▶ : 수정 불가능
    </div>
	<div class="container mx-auto px-3">
		<form class="modifyMyInfo_form" method="POST" enctype="multipart/form-data" action="../member/doModifyMyInfo" onsubmit="MemberModify__submit(this); return false;">
		<input type="hidden" name="memberModifyAuthKey" value="${param.memberModifyAuthKey }" />
			 <table class="table table-compact w-full center-box">
				<colgroup>
					<col width="200" />
				</colgroup>

				<tbody>
					<tr>
						<th class=>▶ 아이디 </th>
						<td>${rq.loginedMember.loginId }</td>
					</tr>

					<tr>
						<th class="">▶  비밀번호 변경 </th>
					</tr>
					<tr>
						<th class="text-red-600">▷ 새 비밀번호 </th>
						<td><input class="w-96" name="loginPw" type="password" placeholder="새로운 비밀번호를 입력해주세요" /></td>
					</tr>
					<tr>
						<th class="text-red-600">▷ 새 비밀번호 확인</th>
						<td><input class="w-96" name="loginPwConfirm" type="password" placeholder="새로운 비밀번호를 다시 한 번 입력해주세요" /></td>
					</tr> 
					<tr>
						<th class="">▶ 가입 날짜 </th>
						<td>${rq.loginedMember.regDate }</td>
					</tr>
					<tr>
						<th class="">▶ 이름 </th>
						<td>${rq.loginedMember.name }</td>
					</tr>
					<tr>
					<th class="text-green-600">▷ 닉네임 </th>
						<td><input value="${rq.loginedMember.nickname }" class="w-96" name="nickname" type="text" placeholder="닉네임을 입력해주세요" /></td>
					</tr>
					<tr>
						<th class="text-green-600">▷ 전화 번호 </th>
						<td><input value="${rq.loginedMember.cellphoneNum }" class="w-96" name="cellphoneNum" type="text" placeholder="전화번호를 입력해주세요" /></td>
					</tr>
					<tr>
						<th class="text-green-600">▷ 이메일</th>
						<td><input value="${rq.loginedMember.email }" class="w-96" name="email" type="text" placeholder="이메일을 입력해주세요" /></td>
					</tr>
					<tr>
						<th class="text-green-600">▷ 프로필 이미지</th>
						<td>
							<img id="preview-profileImg" class="" src="${rq.getProfileImgUri(rq.loginedMember.id)}" onerror="${rq.profileFallbackImgOnErrorHtml}" 
							style="width:200px; height: 200px; border-radius: 50%;" alt="프로필 사진" />
							<input id="input-profileImg" class="img-input mt-3 fc_redH" accept="image/*" name="file__member__0__extra__profileImg__1" type="file" />
						</td>
					</tr>

					<tr class="">
						<th></th>
						<td class="">
							<button class="m-btn" 
							onclick="if(confirm('변경 내용이 정확합니까?') == false) return false;" 
							type="submit" value="회원 정보 수정">회원 정보 수정 완료</button>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="con btn_box mx-auto btns flex justify-end">
				<button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</form>
	</div>
</section>


</body>
</html>