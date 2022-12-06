<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../common/head.jspf"%>
<%@ page import="com.MeokZzang.recipe.util.Ut" %>
   <section class="myPage_section con">
        <div class="info_wrap mx-auto px-3">
            <div class="title">< 내 정보 상세보기 ></div>
            <table class="table w-full">
                <colgroup>
                    <col width="200" />
                </colgroup>

                <tbody>
                    <tr>
                        <th class="fc_blue">▶ 아이디 </th>
                        <td>${rq.loginedMember.loginId }</td>
                    </tr>
                    <tr>
                        <th class="fc_blue">▶ 가입 날짜</th>
                        <td>${rq.loginedMember.regDate }</td>
                    </tr>
                    <tr>
                        <th class="fc_blue">▶ 이름</th>
                        <td>${rq.loginedMember.name }</td>
                    </tr>
                    <tr>
                        <th class="fc_blue">▶ 닉네임</th>
                        <td>${rq.loginedMember.nickname }</td>
                    </tr>
                    <tr>
                        <th class="fc_blue">▶ 전화 번호</th>
                        <td>${rq.loginedMember.cellphoneNum }</td>
                    </tr>
                    <tr>
                        <th class="fc_blue">▶ 이메일</th>
                        <td>${rq.loginedMember.email }</td>
                    </tr>
                </tbody>
            </table>
            <div class="btn-box">
                <a href="../member/checkPassword?replaceUri=${Ut.getUriEncoded('../member/modifyMyInfo')}"
                    class="infoM_btn">회원 정보 수정</a>
            </div>
        </div>

        <div class="con mx-auto btns flex justify-end">
            <button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
        </div>
    </section>

</body>
</html>
