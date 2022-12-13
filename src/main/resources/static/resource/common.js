
$(document).ready(function () {
    
    // 배너 슬라이드
    $('.banner-slider').slick({
        autoplay: true ,
        autoplaySpeed : 3000 , 
        dots: true ,
        pauseOnHover: false ,
        arrows : false ,
    });
    // 배너 슬라이드 버튼
    $('.banner-visual>.section01>.banner-slider-wrap >.prev-btn').click(function(){
        $('.banner-slider').slick('slickPrev')
    });
    $('.banner-visual>.section01>.banner-slider-wrap >.next-btn').click(function(){
        $('.banner-slider').slick('slickNext')
    });

});

$(document).ready(function () {
    
    // 업버튼 
    $('.up-btn-area >.up-btn').click(function(){
    
        // $('html, body').scrollTop(0)
        $('html, body').animate({
          'scrollTop' : 0 ,
        } , 800)
        
      });
});

//
$(window).scroll(function(){
  
    let scrollTop = $(this).scrollTop()
    // 내가 선택한 위치가 어딘지 알려주는 메서드
  
    if( scrollTop > 100 ){
      $('.up-btn-area >.up-btn').addClass('active')
    }
    if( scrollTop < 100 ){
      $('.up-btn-area >.up-btn').removeClass('active')
    }
    
  });


$('select[data-value]').each(function(index, el) {
	const $el = $(el);
	
	const defaultValue = $el.attr('data-value').trim();
	
	if (defaultValue.length > 0) {
		$el.val(defaultValue);
	}
});

// popup
$('.popUp').click(function(){
	// $('.layer').show();
	$('.layer').css('display', 'block');
	$('.layer-bg').css('display', 'block');
	
	
})

$('.close-btn').click(function(){
	// // $('.layer').hide();
	$('.layer').css('display', 'none');
	$('.layer-bg').css('display', 'none');
})