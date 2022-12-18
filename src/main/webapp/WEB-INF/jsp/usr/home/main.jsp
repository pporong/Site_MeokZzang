<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEOK ZZANG" />
<%@ include file="../common/head.jspf"%>

<section class="main">
	<!-- banner visual 시작 -->
	<div class="banner-visual con">
	
		<!-- 섹션 1 : banner -->
		<div class="section01">
			<div class="banner-slider-wrap">
				<div class="banner-slider">
					<a href="#">
						<div class="content content01"></div>
					</a>
					<a href="#">
						<div class="content content02"></div>
					</a>
					<a href="#">
						<div class="content content03"></div>
					</a>
				</div>
				
			<!-- 슬라이드 버튼 -->
			<div class="next-btn"></div>
			<div class="prev-btn"></div>
			
			</div>
		</div>
	
	</div>

	<div class="noticeList con " style="position: relative;">
	<div class="fc_red text-center font-bold mt-8 "> < 공지사항 > </div>
	<!-- list body -->
		<div class="overflow-x-auto text-center">
			<table class="table table-compact w-full" style="text-align: center; position: absolute; left:53%; transform: translateX(-50%);">
				<colgroup>
					<col width="10%" />
					<col width="20%" />
					<col width="40%" />
					<col width="10%" />
					<col width="5%" />
					<col width="5%" />
				</colgroup>
				<thead>
					<tr class="text-indigo-700">
						<th>번호</th>
						<th>날짜</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="article" items="${articles }">
						<tr class="hover">
							<td>${article.id}</td>
							<td>${article.forPrintType1RegDate}</td>
							<td>
								<a class="hover:underline" href="${rq.getArticleDetailUriFromArticleList(article) }">${article.title}</a>
							</td>
							<td>${article.extra__writerName}</td>
							<td>
								<span class="article-detail__hit-count">${article.hitCount }</span>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<div class="newReicpe con " style="position: relative;"> 
	<!-- list body -->
		<div class="overflow-x-auto text-center" style="">
			<div class="row bg-gray-100" style="text-align: center; position: absolute; left:0; top: 280px; padding-bottom: 30px; padding-top: 30px;">
				<div class="title fc_blue text-center font-bold mb-8" style="" > < 최신 레시피 > </div>
					<c:forEach var="recipe" items="${newRecipes }">
						<div class=" hover cell " style="margin-right: 28px; margin-left: 30px; border: 1px solid #304899; box-sizing:border-box;">
							<div>${recipe.recipeId} 번 레시피</div>
							<div>${recipe.forPrintType1RegDate}</div>
							<div>
								<a class="hover:underline" href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">
									<img src="${rq.getMainRecipeImgUri(recipe.recipeId)}" alt="레시피 사진" style="width: 300px; height: 300px;" 
									onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" />
								</a>
							</div>
							<div>
								<a class="hover:underline fc_blueH font-extrabold" href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">${recipe.recipeName}</a>
							</div>
							<div>${recipe.extra__writerName}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="topRecipe con " style="position: relative;"> 
		<!-- list body -->
		<div class="overflow-x-auto text-center" style="">
			<div class="row bg-gray-100" style="text-align: center; position: absolute; left:0; top: 830px; padding-bottom: 30px; padding-top: 30px;">
				<div class="title fc_red text-center font-bold mb-8" style="" > < 인기 레시피 > </div>
					<c:forEach var="recipe" items="${topRecipes }">
						<div class=" hover cell " style="margin-right: 28px; margin-left: 30px; border: 1px solid #e04241; box-sizing:border-box;">
							<div>${recipe.recipeId} 번 레시피</div>
							<div>${recipe.forPrintType1RegDate}</div>
							<div>
								<a class="hover:underline " href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">
									<img src="${rq.getMainRecipeImgUri(recipe.recipeId)}" alt="레시피 사진" style="width: 300px; height: 300px;" 
									onerror="${rq.mainRecipeFallbackImgOnErrorHtml}" />
								</a>
							</div>
							<div>
								<a class="hover:underline font-extrabold fc_redH" href="../recipe/recipeDetail?recipeId=${recipe.recipeId }">${recipe.recipeName}</a>
							</div>
							<div>${recipe.extra__writerName}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="mt-8 mb-10" style="width:20px; height: 30px; position: absolute; left:0; top: 1850px;"></div>

	
</section>
</body>
</html>