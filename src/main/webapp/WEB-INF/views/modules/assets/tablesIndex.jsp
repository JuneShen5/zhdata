<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style>
.linkagesel-select-div {
	display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">数据表</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入数据表名"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#tablesTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<!-- <button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button> -->
								<a data-toggle="modal" class="btn btn-yellow"
									onclick="deleteAll()"><i class='fa fa-trash-o'></i> 批量删除</a>
							</div>
						</div>
					</div>
					<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">所属数据库：</label>
							<div class="check-search-item" style="width:200px;display: inline-block;">
								<select type="text" sName="dbName" class="form-control search-chosen select-chosen">
									<option value="">全部</option>
									<c:forEach var="db" items="${fns:getDrList('dbs')}">
										<option value="${db.nameEn}">${db.nameEn}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">表代码：</label>
							<div class="check-search-item" style="width:200px;display: inline-block;">
								<input type="text" sName="nameEn" class="form-control" placeholder="请输入表代码">
							</div>
						</div>
					</div>
				</div>
				<table id="tablesTable">
					<thead class="ele-hide">
						<tr>
						    <th data-checkbox="true"></th>
						    <th data-field="nameEn">表代码</th>
							<th data-field="nameCn">表名称</th>
							<th data-field="dbName">所属数据库</th>
							<th data-field="Score" data-formatter="customTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="layer_form" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">表代码：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">表名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属数据库：</label>
				<div class="col-sm-7">
					<select name="dbId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="db" items="${fns:getDrList('dbs')}">
							<option value="${db.id}">${db.nameCn}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
	
	<!-- 生成信息项资源 -->
	<div id="new_layer_form" style="display: none" class="ibox-content">
		<div id="new_form" class="form-horizontal">
			<div class="alert alert-danger" id="new_form_prompt">尚有信息项未完善，如需使用，请先完善！</div>
		</div>
		<input name="allDecheckbox" type="checkbox" value="" onclick="allcheck()"> 全选
		<button type="button" id="importAll_btn" class="btn btn-primary btn-sm pull-right" 
			onclick="import2InfoRes();" disabled="disabled">
			<i class="fa fa-download"></i>&nbsp;生成信息资源
		</button>
		<table id="newTable">
			<thead id="newTableThead">
				<tr>
				    <th data-field="eleId" data-formatter="newTableCheckbox"></th>
				    <th data-field="nameEn">名称</th>
				    <th data-field="eleId" data-formatter="showState">状态</th>
					<th data-field="Score" data-formatter="newTableButton" class="col-sm-4">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 信息项 -->
	<div id="info_layer_form" style="display: none" class="ibox-content">
		<form id="info_form" class="form-horizontal">
			<input type="text" name="colId" class="hide">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	
	<div id="generate_layer_form" style="display: none" class="ibox-content">
		<form id="generate_form" class="form-horizontal">
			<input type="text" name="elementIds" class="hide">
			<input type="text" name="count" class="hide">
			<%@include file="/WEB-INF/views/include/inforAutoForm.jsp"%>
			
		</form>
		<table id="elementTable">
			<thead>
				<tr>
					<th data-field="idCode">内部标识符</th>
					<th data-field="nameCn">信息项名称</th>
					<th data-field="dataTypeName">数据类型</th>
					<th data-field="len">数据长度</th>
					<th data-field="companyName">来源部门</th>
					<th data-field="id" data-formatter="elementTableButton">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div id="element_layer_form" style="display:none" class="ibox-content">
		<form id="elementform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#tablesTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/assets/tables/';
		var obj = {
			nameCn : $('#sName').val(),
		};
		var editTitle = "数据表修改";
		var detailTitle = "数据表详情";
		var colData = [];
		var elementData = [];
		var infoRow = new Object();
		var checkedInfoId = 0;
		var checkedTanleId = 0;
		
		$(function () {
			newTable = newTableInit();
			newTable.Init();
			newElement = newElementInit();
			newElement.Init();
			$("#newTableThead").css("display", "none")
			validateNewInfo();
			validateGenInfo();
			// 四级联动
			var relConfigInfo = {
				ajax: '${ctx}/catalogset/infoSort/queryList',
				select: '.linkagesel-select-info',
				loaderImg: ''
			};
			window.linkRelInfo = new LinkageSel(relConfigInfo);
			// 没有找到数据返回之后的回调函数，所以写了一个延时效果
			setTimeout(function () {
				$(".LinkageSel").hide();
				$(".LinkageSel").chosen({width: "100%"});
				$(".LinkageSel").trigger("chosen:updated");
			}, 500);
			changeInit();
		})

		function changeInit () {
			linkRelInfo.onChange(function () {
				$(".linkagesel-select-div select").each(function (index, item) {
					var hideHtml = "div:eq(" + index + ")";
					// 如果为零表示是select为空，隐藏掉，并且将select的name值去掉
					if ($(this).children('option').length == 0) {
						$(".linkagesel-select-div").children(hideHtml).hide();
						$(this).removeAttr("name");
						$(this).removeAttr("required");
					} else {
						$(".linkagesel-select-div").children(hideHtml).show();
						$(this).attr("name", "infoType" + (index + 1));
						$(this).attr("required", "required");
					}
				});
				// 由于执行存在顺序的原因，加上延时，模拟回调函数
				setTimeout(function () {
					$(".linkagesel-select-div").find("div.chosen-container").width("48%");
					$(".LinkageSel").hide();
					$(".LinkageSel").chosen({width: "48%"});
					$(".LinkageSel").trigger("chosen:updated");
				}, 0)
			})
		}
		
		function linkageselChosen () {
			$(".linkagesel-select-div").find("div.chosen-container").width("48%");
			$(".LinkageSel").hide();
			$(".LinkageSel").chosen({width: "48%"});
			$(".LinkageSel").trigger("chosen:updated");
		}
		// 四季联动动态的将数据赋值进去
		function loadLinkageSel (data) {
			linkRelInfo.changeValues(data, true);
		};
		// 弹框关闭之后将多级联动回复初始化
		function resetPage (status, formId) {
			linkRelInfo.reset();
		}
		
		function customTableButton (index, row, element) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
					+ row.id + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
			html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
					+ row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
			html += '<button type="button" class="btn btn-white" onclick="deleteRow(\''
					+ row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
			html += '<button type="button" class="btn btn-white" onclick="newInformation('
					+ row.id + ',\'' + row.nameCn + '\',\'' + row.nameEn + '\',' + row.infoId +  ')"><i class="fa fa-paper-plane-o"></i>&nbsp;生成信息资源</button>';
			html += '</div>';
			return html;
		}
		
		// 生成信息项资源弹框
		function newInformation (id, nameCn, nameEn, infoId) {
			checkedTanleId = id;
			checkedInfoId = infoId;
			$("input[name=count]").val(id);
			tableChecked();
			infoRow.nameCn = nameCn;
			infoRow.tbName = nameEn;
			newInfoLayer = layer.open({
				title: "生成信息项资源",
				type : 1,
				area : [ '80%', '80%' ],
				scrollbar : false,
				zIndex : 100,
				cancel: function () {
					$("#importAll_btn").attr("disabled", "disabled");
					infoRow = {};
				},
				content : $("#new_layer_form")
			});
		}
		
		function tableChecked () {
			$.ajax({
				url : url + 'columns',
				data: {tbId: checkedTanleId, infoId: checkedInfoId},
				async: false,
				success: function (res) {
					$("#newTable").bootstrapTable("load", res.colList1);
					$.each(res.colList2, function (index, item) {
						var dataName = 'tr[data-uniqueid=' + item.id + ']';
						$(dataName).find("input:checkbox").attr("checked", "true");
					})
				}
			})
		}
		
		var newTableInit = function() {
			var oTableInit = new Object();
			// 初始化Table
			oTableInit.Init = function() {
				$("#newTable").bootstrapTable({
					// url : url + 'list',
					data: colData,
					method : 'get',
					striped : true, // 是否显示行间隔色
					iconSize : 'outline',
					icons : {
						refresh : 'glyphicon-repeat',
						columns : 'glyphicon-list'
					},
					uniqueId : "id", // 每一行的唯一标识，一般为主键列
				});
			};
			return oTableInit;
		};
		
		// 返回状态
		function showState (value, row, index) {
			if (0 == value) {
				return "待完善";
			} else {
				$("#importAll_btn").removeAttr("disabled");
				return "已完善";
			}
		}
		
		function newTableCheckbox (value, row, index) {
			var html = '';
			if (value != 0) {
				html = '<input name="decheckbox" type="checkbox" "="" value="' + row.eleId + '">'
			}
			return html;
		}
		
		// 全选
		function allcheck () {
			var $this = $("input[name=allDecheckbox]");
			if ($this.is(':checked')) {
				$("input[name=decheckbox]").prop("checked", "false");
			} else {
				$("input[name=decheckbox]").removeAttr("checked")
			}
		}
		
		function newTableButton (value, row, index) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white"';
			if (row.eleId == 0) {
				html += ' style="color: #f00;"'
			}
			html += ' onclick="editInformation(' + row.id + ',' + row.eleId +  ')"><i class="fa fa-info-circle"></i>&nbsp;信息项</button>';
			html += '</div>';
			return html;
		}
		
		// 完善信息项
		function editInformation (id, eleId) {
			var editRow = {};
			if (eleId == 0) {
				$("#info_form input[name=colId]").val(id);
				editRow = $("#newTable").bootstrapTable('getRowByUniqueId', id);
				editRow.editRow = editRow.type;
				editRow.len = editRow.length;
			} else {
				$.ajax({
					url : url + 'eleList',
					data : {id: eleId},
					async: false,
					success : function (res) {
						editRow = res;
					}
				})
			}
			loadToData(editRow, 'info_form');
			if (eleId == 0) $("#info_form input[name=id]").val(null);
			$("#info_form").validate().form();
			editInforlayer = layer.open({
				title: "信息项修改",
				type : 1,
				area : [ '60%', '70%' ],
				scrollbar : false,
				zIndex : 100,
				btn : [ '保存', '关闭' ],
				yes : function(index, layero) {
					$("#info_form").submit();
					tableChecked();
				},
				end : function() {
					$("#info_form").resetForm();
					endMethod("#info_form", "close");
				},
				cancel: function () {
					$("#info_form").resetForm();
					endMethod("#info_form", "close");
				},
				content : $("#info_layer_form")
			});
		}
		
		// 生成信息资源
		function import2InfoRes () {
			var ids = [];
			$("#newTable input[name=decheckbox]:checked").each(function () {
				ids.push(parseInt($(this).val()));
			})
			console.log("ids: ", ids);
			if (ids.length < 1) {
				layer.msg("请至少选择一条数据")
				return;
			}
			ids = JSON.stringify(ids);
			infoRow.elementIds = ids.substring(1, ids.length - 1);
			$("#generate_form input[name=elementIds]").val(infoRow.elementIds);
			$.ajax({
				url: url + 'infoDetail',
				data: {id: checkedInfoId, elementIds: infoRow.elementIds},
				//dataType: 'json',
				//type:'post',
				async: false,
				success: function (res) {
					if (checkedInfoId == 0) {
						$.ajax({
							url: "${ctx}/catalog/information/getCode",
							type: 'get',
							async: false,
							success: function (data) {
								infoRow.nameEn = data
							}
						});
						infoRow.companyName = '';
						infoRow.elementList = res.elementList;
					} else {
						infoRow = res;
					}
				}
			})
			loadToData(infoRow, 'generate_form');
			$("#generate_form").validate().form();
			$("#elementTable").bootstrapTable("load", infoRow.elementList);
			layer.open({
				title: "生成信息资源",
				type : 1,
				area : [ '85%', '75%' ],
				scrollbar : false,
				zIndex : 100,
				btn : [ '保存', '关闭' ],
				yes : function(index, layero) {
					$("#generate_form").submit();
				},
				end : function() {
					$("#generate_form").resetForm();
					endMethod("#generate_form", "close");
				},
				cancel: function () {
					$("#generate_form").resetForm();
					endMethod("#generate_form", "close");
				},
				content : $("#generate_layer_form")
			});
		}

		function dataTo () {return true};
		
		// 验证表单初始化
		function validateNewInfo () {
			$("#info_form").validate({
				ignore: ":hidden:not(select,input)",
		        submitHandler: function(form){
		        	$("#info_form").ajaxSubmit({
		    			url : url + 'generate',
		    			type : 'post',
		    			success : function(data){
		    				layer.close(editInforlayer);
		    				tableChecked();
		    				layer.msg(data);
		    				endMethod("#info_form");
		    			},
		    			error : function(XmlHttpRequest, textStatus, errorThrown){
		    				layer.close(editInforlayer);
		    				tableChecked();
		    				layer.msg("数据操作失败!");
		    				endMethod("#info_form");
		    			},
		    			resetForm : true
		    		});
		    		return false;
		        }
		    });
		}
		
		function validateGenInfo () {
			$("#generate_form").validate({
				ignore: ":hidden:not(select,input)",
		        submitHandler: function(form){
		        	$("#generate_form").ajaxSubmit({
		    			url : url + 'infoSave',
		    			type : 'post',
		    			success : function(data){
		    				layer.close(layer.index);
							layer.close(newInfoLayer);
		    				$("#tablesTable").bootstrapTable('refresh');
		    				layer.msg(data);
		    				endMethod("#generate_form");
		    			},
		    			error : function(XmlHttpRequest, textStatus, errorThrown){
		    				layer.close(layer.index);
		    				$("#tablesTable").bootstrapTable('refresh');
		    				layer.msg("数据操作失败!");
		    				endMethod("#generate_form");
		    			},
		    			resetForm : true
		    		});
		    		return false;
		        }
		    });
		}
		
		
		// 表单下方的info表格
		var newElementInit = function() {
			var oTableInit = new Object();
			// 初始化Table
			oTableInit.Init = function() {
				$("#elementTable").bootstrapTable({
					data: elementData,
					striped : true, // 是否显示行间隔色
					iconSize : 'outline',
					icons : {
						refresh : 'glyphicon-repeat',
						columns : 'glyphicon-list'
					},
					uniqueId : "id", // 每一行的唯一标识，一般为主键列
				});
			};
			return oTableInit;
		};
		
		function elementTableButton (value, row) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white" onclick="datailElementRow(\''
					+ row.id + '\')"><i class="fa fa-info-circle"></i>&nbsp;查看</button>';
			html += '</div>';
			return html;
		}
		
		function datailElementRow (id) {
			var row = $("#elementTable").bootstrapTable('getRowByUniqueId', id);
			loadToData(row, 'elementform');
			$("#elementform").find("input").each(function () {
				$(this).attr("disabled","disabled");
			});
			$("#elementform").find("textarea").each(function () {
				$(this).attr("disabled","disabled");
			});
			$("#elementform select").prop("disabled", true);
			$("#elementform select").trigger("chosen:updated");
			$('#elementform .i-checks').iCheck('disable');
			layer.open({
				title: "信息项详情",
				type : 1,
				area : [ '60%', '60%' ],
				scrollbar : false,
				zIndex : 100,
				cancel: function () {
					$("#elementform").resetForm();
					endMethod("#elementform", "close");
				},
				content : $("#element_layer_form")
			});
		}

		// 共享方式
		var gxtjSelect = $("select[name=shareCondition]");
		var gxfsSelect = $("select[name=shareMode]");
		gxtjSelect.closest('.form-group').hide();
		gxtjSelect.removeAttr("required");
		gxfsSelect.closest('.form-group').hide();
		gxfsSelect.removeAttr("required");
		$("select[name=shareType]").chosen({
			width : "100%"
		}).change(function () {
			if ($(this).val() == 1) {
				gxfsSelect.closest('.form-group').hide();
				gxfsSelect.closest('.form-group').slideToggle();
				gxfsSelect.attr("required", "required");
				gxtjSelect.closest('.form-group').hide();
				gxtjSelect.val("");
				gxtjSelect.trigger("chosen:updated");
				gxtjSelect.removeAttr("required");
			} else if ($(this).val() == 2) {
				gxfsSelect.closest('.form-group').hide();
				gxtjSelect.closest('.form-group').hide();
				gxfsSelect.closest('.form-group').slideToggle();
				gxfsSelect.attr("required", "required");
				gxtjSelect.closest('.form-group').slideToggle();
				gxtjSelect.attr("required", "required");
			} else if ($(this).val() == 3) {
				gxfsSelect.closest('.form-group').hide();
				gxfsSelect.val("");
				gxfsSelect.trigger("chosen:updated");
				gxfsSelect.removeAttr("required");
				gxtjSelect.closest('.form-group').hide();
				gxtjSelect.val("");
				gxtjSelect.trigger("chosen:updated");
				gxtjSelect.removeAttr("required");
			}
		});
		
		// 是否向社会开放
		$("select[name=openType]").closest('.form-group').hide();
		$("select[name=openType]").removeAttr("required");
		// 判断是否使用其他部门数据与是否提供数据给其他部门
		$("select[name=isOpen]").chosen({
			width : "100%"
		}).change(function () {
			if ($(this).val() == 1) {
				$("select[name=openType]").closest('.form-group').slideToggle();
				$("select[name=openType]").attr("required", "required");
			} else if ($(this).val() == 0) {
				$("select[name=openType]").closest('.form-group').hide();
				$("select[name=openType]").val("");
				$("select[name=openType]").trigger("chosen:updated");
				$("select[name=openType]").removeAttr("required");
			}
		});
		
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

