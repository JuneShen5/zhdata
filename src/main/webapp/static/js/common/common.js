$(function() {
	// 点击document关闭dropdown
	$(document).on('click', function () {
		$('#homeIndex .dropdown', window.parent.document).removeClass('open').find('.dropdown-toggle').attr('aria-expanded', 'false');
	});

	// 1.初始化Table
	oTable = new TableInit();
	oTable.Init();

	$(".select-chosen").chosen({
		width : "100%"
	}).change(function (e) {
		console.log("select")
		$(e.currentTarget).blur();
    });
	$(".linkagesel-select-list").on("change",".LinkageSel",function(e){
		$(e.currentTarget).blur();
	});
	
	
	// 时间插件
	$('.datepicker').datepicker({
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
        todayHighlight:true
    }).on("changeDate", function (e) {
    	$(this).blur();
    });

    // 多选下拉框插件
    $('.is-multiple-select').select2({width:'100%',placeholder:' 请选择(可多选)'});
    $(".is-multiple-select").change(function(){
        $(this).valid();
    });
	// checkbox、radio插件
	$('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    })
	$('.i-checks').on('ifChanged', function(e){
    	setTimeout(function () {
    		$(e.currentTarget).siblings("input").blur();
    	}, 0)
    });
    // 设置表单逻辑字段
    $('.js-hasChild').on('change', function () {
        var parentName = $(this).attr('name');
        if ($(this).val() === '1') {
            $('[data-parent=' + parentName + ']').slideDown().find('input:not(.chosen-search input),select,textarea').prop('required', true).val('');
            // $('.chosen-search').find('input').prop('required', false);
        }else {
            $('[data-parent=' + parentName + ']').slideUp().find('input:not(.chosen-search input),select,textarea').prop('required', false).val('');
        }
        $('[data-parent=' + parentName + ']').find('input,select,textarea').each(function () {
            // that.$element.find('form').validate().element($(this));
            // $(this).valid();
            // $(this).find('.chosen-search').children('input').prop('required', false);
            // console.log($(this).find('.chosen-search').children('input').length);
        });
    });
});

// 消息栏数量设置
function updateCount () {
    var count1 = '';
    var count2 = '';
    $.ajax({
        url: url+'list',
        data: {
            pageNum:1,
            pageSize:6,
            obj:JSON.stringify({isAudit: 1,
                isAuthorize:1,
                nameCn:"",
                nameEn:""
            }),
            companyIds:""

        },
        success: function (res) {
            $('#message_count1', window.parent.document).text(res.total);
            count1 = res.total;
            $('#message_number', window.parent.document).text(count1+count2);
        }
    });
    $.ajax({
        url: url+'list',
        data: {
            pageNum:1,
            pageSize:6,
            obj:JSON.stringify({isAudit: 3,
                isAuthorize:1,
                nameCn:"",
                nameEn:""
            }),
            companyIds:""

        },
        success: function (res) {
            $('#message_count2', window.parent.document).text(res.total);
            count2 = res.total;
            $('#message_number', window.parent.document).text(count1+count2);
        }
    });
}

var TableInit = function() {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		$(tableId).bootstrapTable({
			url : url + 'list',
			method : 'get',
			toolbar : toolbar, // 工具按钮用哪个容器
			striped : true, // 是否显示行间隔色
			pagination : true, // 是否显示分页（*）
			queryParams : oTableInit.queryParams, // 传递参数（*）
			sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
			pageNumber : 1, // 初始化加载第一页，默认第一页
			pageSize : 10, // 每页的记录行数（*）
			pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
			showColumns : true, // 是否显示所有的列
			showRefresh : true, // 是否显示刷新按钮
			iconSize : 'outline',
			icons : {
				refresh : 'glyphicon-repeat',
				columns : 'glyphicon-list'
			},
			uniqueId : "id", // 每一行的唯一标识，一般为主键列
		});
		$(tableId).on('post-body.bs.table', function (e) {
			$(this).find('thead').removeClass('ele-hide');
		});
        $(tableId).on('load-success.bs.table', function (e, data) {
        	if (data.startRow !== null){
                updateCount();
			}
        });
	};

	// 得到查询的参数
	oTableInit.queryParams = function(params) {
		/*$("#searchFor").parents(".form-group").find("input").each(function (index, item) {
			obj[$(this).attr("sName")] = $(this).val();
		});*/
		$(toolbar).find(".form-control").each(function (index, item) {
			if ($(this).attr("sName")!==undefined){
                obj[$(this).attr("sName")] = $(this).val();
			}
		})
		console.log("obj: ", obj);
		if ($(".search-list").length>0){
            $(".search-list").find(".form-control").each(function (index, item) {
                if ($(this).attr("sName")!==undefined) {
                    obj[$(this).attr("sName")] = $(this).val();
                }
            });
		}
		var temp = {
			pageNum : params.offset / params.limit + 1,
			pageSize : params.limit,
			obj : JSON.stringify(obj)
		};
		return temp;
	};
	return oTableInit;
};

