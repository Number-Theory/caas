$(function(){
	/*
	初始化值，
	offset是获取对象的顶部离网页顶部的距离，
	网页顶部是指最原始的顶部，也就是被卷的，
	看不到的部分也包括在里面。
	*/
	var offset_empty=$('.empty').offset();//获取empty离视口的距离
	var height_header=$('.header').height()*2-50;//定义一个高度是nav的两倍
	var height_header_int=parseInt($('.header').height());

	//点击右侧悬浮的导航栏的时候滚动条会滚动到相应的位置
	$('.nav ul li').click(function(){
		var index=$('.nav ul li').index(this);//获取索引值这里要注意，不能用$(this).index(this)。这个是错误的
		$("html,body").animate({scrollTop:$(".floor").eq(index).offset().top-height_header_int},1000);//设置滚动条的值到指定位置
	})
	//回到顶端按钮的效果设计
	$('.back_top').click(function(){
		$("html,body").animate({scrollTop:0},1000);
	})
	/*
	当滚动条滚的时候获取滚动条的值，设置相应的样式。
	scrollTop是指网页被卷的距离，也就拉动滚动条后被遮的部分，
	看不到的部分，的距离。
	*/
	$(window).scroll(function(){
		//给回到顶端设置滚动效果
		var scrolltop=$(window).scrollTop();
			if(scrolltop>50){//当滚动条滚动到一定的位置就显示回到顶部
			$('.back_top').show();//回到顶部按钮显示
			}else{
				$('.back_top').hide();//回到顶部按钮隐藏
			}

		/*导航条随着滚动条的滚动添加样式，通过each遍历循环floor,
		然后定义变量offset_floor获取到不同floor离视口的距离，
		再通过index获取不同的floor的索引，通过获取索引值设置$('nav ul li').eq(index)的样式，
		这是第一种方法，还可以通过for循环实现，或者通过单个的设置。
		*/
		$('.floor').each(function(index){
			var offset_floor=$(this).offset();
			if(offset_floor.top-scrolltop<=height_header){
				$('.nav ul li').eq(index).addClass('selectd').siblings().removeClass('selectd');
			}
		})
	})
})