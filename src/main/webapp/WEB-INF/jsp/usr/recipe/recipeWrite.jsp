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

	form.recipeName.value = form.recipeName.value.trim();
	if (form.recipeName.value.length == 0) {
		alert('제목을 입력해주세요.');
		form.recipeName.focus();
		return;
	}

	form.recipeMsgBody.value = form.recipeMsgBody.value.trim();
	if (form.recipeMsgBody.value.length == 0) {
		alert('요리 과정을 입력해주세요.');
		form.recipeMsgBody.focus();
		return;
	}
	form.recipeBody.value = form.recipeBody.value.trim();
	if (form.recipeBody.value.length == 0) {
		alert('요리 소개를 입력해주세요.');
		form.recipeBody.focus();
		return;
	}
	form.recipePerson.value = form.recipePerson.value.trim();
	if (form.recipePerson.value.length == 0) {
		alert('인원을 선택 또는 입력해주세요.');
		form.recipePerson.focus();
		return;
	}

	form.recipeTime.value = form.recipeTime.value.trim();
	if (form.recipeTime.value.length == 0) {
		alert('소요시간을 선택 또는 입력해주세요.');
		form.recipeTime.focus();
		return;
	}

	form.recipeLevel.value = form.recipeLevel.value.trim();
	if (form.recipeLevel.value == 0) {
		alert('난이도를 선택해주세요.');
		form.recipeLevel.focus();
		return;
	}
	form.recipeCook.value = form.recipeCook.value.trim();
	if (form.recipeCook.value == 0) {
		alert('조리 방법을 선택해주세요.');
		form.recipeCook.focus();
		return;
	}

	// 조리순서 데이터 처리 스크립트 시작
	var recipeMsgBodyArr = $('[name="recipeMsgBody"]');

	var param = [];
	for (var i = 0; i < recipeMsgBodyArr.length; i++) {
		recipeMsgBodyArr[i].value = recipeMsgBodyArr[i].value.trim();
		param.push(recipeMsgBodyArr[i].value);
	}

	var orderStr = '';
	param.map(function(item) {
		if (item != '' && item.length - 1) {
			orderStr += item + '@';
		}
	});

	// 마지막 구분자(@)제거
	orderStr = orderStr.substr(0, orderStr.lastIndexOf('@'));

	// 구성된 문자열을 input테그 값으로
	document['do-write-recipe-form'].recipeMsgBody.value = orderStr;

	// 연결된 조리순서 텍스트를 폼데이터로
	form.recipeMsgBody.value = form.recipeMsgBody.value.trim();

	// 조리순서 이미지 번호 순서대로 처리
	var orderImgArr = $(".recipeOrderBox");
	// 작성내용 갯수만큼 검사
	for (var i = 0; i < recipeMsgBodyArr.length; i++) {
		// 조리순서 이미지 번호 가져오기
		var inputNameStr = orderImgArr[i].recipeName;
		// 내용작성에 해당하는 순서
		var tempStrForNaming = "file__order__0__extra__recipeOrderImg__" + (i + 1);
		// 순서가 일치하지 않을 경우, 작성순서에 따른 번호로 name값 변경
		if (tempStrForNaming !== inputNameStr) {
			orderImgArr[i].recipeName = tempStrForNaming;
		};
	};

	
/* 재료 양념 입력칸 추가 및 삭제 스크립트 */

const addStuffBox = () => {
	const stuffBox = document.getElementById("stuffBox");
	const newStuffP = document.createElement('p');
	newStuffP.innerHTML = "<input name='stuffValue' class='mt-8' type='text' style='width: 400px; height: 50px; border:2px solid #ddf; padding: 20px; margin-left: 64px;' placeholder='예) 당근 반개 '/>"
		+ "<button style='margin-left: 10px;' onclick='removeStuffBox(this);' class='btn btn-sm btn-outline fc_redH'> 삭제 </button>";
		stuffBox.appendChild(newStuffP);
}
const removeStuffBox = (obj) => {
	document.getElementById('stuffBox').removeChild(obj.parentNode);
}

