<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세보기" />
<%@ include file="../common/head.jspf"%>

<!-- 조회수 function -->
<script>
	const params = {};
	params.recipeId = parseInt('${param.recipeId}');
</script>

<script>
	function RecipeDetail__increaseHitCount(){
		const localStorageKey = 'recipe__' + params.recipeId + '__alreadyView';
		
		if (localStorage.getItem(localStorageKey)) {
			return;
		}
		localStorage.setItem(localStorageKey, true);
		
		$.get('../recipe/doIncreaseHitCountRd?', {
			recipeId : params.recipeId,
			ajaxMode : 'Y'
		}, function(data) {
			$('.recipe-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}
	
	$(function() {
		RecipeDetail__increaseHitCount();
	});
	
</script>

<section class="recipeDetailSection con" style="margin-top: 20px;">

	<!-- 아이디 / 작성 날짜 / 조회 수 -->
	<div class=" text-xl ">
	    <div class="recipe_wrap mx-auto">
			<div class="recipeHeader flex justify-between" style="width: 550px; margin: 10px;">
				<div class="recipeId">
					<h3 class="">▶ ${recipe.recipeId} 번 레시피 </h3>
				</div>

			</div>
		</div>
	</div>

	<!-- 레시피 (카테고리 / 인원 / 소요시간 / 난이도 / 조리방법) -->
	<div class="recipeInfoWrap" style="text-align:center; margin-top:30px; font-size:x-large; border-bottom: 1px solid #304899; padding-bottom: 5px;">
		<div class=" flex justify-center mt-8" style="">
			<div class="categoryName mx-8 text-center">
				<c:choose>
					<c:when test="${recipe.recipeCategory == '1'}">
						<div class="font-bold fc_blue"> > 한식 </div>
					</c:when>
					<c:when test="${recipe.recipeCategory == '2'}">
						<div class="font-bold fc_blue"> > 양식 </div>
					</c:when>
					<c:when test="${recipe.recipeCategory == '3'}">
						<div class="font-bold fc_blue"> > 중식 </div>
					</c:when>
					<c:when test="${recipe.recipeCategory == '4'}">
						<div class="font-bold fc_blue"> > 일식 </div>
					</c:when>
					<c:otherwise>
						<div class="font-bold fc_blue"> > 기타 </div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="recipeCook mx-8 text-center">
				<c:choose>
					<c:when test="${recipe.recipeCook == '1'}">
						<div class="font-bold fc_blue"> > 볶음 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '2'}">
						<div class="font-bold fc_blue"> > 끓인 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '3'}">
						<div class="font-bold fc_blue"> > 부침 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '4'}">
						<div class="font-bold fc_blue"> > 조림 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '5'}">
						<div class="font-bold fc_blue"> > 무침 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '6'}">
						<div class="font-bold fc_blue"> > 비빔 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '7'}">
						<div class="font-bold fc_blue"> > 찜 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '8'}">
						<div class="font-bold fc_blue"> > 절임 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '9'}">
						<div class="font-bold fc_blue"> > 튀김 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '10'}">
						<div class="font-bold fc_blue"> > 삶은 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '11'}">
						<div class="font-bold fc_blue"> > 구운 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeCook == '12'}">
						<div class="font-bold fc_blue"> > 데친 요리 </div>
					</c:when>					
					<c:otherwise>
						<div class="font-bold fc_blue"> > 기타 </div>
					</c:otherwise>
				</c:choose>
			</div>

			<div class="recipePerson mx-8 text-center">
				<c:choose>
					<c:when test="${recipe.recipePerson == '1'}">
						<div class="font-bold fc_blue"> > 1인분 </div>
					</c:when>
					<c:when test="${recipe.recipePerson == '2'}">
						<div class="font-bold fc_blue"> > 2인분 </div>
					</c:when>
					<c:when test="${recipe.recipePerson == '3'}">
						<div class="font-bold fc_blue"> > 3인분 </div>
					</c:when>
					<c:otherwise>
						<div class="font-bold fc_blue"> > 기타 </div>
					</c:otherwise>
				</c:choose>
			</div>		
				
			<div class="recipeTime mx-8 text-center">
				<c:choose>
					<c:when test="${recipe.recipeTime == '1'}">
						<div class="font-bold fc_blue"> > 10분 이내 </div>
					</c:when>
					<c:when test="${recipe.recipeTime == '2'}">
						<div class="font-bold fc_blue"> > 20분 이내 </div>
					</c:when>
					<c:when test="${recipe.recipeTime == '3'}">
						<div class="font-bold fc_blue"> > 30분 이내 </div>
					</c:when>
					<c:when test="${recipe.recipeTime == '4'}">
						<div class="font-bold fc_blue"> > 1시간 이내 </div>
					</c:when>
					<c:otherwise>
						<div class="font-bold fc_blue"> > 기타 </div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="recipeLevel mx-8 text-center">
				<c:choose>
					<c:when test="${recipe.recipeLevel == '1'}">
						<div class="font-bold fc_blue"> > 초급 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeLevel == '2'}">
						<div class="font-bold fc_blue"> > 중급 요리 </div>
					</c:when>
					<c:when test="${recipe.recipeLevel == '3'}">
						<div class="font-bold fc_blue"> > 고급 요리 </div>
					</c:when>
					<c:otherwise>
						<div class="font-bold fc_blue"> > 기타 </div>
					</c:otherwise>
				</c:choose>
			</div>	

		</div>
		
		<div class="flex justify-end mt-4" style="font-size : 16px; text-align:right;">
			<div class="recipeRegDate">
				<span class="date"> 작성날짜 ${recipe.getForPrintType1RegDate()} / </span>
			</div>
			<div class="recipeHitCount">
				<span class="date"> 조회 ${recipe.recipeHitCount} </span>
			</div>
		</div>
		
		<!-- 수정 삭제 버튼 -->
		<div class="btns flex justify-end mt-4" style="font-size : 16px; text-align:right;">
			<c:if test="${recipe.extra__actorCanModify }">
              	<a class="mx-4 mBtn badge badge-outline badge-sm fc_redH" href="../recipe/modify?recipeId=${recipe.recipeId }">수정</a>
            </c:if>
            <c:if test="${recipe.extra__actorCanDelete }">
				<a class="dBtn badge badge-outline badge-sm fc_redH" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
	            	href="../recipe/doDelete?recipeId=${recipe.recipeId }">삭제</a>
            </c:if>
		</div>

		
	</div>


	<!-- 레시피 완성 사진 + 레시피 기본 정보 -->
	<div class="recipe_title flex justify-center">
		<div class="titleImgBox" style="width: 530px;">
			<div class="mt-8" style="width: 100%; height: 335px; border: 1px solid grey;">
				<!-- 이미지 미리보기 -->
				<img name="recipeTitleImg" style="width: 100%; height: 100%;" class="bg-gray-100" 
				src="${rq.getMainRecipeImgUri(recipe.recipeId)}" alt="요리 완성 사진" />
			</div>

		</div>

		<!-- 레시피 기본 정보 -->
		<div class="recipeInfoWrap mx-10" style="padding: 30px; padding-top: 40px;">
			<div class="titleBox mt-2 " style="width: 680px;">
				<div class="recipeTitle fc_red font-bold">▶ 레시피 제목</div>
				<div class="w-full" style="width: 100%; height: 60px; font-size: xx-large; font-weight: bold; padding-left: 10px;"> ${recipe.recipeName} </div>
			</div>

			<div class="cookerBox mt-2">
				<div class="nameBox fc_red font-bold">▶ 요리사 </div>
				<div class="w-full" style="width: 100%; height: 60px; font-size: x-large; font-weight: bold; padding-left: 10px;"> ${recipe.extra__writerName} </div>
			</div>

			<div class="bodyBox mt-2">
				<div class="recipeInfo fc_red font-bold">▶ 레시피 소개</div>
				<div class="w-full" style="width: 100%; height: 60px; font-size: x-large; padding-left: 10px;"> ${recipe.recipeBody} </div>
			</div>
		</div>
	</div>

	<!-- 재료 / 양념 -->
	<div class="recipeBox row bg-gray-100" style="padding: 15px; text-align: center; margin-top: 35px; margin-bottom: 20px;">
		<div class="stuffBox cell" style="width: 50%;">
			<span class="fc_blue font-bold" style="font-size: x-large;">재 료</span> <br />	
			<div class="" style="padding: 10px; font-size:20px; width:100%"> ${recipe.recipeStuff} </div>
		</div>

		<div class="sauceBox cell " style="width: 50%;">
			<span class="fc_blue font-bold" style="font-size: x-large;">양 념</span>	<br />
			<div class="" style="padding: 10px; font-size:20px; width:100%"> ${recipe.recipeSauce} </div>
		</div>
	</div>

	<!-- 조리 과정 -->
	<div class="cookWrap mt-8 con" style="border-top: 1px solid #304899;">
		<div id="order" class="">
			<c:forEach var="body" varStatus="status" items="${recipe.recipeMsgBody }" >
				<div class="flex h-full bg-gray-50 rounded-lg justify-center" style="margin-top: 20px; height: 400px; width: 100%;">
				
					<div class="flex justify-center rounded-xl my-auto text-center"> 
						<!-- 조리과정 이미지 -->
						<img class="rounded-md" style="margin: 12px; width: 500px; height: 300px;" name="recipeBodyImg"
						 src="${rq.getRecipeOrderImgUri(recipe.recipeId, status.count)}"  onerror="${rq.orderFallbackImgOnErrorHtml}"/>
					</div>
					
					<div class="recipeBodyMsgBox ml-6 " style="width: 800px; text-align: justify;">
						<div class="" style="margin-top: 55px;">
							<div class="" style="padding: 20px; font-size: 22px;"> ${body} </div>
						</div>
					</div>
				</div>								
			</c:forEach> 
		</div>
	</div>
	
	<!-- 스크랩 사용 가능? -->
	<div class="scrapBox "  style="margin-top: 20px; font-size: 22px;">
		<c:if test="${actorCanMakeScrap }">
			<div class="scrapBtns flex justify-center">
			<!-- 스크랩 버튼 -->
				<a id="" href="/usr/scrapPoint/doScrap?relTypeCode=recipe&relId=${param.recipeId}&replaceUri=${rq.encodedCurrentUri}"
					class="fc_redH btn_s" style="margin-right: 20px;"> ♥ 스크랩 하기 </a>
			</div>
		</c:if>
			<!-- 스크랩 취소 ! -->
            <c:if test="${actorAddScrapPoint }">
                <div class="scrapBtns flex justify-center">
                    <!-- 추천 버튼 -->
                    <a id="" href="/usr/scrapPoint/doDeleteScrap?relTypeCode=recipe&relId=${param.recipeId}&replaceUri=${rq.encodedCurrentUri}"
                        class="fc_blueH has-fail" style="margin-right: 20px;"> ♥ 스크랩 취소 </a>
                </div>
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
	
	<!-- 댓글 -->
	<div class="replyBox mt-8">
	<div class="replyTitle"> 댓글 목록 <span class="badge badge-outline badge-sm fc_blue">${replies.size() }</span></div>
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
					<th class="">비고</th>
				</tr>
			</thead>
			
			<!-- 댓글 목록 -->
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
								<a class="btn-text-link" href="../reply/modify?id=${reply.id }&replaceUri=${rq.encodedCurrentUri}">수정</a>
							</c:if>
						</td>
						<td>
							<c:if test="${reply.extra__actorCanDelete}">
								<a class="btn-text-link cursor-pointer" onclick="if(confirm('정말 삭제하시겠습니까?')) { ReplyList_deleteReply(this);} return false;">삭제</a>
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
                        <input type="hidden" name="relId" value="${recipe.recipeId }" />
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
                    <a class="fc_redH btn-sm btn-ghost" href="${rq.loginUri}">로그인</a> 후 이용해주세요
                </c:if>
            </div>
		</div>
				
	<!-- 뒤로가기 버튼 -->
	<div class="btns my-4 flex justify-end mt-8" style=" border-top: 1px solid #304899; ">
		<button class=" fc_blueH" type="button" style="padding-right: 50px; margin-top : 15px;" onclick="history.back();">뒤로가기</button>
	</div>

</section>


</body>
</html>