<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 탈퇴" />
<%@ include file="../common/head.jspf"%>
<%@ page import="com.MeokZzang.recipe.util.Ut" %>

 <section class="deleteMyInfoSection con">
        <div class="info_wrap mx-auto px-3">
            <div class="title">
                < 회원 탈퇴하기>
            </div>
            <table class="table w-full">
                <colgroup>
                    <col width="150" />
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
                        <th class="fc_red"></th>
                        <td class="fc_red"></td>
                    </tr>
                    <tr>
                        <th class="fc_red"><i class="fa-solid fa-bell"></i> 안내 1</th>
                        <td>탈퇴 시 본 계정으로는 더 이상 활동이 불가능 합니다.</td>
                    </tr>
                    <tr>
                        <th class="fc_red"><i class="fa-solid fa-bell"></i> 안내 2</th>
                        <td>등록하신 글 및 댓글 등은 탈퇴 후에도 삭제 되지 않습니다.</td>
                    </tr>
                    <tr>
                        <th class="fc_red"><i class="fa-solid fa-bell"></i> 안내 3</th>
                        <td>탈퇴를 원하시면 아래 <span style="font-weight: bold;">회원탈퇴</span> 버튼을 눌러 주세요.</td>
                    </tr>
                </tbody>
            </table>
            <div class="btn-box">
                <button class="dmBtn" type="submit" onclick="if(confirm('정말 탈퇴 하시겠습니까?') == false) return false;"
                    value="회원 탈퇴">회원 탈퇴</button>
            </div>

            <div class="con mx-auto btns flex justify-end">
                <button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>
            </div>
        </div>
    </section>

</body>
</html>
