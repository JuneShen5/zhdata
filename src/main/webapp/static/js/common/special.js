$(function pageInit () {
	var data = pageParams;

	// 四级联动
	$(".linkagesel-select-list").on("change",".LinkageSel",function(e){
		$(e.currentTarget).blur();
	});
	// 设置验证信息的默认字段
	$.validator.setDefaults({
	    highlight: function (element) {
	    	if($(element).hasClass('LinkageSel')){
	    		$(element).closest(".form-group").children("label").removeClass('has-success-tips').addClass("has-error-tips");
	    		$(element).next().removeClass('has-success-s').addClass('has-error-s');
	    	} else {
	    		$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
	    	}
	    },
	    success: function (element) {
	    	var thisErrID = $(element).attr("id");
	    	var thisSelect = $("select[aria-describedby='"+thisErrID+"']");
	    	if(thisSelect.hasClass('LinkageSel')){
	    		thisSelect.next().removeClass('has-error-s').addClass('has-success-s');
	    		$(".linkagesel-select-div").find(".LinkageSel").next().each(function(){
	    			thisSelect.closest(".form-group").children("label").removeClass('has-error-tips has-success-tips');
	    			if(!$(this).hasClass('has-error-s')){
	    	    		thisSelect.closest(".form-group").children("label").removeClass('has-error-tips').addClass("has-success-tips");
	    			} else {
	    	    		thisSelect.closest(".form-group").children("label").removeClass('has-success-tips').addClass("has-error-tips");
	    	    		thisSelect.closest(".form-group").find(".help-block").removeClass('has-success-tips').addClass("has-error-span");
	    			}
	    		});
	    	} else {
	    		$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
	    	}
	    },
	    errorElement: "span",
	    errorPlacement: function (error, element) {
	        if (element.is(":radio") || element.is(":checkbox")) {
	            error.appendTo(element.parent().parent().parent());
	        } else if(element.hasClass('LinkageSel')) {
	        	error.appendTo(element.parent().parent());
	            error.addClass("has-error-span");
	        } else {
	            error.appendTo(element.parent());
	        }
	    },
	    errorClass: "help-block m-b-none",
	    validClass: "help-block m-b-none"
	});
	
});

// 表单上传控件
function uploadFile (that) {
	$(that).next(".uploadFile").click();
	$(that).next(".uploadFile").on('change', function () {
		$(that).parents('.form-group').find('.form-control').val($(that).next(".uploadFile").val());
	})
}

// 表单下载文件
function downloadFile (that) {
	window.open($(that).parents('.form-group').find('.form-control').val());
}

