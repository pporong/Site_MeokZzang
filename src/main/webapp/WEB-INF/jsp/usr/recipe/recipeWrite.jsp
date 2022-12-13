<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 작성" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiLib.jspf"%>
<script src="/resource/api_js.js" defer="defer"></script>

<section class="writeRecipeSection con">
	<form class=" py-4 " action="../recipe/doWriteRecipe" method="POST" onsubmit="RecipeWrite_submitForm(this); return false;" name="do-write-recipe-form">
	<input type="hidden" value="" />
	<!-- 레시피 완성 사진 등록 -->
	<div class="recipe_title flex justify-center">
		<div class="titleImgBox" style="width: 450px; height: 300px;">
			<div class="mt-8" style="width: 100%; height: 300px; border: 1px solid grey;">
				<img name="recipeTitleImg" style="width: 100%; height: 100%; background-color: #ddd;" src="" alt="" />
			</div>

			<div class="font-bold" style="margin-top: 15px;">▶ 완성 된 요리사진을 등록 해 주세요</div>
		</div>

		<!-- 레시피 정보 -->
		<div class="recipeInfoWrap mx-10">
			<div class="titleBox mt-8 " style="width: 680px;">
				<div class="recipeTitle fc_blue font-bold">▶ 레시피 제목</div>
					<input name="recipeName" class="w-full input input-bordered" style="width: 100%; height: 60px; padding: 20px;"
												type="text" placeholder="제목을 입력 해 주세요"/>
			</div>

			<div class="cookerBox mt-8">
				<div class="nameBox fc_blue font-bold">▶ 요리사 : ${rq.loginedMember.nickname }</div>
			</div>

			<div class="bodyBox mt-8">
				<div class="recipeInfo fc_blue font-bold">▶ 레시피 소개</div>
					<textarea class="w-full input input-bordered" style="height: 140px; padding: 20px;" name="recipeBody" placeholder="자유롭게 레시피를 소개 해 주세요!" rows="5"/></textarea>
			</div>
		</div>
	</div>


	<!-- 레시피 선택내용(카테고리 / 인원 / 소요시간 / 난이도 / 조리방법) -->
	<div class="recipeBodyWrap flex justify-center mt-8" style="border-bottom: 1px solid #304899; padding-bottom: 15px;">

		<select name="recipeCategory" class="mx-8">
			<option disabled selected>카테고리</option>
			<option value="1">한식</option>
			<option value="2">양식</option>
			<option value="3">중식</option>
			<option value="4">일식</option>
			<option value="0">기타</option>
		</select>
	
		<select name="recipeCook" class="mx-8">
			<option disabled selected>조리 방법</option>
			<option value="1">볶음</option>
			<option value="2">끓이기</option>
			<option value="3">부침</option>
			<option value="4">조림</option>
			<option value="5">무침</option>
			<option value="6">비빔</option>
			<option value="7">찜</option>
			<option value="8">절임</option>
			<option value="9">튀김</option>
			<option value="10">삶기</option>
			<option value="11">굽기</option>
			<option value="12">데치기</option>
			<option value="0">기타</option>
		</select>
	
		<select name="recipePerson" class="mx-8">
			<option disabled selected>인원 선택</option>
			<option value="1">1인분</option>
			<option value="2">2인분</option>
			<option value="3">3인분</option>
			<option value="0">기타</option>
		</select>
	
		<select name="recipeTime" class="mx-8">
			<option disabled selected>소요 시간</option>
			<option value="1">10분 이내</option>
			<option value="2">20분 이내</option>
			<option value="3">30분 이내</option>
			<option value="4">1시간 이내</option>
			<option value="0">기타</option>
		</select>
	
		<select name="recipeLevel" class="mx-8">
			<option disabled selected>난이도</option>
			<option value="1">초급</option>
			<option value="2">중급</option>
			<option value="3">고급</option>
		</select>

	</div>

	<!-- 재료 / 양념 입력 -->
	<div class="recipeBox row mt-10" style="padding-bottom: 15px; margin-left: 100px; text-align: center;">
		<div class="stuffBox cell" id="stuffBox" style="width: 45%;">
			<span class="fc_blue font-bold">재 료</span> <br />
				<input name="stuffValue" class="mt-4" type="text" style="width: 400px; height: 50px; border: 2px solid #ddf; padding: 20px;" required placeholder="예) 양파 2/1개"/>
				<input name="stuffValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #ddf; padding: 20px;" placeholder="예) 감자 1개 "/>
				<input name="stuffValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #ddf; padding: 20px;" placeholder="예) 돼지고기 200g "/>
			<!-- 삭제 버튼 -->
			<p>
				<input name="stuffValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #ddf; padding: 20px; margin-left: 64px;" placeholder="예) 당근 반개 "/>
					<button onclick="removeStuffBox(this);" class="btn btn-sm btn-outline fc_redH">삭제</button>
			</p>

		</div>

		<div class="sauceBox cell" id="sauceBox" style="width: 45%;">
			<span class="fc_blue font-bold">양 념</span>	<br />
				<input name="sauceValue" class="mt-4" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" required placeholder="예) 고추장 한스푼 "/>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" placeholder="예) 고춧가루 한스푼 "/>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" placeholder="예) 참기름 한바퀴 "/>
		<!-- 삭제 버튼 -->
			<p>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px; margin-left: 64px;" name="recipeStuff" placeholder="예) 후추 톡톡 "/>
					<button type="button" onclick="removeSauceBox(this);" class="btn btn-sm btn-outline fc_redH">삭제</button>
			</p>
		</div>
	</div>
	
		<!-- 재료 / 양념 추가 버튼 -->
		<div class="addBtnBox" class="mt-8" style="position:relative;">
			<!-- 추가 버튼 -->
			<div class="" style="padding-bottom: 15px;">
				<button type="button" onclick="addStuffBox();" class="btn btn-sm btn-outline fc_blueH" style="position: absolute; left : 25%;">추가</button>
				<button type="button" onclick="addSauceBox();" class="btn btn-sm btn-outline fc_blueH" style="position: absolute; right : 25%;">추가</button>
			</div>			
		</div>

	<!-- 조리 과정 -->
	<div class="cookWrap mt-8 con" style="border-top: 1px solid #304899;">
		<div id="order" class="">
		<!-- 조리 과정 사진등록 -->
			<div class="flex h-full bg-gray-100 rounded-lg " style="margin-top: 20px; height: 270px; width: 100%;">
				<div class="flex justify-center rounded-xl my-auto">
					<label for="input-recipeOrder__1">
						<i class="fa-solid fa-camera text-3xl fc_blue" style="padding: 75px; cursor: pointer;"></i>
					</label>
					<input type="file" id="input-recipeOrder__1" accept="image/gif, image/jpeg, image/png" name="file__order__0__extra__recipeOrderImg__1" class="hidden recipeOrderBox"/>
				</div>
				
				<!-- 사진 미리보기 -->
				<img class=" rounded-md" style="margin: 12px;" name="recipeBodyImg" src="https://via.placeholder.com/600/FFFFFF?text=..."/>
					
				<!-- 조리순서 내용작성 -->
				<div class="recipeBodyMsgBox w-full ml-6 my-auto">
					<div class="flex justify-center bg-gray-100 rounded-md " style="margin-top: 26px;">
						<textarea name="recipeMsgBody" class="w-full h-full text-lg p-3 border border-gray-300 rounded-lg"
						 style="height: 220px;" rows="5" onkeyup="characterCheck(this);" onkeydown="characterCheck(this);" 
						 required placeholder="조리 과정을 입력해주세요."></textarea>
					</div>
				</div>
			</div>
		</div>

	</div>
				
		<!-- 조리과정 추가 버튼 -->
		<div class=" flex justify-center mt-3" style="border-bottom: 1px solid #304899; padding-bottom: 15px;">
			<div onclick="add_orderBox();" class="flex justify-center items-center">
				<button type="button" class="btn btn-sm btn-outline fc_blueH">추가</button>
			</div>
		</div>
		
	<!-- 조리과정 데이터 -->
		<input type="hidden" name="orderBody" />
		<!-- 조리과정 등록 영역 끝 -->

		<!-- 토스트 에디터 적용 -->
		<div class="toast-ui-editor mt-8 hidden">
			<script type="text/x-template"></script>
		</div>

		<div class="btn_box mt-8 flex justify-center">
			<button class="btn btn-sm fc_redH" type="submit" value="등록">등록</button>
		</div>
		
	</form>

		<div class="btns my-4 ">
				<button class=" fc_blueH" type="button" onclick="history.back();">뒤로가기</button>
		</div>
		
</section>





</body>
</html>