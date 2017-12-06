/*

* 初始化配置项
* 可通过pageInit().function()在外部调用
*
*/
$(function pageInit () {
	var data = pageParams;
	// 1.初始化Table
	oTable = new TableInit(data.tableId, data.url);
	oTable.Init();

	// 初始化select
	$(".select-chosen").chosen({
		width : "100%"
	}).change(function (e) {
		$(e.currentTarget).blur();
    });
	
	// 初始化时间插件
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
	
	// 初始化checkbox、radio插件
	$('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    })
	$('.i-checks').on('ifChanged', function(e){
    	setTimeout(function () {
    		$(e.currentTarget).siblings("input").blur();
    	}, 0)
    });
	
	// 初始化textarea自定义注释
	/*var textareaData = [];
	$(data.formId).find("textarea").each(function (index, item) {
		textareaData[index] = $(this).attr("placeholder");
		console.log("val: ", textareaData[index]);
		$(this).attr("placeholder", "");
		$(this).focus(function () {
			if ($(this).val() == textareaData[index]) {
				$(this).val("");
				$(this).css("color", "#000")
			}
		});
		$(this).blur(function () {
			if ($(this).val() == "") {
				$(this).val(textareaData[index]);
				$(this).css("color", "#aaa")
			}
		});
	});*/
	
	// 验证表单
	$(function () {
		$(data.formId).validate({
			ignore: ":hidden:not(select,input)",
	        submitHandler: function(form){
	        	$(data.formId).ajaxSubmit({
	    			url : data.url + 'save',
	    			type : 'post',
	    			success : function(dataReturn){
	    				layer.close(layeForm);
	    				$(data.tableId).bootstrapTable('refresh');
	    				layer.msg(dataReturn);
	    				endMethod(data.formId);
	    			},
	    			error : function(XmlHttpRequest, textStatus, errorThrown){
	    				layer.close(layeForm);
	    				$(data.tableId).bootstrapTable('refresh');
	    				layer.msg("数据操作失败!");
	    				endMethod(data.formId);
	    			},
	    			resetForm : true
	    		});
	    		return false;
	        }
	    });
	})

	// layertips提示框，在class中加上layerTips即可，data-tips-text是提示的内容
	$(function (){
		$(".layerTips").mouseenter(function(event) {
			var $this = $(this);
			var tipsIndex = "";
			tipsIndex = layer.tips($this.attr("data-tips-text"), $this, {tips: [3, 'rgba(68,68,68,.9)'],time: 0});
			var thisTagWidth = $("#layui-layer"+tipsIndex).width();
//			宽度与依附元素宽度相同
//			$(".layui-layer-tips").width($this.width());
//			宽度随内容改变
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
	
	// checkbox取值
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
});

/*

* 公用的js方法
* 通过commonEvent(data).function()在外部调用
* 
*/
function commonEvent (data) {
	var list = [{
		name: "详情",
		event: "datailRow",
		params: ["id"],
		icon: "fa-info-circle"
	}, {
		name: "修改",
		event: "editRow",
		params: ["id"],
		icon: "fa-pencil"
	}, {
		name: "删除",
		event: "deleteRow",
		params: ["id"],
		icon: "fa-trash"
	}];
	// button
	function button (index, row, element) {
		if (data.initButton != undefined) {
			list = pageParams.initButton;
		};
		var html = '<div class="btn-group">';
		$.each(list, function (i, t) {
			html += '<button type="button" class="btn btn-white"';
			html += 'onclick="' + t.event + '(';
			$.each(t.params, function (m, n) {
				html += '\'' + row[n] + '\',';
			});
			html = html.substring(0, html.length-1);
			html += ')">';
			html += '<i class="fa ' + t.icon + '"></i>&nbsp;' + t.name + '</button>';
		})
		html += '</div>';
		return html;
	};
	
	// 新增修改的弹框--单个弹框
	function openLayer(title) {
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
				// $(data.formId).find("textarea").each(function (index, item) {
				// 	if ($(this).val() == textareaData[index]) {
				// 		$(this).val("");
				// 	};
				// });
				$(data.formId).submit();
			},
			end : function() {
				$(data.formId).resetForm();
				endMethod(data.formId, "close");
			},
			content : $(data.layerId)
		});
		// 弹出表单之后验证表单
		$(data.formId).find("textarea").val("");
		$(data.formId).submit();
		// $(data.formId).find("textarea").each(function (index, item) {
		// 	if ($(this).val() == "") {
		// 		$(this).val(textareaData[index]);
		// 		$(this).css("color", "#aaa");
		// 	}
		// });
	};
	
	// 新增修改的弹框--多个弹框
	function openMultiLayer(title) {
		removeClassAndData();
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
				addElementList();
				$(data.formId).submit();
			},
			end : function() {
				$(data.formId).resetForm();
				endMethod(data.formId, "close");
			},
			content : $(data.layerId)
		});
	};
	
	// 详情弹框
	function openDetail () {
		layeForm = layer.open({
			title: data.detailTitle,
			type : 1,
			area : [ '90%', '90%' ],
			scrollbar : false,
			zIndex : 100,
			content : $(data.layerId),
			cancel : function () {
				removeDisable(data.formId);
				endMethod(data.formId, "close");
			}
		});
	}
	
	// 详情
	function datailRow(id) {
		var row = $(data.tableId).bootstrapTable('getRowByUniqueId', id);
		openDetail();
		loadData(row);
		addDisable(data.formId);
	}
	
	// 给表单添加禁选属性
	function addDisable (id) {
		// 然后将所有表单中的选项做一个禁选中操作
		$(id).find("input").attr("disabled","disabled");
		$(id).find("textarea").attr("disabled","disabled");
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
		$(".select-chosen").prop("disabled", true);
		$(".select-chosen").trigger("chosen:updated");
		setTimeout(function(){
			$(".linkagesel-select-div").find(".LinkageSel").prop("disabled", true);
			$(".linkagesel-select-div").find(".LinkageSel").trigger("chosen:updated");
			$(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
			// i-ckeck将自动验证去掉
			$('.i-checks').closest(".form-group").removeClass("has-success");
		},500);
		// checkbox
		$('.i-checks').iCheck('disable');
	}
	
	// 清空表单的禁选属性
	function removeDisable (id) {
		$(id).find("input").removeAttr("disabled");
		$(id).find("textarea").removeAttr("disabled");
		try{
			if(zTree) {
				var allnodes = zTree.getNodes();
				for (var i in allnodes) {
					zTree.setChkDisabled(allnodes[i], false, true, true);
				};
			};
		} catch (e) {}
		$(".select-chosen").prop("disabled", false);
		$(".select-chosen").trigger("chosen:updated");
		$('.i-checks').iCheck('enable');
	}
	
	// 删除数据
	function deleteRow(ids) {
		layeConfirm = layer.confirm('您确定要删除么？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.post(data.url + 'delete', {
				ids : ids
			}, function(data) {
				layer.close(layeConfirm);
				$(data.tableId).bootstrapTable('refresh');
				layer.msg(data);
				endMethod(data.formId);
			}, 'json');
		});
	}
	
	// 修改，表单回显功能
	function editRow(id) {
		var row = $(data.tableId).bootstrapTable('getRowByUniqueId', id);
		openLayer(data.editTitle);
		loadData(row);
		// 通过验证
		$(data.formId).find("input").blur();
		$(data.formId).find("textarea").blur();
		$(data.formId).find(".select-chosen").blur();
		if(data.editTitle=="信息资源修改"){
			$("#selectElement").removeClass("hide");	
		}
	}
	
	// 将所有的通用方法通过return的方式抛出来
	return {
		button: button,
		openLayer: openLayer,
		openDetail: openDetail,
		datailRow: datailRow,
		addDisable: addDisable,
		removeDisable: removeDisable,
		deleteRow: deleteRow,
		editRow: editRow
	}
}

