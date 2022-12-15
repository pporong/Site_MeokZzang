<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시글 상세보기" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiLib.jspf"%>

<!-- 조회수 function -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
</script>

<script>
	function ArticleDetail__increaseHitCount(){
		const localStorageKey = 'airtlce__' + params.id + '__alreadyView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		localStorage.setItem(localStorageKey, true);
		
		$.get('../article/doIncreaseHitCountRd?', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		ArticleDetail__increaseHitCount();
	});
	
</script>

<!-- 댓글 function -->
<script>
	// 댓글 중복 submit 방지
	let ReplyWrite__submitFormDone = false;
	
	function ReplyWrite__submitForm(form) {
		
		if (ReplyWrite__submitFormDone) {
			return;
		}
		
		form.body.value = form.body.value.trim();
		if (form.body.value.length < 2) {
			alert('2글자 이상 입력해주세요');
			form.body.focus();
			return;
		}
		
		ReplyWrite__submitFormDone = true;
		form.submit();
	}
	
</script>

<script>
// 댓추
/* function replyRecomm(){

	console.log($('#replyId').find('input:eq(0)').val())
	var params = {
		
	}
	
	$.get('/usr/reactionPoint/doGoodReactionReply?', {
		id : $('#replyId').find('input:eq(0)').val(),
		relTypeCode : 'reply',
		replaceUri : $('#replyId').find('input:eq(1)').val() ,
		ajaxMode : 'Y'
	}, function(data) {
		console.log(data)
	}, 'json');
	
	 
}

$(document).on('click', '#replyId', function(){
	replyRecomm();
}) */
</script>

