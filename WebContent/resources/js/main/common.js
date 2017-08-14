var publish = window.publish || {};

(function() {
	//左侧导航跟页面背景适应
	publish.leftNav = function(){
		// 根据链接标题修改页面标题
		var title = "";
		title = $('title').text();
		if (title == "") {
			title = document.title;
		}
		$("#topTitle").text(title.substring(10));
		
		$(".sidebar .item").each(function() {
			//页面加载时根据链接高亮菜单项
			$(this).find("a").each(function(){
				
				if ($("body").hasClass("isHomePage")) {
					$("#homePageMenu").addClass("active");
				} else if (location.href.indexOf($(this).attr("href")) != -1) {
					$(".sidebar .item a").removeClass("active");
					$(this).addClass("active");
					return false;
				} else if ($(this).attr("menuId") != undefined && $(this).attr("menuId") == getcookie('menuId')) {
					$(this).addClass("active");
				}
			});
			
			var subMemu = $(this).children('.fold-nav').children("li");
			$(this).click(function() {
				$(this).find(".fold-nav").slideToggle();	
				$(".sidebar").find("a").removeClass('active');	
				$(this).children('a').addClass('active');
				$(this).find('.select').toggleClass('select-show');
			});		
			if(subMemu !=  null){
				subMemu.each(function() {
					$(this).click(function(event) {
						event.stopPropagation();
						$(".sidebar").find("a").removeClass('active');	
						$(this).children().addClass('active');
					});
				});
			}
			
		});
		/*
		 *当左侧导航高度大于主体部分高度时，主体部分高度
		 */
		// var h1 = $(".sidebar").height(); //主体部分左侧导航的高度
		// var h2 = $("body").height();  //主体部分高度
		// if (h1 > h2) {
		// 	$("body").height(h1);
		// }
		//点击在线体验
		$("body").delegate(".js-qq-link", "click", function(){//
			var frame = $(".js-qq-link1 iframe");
			var launchBtn = frame[0].contentDocument.getElementById("launchBtn");
			launchBtn.click();
		});	
		//在线qq咨询处理
		var timer = setInterval(function(){
			var frame = $(".js-qq-link1 iframe");
			if(frame.length > 0){
				frame.css("margin-left", "-100000px").css("position", "absolute");
				clearInterval(timer);
			}
		}, 10);	
		//首页信息提示
		$(".js-close").click(function() {
			$(this).parents(".publish-tip").hide();
		});
	}

	publish.card = function() {
		$(".div-user").hover(function() {
			$(this).find(".card").show();
		}, function() {
			$(this).find(".card").hide();
		});
		//进度条
		var tarArr = $(".box-fff");
		tarArr.each(function() {
			var num1 = $(this).find(".rest-count").text();
			var allNum = $(this).find(".all-count").text();
			var percent = ((num1/allNum)*100).toFixed(2) + "%";
			$(this).find(".progressbar i").width(percent);	
		});

	}
	//点击的时候显示或隐藏相应区域(tab)
	publish.showHidden = function(className,styleName) {
		$("body").on('click', '.' + className, function(event) {
			var target = $(this).attr("data-tab");
			var tt = $("#" + target);
			tt.show().siblings().hide();
			$(this).children('a').addClass(styleName).end().siblings().children('a').removeClass(styleName);
			
		});
	}

	//下拉选项和单选按钮
	publish.selectOption = function(event) {
		$("body").delegate('.select-option', 'click', function(event) {
			event.stopPropagation();

			$(this).siblings('ul').toggle().end().children('i').toggleClass('active');
			$(this).siblings('ul').children('li').each(function() {
				$(this).click(function(event) {
					event.stopPropagation();
					var obj = $(this).children('a');
					var data_key = obj.attr("data-key");
					var data_id = obj.attr("data-key-id");
					var data_value = obj.attr("data-value");
					var data_value_id = obj.attr("data-value-id");
					var txt = obj.text();
					$("#"+data_id).val(data_key);
					$("#"+data_value_id).val(data_value);
					$(this).parent("ul").siblings(".select-option").html(txt + '<i class="mark"></i>');
					$(this).parent("ul").hide();
					if(typeof(obj.attr("callback")!="undefined")){
						eval(obj.attr("callback"));
					}
				});
			});
		});
		$("body").delegate('.page .page-select', 'click', function(event) {
			event.stopPropagation();
			var self = $(this);
			$(this).toggleClass('active').siblings('ul').toggle();
			$(".page .show-num li").each(function() {
				$(this).click(function(event) {
					var ele = $(".page .show-count .page-select");
					var txt = $(this).text();
					ele.text(txt);
					$(this).parent("ul").hide();
					self.removeClass('active');
				})			
			});
		});
		$(".radio-a").each(function() {
			$(this).click(function() {
				$(this).addClass('active').siblings().removeClass('active');
			});
		});
		$(".radia-list .radio-a").each(function() {
			$(this).click(function() {
				$(".radia-list .radio-a").removeClass('active');
				$(this).toggleClass('active');
			});
		});
		//点击空白下拉选项隐藏
		$(document).click(function(event) {
			$(".select-box ul").hide();
			$(".select-option").children('i').removeClass('active');
			$(".page-select-box ul").hide().siblings('.page-select').removeClass('active');
		});
	}  
	
	// 复选框
	publish.checkBox = function() {
		//方框打钩选项按钮
		$(".check-box .checks").each(function() {
			var self = $(this);
			self.children('span').click(function() {
				self.toggleClass('active');
			});
		});
		
		$(".check-box .nbr_checks").each(function() {
			$(this).click(function() {
				$(this).toggleClass('active');
			});
		});
		
		$("body").on('click', '.all-check', function() {
			$(this).toggleClass('active');
		});
		//产品页面复选框按钮范围
		// $(".dialog-box .connect-app").find('.checks').unbind('click');
		// $(".dialog-box .connect-app .checks").each(function() {
		// 	$(this).children('span').click(function() {
		// 		$(this).parent('.checks').toggleClass('active');
		// 	});
		// });
	}

	// 模态框
	publish.dialog = function() {
		//取消弹框
		$("body").on('click', '.close-d', function(event) {
			event.stopPropagation();
			$('.dialog-box').hide();
			$('.dialog-bg').hide();
		});
		$("body").on('click', '.cancel', function(event) {
			$('.dialog-box').hide();
			$('.dialog-bg').hide();
		});
		//出现对话框相应内容
		$("body").on('click', '.js-show-dialog', function(event) {
			var data = $(this).attr("data-dialog");
			var dialogRelate = data.substring(3);
			$(".dialog-bg").show();
			$('.dialog-box').show().children('.' + dialogRelate).show().siblings(".dialog").hide();
			dialogCenter();
		});
	}
	//统计中心
	publish.statis = function(){
		$(".radio-list li").each(function() {
			$(this).click(function() {
				$(this).children().addClass('active').end().siblings().children().removeClass('active');
				var value = $(this).children().attr('data-value');
				var key = $(this).children().attr('data-key');
				var obj = $(this).children();
				$("#"+key).val(value);
				if(typeof(obj.attr("callback")!="undefined")){
					eval(obj.attr("callback"));
				}
			});
		});
	}
	//fileInput
	publish.initFileInput = function(ctrlName, uploadUrl) {   
		console.log($('#' + ctrlName));
	    $('#' + ctrlName).fileinput({
	    	language: 'zh', //设置语言
		    allowedFileExtensions: ["wav", "mp3"],
		    uploadUrl: uploadUrl,
	        maxFileCount: 1,
	        showUpload: false, //是否显示上传按钮
	        showCaption: false,//是否显示标题
	        browseClass: "btn btn-primary", //按钮样式             
	        previewFileIcon: "<i class='glyphicon glyphicon-king'></i>"
	    });
	}
	
	//搜索结果高亮
	publish.highlight = function() {
		var highlightChar = $(".highlightSearch").val();
		var reg = new RegExp(highlightChar,"g");  
		if (highlightChar != undefined && highlightChar != "") {
			$(".useHighlight").each(function(){
				var text = $(this).text();
				$(this).html(text.replace(reg, "<span class='highlight'>" + highlightChar + "</span>"));
			});
		}
	}
	
	return publish;
})();