//初始化表单按钮
var initTableButton = function (index, row, element) {
	return commonEvent(pageParams).button(index, row, element);
}

//新增修改弹框
function openLayer(title) {
	commonEvent(pageParams).openLayer(title);
};

//查看详情弹框
function openDetail() {
	commonEvent(pageParams).openDetail();
};

//查看表单详情
function datailRow(id) {
	commonEvent(pageParams).datailRow(id);
}

//删除数据
function deleteRow(ids) {
	commonEvent(pageParams).deleteRow(ids);
}

//修改，表单回显功能
function editRow(id) {
	commonEvent(pageParams).editRow(id);
}

//初始化表单
var TableInit = function(id, url) {
	var oTableInit = new Object();
	// 初始化Table
	oTableInit.Init = function() {
		$(id).bootstrapTable({
			url : url + 'list',
			method : 'get',
			toolbar : '#toolbar', // 工具按钮用哪个容器
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
	};

	// 得到查询的参数
	oTableInit.queryParams = function(params) {
		var obj = {};
		$("#searchFor").parents(".form-group").find("input").each(function (index, item) {
			obj[$(this).attr("sName")] = $(this).val();
		});
		var temp = {
			pageNum : params.offset / params.limit + 1,
			pageSize : params.limit,
			obj : JSON.stringify(obj)
		};
		return temp;
	};
	return oTableInit;
};

// 执行提交之后统一执行的方法
// 第一个属性是提交表单的id，第二个属性是判断事件属于提交事情还是关闭事件
function endMethod (closeId, status) {
	// 将表单验证去掉
	console.log(closeId);
	$(closeId).validate().resetForm();
	setTimeout(function () {
		$("#linkageSelSelect_chosen").width('100%');
	},500);
	// 表单关闭之后将所有的验证信息去掉
	$(closeId).find(".form-group").each(function (item) {
        $(this).removeClass("has-error");
        $(this).removeClass("has-success");
        $(this).children("label").removeClass("has-success-tips has-error-tips");
        $(this).find(".chosen-container").removeClass("has-success-s has-error-s");
        $(this).find(".i-checks>div").removeClass("checked");
    });
	// 将插件加上的属性去掉
	$(closeId).find("select").val("");
	$(".select-chosen").trigger("chosen:updated");
	$(".i-checks").find("input").removeAttr("checked");
	$(".i-checks").find("div.checked").removeClass("checked");
	try{
		if(resetPage) {
			resetPage(status);
		};
	} catch (e) {};
}

// 数据具体的回显功能 
function loadData(row) {
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
					loadLinkageSel(linkageSelData);
					// 清除四级联动查看及修改额外样式
					setTimeout(function(){
						$(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
						$(".linkagesel-select-group-info ").find(".chosen-container").removeClass("has-error-s has-success-s");
					},500);
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
}
