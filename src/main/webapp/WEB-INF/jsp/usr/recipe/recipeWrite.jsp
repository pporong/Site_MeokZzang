<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="레시피 작성" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiLib.jspf"%>

<script>

/* 입력데이터 유효성검사 스크립트 시작 */
let RecipeWrite_submitFormDone = false;

function RecipeWrite_submitForm(form) {
	
	if (RecipeWrite_submitFormDone) {
		alert('처리중...');
		return;
	}
	
	// 값 확인
	console.log('recipeName : ',form.recipeName.value)
	console.log('recipeLevel : ',form.recipeLevel.value)
	console.log('recipePerson : ',form.recipePerson.value)
	console.log('recipeCategory : ',form.recipeCategory.value)
	console.log('recipeBody : ',form.recipeBody.value)
 	console.log('recipeStuff : ', form.recipeStuff.value)
	console.log('recipeSauce : ',form.recipeSauce.value)
	console.log('recipeMsgBody : ',form.recipeMsgBody.value)
		
	
	// 대표사진 용량 제한
	const maxSizeMb = 10;
	const maxSize = maxSizeMb * 1204 * 1204;

	const mainRecipeImgFileInput = form["file__recipe__0__extra__mainRecipeImg__1"];

	if (mainRecipeImgFileInput.value) {
		if (mainRecipeImgFileInput.files[0].size > maxSize) {
			alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
			mainRecipeImgFileInput.focus();

			return;
		}
	}
	
	RecipeWrite_submitFormDone = true;
	form.submit();

};


/* 재료 양념 입력칸 추가 및 삭제 스크립트 */
const addStuffBox = () => {
	const stuffBox = document.getElementById("stuffBox");
	const newStuffP = document.createElement('p');
	newStuffP.innerHTML = "<input name='recipeStuff' class='mt-8' type='text' required style='width: 400px; height: 50px; border:2px solid #ddf; padding: 20px;' placeholder='예) 당근 반개 '/>"
		+ "<button style='margin-left: 10px;' onclick='removeStuffBox(this);' class='btn btn-sm btn-outline fc_redH'> 삭제 </button>";
		stuffBox.appendChild(newStuffP);
}
const removeStuffBox = (obj) => {
	document.getElementById('stuffBox').removeChild(obj.parentNode);
}
const addSauceBox = () => {
	const sauceBox = document.getElementById("sauceBox");
	const newSauceP = document.createElement('p');
	newSauceP.innerHTML = "<input name='recipeSauce' class='mt-8' type='text' required style='width: 400px; height: 50px; border:2px solid #dfd; padding: 20px;' name='recipeStuff' placeholder='예) 후추 톡톡 '/>"
		+ "<button style='margin-left: 10px;' onclick='removeSauceBox(this);' class='btn btn-sm btn-outline fc_redH'> 삭제 </button>";
	sauceBox.appendChild(newSauceP);
}
const removeSauceBox = (obj) => {
	document.getElementById('sauceBox').removeChild(obj.parentNode);
}


/* 조리과정 내용작성 박스 추가 및 삭제 스크립트 */

var orderNum = 1;
var lastOrderNum = 1;

const add_orderBox = () => {
	
	//  마지막 번호 가져오기
	if (document.getElementById("lastOrderNum")) {
		lastOrderNum = document.getElementById("lastOrderNum").value;
		// 처음 한번만 orderNum를 lastOrderNum로 설정하기
		if (lastOrderNum > orderNum) {
			orderNum = lastOrderNum;
		}
	}
	
	++orderNum;
	
	const orderBox = document.getElementById("order");
	const newOrderP = document.createElement('p');
	
	newOrderP.innerHTML = "<div class='flex bg-gray-50 justify-center'> <div class='flex h-full bg-gray-50 rounded-lg justify-center'" 
	    + "style='margin-top: 20px; height: 400px;'> <div class='flex justify-center rounded-xl my-auto text-center'>"
        + "<label for='input-recipeOrder__'> " + orderNum + "<img class='rounded-md' style='margin: 12px; width: 500px; height: 300px;'"
        + "name='recipeBodyImg' id='preview-recipeOrder__" + orderNum + "'src='https://via.placeholder.com/600/FFFFFF?text=...' />"
        + "<input type='file' id='input-recipeOrder__" + orderNum + "' accept='image/*'  multiple='multiple'"
		+ " name='file__order__0__extra__recipeOrderImg__" + orderNum + "' class=' recipeOrderBox' /></div></label></div>"
		+ "<div class='recipeBodyMsgBox ml-6' style='width: 800px;'>"
   		+ "<div class='flex justify-center bg-gray-50 rounded-md' style='margin-top: 68px;'>"
        + "<textarea name='recipeMsgBody' class='w-full h-full text-lg p-3 border border-gray-300 rounded-lg' style='height: 300px;' rows='5' required  "
		+ "placeholder='조리 과정을 입력해주세요.'></textarea>"
        + "<div onclick='remove_orderBox(this);' style='margin-top: 265px; margin-left: 5px;' class='btn btn-sm btn-outline fc_redH'>"
        + "<span>삭제</span></div></div> </div> </div>";
	orderBox.appendChild(newOrderP);
};
const remove_orderBox = (obj) => {
	document.getElementById("order").removeChild(obj.parentNode.parentNode.parentNode.parentNode);
}