//ie8弹窗居中
function dialogCenter(){
	if (navigator.appName === 'Microsoft Internet Explorer') { //判断是否是IE浏览器
	    if (navigator.userAgent.match(/Trident/i) && navigator.userAgent.match(/MSIE 8.0/i)) { //判断浏览器内核是否为Trident内核IE8.0
			var w = $(window).width(); //窗口宽度
			var h = $(window).height(); //窗口高度
			var fw = $(".dialog-box").width();
			var fh = $(".dialog-box").height();
			var fww = (w - fw - 50)/2;
			var fhh = (h - fh - 50)/2;
			$(".dialog-box").css({"left":fww+"px","top":fhh+"px"});
	    }
	}

}

//上月末尾最后一天
function getPreMonthLastDay(){
	return getPreDay(1,getFirstDay());
}

//上月开始第一天
function getPreMonthFirstDay(){
	return getPreDay(1,getFirstDay()).substring(0,8)+'01';
}

//本月第一天
function getFirstDay(){
	return getCurrentYear()+"-" + getCurrentMonth() + "-01";
}

//获得当月最大天数
function getMaxDay(year,month){
	month = parseInt(month);
	year = parseInt(year);
	month = month +1;
	if(month==13){
		month = 1;
		year ++ ;
	}
	if(0<month && month<10){
		month="0"+month;
	}
	//下月1号
	var nextMonthFirst = year + '-' + month + '-01';
	//本月末尾
	var monthLast = getPreDay(1,nextMonthFirst);
	return monthLast.substring(8);
	
}