function initTableButton(index, row, element) {
	var html = '';
	html += '<div class="btn-group">';
	html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
			+ row.id
			+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
	html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
			+ row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
	html += '<button type="button" class="btn btn-white" onclick="deleteRow(\''
			+ row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
	html += '</div>';
	return html;
}

var textVal = "上级配套资金__________（具体经费来源渠道）\n省财政资金__________（具体经费来源渠道）\n市财政资金__________（具体经费来源渠道）\n单位自筹资金__________（具体经费来源渠道）\n其他资金__________   （具体经费来源渠道）";
var jsjfly = $("textarea[name=jianshejingfeilaiyuan]");
// 新增修改
function openLayer(title) {
	if(title=="信息资源新增"){
		removeClassAndData();
	}
	$(".linkagesel-select-div").find(".LinkageSel").prop("disabled", false);
	$(".linkagesel-select-div").find(".LinkageSel").trigger("chosen:updated");
	$(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
	layeForm = layer.open({
		title: title,
		type : 1,
		area : [ '100%', '100%' ],
		scrollbar : false,
		zIndex : 100,
		btn : [ '保存', '关闭' ],
		yes : function(index, layero) {
			if(title=="信息资源新增"||title=="信息资源修改"){
				//将数据加到elementList
				addElementList();
			}
			if (jsjfly.val() == textVal) {
				jsjfly.val("")
			};
			$(formId).submit();
		},
		end : function() {
			$(formId).resetForm();
			endMethod(formId, "close");
		},
		content : $(layerId)
	});
	// 弹出表单之后验证表单
	jsjfly.val("");
	$(formId).validate().form();
	if (jsjfly.val() == "") {
		jsjfly.val(textVal);
		jsjfly.css("color", "#aaa");
	}
}

// 查看详情弹框
function openDetail() {
	layeForm = layer.open({
		title: detailTitle,
		type : 1,
		area : [ '100%', '100%' ],
		scrollbar : false,
		zIndex : 100,
		content : $(layerId),
		cancel : function () {
			endMethod(formId, "close");
		}
	});
}

// 执行提交之后统一执行的方法
// 第一个属性是提交表单的id，第二个属性是判断事件属于提交事情还是关闭事件
function endMethod (closeId, status) {
	// 清除禁选项
	$(closeId).find("input").each(function () {
		$(this).removeAttr("disabled");
	});
	$(closeId).find("textarea").each(function () {
		$(this).removeAttr("disabled");
	});
	try{
		if(zTree) {
			var allnodes = zTree.getNodes();
			for (var i in allnodes) {
				zTree.setChkDisabled(allnodes[i], false, true, true);
			};
		};
	} catch (e) {}
	$(closeId).find("select").prop("disabled", false);
	$(closeId).find("select").trigger("chosen:updated");
	$(closeId).find('.i-checks').iCheck('enable');
	console.log("清空表单: ", closeId)
	// 将表单验证去掉
	$(closeId).validate().resetForm();
	setTimeout(function () {
		$(closeId).find("#linkageSelSelect_chosen").width('100%');
	},500);
	$(closeId).find(".form-group").each(function (item) {
        $(this).removeClass("has-error");
        $(this).removeClass("has-success");
        $(this).children("label").removeClass("has-success-tips has-error-tips");
        $(this).find(".chosen-container").removeClass("has-success-s has-error-s");
        $(this).find(".i-checks>div").removeClass("checked");
        // $(this).find(".help-block").remove();
    });
	// 将插件加上的属性去掉
	// $(".chosen-container").find("span").text("");
	$(closeId).find("select").val("");
	$(closeId).find("select").trigger("chosen:updated");
	$(closeId).find(".i-checks").find("input").removeAttr("checked");
	$(closeId).find(".i-checks").find("div.checked").removeClass("checked");
    $(closeId).find('select[name=shareCondition],select[name=shareMode],select[name=openType]').closest('.form-group').hide().val('').trigger("chosen:updated").removeAttr("required");
    // console.log($(closeId).find('select[name=shareCondition],select[name=shareMode],select[name=openType]').closest('.form-group').length);
    $(closeId).find(".is-multiple-select").val('').trigger("change");
    // 将相关下拉框选项隐藏
    $('.js-hasChild').each(function (index) {
        var parentName = $(this).attr('name');
        $('[data-parent=' + parentName + ']').addClass('ele-hide').find('input:not(.chosen-search input),select,textarea').prop('required', false).val('');
    });
	try{
		if(resetPage) {
			resetPage(status, closeId);
		};
	} catch (e) {};
}

// 验证表单
$(function () {
	$(formId).validate({
		ignore: ":hidden:not(select,input)",
        submitHandler: function(form){
            $(document).one('click', '.layui-layer-btn0', function () {
                $(this).hide();
                $(this).before('<button class="btn btn-primary a-disabled" disabled>操作中...</button>');
            });
        	$(formId).ajaxSubmit({
    			url : url + 'save',
    			type : 'post',
    			success : function(data){
    				layer.close(layeForm);
    				$(tableId).bootstrapTable('refresh');
    				layer.msg(data);
    				endMethod(formId);
    			},
    			error : function(XmlHttpRequest, textStatus, errorThrown){
    				layer.close(layeForm);
    				$(tableId).bootstrapTable('refresh');
    				layer.msg("数据操作失败!");
    				endMethod(formId);
    			},
    			resetForm : true
    		});
    		return false;
        }
    });
})

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


// 查看表单详情
function datailRow(id) {
	var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
	openDetail();
	loadData(row);
	disabledMenu(formId);
}

// 然后将所有表单中的选项做一个禁选中操作
function disabledMenu (formId) {
	$(formId).find("input").each(function () {
		$(this).attr("disabled","disabled");
	});
	$(formId).find("textarea").each(function () {
		$(this).attr("disabled","disabled");
	});
	// 判断是否存在树插件，禁止check改变
	try{
		if(zTree) {
			var allnodes = zTree.getNodes();
			for (var i in allnodes) {
				zTree.setChkDisabled(allnodes[i], true, true, true);
			};
		};
	} catch (e) {}
	// 判断select
	$(formId).find("select").prop("disabled", true);
	$(formId).find("select").trigger("chosen:updated");
	setTimeout(function(){
		$(formId).find(".linkagesel-select-div").find(".LinkageSel").prop("disabled", true);
		$(formId).find(".linkagesel-select-div").find(".LinkageSel").trigger("chosen:updated");
		$(formId).find(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
		// i-ckeck将自动验证去掉
		$(formId).find('.i-checks').closest(".form-group").removeClass("has-success");
	},500);
	// checkbox
	$(formId).find('.i-checks').iCheck('disable');
}

// 修改，表单回显功能
function editRow(id) {
	var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
	openLayer(editTitle);
	loadData(row);
	// 通过验证
	$(formId).validate().form();
	if(editTitle=="信息资源修改"){
		$("#selectElement").removeClass("hide");	
	}
}

//批量删除
function deleteAll () {
	var delData = $(tableId).bootstrapTable('getSelections');
	if (delData.length == 0) {
		layer.msg("请至少选择一项数据");
		return;
	}
	var ids = new Array();
	$.each(delData, function (index, item) {
		ids.push(item.id);
	})
	ids = JSON.stringify(ids);
	deleteRow(ids.slice(1, ids.length - 1));
}

// 删除数据
function deleteRow(ids) {
	layeConfirm = layer.confirm('您确定要删除么？', {
		btn : [ '确定', '取消' ]
	}, function() {
		$.post(url + 'delete', {
			ids : ids
		}, function(data) {
			layer.close(layeConfirm);
			$(tableId).bootstrapTable('refresh');
			layer.msg(data);
			endMethod(formId);
		}, 'json');
	});
}

// 数据具体的回显功能，存在巨大的bug，请使用下面的
function loadData(row) {
	console.log("row: ", row);
	var obj = row;
	var key, value, tagName, type, arr;
	for (x in obj) {
		key = x;
		value = obj[x];
		if(key=='elementList'){
			dataTo(value);
		}
		$("[name='" + key + "'],[name='" + key + "[]']").each(function() {
			tagName = $(this)[0].tagName;
			type = $(this).attr('type');
			if (tagName == 'INPUT') {
				if (type == 'radio') {
					$(this).attr('checked', $(this).val() == value);
				} else {
					$(this).val(value);
					if ($(this).attr("stype") == "checkbox") {
						var fthis = $(this).closest(".form-group");
						arr = value.split(',');
						console.log("arr: ", arr);
						for (var i = 0; i < arr.length; i++) {
							/*if ($(this).val() == arr[i]) {
								$(this).attr('checked', true);
								break;
							}*/
							fthis.find("input").each(function (index, item) {
								if ($(this).val() == arr[i]) {
									$(this).iCheck('check');
								};
							});
						};
					}
				}
			} else if (tagName == 'TEXTAREA') {
				$(this).val(value);
			} else if (tagName == 'SELECT') {
				// 判断是否是联动
				if ($(this).attr("id") == "linkageSelSelect") {
					var linkageSelData = new Array();
					linkageSelData.push(value);
					// 判断是否存在后续的数据
					for (var i = 2; i < 100; ++i) {
						if (row["infoType" + i] !== undefined) {
							linkageSelData.push(row["infoType" + i]);
						} else {
							break;
						}
					}
					console.log(linkageSelData);
					loadLinkageSel(linkageSelData);
					// 清除四级联动查看及修改额外样式
					// setTimeout(function(){
					// 	$(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
					// 	$(".linkagesel-select-group-info ").find(".chosen-container").removeClass("has-error-s has-success-s");
					// },500);
				}else if ($(this).hasClass('is-multiple-select')){
                    var values = new Array(); //定义一数组
                    values = value.toString().split(",");
                    $(this).val(values).trigger("change");
                    $(this).closest('.form-group').removeClass('has-success has-error');
                } else {
					$(this).val(value);
					$(this).trigger("chosen:updated");
				}
			} else if (tagName == 'UL') {
				console.log("树回显: ", value);
				// 在回显的时候暂时先将父级影响子级关闭，回显结束之后再将其打开
				zTree.setting.check.chkboxType = {"Y": "", "N": "ps"}
				zTree.checkAllNodes(false);
				var checkData = []
				for (var i in value) {
					zTree.checkNode(zTree.getNodeByParam("id", value[i].id, null), true, true);
					checkData.push({
						id : value[i].id
					});
				};
				zTree.setting.check.chkboxType = {"Y": "s", "N": "ps"}
				$("#menuIds").val(JSON.stringify(checkData));
			}
		});
	}
	// 数据回显之后自动更新插件回显
	$('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    shareToggle();
    // 判断相关下拉框选项
    $('.js-hasChild').each(function (index) {
        var parentName = $(this).attr('name');
        if ($(this).val() === '1') {
            $('[data-parent=' + parentName + ']').removeClass('ele-hide').find('input:not(.chosen-search input),select,textarea').prop('required', true);
        }else {
            $('[data-parent=' + parentName + ']').slideUp().find('input:not(.chosen-search input),select,textarea').prop('required', false).val('');
        }
    });
}

// 数据具体的回显功能，上面的存在bug
function loadToData(row, formId) {
	console.log("row: ", row);
	var obj = row;
	var key, value, tagName, type, arr;
	for (x in obj) {
		key = x;
		value = obj[x];
		if(key=='elementList'){
			dataTo(value);
		}
		$('#' + formId).find("[name='" + key + "'],[name='" + key + "[]']").each(function() {
			tagName = $(this)[0].tagName;
			type = $(this).attr('type');
			if (tagName == 'INPUT') {
				if (type == 'radio') {
					$(this).attr('checked', $(this).val() == value);
				} else {
					$(this).val(value);
					if ($(this).attr("stype") == "checkbox") {
						var fthis = $(this).closest(".form-group");
						arr = value.split(',');
						console.log("arr: ", arr);
						for (var i = 0; i < arr.length; i++) {
							/*if ($(this).val() == arr[i]) {
								$(this).attr('checked', true);
								break;
							}*/
							fthis.find("input").each(function (index, item) {
								if ($(this).val() == arr[i]) {
									$(this).iCheck('check');
								};
							});
						};
					}
				}
			} else if (tagName == 'TEXTAREA') {
				$(this).val(value);
			} else if (tagName == 'SELECT') {
				// 判断是否是联动
				if ($(this).attr("id") == "linkageSelSelect") {
					var linkageSelData = new Array();
					linkageSelData.push(value);
					// 判断是否存在后续的数据
					for (var i = 2; i < 100; ++i) {
						if (row["infoType" + i] !== undefined) {
							linkageSelData.push(row["infoType" + i]);
						} else {
							break;
						}
					}
					console.log(linkageSelData);
					loadLinkageSel(linkageSelData);
				}else if ($(this).hasClass('is-multiple-select')){
                    var values = new Array(); //定义一数组
                    values = value.split(",");
                    $(this).val(values).trigger("change");
                    $(this).closest('.form-group').removeClass('has-success has-error');
                }  else {
					console.log("value: ", value)
					$(this).val(value);
					$(this).trigger("chosen:updated");
				}
			} else if (tagName == 'UL') {
				console.log("树回显: ", value);
				// 在回显的时候暂时先将父级影响子级关闭，回显结束之后再将其打开
				zTree.setting.check.chkboxType = {"Y": "", "N": "ps"}
				zTree.checkAllNodes(false);
				var checkData = []
				for (var i in value) {
					zTree.checkNode(zTree.getNodeByParam("id", value[i].id, null), true, true);
					checkData.push({
						id : value[i].id
					});
				};
				zTree.setting.check.chkboxType = {"Y": "s", "N": "ps"}
				$("#menuIds").val(JSON.stringify(checkData));
			}
		});
	}
	// 数据回显之后自动更新插件回显
	$('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    shareToggleName(formId);
    // 判断相关下拉框选项
    $('.js-hasChild').each(function (index) {
        var parentName = $(this).attr('name');
        if ($(this).val() === '1') {
            $('[data-parent=' + parentName + ']').removeClass('ele-hide').find('input:not(.chosen-search input),select,textarea').prop('required', true);
        }else {
            $('[data-parent=' + parentName + ']').slideUp().find('input:not(.chosen-search input),select,textarea').prop('required', false).val('');
        }
    });
}

// 四级联动数据获取之后样式的变化
function linkageselChosen () {
	setTimeout(function () {
		$(".LinkageSel").hide();
		$(".LinkageSel").chosen({width: "48%"});
		$(".LinkageSel").trigger("chosen:updated");
	}, 0)
}
// 四季联动动态的将数据赋值进去
function loadLinkageSel (data) {
	linkRelInfo.changeValues(data, true);
};


// checkbox取值--注意放在最下面
$('.i-checks').on('ifChanged', function(event){ 
	// 遍历dom节点将数据放入上面的隐藏域中
	var isCheckData = [];
	// 回调函数执行顺序存在问题，先执行的回调函数方法，再改变样式
	setTimeout(function () {
  		var that = event.currentTarget
		$(that).parents(".form-group").find("div.checked").each(function (index, item) {
  			isCheckData.push($(this).children("input").val());
  		});
  		$(that).siblings(".checkboxInput").val(isCheckData)
	}, 0)
}); 

// 上传控件
function uploadFile (that) {
	$(that).next(".uploadFile").click();
	$(that).next(".uploadFile").on('change', function () {
		$(that).parents('.form-group').find('.form-control').val($(that).next(".uploadFile").val());
	})
}

// 下载
function downloadFile (that) {
	window.open($(that).parents('.form-group').find('.form-control').val());
}

// layertips提示框，在class中加上layerTips即可，data-tips-text是提示的内容
$(function (){
	$(".layerTips").mouseenter(function(event) {
		var $this = $(this);
		var tipsIndex = "";
		tipsIndex = layer.tips($this.attr("data-tips-text"), $this, {tips: [3, 'rgba(68,68,68,.9)'],time: 0});
		var thisTagWidth = $("#layui-layer"+tipsIndex).width();
//		宽度与依附元素宽度相同
//		$(".layui-layer-tips").width($this.width());
//		宽度随内容改变
		var tipsLeft = parseInt($this.css("paddingLeft"))+parseInt($this.width())-thisTagWidth;
		if($this.attr("data-tips-text")==""){
			$("#layui-layer"+tipsIndex).css("display", "none");
		}
		$("#layui-layer"+tipsIndex).css("left", tipsLeft);
		$("#layui-layer"+tipsIndex).find("i").css({"border-left-color": "rgba(68, 68, 68, 0.9)","border-right-color": "transparent","border-bottom": "none","right":"5px","left":"auto"});
		// $(".layui-layer-tips").children(".layui-layer-content").css("color", "#666")
		$("#layui-layer"+tipsIndex).children(".layui-layer-content").css("padding", "2px 10px");
	}).mouseleave(function(event){
		layer.close(layer.index);
	});
});


function tf(str){
  var arr=str.split("_");
  for(var i=1;i<arr.length;i++){
    arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substring(1);
  }
  return arr.join("");
};

/*导出字段勾选结束*/

// 共享、开放显示相关
// 事件绑定
function shareToggleMethod() {
    var gxlxSelect = $("select[name=shareType]");
    if (gxlxSelect !== undefined) {
        // 共享方式
        var gxtjSelect = gxlxSelect.closest('form').find('input[name=shareCondition]');
		var gxfsSelect = gxlxSelect.closest('form').find('select[name=shareMode]');
		var fbrqSelect = gxlxSelect.closest('form').find('input[name=releaseDate]');
        var gxlxValue = parseInt(gxlxSelect.val());
        gxtjSelect.closest('.form-group').hide();
        gxtjSelect.removeAttr("required");
        gxfsSelect.closest('.form-group').hide();
        gxfsSelect.removeAttr("required");
        fbrqSelect.closest('.form-group').hide();
        fbrqSelect.removeAttr("required");
        gxlxSelect.chosen({
            width: "100%"
        }).on('change', function () {
            var thisValue = parseInt($(this).val());
            if (thisValue === 1) {
                gxfsSelect.closest('.form-group').hide();
                gxfsSelect.closest('.form-group').slideToggle();
                gxfsSelect.attr("required", "required");
                gxtjSelect.closest('.form-group').hide();
                gxtjSelect.val("");
                gxtjSelect.trigger("chosen:updated");
                gxtjSelect.removeAttr("required");
                fbrqSelect.closest('.form-group').hide();
                fbrqSelect.closest('.form-group').slideToggle();
                fbrqSelect.attr("required", "required");
            } else if (thisValue === 2) {
                gxfsSelect.closest('.form-group').hide();
                gxtjSelect.closest('.form-group').hide();
                gxfsSelect.closest('.form-group').slideToggle();
                gxfsSelect.attr("required", "required");
                gxtjSelect.closest('.form-group').slideToggle();
                gxtjSelect.attr("required", "required");
                fbrqSelect.closest('.form-group').hide();
                fbrqSelect.closest('.form-group').slideToggle();
                fbrqSelect.attr("required", "required");
            } else if (thisValue === 3) {
                gxfsSelect.closest('.form-group').hide();
                gxfsSelect.val("");
                gxfsSelect.trigger("chosen:updated");
                gxfsSelect.removeAttr("required");
                gxtjSelect.closest('.form-group').hide();
                gxtjSelect.val("");
                gxtjSelect.trigger("chosen:updated");
                gxtjSelect.removeAttr("required");
                fbrqSelect.closest('.form-group').hide();
                fbrqSelect.val("");
                fbrqSelect.removeAttr("required");
            }
        });
    }
    // 是否向社会开放
    var isOpenSelect = $("select[name=isOpen]");
    if (isOpenSelect !== undefined) {
        var kflxSelect = isOpenSelect.closest('form').find("select[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        isOpenSelect.chosen({
            width: "100%"
        }).on('change', function () {
            var thisValue = parseInt($(this).val());
            if (thisValue === 1) {
                kflxSelect.closest('.form-group').slideToggle();
                kflxSelect.attr("required", "required");
            } else if (thisValue === 0) {
                kflxSelect.closest('.form-group').hide();
                kflxSelect.val("");
                kflxSelect.trigger("chosen:updated");
                kflxSelect.removeAttr("required");
            }
        });
    }
}
// 状态判断及事件绑定
function shareToggle() {
	// 共享方式
    var gxlxSelect = $("select[name=shareType]");
    // 是否向社会开放
    var isOpenSelect = $("select[name=isOpen]");
	shareToggleChange(gxlxSelect, isOpenSelect)
}

// 当页面中存在两张表时，可以通过formId来辨别
function shareToggleName (formId) {
	var gxlxSelect = $('#' + formId).find("select[name=shareType]");
    var isOpenSelect = $('#' + formId).find("select[name=isOpen]");
	shareToggleChange(gxlxSelect, isOpenSelect);
}

function shareToggleChange (gxlxSelect, isOpenSelect) {
	if (gxlxSelect !== undefined){
		var gxtjSelect = gxlxSelect.closest('form').find('input[name=shareCondition]');
		var gxfsSelect = gxlxSelect.closest('form').find('select[name=shareMode]');
        var fbrqSelect = gxlxSelect.closest('form').find('input[name=releaseDate]');
		var gxlxValue = parseInt(gxlxSelect.val());
		gxtjSelect.closest('.form-group').hide();
		gxtjSelect.removeAttr("required");
		gxfsSelect.closest('.form-group').hide();
		gxfsSelect.removeAttr("required");
        fbrqSelect.closest('.form-group').hide();
        fbrqSelect.removeAttr("required");
		if (gxlxValue === 1) {
			gxfsSelect.closest('.form-group').show();
			gxfsSelect.attr("required", "required");
			gxtjSelect.closest('.form-group').hide();
			gxtjSelect.val("");
			gxtjSelect.trigger("chosen:updated");
			gxtjSelect.removeAttr("required");
            fbrqSelect.closest('.form-group').show();
            fbrqSelect.attr("required", "required");
		} else if (gxlxValue === 2) {
			gxfsSelect.closest('.form-group').show();
			gxtjSelect.closest('.form-group').show();
			gxfsSelect.attr("required", "required");
			gxtjSelect.attr("required", "required");
            fbrqSelect.closest('.form-group').show();
            fbrqSelect.attr("required", "required");
		} else if (gxlxValue === 3) {
			gxfsSelect.closest('.form-group').hide();
			gxfsSelect.val("");
			gxfsSelect.trigger("chosen:updated");
			gxfsSelect.removeAttr("required");
			gxtjSelect.closest('.form-group').hide();
			gxtjSelect.val("");
			gxtjSelect.trigger("chosen:updated");
			gxtjSelect.removeAttr("required");
            fbrqSelect.closest('.form-group').hide();
            fbrqSelect.val("");
            fbrqSelect.removeAttr("required");
		}
    }
    if (isOpenSelect !== undefined) {
        var kflxSelect = isOpenSelect.closest('form').find("select[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        if (isOpenValue === 1) {
            kflxSelect.closest('.form-group').slideToggle();
            kflxSelect.attr("required", "required");
        } else if (isOpenValue === 0 || isOpenValue === '') {
            kflxSelect.closest('.form-group').hide();
            kflxSelect.val("");
            kflxSelect.trigger("chosen:updated");
            kflxSelect.removeAttr("required");
        }
    }
}

/**********************************导入导出EXCEL开始**********************************************/

/*导入导出定义的全部变量 */
	var exportForm = '#exportForm';
	var importForm = '#importForm';
	var exportBox = '#exportData';
	var importBox = '#importData';
	
	$(function(){
		rowName();
		$($("#importData input[name='obj']")).val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
		//$("#obj").val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
	})
	/*导出字段勾选开始*/
	$("#exportData input[type='checkbox']").click(function(){
		rowName();
	})
	
	//更改导出弹框复选框都选字段
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
	
	function tf(str){
		  var arr=str.split("_");
		  for(var i=1;i<arr.length;i++){
		    arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substring(1);
		  }
		  return arr.join("");
		};
	// 导出
	function exportData() {
		rowName();//重新点开时，吧勾选的重新复制一遍
		layer.open({
			type : 1,
			title : '确认要导出用户数据吗？',
			btn : [ '确定', '取消' ],
			scrollbar : false,
			area : [ '60%', '50%' ],
			zIndex : 100,
			yes : function(index, layero) {
				layer.close(index);
				$(exportForm).attr("action",uploaderServer+"/exportData");
				$(exportForm).submit();
			},
			end : function() {
				$(exportForm).resetForm();
			},
			content : $(exportBox)
		});
	}
	
	// 导入
	function importData(attributeType) {
		$("#file-message").html("");//清空上次上传后的提示信息
		$("#message").html("");
		console.log("attributeType:",attributeType)
	var importDataLayer	= layer.open({
			type : 1,
			title : '导入数据',
			scrollbar : false,
			area : [ '50%', '60%' ],
			zIndex : 100,
			success: function(layero, index){
				initUploader(importDataLayer,attributeType);
			},
			content : $(importBox),
			
		});
	}
	
	//下载模板
	function downloadTemplate(){
		//设置下载模板的请求路径
		$(importForm).attr("action",uploaderServer+"/downloadTemplate")
		$(importForm).submit();
	}
	
	//文件导入方法
	function initUploader(importDataLayer,attributeType){
		$("#filePicker").text("上传数据文件");
		uploader = WebUploader.create({
			// 选完文件后，是否自动上传。
			auto: true,
			// swf文件路径
			swf: '${ctxStatic}/js/plugins/webuploader/Uploader.swf',
			//传输的参数
			formData: {"attributeType":attributeType},//参数列表  
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
            var html = '<div style="position: absolute;"><img src="../static/js/plugins/webuploader/img/excel.png"  alt="excel" /></div>'+
                '<div id="' + file.id + '" class="item" style="display: inline-block; vertical-align: top;">' +
                '<h4 class="uploader-info">' + file.name + '</h4>' +
                '</div>';
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
            $("#message").addClass('uploader-unfail').removeClass('font-color-green font-color-red');
            $("#message").html('<i class="fa fa-spinner" aria-hidden="true"></i> '+'上传中...');
		    $percent.css( 'width', percentage * 100 + '%' );
		});

        uploader.on("uploadAccept", function( file, data){
            if(data=="数据导入完成"){
                $("#message").html('<i class="fa fa-check"></i> '+data).addClass('font-color-green');
                layer.close(importDataLayer);
                $(tableId).bootstrapTable('refresh');
            }else{
                $("#message").removeClass('uploader-unfail').html('<i class="fa fa-times-circle" aria-hidden="true"></i> '+data).addClass('font-color-red');
            }
//		    if ( data.success=="0") {
//		        // 通过return false来告诉组件，此文件上传有错。
//		        return false;
//		    }
        });
		/*    完成上传完了，成功或者失败，先删除进度条。 */
		uploader.on( 'uploadComplete', function( file ) {
		     $( '#'+file.id ).find('.progress').fadeOut();
		});
		setTimeout(function () {
			uploader.refresh();
		}, 50)
	}
/**********************************导入导出EXCEL结束**********************************************/


/*** 临时删除信息资源分类3和信息资源分类4，待删除 ***/
$(function () {
    $('.form-group').each(function () {
        var $this = $(this);
        if ($this.find('label').text() === '信息资源分类3 :' || $this.find('label').text() === '信息资源分类4 :'){
            $this.hide();
        }
    });
});
/*** 临时删除信息资源分类3和信息资源分类4，待删除 ***/
