$(function(){
	var $slider = $('.slider ul');
	var $slider_child_l = $('.slider ul li').length;
	var $slider_width = $('.slider ul li').width();
	$slider.width($slider_child_l * $slider_width);

	var slider_count = 0;

	if ($slider_child_l < 1) {
		$('#btn-right').css({cursor: 'auto'});
		$('#btn-right').removeClass("dasabled");
	}

	$('#btn-right').click(function() {
//		if ($slider_child_l < 4 || slider_count >= $slider_child_l - 4) {
//			return false;
//		}
//		
//		slider_count++;
//		$slider.animate({left: '-=' + $slider_width + 'px'}, 'slow');
//		slider_pic();
		alert("已经是最后一张了");
	});

	$('#btn-left').click(function() {
		if (slider_count <= 0) {
			return false;
		}
		
		slider_count--;
		$slider.animate({left: '+=' + $slider_width + 'px'}, 'slow');
		slider_pic();
	});
})
function slider_pic() {
	if (slider_count >= $slider_child_l - 4) {
		$('#btn-right').css({cursor: 'auto'});
		$('#btn-right').addClass("dasabled");
	}
	else if (slider_count > 0 && slider_count <= $slider_child_l - 4) {
		$('#btn-left').css({cursor: 'pointer'});
		$('#btn-left').removeClass("dasabled");
		$('#btn-right').css({cursor: 'pointer'});
		$('#btn-right').removeClass("dasabled");
	}
	else if (slider_count <= 0) {
		$('#btn-left').css({cursor: 'auto'});
		$('#btn-left').addClass("dasabled");
	}
}