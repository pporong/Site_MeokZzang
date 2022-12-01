<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="로그인" />
<%@ include file="../common/head.jspf"%>

<section class="login_section">
		
	<div class="login_form_wrap">
		<div class="login-form">
			<form class="members_form" method="POST" action="../member/doLogin">
				<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri}" />
				<div class="login-input">
					<div class="line">
						<label for="user-loginId">아이디</label>
						<div class="id_input-box">
							<input class="id-input" name="loginId" type="text" placeholder="아이디를 입력해주세요" />
						</div>
					</div>
					<div class="line line-2">
						<label for="user-loginPw">비밀번호</label>
						<div class="pw_input-box">
							<input class="pw-input" name="loginPw" type="password" placeholder="비밀번호를 입력해주세요" />
						</div>
					</div>
				</div>
				
				<button class="l-btn" type="submit" value="로그인">로그인</button>
				
				</form>
				
			<!-- 찾기 버튼 -->
			<div class="find-btn">
				<a href="${rq.findLoginIdUri }" class="" type="submit">아이디 찾기</a>
				<span class="l-bar"></span>
				<a href="${rq.findLoginPwUri }" class="" type="submit">비밀번호 찾기</a>
			</div>
		</div>
	</div>
	
</section>



</body>
</html>
