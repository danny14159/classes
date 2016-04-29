
function onfinish(){
	
	uploader.upload();
	return false;
}
$(function(){
	//initial params
	var $list=$("#fileList"),
		thumbnailWidth = 112,
		thumbnailHeight = 112;
	
	uploader = WebUploader.create({

	    // swf文件路径
	    swf:'/f/assets/webuploader-0.1.5/Uploader.swf',

	    // 文件接收服务端。
	    server: 'upd/stuavatar',

	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#filePicker',

	    // 只允许选择图片文件。
	    accept: {
	        title: 'Images',
	        extensions: 'gif,jpg,jpeg,bmp,png',
	        mimeTypes: 'image/*'
	    },
		fileVal:'avatar',
		fileNumLimit : 1,
		fileSizeLimit : 5*1024*1024 /*200KB*/,
		/*auto:true*/ /*选中即自动上传*/
	});
	
	// 当有文件添加进来的时候
	uploader.on( 'fileQueued', function( file ) {
		//TODO 先把当前文件队列和预览队列清空
		
	    var $li = $(
	            '<div id="' + file.id + '" class="file-item thumbnail">' +
	                '<img>' +
	                '<div class="picFileInfo">' + file.name + '</div>' +
	            '</div>'
	            ),
	        $img = $li.find('img');


	    // $list为容器jQuery实例
	    $list.append( $li );

	    // 创建缩略图
	    // 如果为非图片文件，可以不用调用此方法。
	    // thumbnailWidth x thumbnailHeight 为 100 x 100
	    uploader.makeThumb( file, function( error, src ) {
	        if ( error ) {
	            $img.replaceWith('<span>不能预览</span>');
	            return;
	        }

	        $img.attr( 'src', src );
	    }, thumbnailWidth, thumbnailHeight );
	    
	    $('#fmain').show();
	});
	
	// 文件上传过程中创建进度条实时显示。
	uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress span');

	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<p class="progress"><span></span></p>')
	                .appendTo( $li )
	                .find('span');
	    }

	    $percent.css( 'width', percentage * 100 + '%' );
	});

	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadSuccess', function( file ,response) {
		console.log(arguments);
		if(!response.ok){
			alert(response.msg);return;
		}
		$("#hidlogo").val(response.msg);
		
		$.get("stu/upd?"+$("#fmain").serialize(),function(data){
			if(data && data.ok){
				alert('设置成功');
			}
			else{
				alert(data.msg);
			}
		},'json');
	    $( '#'+file.id ).addClass('upload-state-done');
	    
	});

	// 文件上传失败，显示上传出错。
	uploader.on( 'uploadError', function( file ) {
	    var $li = $( '#'+file.id ),
	        $error = $li.find('div.error');

	    // 避免重复创建
	    if ( !$error.length ) {
	        $error = $('<div class="error"></div>').appendTo( $li );
	    }

	    $error.text('上传失败');
	});

	// 完成上传完了，成功或者失败，先删除进度条。
	uploader.on( 'uploadComplete', function( file ) {
	    $( '#'+file.id ).find('.progress').remove();
	});
	
	uploader.on('error',function(reason,limit,file){
		var prompt={
				'Q_EXCEED_NUM_LIMIT':'上传图片数量应不超过'+limit+'幅',
				'Q_EXCEED_SIZE_LIMIT':'上传图片大小应不超过'+limit/1024+'KB',
				'Q_TYPE_DENIED':'文件类型选择不正确！'
		};
		alert(prompt[reason]);
	});

});