<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="비밀 번호 확인" />
<%@ include file="../common/head.jspf"%>

 <!-- 비밀번호 확인 시작 -->
    <section class="checkPW_section con">

        <div class="form_wrap">
            <div class="chechPw_form">
                <form class="pw_form" method="POST" action="../member/doCheckPw">
                    <input type="hidden" name="replaceUri" value="${param.replaceUri}" />
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
                                <input class="name-input" required="required" name="loginPw" type="password"
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