
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db7d32a27c8fa9ce57406cccb2d017b1&libraries=services"> </script>

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

			// switch 문으로 
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