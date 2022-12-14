<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />
<%@ include file="../common/head.jspf"%>

<script>
	// 데이터 유효성 검사 스크립트

	let MemberJoin__submitDone = false;
	let validLoginId = "";
	let validNickname ="";
	
	function MemberJoin__submit(form) {
		
		if (MemberJoin__submitDone) {
			alert('처리중입니다');
			return;
		}
		if (MemberJoin__submitDone) {
			return;
		}
		
		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwConfirm.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			
			if (form.loginPwConfirm.value.length == 0) {
				alert('비밀번호 확인을 입력해주세요');
				form.loginPwConfirm.focus();
				return;
			}
			
			if (form.loginPwInput.value != form.loginPwConfirm.value) {
				alert('비밀번호가 일치하지 않습니다');
				form.loginPwInput.focus();
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
		
		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.loginPwConfirm.value = '';
		
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
	
	// 닉네임 중복체크
	const checkNicknameDupDebounced = _.debounce(checkNicknameDup, 300);
	
	function checkNicknameDup(el) {
		
		console.log('checkNicknameDup called : ' + ++callCount);
		console.log(el.value)
		
		const form = $(el).closest('form').get(0);
		
		if (form.nickname.value.length == 0) {
			nickname = '';
			return;
		}
		if (validNickname == form.nickname.value) {
			return;
		}
		
		$('.nicknameMsg').html('<div class="mt-2">확인중...</div>');
		
		$.get('../member/doCheckNickname', {
			isAjax : 'Y',
			nickname : form.nickname.value
		}, function(data) {
			$('.nicknameMsg').html('<div class="mt-2">' + data.msg + '</div>');
			$('.nicknameMsg, .inputNickname').addClass('has-fail');
			$('.nicknameMsg, .inputNickname').removeClass('has-success');
			
			if (data.success) {
				validLoginId = data.data1;
				$('.nicknameMsg, .inputNickname').addClass('has-success');
				$('.nicknameMsg, .inputNickname').removeClass('has-fail');
				
			} else {
				validNickname = '';
			} if (data.resultCode == 'F-B'){
				alert(data.msg);
				location.replace('/');
			}
		}, 'json');
	}

</script>

    <!-- 회원가입 시작 -->
    <section class="memberJoin_section">
        <div class="form_wrap">
            <div class="memberJoin_form">
                <form class="members_form" method="POST" enctype="multipart/form-data" action="../member/doJoin"
                    onsubmit="MemberJoin__submit(this); return false;">
                    <input type="hidden" name="afterJoinUri" value="${param.afterJoinUri}" />
       				<input type="hidden" name="loginPw">
                    <div class="memberJoin-input">
                        <div class="line flex">
                            <label for="user-loginId">▶ 아이디</label>
                            <div class="id_input-box input-box">
                                <input class="id-input" name="loginId" type="text" placeholder="아이디를 입력 해 주세요."
                                    onkeyup="checkLoginIdDupDebounced(this);" autocomplete="off" />
                            </div>
                            <div class="loginIdMsg"></div>
                        </div>

                        <div class="line line-2 flex">
                            <label for="user-loginPw">▶ 비밀번호</label>
                            <div class="pw_input-box input-box">
                                <input class="pw-input" name="loginPwInput" type="password" placeholder="비밀번호를 입력해주세요" />
                            </div>
                        </div>

                        <div class="line line-2 flex">
                            <label for="user-loginPw user-loginPwConfirm">▶ 비밀번호 확인</label>
                            <div class="pw_input-box input-box">
                                <input class="pw-input" name="loginPwConfirm" type="password"
                                    placeholder="비밀번호를 다시 한 번 입력해주세요" />
                            </div>
                        </div>

                        <div class="line line-2 flex">
                            <label for="user-name">▶ 이름</label>
                            <div class="name_input-box input-box">
                                <input class="name-input" name="name" type="text" placeholder="이름을 입력해주세요" />
                            </div>
                        </div>
                                                
                        <div class="line line-2 flex">
                            <label for="user-nickname">▶ 닉네임</label>
                            <div class="nickname_input-box input-box">
                                <input class="nickname-input" name="nickname" autocomplete="off" type="text" placeholder="닉네임을 입력해주세요" 
                                onkeyup="checkNicknameDupDebounced(this);" />
                            </div>
                            <div class="nicknameMsg"></div>
                        </div>

                        <div class="line line-2 flex">
                            <label for="user-cellphoneNum">▶ 전화번호</label>
                            <div class="cellphoneNum_input-box input-box">
                                <input class="cellphoneNum-input" name="cellphoneNum" type="text"
                                    placeholder="전화번호를 입력해주세요" />
                            </div>
                        </div>

                        <div class="line line-2 flex">
                            <label for="user-email">▶ 이메일</label>
                            <div class="email_input-box input-box">
                                <input class="email-input" name="email" autocomplete="off" type="text" placeholder="이메일을 입력해주세요" />
                            </div>
                        </div>
                        
                        <div class="line line-2 flex">
                            <label for="user-profileImg">▶ 프로필 이미지</label>
                            <div class="img_input-box ">
                                <input class="img-input mt-3 fc_redH" accept="image/*" name="file__member__0__extra__profileImg__1" type="file" />
                            </div>
                        </div>
                        
					</div>
					
                    <button class="j-btn" type="submit" value="회원가입">회원가입</button>

                </form>

                <!-- 뒤로가기 버튼 -->
                <div class="find-btn ">
                    <button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
                </div>
            </div>
        </div>
    </section>

</body>
</html>