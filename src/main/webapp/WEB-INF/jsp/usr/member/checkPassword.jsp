<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀 번호 확인" />
<%@ include file="../common/head.jspf"%>

<script>
	// 유효성 검사
	  let MemberCheckPassword__submitDone = false;
	  
	  function MemberCheckPassword__submit(form) {
		  
	    if (MemberCheckPassword__submitDone) {
	      alert('처리중...');
	      return;
	    }
	    
	    form.loginPwInput.value = form.loginPwInput.value.trim();
	    
	    if (form.loginPwInput.value.length == 0) {
	        alert('비밀번호를 입력해주세요.');
	        form.loginPwInput.focus();
	        return;
	    }
	    
	    form.loginPw.value = sha256(form.loginPwInput.value);
	    form.loginPwInput.value = '';
	    
	    MemberCheckPassword__submitDone = true;
	    form.submit();
	  }
</script>


 <!-- 비밀번호 확인 시작 -->
    <section class="checkPW_section con">

        <div class="form_wrap">
            <div class="chechPw_form">
                <form class="pw_form" method="POST" action="../member/doCheckPw" onsubmit="MemberCheckPassword__submit(this); return false;">
                    <input type="hidden" name="replaceUri" value="${param.replaceUri}" />
                    <input type="hidden" name="loginPw">
                    
                    <div class="cPw-input">
                    
                        <div class="line">
                            <div class="loginId_box">
                                <div class="title">아이디</div>
                                <div class="id_name">${rq.loginedMember.loginId }</div>
                            </div>
                        </div>
                        
                        <div class="line line-2">
                            <label for="user-pw">비밀번호</label>
                            <div class="pw_input_box">
                                <input class="name-input" required="required" name="loginPwInput" type="password"
                                    placeholder="비밀번호를 입력해주세요" />
                            </div>
                        </div>
                        
                    </div>

                    <button class="c-btn" type="submit" value="비밀번호 확인">비밀번호 확인</button>

                </form>

                <!-- 뒤로가기 -->
                <div class="btn_box flex justify-end">
                    <button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
                </div>
            </div>
        </div>

    </section>

</body>
</html>