</script>

<script>
// 이미지 미리보기
$(document).ready(function () {
	
	//대표사진 미리보기 스크립트
	const inputMainRecipeImg = document.querySelector('#input-mainRecipe');
	const previewMainRefipeImg = document.querySelectorAll('#preview-mainRecipe');

	// input file에 change 이벤트 부여
	inputMainRecipeImg.addEventListener('change', () => {
	  const reader = new FileReader();
	  reader.onload = ({ target }) => {
		  previewMainRefipeImg[0].src = target.result;
	  };
	  reader.readAsDataURL(inputMainRecipeImg.files[0]);
	});
	
	// 조리과정 미리보기 스크립트
	function readRecipeOrderImage(order) {

		// 조리순서 번호 가져오기
		var inputNameStr = order.name;
		var inputNum = inputNameStr.substring(39);

		// 인풋 태그에 파일이 있는 경우
		if (order.files && order.files[0]) {
			// FileReader 인스턴스 생성
			const reader = new FileReader();
			// 이미지가 로드가 된 경우
			reader.onload = e => {
				const previewImage = document.getElementById("preview-recipeOrder__" + inputNum);
				previewImage.src = e.target.result;
			}
			// reader가 이미지 읽도록 하기
			reader.readAsDataURL(order.files[0]);
		};
	};

	// input file에 change 이벤트 부여
	$(function() {
		$(document).on("change", ".recipeOrderBox", function() {
			readRecipeOrderImage(this);
		});
	});

});
</script>

