<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 상세보기" />
<%@ include file="../common/head.jspf"%>

<section class="recipeDetailSection text-xl con">
    <div class="recipe_wrap mx-auto">
        <div class="recipe_header">
            <div class="recipeHeader">
                <div class="categoryName">
                    <c:choose>
                        <c:when test="${recipe.recipeCategory == '1'}">
                            <td class=""> > 한식 </td>
                        </c:when>
                        <c:when test="${recipe.recipeCategory == '2'}">
                            <td class=""> > 양식 </td>
                        </c:when>
                        <c:when test="${recipe.recipeCategory == '3'}">
                            <td class=""> > 중식 </td>
                        </c:when>
                        <c:when test="${recipe.recipeCategory == '4'}">
                            <td class=""> > 일식 </td>
                        </c:when>
                        <c:otherwise>
                            <td class=""> > 기타 </td>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="titleName">
                    <h3 class="">${recipe.recipeName}</h3>
                </div>
                <div class="titleName">
                    <h3 class="">${recipe.recipeStuff}</h3>
                </div>
                
                <div class="titleName">
                    <h3 class="">${recipe.recipeSauce}</h3>
                </div>
                

            </div>
            <div class="recipeInfo row">
                    <div class="cell">
                    	<c:forEach var="body" items="${recipe.recipeMsgBody }">
                    		<div style="border: 1px solid green; margin: 20px;" class="">${body} </div>
                    	</c:forEach>
                    </div>
               
            </div>
             <div class="profileArea cell">
                    <div class="profileInfo">
                        <div class="profileNick">${recipe.extra__writerName }</div>
                    </div>
                    <div class="articleInfo">
                        <span class="date">
                            ${recipe.getForPrintType1RegDate() } /
                        </span>
                        <span class="hitCount article-detail__hit-count">
                            조회 ${recipe.recipeHitCount }
                        </span>
                    </div>
                </div>

 
        </div>

        <div class="articleContainer">
            <div class="articleViewer">
                <div class="toast-ui-viewer">
                    <script type="text/x-template">${recipe.getForPrintBody()}</script>
                </div>
            </div>
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
	</div>
</section>



</body>
</html>