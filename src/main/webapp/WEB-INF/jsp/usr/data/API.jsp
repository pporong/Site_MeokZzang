<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="맛집 추천" />
<%@ include file="../common/head.jspf"%>

<!-- kakao map API -->
<div class="" id="map" style="width:500px;height:400px; margin:20px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e349d8e7cf9d111a09748714ff65d72f"></script>
	<p>
	    <button onclick="setCenter()">지도 중심좌표 이동시키기</button> 
	    <button onclick="panTo()">지도 중심좌표 부드럽게 이동시키기</button> 
	</p>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>

<script>
	const API_KEY = '0KUyd62PWlPgtMKXkK86TYWHpxtqlpP4tUg6Ksd1sZyRb66o9s98%2FloWqVvNdRVDo76aQSKAA4bmCEhfjPlocQ%3D%3D';
		
	async function getData() {
		const url = 'http://apis.data.go.kr/3660000/PublicToiletListService/getPublicToiletList?serviceKey=' + API_KEY
				+ '&&&';
			
		const response = await fetch(url);
		const data = await response.json();
		console.log("data : ", data);
		
		Lalocation = data.la;
		Lolocation = data.lo;
		
		console.log(Lalocation);
		console.log(Lolocation);
	}
	
	getData();
		var la = 36.33115899;
		var lo = 127.3896;
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	function setCenter() {            
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(33.452613, 126.570888);
	    
	    // 지도 중심을 이동 시킵니다
	    map.setCenter(moveLatLon);
	}
	function panTo() {
	    // 이동할 위도 경도 위치를 생성합니다
	  	console.log("위도(la) : " + la);
	  	console.log("경도(lo) : " + lo); 
	    
	    var moveLatLon = new kakao.maps.LatLng(la, lo);
	    
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);            
	}
	
	// 마커가 표시될 위치입니다 
	var markerPosition = new kakao.maps.LatLng(la, lo);
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		position : markerPosition
	});
	
	marker.setMap(map);
</script>


</body>
</html>