<section class="writeRecipeSection con">
	<form id="form" class=" py-4 " action="../recipe/doWriteRecipe" method="POST" enctype="multipart/form-data" onsubmit="RecipeWrite_submitForm(this) return false;" name="do-write-recipe-form">
	<input type="hidden" value="${replaceUri }" />
	<!-- 레시피 완성 사진 등록 + 레시피 기본 정보 -->
	<div class="recipe_title flex justify-center">
		<div class="titleImgBox" style="width: 530px; height: 300px;">
			<div class="mt-8" style="width: 100%; height: 335px; border: 1px solid grey;">
				<!-- 이미지 미리보기 -->
				<img id="preview-mainRecipe" name="recipeTitleImg" style="width: 100%; height: 100%;" class="bg-gray-100" 
				src="https://raw.githubusercontent.com/pporong/
				Site_MeokZzang/8a022c533f3e6e2214285320fa4d03ca3789bc55/MeokZzang_ImgFile/member/2022_12/1.png"
				 alt="요리 완성 사진" />
				
				<div class="font-bold" style="margin-top: 10px;">▶ 완성 된 요리사진을 등록 해 주세요</div>
				
				<label for="file">
					<!-- 완성 사진 등록 -->
					<input type="file" id="input-mainRecipe" style="padding-top: 8px; cursor: pointer;" accept="image/*" 
							name="file__recipe__0__extra__mainRecipeImg__1" class="titleImgChoice fc_redH" />
				</label>
			</div>

		</div>

		<!-- 레시피 기본 정보 -->
		<div class="recipeInfoWrap mx-10">
			<div class="titleBox mt-8 " style="width: 680px;">
				<div class="recipeTitle fc_blue font-bold">▶ 레시피 제목</div>
				<input name="recipeName" class="w-full input input-bordered" style="width: 100%; height: 60px; padding: 20px;" type="text" 
				placeholder="제목을 입력 해 주세요"/>
			</div>

			<div class="cookerBox mt-8">
				<div class="nameBox fc_blue font-bold">▶ 요리사 : ${rq.loginedMember.nickname }</div>
			</div>

			<div class="bodyBox mt-8">
				<div class="recipeInfo fc_blue font-bold">▶ 레시피 소개</div>
					<textarea class="w-full input input-bordered" style="height: 160px; padding: 20px;" name="recipeBody" 
					placeholder="자유롭게 레시피를 소개 해 주세요!" rows="5"/></textarea>
			</div>
		</div>
	</div>


	<!-- 레시피 선택내용(카테고리 / 인원 / 소요시간 / 난이도 / 조리방법) -->
	<div class="recipeSelectWrap" style="text-align:center; margin-top:100px;">
		<div class="recipeBodyWrap flex justify-center mt-8" style="border-bottom: 1px solid #304899; padding-bottom: 15px;">

			<select name="recipeCategory" class="mx-8 text-center" required data-value="${recipe.recipeCategory}">
				<option value="">카테고리</option>
				<option value="1">한식</option>
				<option value="2">양식</option>
				<option value="3">중식</option>
				<option value="4">일식</option>
				<option value="0">기타</option>
			</select>
		
			<select name="recipeCook" class="mx-8 text-center" required data-value="${recipe.recipeCook}">
				<option value="">조리 방법</option>
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
		
			<select name="recipePerson" class="mx-8 text-center" required data-value="${recipe.recipePerson}">
				<option value="">인원 선택</option>
				<option value="1">1인분</option>
				<option value="2">2인분</option>
				<option value="3">3인분</option>
				<option value="0">기타</option>
			</select>
		
			<select name="recipeTime" class="mx-8 text-center" required data-value="${recipe.recipeTime}">
				<option value="" >소요 시간</option>
				<option value="1">10분 이내</option>
				<option value="2">20분 이내</option>
				<option value="3">30분 이내</option>
				<option value="4">1시간 이내</option>
				<option value="0">기타</option>
			</select>
		
			<select name="recipeLevel" class="mx-8 text-center" required data-value="${recipe.recipeLevel}">
				<option value="">난이도</option>
				<option value="1">초급</option>
				<option value="2">중급</option>
				<option value="3">고급</option>
			</select>

		</div>
	</div>

	<!-- 재료 / 양념 입력 -->
	<div class="recipeBox row mt-10" style="padding-bottom: 15px; margin-left: 100px; text-align: center;">
		<div class="stuffBox cell" id="stuffBox" style="width: 45%;">
			<span class="fc_blue font-bold" style="font-size: x-large;">재 료</span> <br />	
			<span class="fc_red mt-2">** 재료마다 입력칸을 하나씩 추가 해 주세요! **</span>		
			<!-- 삭제 버튼 -->
			<p>
				<input name="recipeStuff" class="mt-4" type="text" style="width: 400px; height: 50px; border: 2px solid #ddf; padding: 20px;" required placeholder="예) 양파 2/1개" />
				<button type="button" onclick="removeStuffBox(this);" class="btn btn-sm btn-outline fc_redH">삭제</button>
			</p>

		</div>

		<div class="sauceBox cell" id="sauceBox" style="width: 45%;">
			<span class="fc_blue font-bold" style="font-size: x-large;">양 념</span>	<br />
			<span class="fc_red mt-2">** 양념마다 입력칸을 하나씩 추가 해 주세요! **</span>		
		<!-- 삭제 버튼 -->
			<p>
				<input name="recipeSauce" class="mt-4" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" required placeholder="예) 참기름 한바퀴 "/>
				<button type="button" onclick="removeSauceBox(this);" class="btn btn-sm btn-outline fc_redH">삭제</button>
			</p>
		</div>
	</div>
	
		<!-- 재료 / 양념 추가 버튼 -->
		<div class="addBtnBox" class="mt-8" style="position:relative;">
			<!-- 추가 버튼 -->
			<div class="" style="padding-bottom: 15px;">
				<button type="button" onclick="addStuffBox();" class="btn btn-sm btn-outline fc_blueH" style="position: absolute; left : 24%;">추가</button>
				<button type="button" onclick="addSauceBox();" class="btn btn-sm btn-outline fc_blueH" style="position: absolute; right : 30%;">추가</button>
			</div>			
		</div>

	<!-- 조리 과정 -->
	<div class="cookWrap mt-8 con" style="border-top: 1px solid #304899;">
	
		<div id="order" class="">
		<!-- 조리 과정 사진등록 -->
			<div class="flex h-full bg-gray-50 rounded-lg justify-center" style="margin-top: 20px; height: 400px; width: 100%;">
				<div class="flex justify-center rounded-xl my-auto text-center"> 
					<label for="input-recipeOrder__1">
						<!-- 사진 미리보기 -->
						<img id="preview-recipeOrder__1" class="multiple-container rounded-md" style="margin: 12px; width: 500px; height: 300px;" name="recipeBodyImg" src="https://via.placeholder.com/600/FFFFFF?text=..."/>
						<input type="file" id="input-recipeOrder__1" multiple="multiple" accept="image/*" name="file__order__0__extra__recipeOrderImg__1" class=" recipeOrderBox" />
					</label>
				</div>
				
				<!-- 조리순서 내용작성 -->
				<div class="recipeBodyMsgBox ml-6 " style="width: 800px;">
					<div class="flex justify-center bg-gray-50 rounded-md " style="margin-top: 36px;">
						<textarea name="recipeMsgBody" class="w-full h-full text-lg p-3 border border-gray-300 rounded-lg"
						 style="height: 300px;" rows="5" required placeholder="조리 과정을 입력해주세요."></textarea>
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
	
		<input type="hidden" id="lastOrderNum" value="${ lastOrderNum }">
		<!-- 조리과정 등록 영역 끝 -->

		<!-- 토스트 에디터 적용 -->
		<div class="toast-ui-editor mt-8 hidden">
			<script type="text/x-template"></script>
		</div>

		<div class="btn_box mt-8 flex justify-center">
			<button id="writeSubmitBtn" class="btn btn-sm fc_redH" type="submit" value="등록">등록</button>
		</div>
		
	</form>

		<div class="btns my-4 flex justify-end">
				<button class=" fc_blueH" type="button" style="margin-right: 35px;" onclick="history.back();">뒤로가기</button>
		</div>
		
</section>





</body>
</html>