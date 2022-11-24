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