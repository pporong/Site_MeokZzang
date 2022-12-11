
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
        $('.main-slider').slick('slickPrev')
    });
    $('.banner-visual>.section01>.banner-slider-wrap >.next-btn').click(function(){
        $('.main-slider').slick('slickNext')
    });

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