const addSauceBox = () => {
	const sauceBox = document.getElementById("sauceBox");
	const newSauceP = document.createElement('p');
	newSauceP.innerHTML = "<input name='sauceValue' class='mt-8' type='text' style='width: 400px; height: 50px; border:2px solid #dfd; padding: 20px; margin-left: 64px;' name='recipeStuff' placeholder='예) 후추 톡톡 '/>"
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
	// 수정페이지에서 마지막 번호 가져오기
	if (document.getElementById("lastOrderNum")) {
		lastOrderNum = document.getElementById("lastOrderNum").value;
		// 처음 한번만 orderNum를 lastOrderNum로 설정하기
		if (lastOrderNum > orderNum) {
			orderNum = lastOrderNum;
		}
	}
	
	++ orderNum;
	const orderBox = document.getElementById("order");
	const newOrderP = document.createElement('p');

	newOrderP.innerHTML = "<div id='order' class='flex'> <div class='flex h-full bg-gray-100 rounded-lg ' style='margin-top: 20px; height: 270px; width:50%;'>" 
	    + "<div class='flex justify-center rounded-xl my-auto'>"
        + "<label for='input-recipeOrder__1'> " + orderNum + " <i class='fa-solid fa-camera text-3xl fc_blue' style='padding :75px; cursor: pointer;'></i></label>"
        + "<input type='file' id='input-recipeOrder__" + orderNum + "' accept='image/gif, image/jpeg, image/png'"
		+ " name='file__order__0__extra__recipeOrderImg__" + orderNum + "' class='hidden recipeOrderBox' /></div>"
   		+ "<img class='rounded-md' style='margin: 12px;' name='recipeBodyImg' id='preview-recipeOrder__" + orderNum + "'src='https://via.placeholder.com/600/FFFFFF?text=...' /></div>"
		+ "<div class='recipeBodyMsgBox w-full ml-6 my-auto'>"
   		+ "<div class='flex justify-center bg-gray-100 rounded-md' style='margin-top: 26px;'>"
        + "<textarea name='recipeMsgBody' class='w-full h-full text-lg p-3 border border-gray-300 rounded-lg' style='height: 220px;' rows='5' "
		+ " onkeyup='characterCheck(this);' onkeydown='characterCheck(this);' required placeholder='조리 과정을 입력해주세요.'></textarea>"
        + "<div onclick='remove_orderBox(this);' class='btn btn-sm btn-outline fc_redH'>"
        + "<span>삭제</span></div></div> </div> </div>";

	orderBox.appendChild(newOrderP);
};

const remove_orderBox = (obj) => {
	document.getElementById("order").removeChild(obj.parentNode.parentNode.parentNode.parentNode);
}

// 특수문자 입력 방지 스크립트
function characterCheck(obj) {
	// 방지할 특수문자 구분자로 사용되는 문자 '@' 제외
	var regExp = /@/gi;
	if (regExp.test(obj.value)) {
		alert("해당 특수문자는 입력하실수 없습니다.");
		obj.value = obj.value.substring(0, obj.value.length - 1); // 입력한 특수문자 한자리 지움
	};
};
</script>


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
			<!-- 추가 버튼 -->
			<div class="mt-8">
				<button onclick="addStuffBox();" class="btn btn-sm btn-outline fc_blueH">추가</button>
			</div>
		</div>

		<div class="sauceBox cell" id="sauceBox" style="width: 45%;">
			<span class="fc_blue font-bold">양 념</span>	<br />
				<input name="sauceValue" class="mt-4" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" required placeholder="예) 고추장 한스푼 "/>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" placeholder="예) 고춧가루 한스푼 "/>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px;" placeholder="예) 참기름 한바퀴 "/>
		<!-- 삭제 버튼 -->
			<p>
				<input name="sauceValue" class="mt-8" type="text" style="width: 400px; height: 50px; border: 2px solid #dfd; padding: 20px; margin-left: 64px;" name="recipeStuff" placeholder="예) 후추 톡톡 "/>
					<button onclick="removeSauceBox(this);" class="btn btn-sm btn-outline fc_redH">삭제</button>
			</p>
		<!-- 추가 버튼 -->
			<div class="mt-8">
				<button onclick="addSauceBox();" class="btn btn-sm btn-outline fc_blueH">추가</button>
			</div>
		</div>
	</div>

	<!-- 조리 과정 -->
	<div class="cookWrap mt-8 con" style="border-top: 1px solid #304899;">
		<div id="order" class="flex">
		<!-- 조리 과정 사진등록 -->
			<div class="flex h-full bg-gray-100 rounded-lg " style="margin-top: 20px; height: 270px; width: 50%;">
				<div class="flex justify-center rounded-xl my-auto">
					<label for="input-recipeOrder__1">
						<i class="fa-solid fa-camera text-3xl fc_blue" style="padding: 75px; cursor: pointer;"></i>
					</label>
					<input type="file" id="input-recipeOrder__1" accept="image/gif, image/jpeg, image/png" name="file__order__0__extra__recipeOrderImg__1" class="hidden recipeOrderBox"/>
				</div>
				
				<!-- 미리보기 -->
				<img class=" rounded-md" style="margin: 12px;" name="recipeBodyImg" src="https://via.placeholder.com/600/FFFFFF?text=..."/>
			</div>
							
			<!-- 조리순서 내용작성 -->
			<div class="recipeBodyMsgBox w-full ml-6 my-auto">
				<div class="flex justify-center bg-gray-100 rounded-md " style="margin-top: 26px;">
					<textarea name="recipeMsgBody" class="w-full h-full text-lg p-3 border border-gray-300 rounded-lg"
					 style="height: 220px;" rows="5" onkeyup="characterCheck(this);" onkeydown="characterCheck(this);" 
					 required placeholder="조리 과정을 입력해주세요."></textarea>
				</div>
			</div>
		</div>

		<!-- 추가 버튼 -->
		<div class=" flex justify-center mt-3" style="border-bottom: 1px solid #304899; padding-bottom: 15px;">
			<div onclick="add_orderBox();" class="flex justify-center items-center">
				<button class="btn btn-sm btn-outline fc_blueH">추가</button>
			</div>
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