<!-- 게시글 상세보기 시작 -->
<section class="article_detail_section text-xl con">
    <div class="article_wrap mx-auto">
        <div class="article_header">
            <div class="articleTitle">
                <div class="boardName">
                    <c:choose>
                        <c:when test="${article.boardId == '1'}">
                            <td class=""> > 공지사항</td>
                        </c:when>
                        <c:when test="${article.boardId == '2'}">
                            <td class=""> > 자유게시판</td>
                        </c:when>
                        <c:otherwise>
                            <td class=""> > 레시피 게시판</td>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="titleName">
                    <h3 class="">${article.title }</h3>

                </div>
            </div>
            <div class="writerInfo row cell">
                <div class="profile_img cell">
                    <img src="${rq.getProfileImgUri(article.memberId)}"  onerror="${rq.profileFallbackImgOnErrorHtml}" alt="프로필 이미지">
                </div>

                <div class="profileArea cell">
                    <div class="profileInfo">
                        <div class="profileNick">${article.extra__writerName }</div>
                    </div>
                    <div class="articleInfo">
                        <span class="date">
                            ${article.getForPrintType1RegDate() } /
                        </span>
                        <span class="hitCount article-detail__hit-count">
                            조회 ${article.hitCount }
                        </span>
                    </div>
                </div>
            </div>

            <div class="articleTool">
                <div class="likeNum row">
                    <span class="hate cell-r"> 싫어요 <div class="badge badge-sm"> ${article.badReactionPoint} </div></span>
                    <span class="like cell-r"> 좋아요 <div class="badge badge-secondary badge-sm"> ${article.goodReactionPoint} </div></span>
                </div>
            </div>
        </div>

        <div class="articleContainer">
            <div class="articleViewer">
                <div class="toast-ui-viewer">
                    <script type="text/x-template">${article.getForPrintBody()}</script>
                </div>
            </div>
        </div>

        <div class="reactionBox">
            <!-- 리액션 사용 가능? -->
            <c:if test="${actorCanMakeReaction }">
                <div class="reactionBtns flex justify-center">
                    <!-- 추천 버튼 -->
                    <a id="" href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                        class="btn_like btn_s" style="margin-right: 20px;"> 👍 좋아요 </a>
                    <a id=""
                        href="/usr/reactionPoint/doBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                        class="btn_hate btn_s"> 👎 싫어요 </a>
                </div>
            </c:if>

            <!-- 싫어요를 누르고싶다면 좋아요를 취소 해! -->
            <c:if test="${actorCanDelGoodRp }">
                <div class="reactionBtns flex justify-center">
                    <!-- 추천 버튼 -->
                    <a id="" href="/usr/reactionPoint/doDeleteGoodReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                        class="btn_s has-fail" style="margin-right: 20px;"> 👍 좋아요 </a>
                    <a onclick="alert(this.title); return false;" title="싫어요를 누르고 싶다면 좋아요를 취소 해 주세요!" id="" href="#"
                        class="btn_s"> 👎 싫어요 </a>
                </div>
            </c:if>

            <!-- 좋아요를 누르고싶다면 싫어요를 취소 해! -->
            <c:if test="${actorCanDelBadRp }">
                <div class="reactionBtns flex justify-center">
                    <!-- 추천 버튼 -->
                    <a onclick="alert(this.title); return false;" title="좋아요를 누르고 싶다면 싫어요를 취소 해 주세요!" id="" href="#" style="margin-right: 20px;"
                        class="btn_s"> 👍 좋아요 </a>
                    <a href="/usr/reactionPoint/doDeleteBadReaction?relTypeCode=article&relId=${param.id}&replaceUri=${rq.encodedCurrentUri}"
                        class="btn_s has-fail"> 👎 싫어요 </a>
                </div>
            </c:if>
        </div>

        <!-- -->
        <!-- 게시글 수정 삭제 버튼 -->
        <div class="btns flex justify-end my-3">
            <c:if test="${article.extra__actorCanModify }">
                <a class="mx-4 mBtn badge badge-outline badge-sm" href="../article/modify?id=${article.id }">수정</a>
            </c:if>
            <c:if test="${article.extra__actorCanDelete }">
                <a class="dBtn badge badge-outline badge-sm"
                    onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
                    href="../article/doDelete?id=${article.id }">삭제</a>
            </c:if>
        </div>

        <!-- 댓글 삭제 fun -->
        <script>
            function ReplyList_deleteReply(btn) {

                const $clicked = $(btn);
                const $target = $clicked.closest('[data-id]');
                const id = $target.attr('data-id');

                $clicked.html('삭제중..')


                $.post(
                    '../reply/doDeleteAjax', {
                        id: id
                    },
                    function (data) {
                        if (data.success) {
                            $target.remove();
                        } else {
                            if (data.msg) {
                                alert(data.msg);
                            }
                            $clicked.text('삭제 실패');
                        }
                    },
                    'json'
                );
            }
        </script>

        <!-- 댓글 목록 -->
        <div class="replyBox">
            <div class="replyTitle"> 댓글 목록 <span class="badge badge-outline badge-sm">${replies.size() }</span></div>
            <div class="overflow-x-auto">
                <table class="table table-compact w-full">
                    <colgroup align="center">
                        <col width="5%" />
                        <col width="20%" />
                        <col width="5%" />
                        <col width="50%" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="5%" />
                        <col width="5%" />
                    </colgroup>
                    <thead>
                        <tr class="replyHead text-center">
                            <th>번호</th>
                            <th class="">날짜</th>
                            <th class="">작성자</th>
                            <th class="">내용</th>
                            <th class="">추천수</th>
                            <th class="">수정</th>
                            <th class="">삭제</th>
                            <th class="">추천</th>

                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="reply" items="${replies }" varStatus="status">
                            <tr data-id="${reply.id }" class="hover text-center">
                                <td>${status.count}</td>
                                <td>${reply.getForPrintType1RegDate()}</td>
                                <td>${reply.extra__writerName}</td>
                                <td class="">${reply.getForPrintBody()}</td>
                                <td class="">${reply.goodReactionPoint }</td>

                                <td>
                                    <c:if test="${reply.extra__actorCanModify}">
                                        <a class="btn-text-link"
                                            href="../reply/modify?id=${reply.id }&replaceUri=${rq.encodedCurrentUri}">수정</a>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${reply.extra__actorCanDelete}">
                                        <a class="btn-text-link cursor-pointer"
                                            onclick="if(confirm('정말 삭제하시겠습니까?')) { ReplyList_deleteReply(this);} return false;">삭제</a>
                                    </c:if>
                                </td>

                                <td>
                                    <!-- 댓글 추천 기능 사용 가능? -->
                                    <c:if test="${actorCanMakeReactionReply }">
                                        <div class="btns my-3 flex justify-center">
                                            <!-- 댓추 -->
                                            <a id=""
                                                href="/usr/reactionPoint/doGoodReactionReply?relTypeCode=reply&relId=${reply.id}&replaceUri=${rq.encodedCurrentUri}"
                                                class="btn gap-2 btn-sm mx-2 btn-like btn-outline"> 🤍 </a>
                                        </div>
                                    </c:if>
                                    <!-- 댓추 취소 -->
                                    <c:if test="${actorCanDelGoodRpReply }">
                                        <div class="btns my-3 flex justify-center">
                                            <!-- 추천 버튼 -->
                                            <a id=""
                                                href="/usr/reactionPoint/doDeleteGoodReactionReply?relTypeCode=reply&relId=${reply.id}&replaceUri=${rq.encodedCurrentUri}"
                                                class="btn gap-2 btn-sm mx-2 btn-like btn-warning"> 💙 </a>
                                        </div>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                </table>
            </div>

            <!-- 댓글 작성 -->
            <div class="writeWrap mt-5 overflow-x-auto">
                <div class="replyWrite text-indigo-700">댓글 작성</div>
                <c:if test="${rq.logined }">
                    <form class="table-box-type-1 overflow-x-auto" method="POST" enctype="multipart/form-data" action="../reply/doWrite"
                        onsubmit="ReplyWrite__submitForm(this); return false;">
                        <input type="hidden" name="relTypeCode" value="reply" />
                        <input type="hidden" name="relId" value="${article.id }" />
                        <input type="hidden" name="replaceUri" value="${rq.currentUri }" />
                        <table class="table table-zebra w-full text-sm">
                            <colgroup>
                                <col width="100" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="text-indigo-700">작성자</th>
                                    <td>${rq.loginedMember.name }</td>
                                </tr>
                                <tr>
                                    <th class="text-indigo-700">내용</th>
                                    <td><textarea class="w-full input input-bordered" style="height: 100px;" name="body"
                                            placeholder="댓글을 입력해주세요" rows="5" /></textarea></td>
                                </tr>
                                <tr>
                                    <th class="text-indigo-700"></th>
                                    <td class=""><button class="sBtn btn-sm" type="submit">등록</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </c:if>

                <!-- 댓글 이용시 로그인여부 -->
                <c:if test="${rq.notLogined }">
                    <a class="btn-text-link btn-sm btn-ghost" href="${rq.loginUri}">로그인</a> 후 이용해주세요
                </c:if>
            </div>

            <!-- 뒤로가기 버튼 -->
            <div class="btns mb-3 flex justify-end">
                <c:if test="${empty param.listUri}">
                    <button class=" my-3 fc_redH" type="button" onclick="history.back();"> 뒤로가기 </button>
                </c:if>
                <c:if test="${not empty param.listUri}">
                    <a class=" my-3 fc_redH" href="${param.listUri }"> 뒤로가기</a>
                </c:if>
            </div>


        </div>
    </div>
</section>



</body>
</html>