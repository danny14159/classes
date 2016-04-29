/**
 * initialization for slider
 * 
 * @param p
 *            previmg,nextimg,width,height
 */
function initSlider(p) {
	var showPics = function(index, fwidth) {

		$('#focus .shade')
		var nowLeft = -index * fwidth;
		$('#focus ul').stop(true, false).animate({
			'left' : nowLeft
		}, 300);
		$('#focus .icon span').removeClass('on').eq(index).addClass('on');

		$('#focus .icon span').animate({
			'opacity' : 0.6
		}, 300).eq(index).stop(true, false).animate({
			'opacity' : 1.0
		}, 300);
	}

	var nAdv = $('#focus ul li').length;
	var fwidth = $('#focus').width();
	var index = 0;
	var picTimer;
	var btn = '<div class="icon">';
	for (var i = 0; i < nAdv; i++) {
		btn += "<span></span>";
	}
	btn += "</div><div class='prenext pre'><img src='" + p.previmg
			+ "'/></div><div class='prenext next'><img src='" + p.nextimg
			+ "'/></div>";
	$('#focus').append(btn);

	$('#focus ul').css('width', fwidth * nAdv);
	$('#focus ul li img').width(fwidth);
	$('#focus .icon').width(fwidth);
	$('#focus .icon span').css('opacity', 0.6).mouseover(function() {
		index = $(this).index();

		showPics(index, fwidth);
	}).eq(0).trigger('mouseover');

	/*
	 * $('#focus .prenext').css('opacity',0).hover(function(){
	 * $(this).stop(true,false).animate({'opacity':0.6},300); },function(){
	 * $(this).stop(true,false).animate({'opacity':0},300); });
	 */

	$('#focus .pre').click(function() {
		index--;
		if (index == -1) {
			index = nAdv - 1;
		}
		showPics(index, fwidth);
	});

	$('#focus .next').click(function() {
		index++;
		if (index == nAdv) {
			index = 0;
		}
		showPics(index, fwidth);
	});

	$('#focus').hover(function() {
		clearInterval(picTimer);
		$('#focus .prenext').stop(true, false).animate({
			'opacity' : 0.6
		});
	}, function() {
		$('#focus .prenext').stop(true, false).animate({
			'opacity' : 0
		});
		picTimer = setInterval(function() {
			index++;

			if (index == nAdv) {
				index = 0;
			}
			showPics(index, fwidth);
		}, 3000);
	}).trigger('mouseleave');

	$('#focus .prenext img').hover(function() {
		$(this).stop(true, false).animate({
			'opacity' : 0.95
		});
	}, function() {
		$(this).stop(true, false).animate({
			'opacity' : 0.6
		});
	}).mousedown(function() {
		$(this).stop(true, false).animate({
			'opacity' : 0.4
		});
	}).mouseup(function() {
		$(this).stop(true, false).animate({
			'opacity' : 0.95
		});
	});

}
function enterparty(){
	if(confirm('请先阅读加入须知：balabalabala...')){
		/*$.get('/party/enter',function(data){
			if(data && data.ok){
				alert('加入成功。');
				loadParty(true);
			}
			else if(data.msg) alert(data.msg);
		},'json');*/
		location.href="/iparty/enter";
	}
}
function loadParty(refresh) {
	$.ajax({
		beforeSend : function() {
		},
		data : {},
		dataType : 'json',
		type : 'POST',
		url : '/party/show'
	}).done(function(data) {
		if(data.ok === false && data.msg=="未加入派对。"){
			$('#party').html('您还未加入派对，请先<button class="ui-button ui-button-mblue" onclick="enterparty();">加入派对</button>');
			return;
		}
		laytpl($('#tplparty').html()).render(data, function(html) {
			$('#party').html(html);
		});
		if (refresh)
			$('#party .fader').hide().jqfader({
				callback : function() {
				}
			});
	}).fail(function() {
		alert('加载失败，请刷新页面重试');
	});
}
function interact(a, addclass, type, no, clzId,cancel) {
	$.get('/partyi/' + type, {
		toNo : no,
		toClz : clzId,
		cancel : cancel||false
	}, 'json').done(function(data) {
		if (data && data.ok) {
			// $(a).removeClass('text-weak').addClass(addclass);
			loadParty();
		} else if (data && data.msg)
			alert(data.msg);
		else
			alert('error');
	});
}
$(function() {
	initSlider({
		previmg : 'f/assets/img/arr_prev.jpg',
		nextimg : 'f/assets/img/arr_next.jpg'
	});

	// javascript for elevator
	$(window).scroll(function() {
		var scrolltop = $(this).scrollTop();
		if (scrolltop >= 100) {
			$("#elevator_item").stop(true,false).animate({bottom:'15px'});
		} else {
			$("#elevator_item").stop(true,false).animate({bottom:'-100px'});
		}
	});
	$("#elevator").click(function() {
		$("html,body").animate({
			scrollTop : 0
		}, 500);
	});
	$(".qr").hover(function() {
		$(".qr-popup").show();
	}, function() {
		$(".qr-popup").hide();
	});

	// ====class intro
	var $intro = $('#row1 .intro .ui-box-container');
	if ($('#row1 .intro').width() < $intro.width())
		$intro.css('overflow-x', 'scroll');
	else
		$intro.css('overflow-x', 'auto');
	if ($('#row1 .intro').height() < $intro.height())
		$intro.css('overflow-y', 'scroll');
	else
		$intro.css('overflow-y', 'auto');

	loadParty(true);

});