/**
 * javscript for header,content,left side bar,footer
 */
/**添加至收藏
 * @param url
 * @param title
 * @returns {Boolean}
 */
function addToFav(url, title) {

	if (window.sidebar && window.sidebar.addPanel) { // Mozilla Firefox
														// Bookmark
		window.sidebar.addPanel(title, url, "");
	} else if (window.external && window.external.addFavorite) { // IE
																	// Favorite
		window.external.addFavorite(url, title);
	} else if (window.opera) { // Opera 7+
		return false; // do nothing
	} else {
		alert('您的浏览器不支持此操作，请按下Ctrl+D手动收藏本站。');
	}
}
// 将imageDest图片的大小按比例缩放,适合显示在宽W和高H的区域内
function ResizeImage(imageDest, W, H) {
	// 显示框宽度W,高度H
	var image = new Image();
	image.src = imageDest.src;
	if (image.width > 0 && image.height > 0) {
		// 比较纵横比
		if (image.width / image.height >= W / H)// 相对显示框：宽>高
		{
			if (image.width > W) // 宽度大于显示框宽度W，应压缩高度
			{
				imageDest.width = W;
				imageDest.height = (image.height * W) / image.width;
			} else // 宽度少于或等于显示框宽度W，图片完全显示
			{
				imageDest.width = image.width;
				imageDest.height = image.height;
			}
		} else// 同理
		{
			if (image.height > H) {
				imageDest.height = H;
				imageDest.width = (image.width * H) / image.height;
			} else {
				imageDest.width = image.width;
				imageDest.height = image.height;
			}
		}
	}
}
// 将imageDest图片的大小按比例缩放,使图像完全显示在宽W和高H的区域内,
function FillImage(image, W, H) {
	if (image.width > 0 && image.height > 0) {
		// 比较纵横比
		image.style.position='relative';
		var whrate = image.width / image.height; //宽高比
		if ( whrate>= W / H)// 相对显示框：宽>高
		{
			image.style.height = H+'px';
			image.style.right = ((H*whrate-W)/2)+'px';
		} else// 同理
		{
			image.style.width = W+'px';
			image.style.top = -((W/whrate-H)/2)+'px';
		}
	}
}

//为jQuery对象扩展serializeObject()方法
if(!jQuery) console.error('please import jQuery first!');
else{
	jQuery.fn.extend({
		serializeObject:function(){
			var obj=new Object();  
			$.each(this.serializeArray(),function(index,param){  
				if(!(param.name in obj)){  
					obj[param.name]=param.value;  
				}  
			});  
			return obj; 
		}
	})
}

/**格式化日期函数yy-MM-dd hh:mm:ss q季度 S毫秒
 * @param date
 * @param format
 * @returns
 */
function FormatDate(date,format){
	date = new Date(date);

    var map = {
        "M": date.getMonth() + 1, //月份 
        "d": date.getDate(), //日 
        "h": date.getHours(), //小时 
        "m": date.getMinutes(), //分 
        "s": date.getSeconds(), //秒 
        "q": Math.floor((date.getMonth() + 3) / 3), //季度 
        "S": date.getMilliseconds() //毫秒 
    };
    format = format.replace(/([yMdhmsqS])+/g, function(all, t){
        var v = map[t];
        if(v !== undefined){
            if(all.length > 1){
                v = '0' + v;
                v = v.substr(v.length-2);
            }
            return v;
        }
        else if(t === 'y'){
            return (date.getFullYear() + '').substr(4 - all.length);
        }
        return all;
    });
    return format;
}

$(function(){
	$(window).scroll(function(){
		//console.log($('#menu').offset())
	})
})