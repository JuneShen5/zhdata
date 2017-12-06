// 导出
function exportData() {
	layer.open({
		type : 1,
		title : '确认要导出用户数据吗？',
		btn : [ '确定', '取消' ],
		scrollbar : false,
		area : [ '60%', '50%' ],
		zIndex : 100,
		yes : function(index, layero) {
			layer.close(index);
			$(exportForm).submit();
		},
		end : function() {
			$(exportForm).resetForm();
		},
		content : $(exportBox)
	});
};

// 导入
function importData() {
var importDataLayer	= layer.open({
		type : 1,
		title : '导入数据',
		scrollbar : false,
		area : [ '50%', '60%' ],
		zIndex : 100,
		success: function(layero, index){
			initUploader(importDataLayer);
		},
		content : $(importBox),
		
	});
}

//下载模板
function downloadTemplate(){
	$(importForm).submit();
}

//文件导入方法
function initUploader(importDataLayer){
	$("#filePicker").text("上传数据文件");
	uploader = WebUploader.create({
		// 选完文件后，是否自动上传。
		auto: true,
		// swf文件路径
		swf: '${ctxStatic}/js/plugins/webuploader/Uploader.swf',
		// 文件接收服务端。
		server: uploaderServer+'/importData',
		// 选择文件的按钮。可选。
		pick: '#filePicker',
		// 只允许选择Excel文件。
		timeout: 0,
		duplicate :true ,
		accept: {
		    title: 'Excel',
		    extensions: 'xls,xlsx',
		    mimeTypes: 'Excel/*'
		}
	});

	uploader.on( 'fileQueued', function( file ) {
		var html = '<div style="display: inline-block; vertical-align: top;"><img src="${ctxStatic}/js/plugins/webuploader/img/excel.png"  alt="excel" /></div>'+
					'<div id="' + file.id + '" class="item" style="display: inline-block; vertical-align: top;">' +
			        '<h4 class="info">' + file.name + '</h4>' +
			    '</div>'
		$("#file-message").html(html);
	});

	// 文件上传过程中创建进度条实时显示。
	uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress .progress-bar');
	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<div class="progress progress-striped active">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	    }
	    $("#message").text("上传中");
	    $percent.css( 'width', percentage * 100 + '%' );
	});

	// 文件上传成功，给item添加成功class, 用样式标记上传成功。
	uploader.on( 'uploadSuccess', function( file,response) {
		$("#message").text(response).css("color", "#1ab394");
		layer.close(importDataLayer);
		$(tableId).bootstrapTable('refresh');
	});
	// 文件上传失败，显示上传出错。
	uploader.on( 'uploadError', function( file) {
	   $("#message").text("上传失败").css("color", "#ed5565");
	});
	/*    完成上传完了，成功或者失败，先删除进度条。 */
	uploader.on( 'uploadComplete', function( file ) {
	     $( '#'+file.id ).find('.progress').fadeOut();
	});
	setTimeout(function () {
		uploader.refresh();
	}, 50)
}

/*导出字段勾选开始*/
$("#exportData input[type='checkbox']").click(function(){
	rowName();
})

function rowName(){
	var obj = "";
	$("#exportData input[type='checkbox']:checked").each(function(){
		var nameEn = $(this).attr("nameEn");
		var nameCn = $(this).attr("nameCn");
		var inputType = $(this).attr("inputType");
		var inputValue = tf($(this).attr("inputValue")); //有关联数据时需要用到_,所以这边先装换一下
		
		obj += nameCn+"_"+nameEn+"_"+inputType+"_"+inputValue+",";
	})
	$("#exportData input[name='obj']").val(obj.substring(0,obj.length-1));
}
$(function(){
	rowName();
	$($("#importData input[name='obj']")).val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
	//$("#obj").val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
})

function tf(str){
  var arr=str.split("_");
  for(var i=1;i<arr.length;i++){
    arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substring(1);
  }
  return arr.join("");
};

/*导出字段勾选结束*/
