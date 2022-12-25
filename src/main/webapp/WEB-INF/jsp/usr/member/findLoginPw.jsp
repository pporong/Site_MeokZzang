<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀번호 찾기" />
<%@ include file="../common/head.jspf"%>


<script>
	let MemberFindLoginPw__submitDone  = false;
	function MemberFindLoginPw__submit(form) {
		if (MemberFindLoginPw__submitDone ) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요');
			form.loginId.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요');
			form.email.focus();
			return;
		}
		MemberFindLoginPw__submitDone = true;
		form.submit();
	}
</script>

<section class="findLoginPw_section">
		
	<div class="form_wrap">
		<div class="find_loginPw_form">
		<form class="members_form" method="POST" action="../member/goFindLoginPw" onsubmit="MemberFindLoginPw__submit(this) ; return false;">
		<input type="hidden" name="afterFindLoginPwUri" value="${param.afterFindLoginPwUri}" />
			<div class="findLoginPw-input">
					<div class="line">
						<label for="user-loginId">아이디</label>
						<div class="id_input-box">
							<input class="id-input" name="loginId" type="text" placeholder="아이디를 입력해주세요" />
						</div>
					</div>
					<div class="line line-2">
						<label for="user-email">이메일</label>
						<div class="email_input-box">
							<input class="email-input" name="email" type="text" placeholder="이메일을 입력해주세요" />
						</div>
					</div>
				</div>
				
				<button class="f-btn" type="submit" value="비밀번호 찾기">비밀번호 찾기</button>
				
				</form>
				
			<!-- 찾기 버튼 + 뒤로가기 -->
			<div class="find-btn">
				<a href="${rq.findLoginIdUri }" class="" type="submit">아이디 찾기</a>
				<span class="l-bar"></span>
				<button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
</section>

</body>
</html>