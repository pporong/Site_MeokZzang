<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="맛집 추천" />
<%@ include file="../common/head.jspf"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db7d32a27c8fa9ce57406cccb2d017b1&libraries=services"> </script>

<!-- 공공데이터 + 카카오 API 시작 -->
<script>
const API_KEY = '0KUyd62PWlPgtMKXkK86TYWHpxtqlpP4tUg6Ksd1sZyRb66o9s98%2FloWqVvNdRVDo76aQSKAA4bmCEhfjPlocQ%3D%3D';
var pageNum = 1;

//api 실행
start()
function start(){	
	foodDetail(0)
	foodList(pageNum)
}

$(document).on('click', '#foodTable > tr', function(){
	console.log('detail 실행')
	var foodIdx = $(this).find('input:eq(0)').val();
	foodDetail(foodIdx)
})

$(document).on('click', '#search', function(){
	pageNum = 1;
	foodList(pageNum)
})

/* 검색 후 pagination */
$(document).on('click', '#pagination > button', function(){
		var pageCount = 5;
		var pageGroup = Math.ceil(pageNum/pageCount);
		var lastNum = pageGroup * pageCount;
		var firstNum = lastNum - (pageCount -1);
		var totalPage = $('#totalPage').val();

		if($(this).val() != 99 && $(this).val() != 0){
			pageNum = $(this).val()
			$('#pagination').html('');
		}else if($(this).val() == 99){
			firstNum += pageCount
			lastNum += pageCount
			pageNum = firstNum
			$('#pagination').html('');
		}else if($(this).val() == 0){
			firstNum -= pageCount
			lastNum -= pageCount
			pageNum = firstNum
			$('#pagination').html('');
		}
			nextPage(firstNum, lastNum, totalPage)
			foodList(pageNum)
	})


// 검색전 pagination
async function paginFn(){

	var pageCount = 5;
	var pageGroup = Math.ceil(pageNum/pageCount);
	var lastNum = pageGroup * pageCount;
	var firstNum = lastNum - (pageCount -1);
	var totalPage = $('#totalPage').val();

	nextPage(firstNum, lastNum, totalPage)
}

function nextPage(firstNum, lastNum, totalPage){
	var page = '';

	if(lastNum > totalPage){
		lastNum = totalPage;
	}
	if(firstNum > 5){
		page = '<button class="btn btn-sm" value="' + 0 +'">이전</button>';
	}
	for(var i = firstNum; i <= lastNum; i++){
		page += '<button class="btn btn-sm btn-outline" value="' + i +'">' + i +'</button>';
	}
	if(lastNum < totalPage){
		page += '<button class="btn btn-sm " value="' + 99 +'">다음</button>';
	}
	$('#pagination').html(page);
}

// 음식점 list -> 음식점분류코드 뽑아오기
async function foodList(pageNum) {
	console.log("pageNum : ", pageNum)

	var keyWord = '';

	if($('#searchKeyword').val() != undefined){
		keyWord = $('#searchKeyword').val();			
	}

	console.log('keyWord', keyWord)

	var url = 'http://apis.data.go.kr/6300000/tourFoodDataService/tourFoodDataListJson?serviceKey='+API_KEY
			+'&pageNo='+pageNum+'&searchKeyword='+keyWord;


	const response = await  
	fetch(url);
	const data = await
	response.json();

	var listTable = '';

	if(data.msgHeader.totalCount == 0){
		listTable = '<tr><td class="cursor-pointer">존재하지 않는 상호명 입니다.</td></tr>';
		foodDetail(0);
	}

	$('#badge').text(data.msgHeader.totalCount + '개');
	$('#totalPage').val(data.msgHeader.totalPage);

	for(i in data.msgBody){

		// data 관리자 test 숨기기
		if(data.msgBody[i].foodSeq != 'FH0000934'){

			listTable += '<tr><td class="cursor-pointer">' + data.msgBody[i].name + '</td>'
			+ '<input type="hidden" value="' + data.msgBody[i].foodSeq + '"/></tr>';

		}

	}

	$('#foodTable').html(listTable)
	paginFn()
}

