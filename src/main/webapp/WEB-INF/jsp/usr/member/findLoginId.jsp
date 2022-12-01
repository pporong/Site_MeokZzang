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

<section class="findLoginId_section">
		
	<div class="form_wrap">
		<div class="find_loginId_form">
			<form class="members_form" method="POST" action="../member/goFindLoginId" onsubmit="MemberFindLoginId__submit(this) ; return false;">
			<input type="hidden" name="afterFindLoginIdUri" value="${param.afterFindLoginIdUri}" />
				<div class="findLoginId-input">
					<div class="line">
						<label for="user-name">이름</label>
						<div class="name_input-box">
							<input class="name-input" name="name" type="text" placeholder="이름을 입력해주세요" />
						</div>
					</div>
					<div class="line line-2">
						<label for="user-email">이메일</label>
						<div class="email_input-box">
							<input class="email-input" name="email" type="text" placeholder="이메일을 입력해주세요" />
						</div>
					</div>
				</div>
				
				<button class="f-btn" type="submit" value="아이디 찾기">아이디 찾기</button>
				
				</form>
				
			<!-- 찾기 버튼 + 뒤로가기 -->
			<div class="find-btn">
				<a href="${rq.findLoginPwUri }" class="" type="submit">비밀번호 찾기</a>
				<span class="l-bar"></span>
				<button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
			</div>
		</div>
	</div>
	
</section>

</body>
</html>