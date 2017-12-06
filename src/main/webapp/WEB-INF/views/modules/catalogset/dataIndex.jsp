<%@ page contentType="text/html;charset=UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/js/plugins/webuploader/webuploader.css">
<!-- 查看数据 -->
<div id="data_layer_form" style="display: none" class="ibox-content">

	<div id="dataInfoDiv">
	
	
	</div>
</div>
<!-- 查看数据的表单 -->
<div id="data_row_layer" style="display:none" class="ibox-content">
	<form id="data_row_form" class="form-horizontal">
	</form>
</div>
	
	<style>
		#dataInfoDiv .form-group {
			min-width: 380px;
		}
		#dataInfoDiv .form-group .chosen-container {
			margin-bottom: 0;
		}
	</style>
	
	<script src="${ctxStatic}/js/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxStatic}/js/plugins/webuploader/webuploader.js"></script>
<script>
	//查看数据的弹框
	var dataInfoIndex = 0;
	var dataInfoTablId = "dataInfoTable";
	var dataInfoInputId = "dataInfoToolbar";
	var dataInfoCode = "";
	var dataRowLayerId = "#data_row_layer"
	var dataInfoFormId = "#data_row_form";
	var dataUrl = "";
    var dictJson="";
    var dictRowId="";
    var dictJsons=new Array();
    var dictRowIds=new Array();;

	
	// 查看数据按钮
	function showDataRow(id, code, name) {
		//console.log("id: ", id, "code: ", code, "name: ", name)
		dataInfoCode = code;
		dataInfoTablId += dataInfoIndex;
		dataInfoInputId += dataInfoIndex;
		// 将搜索框插入
		var inputHtml = '<div class="data-info-toolbar"><div class="form-inline"><div class="form-group">'
			+ '<select id="dataSelect" class="select-chosen" required style="float: left;"><option value=""></option>';
		var html = '<table id="' + dataInfoTablId + '"><thead><tr>'
		$.ajax({url: url + "getHeader?id=" + id, success: function (res) {
			$.each(res, function (index, item) {
				
				if (item.searchType == 2) {
					inputHtml += '<option value="' + index + '">' + item.nameCn + '</option>';
				}
				
                if (item.inputType == "dictselect") {
                    dictJson=JSON.parse(item.dict);
                    dictJsons.push(dictJson);
                    dictRowId=index+1;
                    dictRowIds.push(dictRowId);
                }

				html += '<th data-field="' + item.nameEn + '">' + item.nameCn + '</th>';
			});
			//inputHtml += '</select><input id="dataSearchInput" sName="name" type="text" placeholder="请先选择搜索的类型" readOnly="readOnly" class="form-control col-sm-8"><div class="input-group-btn col-sm-4">' 
			inputHtml += '</select><div id="dataSearchInputs"></div><div class="input-group-btn col-sm-4">' 
				+ '<button type="button" id="dataSearchFor" onclick=" $(\'#' + dataInfoTablId + '\').bootstrapTable(\'refresh\');" class="btn btn-primary">搜索</button></div></div>'
				+ '<div class="form-group" style="margin-left: 15px;"><div class="text-center">'
				
				
				+ '<button type="button" class="btn btn-primary" onclick="dataAddRow('
				+ id + ',\'' + code + '\')"><i class="fa fa-pencil"></i>&nbsp;新增</button>'
				+ '<div data-toggle="modal" class="btn btn-primary" id="importData" code='+code+'>导入</div>'
				+ '<a href="data/exportData?id='+id+'&name='+name+'&code='+code+'" data-toggle="modal" class="btn btn-primary" onclick="">导出</a>'
				+ '</div></div></div></div>';
			html += '<th data-formatter="dataTableButton">操作</th>'
				+ '</tr></thead></table>';
			$("#data_layer_form").append(inputHtml);
			$(".select-chosen").chosen({
				width : "40%"
			}).change(function (e) {
				// 监听下拉框发生变化，将搜索框中的索引值改变
				//var typeId = $("#dataSelect").val()
				//$("#dataSearchInput").attr("placeholder", "请输入搜索的内容");
				//$("#dataSearchInput").attr("sName", res[typeId].nameEn);
				var typeId = $("#dataSelect").val();
                var dataSearchInput="";
                $("#dataSearchInputs").html("");
				if (res[typeId].inputType == "input") {
					//$("#dataSearchInput").attr("readOnly", false);
					//$("#dataSearchInput").attr("class", "form-control col-sm-8");
					//$('#dataSearchInput').unbind();
                    dataSearchInput='<input  id="dataSearchInput" sName="'+ res[typeId].nameEn +'" type="text" placeholder="请输入搜索的内容"  class="form-control col-sm-8">';
                    $("#dataSearchInputs").append(dataSearchInput);
				} else if (res[typeId].inputType == "dateselect") {
					//$("#dataSearchInput").attr("readOnly", "readOnly");
					//$("#dataSearchInput").attr("class", "form-control col-sm-8 datepicker");
					dataSearchInput='<input id="dataSearchInput" sName="startDate" type="text" placeholder="请输入开始时间" readOnly="readOnly"  class="form-control col-sm-8 datepicker">';
                    dataSearchInput+='<input id="dataSearchInput2" sName="endDate" type="text" placeholder="请输入结束时间" readOnly="readOnly"  class="form-control col-sm-8 datepicker">';
                    dataSearchInput+='<input type="text" tName="'+ res[typeId].nameEn +'" class="hide" value="date">';
                    $("#dataSearchInputs").append(dataSearchInput);
					$('.datepicker').datepicker({
				        todayBtn: "linked",
				        keyboardNavigation: false,
				        forceParse: false,
				        calendarWeeks: true,
				        autoclose: true,
				        todayHighlight:true,
				    });
                }else if (res[typeId].inputType == "dictselect") {
                    var dict=JSON.parse(res[typeId].dict);
                    dataSearchInput += '<select sName="'+ res[typeId].nameEn +'" id="dictSelects" class="form-control col-sm-7 select-chosen">';
                    dataSearchInput += '<option value=""></option>';
                    for(var key in dict){
                        dataSearchInput += '<option value="' +key+ '">' +dict[key]+ '</option>';
                    }
                    dataSearchInput += '</select>';
                    $("#dataSearchInputs").append(dataSearchInput);
                   
                }
		    });
			$(".data-info-toolbar").attr("id", dataInfoInputId);
			$("#dataInfoDiv").append(html);
			// 初始化表格
			dataInfoTable = new dataInfoTableInit(code, dataInfoTablId);
			dataInfoTable.Init();
			
            if(dictJsons.length>0){
                
                $("#"+dataInfoTablId).on("post-body.bs.table", function () {
                    for(var i=0;i < dictJsons.length;i++){
                        console.log(JSON.stringify(dictJsons[i]));
                        console.log("dictRowId:"+dictRowIds[i]);
                        var columnField;
                        var newColumnField;
                        $("#"+dataInfoTablId).find("tbody>tr").each(function (index, item) {
                            columnField = $(this).children("td:nth-child("+dictRowIds[i]+")").html();
                            for(var key in dictJsons[i]){
                                if(columnField==key)
                                    newColumnField = dictJsons[i][key];
                            }
                            $(this).children("td:nth-child("+dictRowIds[i]+")").html(newColumnField);
                            var asd = $("#"+dataInfoTablId).bootstrapTable('getData', true);
                            console.log("asd: ", asd);
                                
                        })
                    }
                })
                
            }

			
			// dataInfoTableInit(code, dataInfoTablId);
			layeForm = layer.open({
				title: name,
				type : 1,
				area : [ '100%', '100%' ],
				scrollbar : false,
				zIndex : 100,
				content : $(dataTableId),
				// 当弹框关闭的时候，将所有动态生成的dom节点删除
				cancel : function () {
					$("#dataInfoDiv").children().remove();
					dataInfoIndex++;
					dataLayerData = [];
					$(dataInfoFormId).children().remove();
                    dictJson="";
                    dictRowId="";
                    dictJsons=[];
                    dictRowIds=[];
				}
			})
			// 新增详情修改的表单初始化
			dataFormInit(id, code);
			$("#dataInfoDiv").find("div.chosen-container").addClass("col-sm-8");
		}})
	}
	
	// 初始化表单
	function dataFormInit (id, code) {
		$.ajax({url: url + "getForm?id=" + id, success: function (res) {
			var html = '<input type="text" name="tableName" value="' + code + '" class="form-control hide">';
			html += '<input type="text" name="TONG_ID" class="form-control hide">'
			$.each(res, function (index, item) {
				html += '<div class="form-group"><label class="col-sm-3 control-label">' + item.nameCn + '：</label>';
				if (item.requireType == 1) {
					if (item.inputType == "input") {
						html += '<div class="col-sm-7">';
						html += '<input type="' + item.validateType + '" name="' + item.nameEn + '" class="form-control" required></div></div>';
					} else if (item.inputType == "dateselect") {
						html += '<div class="col-sm-7">';
						html += '<input type="text" name="' + item.nameEn + '" class="form-control datepicker" readonly="readonly" required></div></div>';
					}else if (item.inputType == "dictselect") {
						var dict=JSON.parse(item.dict);
						html += '<div class="col-sm-7">';
						html += '<select name="' + item.nameEn + '" class="select-chosen" required>';
						html += '<option value=""></option>';
						for(var key in dict){
							html += '<option value="' +key+ '">' +dict[key]+ '</option>';
						}
						html += '</select></div></div>';
					}
				} else if (item.requireType == 0) {
					if (item.inputType == "input") {
						html += '<div class="col-sm-7">';
						html += '<input type="text" name="' + item.nameEn + '" class="form-control"></div></div>';
					} else if (item.inputType == "dateselect") {
						html += '<div class="col-sm-7">';
						html += '<input type="text" name="' + item.nameEn + '" class="form-control datepicker" readonly="readonly"></div></div>';
					} else if (item.inputType == "dictselect") {
						var dict=JSON.parse(item.dict);
						html += '<div class="col-sm-7">';
						html += '<select name="' + item.nameEn + '" class="select-chosen">';
						html += '<option value=""></option>';
						for(var key in dict){
							html += '<option value="' +key+ '">' +dict[key]+ '</option>';
						}
						html += '</select></div></div>';
					}
				}
			});
			// 动态生成form表单，在关闭的时候将表单销毁
			$(dataInfoFormId).append(html);
			$(".select-chosen").chosen({
				width : "100%"
			})
			// 将时间插件初始化
			$('.datepicker').datepicker({
		        todayBtn: "linked",
		        keyboardNavigation: false,
		        forceParse: false,
		        calendarWeeks: true,
		        autoclose: true,
		        todayHighlight:true,
		    });
			// 将验证表单加上去
			$(dataInfoFormId).validate({
				ignore: ":hidden:not(select,input)",
		        submitHandler: function(form){
		        	$(dataInfoFormId).ajaxSubmit({
		    			url : dataUrl,
		    			type : 'post',
		    			success : function(data){
		    				layer.close(layeForm);
		    				$("#" + dataInfoTablId).bootstrapTable('refresh');
		    				layer.msg(data);
		    			},
		    			error : function(XmlHttpRequest, textStatus, errorThrown){
		    				layer.close(layeForm);
		    				$("#" + dataInfoTablId).bootstrapTable('refresh');
		    				layer.msg("数据操作失败!");
		    			},
		    			resetForm : true
		    		});
		    		return false;
		        }
		    });
		}});
	};
	
	// data_layer 的操作按钮
	var dataLayerData = new Array();
	function dataTableButton (value, row, index) {
		dataLayerData.push(row);
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailDataRow(\''
				+ row.TONG_ID + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '<button type="button" class="btn btn-white" id="edit"  onclick="editDataRow('
				+ row.TONG_ID + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
		html += '<button type="button" class="btn btn-white" onclick="deleteDataRow('
				+ row.TONG_ID + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
		html += '</div>';
		return html;
	};
	
	// 查看数据的表格初始化
	var dataInfoTableInit = function(code, id) {
		var dataInfoTableId = "#" + id
		var oTableInit = new Object();
		oTableInit.Init = function() {
			$(dataInfoTableId).bootstrapTable({
				url : '${ctx}/catalogset/data/getdata?tableName=' + code,
				method : 'get',
				toolbar : "#" + dataInfoInputId, // 工具按钮用哪个容器
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
				uniqueId : "TONG_ID", // 每一行的唯一标识，一般为主键列
			});
		};
		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var queryParams = new Object();
			$("#dataSearchFor").parents(".form-group").find("input.form-control").each(function (index, item) {
				//console.log("item: ", item)
				queryParams[$(this).attr("sName")] = $(this).val();
			});
            $("#dataSearchFor").parents(".form-group").find("input.hide").each(function (index, item) {
                //console.log("item: ", item)
                queryParams[$(this).val()] = $(this).attr("tName");
            });
            $("#dataSearchFor").parents(".form-group").find("#dictSelects").each(function (index, item) {
                //console.log("item: ", item)
                queryParams[$(this).attr("sName")] = $(this).val();
            });
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				queryParams : JSON.stringify(queryParams)
			};
			return temp;
		};
		return oTableInit;			
	};
	
	//data_layer的新增
	function dataAddRow (id, name) {
		dataUrl = '${ctx}/catalogset/data/saveData'
		layeForm = layer.open({
			title: "新增",
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			btn : [ '保存', '关闭' ],
			yes : function(index, layero) {
				$(dataInfoFormId).submit();
			},
			end : function() {
				$(dataInfoFormId).resetForm();
				endMethod(dataInfoFormId, "close");
			},
			content : $(dataRowLayerId),
		});
	};
	
	// data_layer的详情
	function datailDataRow (id) {
		var row = $("#" + dataInfoTablId).bootstrapTable('getRowByUniqueId', id);
		loadData(row);
		layeForm = layer.open({
			title: "详情",
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			content : $(dataRowLayerId),
			cancel : function () {
				// 当弹框被关闭的时候将所有加上的属性移除掉
				$(dataInfoFormId).find("input").each(function () {
					$(this).removeAttr("disabled");
				});
				$(dataRowLayerId).find("select").prop("disabled", false);
				$(dataRowLayerId).find("select").trigger("chosen:updated");
				endMethod(dataInfoFormId, "close");
			}
		});
		$(dataRowLayerId).find("input").each(function () {
			$(this).attr("disabled","disabled");
		});
		// 判断select
		$(dataRowLayerId).find("select").prop("disabled", true);
		$(dataRowLayerId).find("select").trigger("chosen:updated");
	};
	
	// data_layer修改
	function editDataRow (id) {
		dataUrl = "${ctx}/catalogset/data/saveData"
		var row = $("#" + dataInfoTablId).bootstrapTable('getRowByUniqueId', id);
		loadData(row);
		layeForm = layer.open({
			title: "修改",
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			btn : [ '保存', '关闭' ],
			yes : function(index, layero) {
				$(dataInfoFormId).submit();
			},
			end : function() {
				$(dataInfoFormId).resetForm();
				endMethod(dataInfoFormId, "close");
			},
			content : $(dataRowLayerId),
		});
	};
	
	// 查看数据的删除
	function deleteDataRow (id) {
		layeConfirm = layer.confirm('您确定要删除么？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.ajax({url: "data/deleteData?TONG_ID=" + id + "&tableName=" + dataInfoCode, success: function (res) {
				layer.msg("删除成功");
				$("#" + dataInfoTablId).bootstrapTable('refresh');
			}})
		});
	};
	
	// 文件导入弹框
	$(document).delegate("#importData","click",function(){
		var code = $(this).attr("code");
		var url = $(this).attr("url");
	   	layerIndex=layer.open({
			type: 1,
			area: ['60%', '80%'], //宽高
			title: '从Excel导入',
			offset: '0',
			cancel:function(){
				// 初始化操作
				$('#error-msg').html('');
				$("#filePicker").html('');
				$("#file-message").html('');
				$("#message").text('');
			},
			success: function(layero, index){
				$(".importTemplate").attr("href", url);
			},
			content: $('#import_form') //这里content是一个DOM
		});
	});
	
</script>