// 음식점 상세정보 가져오기
async function foodDetail(foodSeq){

	var address = '';
	var title = '';
	console.log(foodSeq)

	const url = 'http://apis.data.go.kr/6300000/tourFoodDataService/tourFoodDataItemJson?serviceKey='
		+ API_KEY + '&foodSeq=' +foodSeq 

	const response = await  
	fetch(url);
	const data = await
	response.json();
	console.log("data : ", data)

	if(foodSeq == 0){
		address = '대전 서구 둔산로 52';
		title = '코리아 IT 아카데미 대전점';
		$('#category').text("")
		$('#resNm').text("")
		$('#resNum').text("")
		$('#resTime').text("")
		$('#resAddr').text("")
		$('#resMenu').text("")
	} else {
		address = data.msgBody.addr1 + data.msgBody.addr2;
		title = data.msgBody.name;	
		$('#category').text(data.msgBody.dCodeNm)
		$('#resNm').text(data.msgBody.name)
		$('#resNum').text(data.msgBody.telCode + ' - ' + data.msgBody.telKuk + ' - ' + data.msgBody.telNo)
		$('#resTime').text(data.msgBody.openTime + ' ~ ' + data.msgBody.closeTime)
		$('#resAddr').text(data.msgBody.addr1 + data.msgBody.addr2)
		$('#resMenu').text(data.msgBody.foodMenuList[0].title)

	}

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
// 주소로 좌표를 검색합니다
geocoder.addressSearch(address, function(result, status) {
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+title+'</div>'
        });
        infowindow.open(map, marker);
        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
}); 

}

</script>
<!-- 공공데이터 + 카카오 API 끝 -->

<!-- 섹션 시작 -->
<!-- 페이지 검색 -->
<div class="container mx-auto px-5  con" >
		<div class="list_nav flex justify-between mt-4">
		<!-- 검색 박스 -->
		<div> 총 갯수 : <span id="badge" class="badge"></span></div>
		<input type="hidden" id="totalPage"/>
			<div class="search-box">
					<table class="pull-right">
						<tr>
							<th class="badge" style="margin-top : 7px; margin-right: 5px;">상 호 명</th>
							<td><input id="searchKeyword" class="text-center" style="border : 1px solid grey; border-radius:5px; margin-right: 5px;" type="text" autocomplete="off" placeholder="검색어 입력" name="searchKeyword" maxlength="30"></td>
							<td><button id="search" type="submit" class="btn btn-active btn-sm btn-warning">검색</button></td>
						</tr>
					</table>	
			</div>
		</div> 
		</div>
		
<!-- 상호명 리스트 -->	
<div class="container mx-auto px-5 con">
	<div class="flex mt-4 mx-auto">
		<section class="text-xl mr-2" style = "width :50%;">
		
			<!-- list body -->
			<div class="table-box-type-1 overflow-x-auto">
				<table class="table table-compact w-full">
					<colgroup>
						<col width="100%" />
					</colgroup>
					<thead>
						<tr class="text-indigo-700">
							<th class="">상호명</th>
						</tr>
					</thead>
					<tbody class="cursor-pointer" id ="foodTable">
						
					</tbody>
				</table>
				
				<!-- 페이징 -->
			 	<div class="page-menu flex justify-center">
				 	<div class="btn-group mx-0 my-4 grid grid-cols-2" id = "pagination">
							
					</div>
				</div>
			</div>
		</section>
		
	<!-- 지도 -->
		<section class="" style="width: 50% ">
			<div id="map" style="background-color : grey; width: 100%; height: 250px"></div>
			<table class="table table-compact w-full">
				<colgroup>
					<col style="">
					<col style="">
					<col style="">
					<col style="">
					<col style="">
					<col style="">
				</colgroup>
				
				<!-- 가게 상세 정보 -->
				<tbody>
					<tr>
						<th class="">카테고리</th>
						<td id ="category"></td>
					</tr>
					<tr>
						<th>상호명</th>
						<td id="resNm"></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td id="resNum"></td>
					</tr>
					<tr>
						<th>영업시간</th>
						<td id="resTime"></td>
					</tr>
					<tr>
						<th>주  소</th>
						<td id="resAddr"></td>
					</tr>
					<tr>
						<th>대표메뉴</th>
						<td id="resMenu"></td>
					</tr>
				</tbody>
			</table>
		</section>
	</div>
</div>
</body>
</html>
</html>