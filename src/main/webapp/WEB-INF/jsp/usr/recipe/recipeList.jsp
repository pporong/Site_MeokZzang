<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 게시판" />
<%@ include file="../common/head.jspf"%>

<section class="recipeListSection con">
	<div class="recipeWrap" style ="">
	
		<c:forEach var="recipe" items="${recipies }">
			<div class="list_wrap row">
				<div class="imgWrap cell" style="width : 250px; height : 250px; background : yellow;" >
					<input type="hidden" value="${recipe.recipeId}"/>
					<a href="../recipe/recipeDetail?recipeId=${recipe.recipeId }"><img src="${recipe.recipeTitleImg }" alt="" /></a>
				</div>
				<div class="recipeInfowrap cell" style="background : salmon; margin-top : 30px;">
					<div class="recipeTitle"> <a href="../recipe/recipeDetail?recipeId=${recipe.recipeId }"> ${recipe.recipeName }</a></div>
					<div class="recipeWriter">${recipe.extra__writerName }</div>
					<div class="recipeDate">${recipe.recipeRegDate }</div>
					<div class="recipeHit">${recipe.recipeHitCount }</div>
				</div>
			</div>
		</c:forEach>
		

	</div>
</section>

</body>
</html>