//本月末尾最后一天
function getMonthLastDay(){
	//下个月
	var month = new Date().getMonth();
	var year = new Date().getFullYear();
	month = month+2;
	if(month > 12){
		year++;
		month = month - 12;
		if(0<month && month<10){
			month="0"+month;
		}
	}
	//下月1号
	var nextMonthFirst = year + '-' + month + '-01';
	//上月末尾
	var monthLast = getPreDay(1,nextMonthFirst);
	return monthLast;
}

//获得n天前的时间(格式：yyyy-MM)
function getPreDayByMonth(n){
	var now = new Date();
	var date = new Date(now.getTime() - n * 24 * 3600 * 1000);
	var year = date.getFullYear();
	var month=date.getMonth() + 1;
	if(0<month && month<10){
		month="0"+month;
	}
	return year+"-"+month;
}

//获得n天前的时间(格式：yyyy-MM-dd)
function getPreDay(n,time){
	var now;
	if(typeof(time) != "undefined"){
//		now = new Date(time);
		var arr = time.split("-");  
		now = new Date(arr[0],parseInt(arr[1])-1,arr[2]); 
	}else{
		now = new Date();
	}
	var date = new Date(now.getTime() - n * 24 * 3600 * 1000);
	var year = date.getFullYear();
	var month=date.getMonth() + 1;
	if(0<month && month<10){
		month="0"+month;
	}
	var day = date.getDate();
	if(0<day && day<10){
		day="0"+day;
	}
	
	return year+"-"+month+"-"+day;
}

var getCurrentYear = function(){
	return new Date().getFullYear();
}

var getCurrentMonth = function(){
	var month = new Date().getMonth()+1;
	if(0<month && month<10){
		month="0"+month;
	}
	return month;
}

var getCurrentDay = function(){
	var day = new Date().getDate();
	if(0<day && day<10){
		day="0"+day;
	}
	return day;
}

function getToday(){
	return getCurrentYear()+"-" + getCurrentMonth() + "-" + getCurrentDay();
}

$(function() {
	publish.leftNav();
	publish.selectOption();
	publish.card();
	publish.showHidden("js-tab","active");
	publish.dialog();
	publish.statis();
	publish.checkBox();
	publish.highlight();
})

//复制功能
	function copyAcountInfoListener(){
	         var clipboard = new Clipboard('.copyContent');
	         clipboard.on('success', function(e) {
	            publish.alertDialog("复制成功","true",2000);
	         });
	         clipboard.on('error', function(e) {
	        	publish.alertDialog("复制失败，请手动复制","false",2000);
	         });
	     }

	//提示框(正确true,错误false)
	publish.alertDialog = function(content,className,time) {
		var html = "";
		html = '<div class="alert-dialog">' +
					'<div class="' + className + '">' +
						'<span class="icon"></span>' +
						'<span class="tips-txt">' + content + '</span>' +
					'</div>' +
				'</div>';
		$("body").append(html);
		setTimeout(function() {
			$(".alert-dialog").hide()
		},time);
		
		//点击空白下拉选项隐藏
		$(document).click(function(event) {
			$(".select-box ul").hide();
		});
		
}
