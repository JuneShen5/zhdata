<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style>
.search-list {
	padding: 5px 0;
	height: 50px;
    display: none;
}
.check-search {
	display: inline-block;
	margin-right: 20px;
}
.check-search-item {
	display: inline-block;
}
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入中文名称"
								class="form-control col-sm-8 nameCn">
							<input id="sName" sName="publicId" type="text" placeholder="输入角色名"
								class="form-control col-sm-8 hide" value="1">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#publicTable').bootstrapTable('refresh');"
									class="btn btn-primary">搜索</button>
								<button type="button" id=""
                                	onclick="searchMore()" 
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-primary btn-green"
									onclick="ImportInfo('导入信息项');"><i class="fa fa-plus"></i> 添加公共信息项</a>
							</div>
						</div>
					</div>
					<div class="search-list">
						<div class="check-search">
							<label class="">数据类型：</label>
							<div class="check-search-item" style="width:200px;">
								<select sName="dataType" class="select-chosen form-control" placeholder="标明该信息项的数据类型">
									<option value="">全部</option>
									<c:forEach var="dict" items="${fns:getDictList('data_type')}">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="check-search">
							<label class="">来源部门：</label>
							<div class="check-search-item" style="width:200px;">
								<select type="text" sName="companyId" class="form-control search-chosen select-chosen companyId">
									<option value="">全部</option>
									<c:forEach var="company" items="${fns:getList('company')}">
										<option value="${company.id}">${company.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>
				<table id="publicTable">
					<thead>
						<tr>
							<th data-field="idCode">内部标识符</th>
							<th data-field="nameCn">中文名称</th>
							<th data-field="nameEn">英文名称</th>
							<th data-field="dataTypeName">信息项类型</th>
							<th data-field="companyName">来源部门</th>
							<th data-field="Score" data-formatter="publicTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
				</div>
			</div>
			
			<%@include file="/WEB-INF/views/include/dataType.jsp"%>
			
            <div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
				<div class="col-sm-7">
					<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
				</div>
			</div>
						
			 <div class="form-group">
				<label class="col-sm-3 control-label">对象类型：</label>
				<div class="col-sm-7">
					<select name="objectType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('object_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label">数据标记：</label>
				<div class="col-sm-7">
					<select name="dataLabel" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			 <div class="form-group">
				<label class="col-sm-3 control-label">来源部门：</label>
				<div class="col-sm-7">
					<select name="companyId" class="select-chosen">
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select>
				</div>
			</div> 
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否字典项：</label>
				<div class="col-sm-7">
					<select name="isDict" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享类型：</label>
				<div class="col-sm-7">
					<select name="shareType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享条件：</label>
				<div class="col-sm-7">
					<select name="shareCondition" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_condition')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享方式：</label>
				<div class="col-sm-7">
					<select name="shareMode" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_mode')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否向全社会开放：</label>
				<div class="col-sm-7">
					<select name="isOpen" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">开放条件：</label>
				<div class="col-sm-7">
					<select name="openType" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('open_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">更新周期：</label>
				<div class="col-sm-7">
					<select name="updateCycle" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('update_cycle')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
	
	<div id="import_layer_table" style="display: none;" class="ibox-content">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="form-horizontal">
				
					<div class="form-group">
						<div class="col-sm-6">
							<label class="col-sm-3 control-label" style="text-align:left;">
								<div class="row">来源部门：</div>
							</label>
							<div class="col-sm-9">
								<div class="row">
									<select name="search_company_id" data-placeholder=" " class="select-chosen name1 form-control" style="width: 350px;">
										<option value="">全部</option>
										<c:forEach var="company" items="${fns:getList('company')}">
											<option value="${company.id}">${company.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="text" placeholder="输入名称" name="search_name" class="form-control">
								<span class="input-group-btn">
									<button type="button" onclick=" $('#informationTable').bootstrapTable('refresh');" class="btn btn-primary">搜索</button>
								</span>
							</div>
						</div>
					</div>
				</div>
				<table id="informationTable">
					<thead>
						<tr>
							<th data-checkbox=“true"></th>
							<th data-field="idCode">内部标识符</th>
							<th data-field="nameCn">中文名称</th>
							<th data-field="companyName">来源部门</th>
							<th data-field="Score" data-formatter="importTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 信息项详情 -->
	<div id="import_layer_form" style="display: none;" class="ibox-content">
		<form id="import_eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
				</div>
			</div>
			
			<%@include file="/WEB-INF/views/include/dataType.jsp"%>
			
            <div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
				<div class="col-sm-7">
					<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">对象类型：</label>
				<div class="col-sm-7">
					<select name="objectType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('object_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">数据标记：</label>
				<div class="col-sm-7">
					<select name="dataLabel" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			 <div class="form-group">
				<label class="col-sm-3 control-label">来源部门：</label>
				<div class="col-sm-7">
					<select name="companyId" class="select-chosen">
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select>
				</div>
			</div> 
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否字典项：</label>
				<div class="col-sm-7">
					<select name="isDict" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享类型：</label>
				<div class="col-sm-7">
					<select name="shareType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享条件：</label>
				<div class="col-sm-7">
					<select name="shareCondition" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_condition')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享方式：</label>
				<div class="col-sm-7">
					<select name="shareMode" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_mode')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否向全社会开放：</label>
				<div class="col-sm-7">
					<select name="isOpen" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">开放条件：</label>
				<div class="col-sm-7">
					<select name="openType" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('open_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">更新周期：</label>
				<div class="col-sm-7">
					<select name="updateCycle" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('update_cycle')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	var tableId = '#publicTable';
	var toolbar = '#toolbar';
	var layerId = '#layer_form';
	var formId = '#eform'; //form id
	var importForm = '#importForm';
	var importBox = '#importBox';
	var exportForm='#exportForm';
	var exportBox='#exportBox';
	var url = '${ctx}/standard/manage/';
	var pubUrl = '${ctx}/standard/public/';
	var obj = {};
	var editTitle = "数据元池修改";
	var detailTitle = "数据元池详情";
	
	$(function () {
		publicTable = new publicTableInit();
		publicTable.Init();
	})
	
	// 搜素的下拉框
	function searchMore () {
		$(".search-list").slideToggle();
	};
	
	function publicTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailRow('
				+ row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow('
				+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
		html += '<button type="button" class="btn btn-white" onclick="deletePublicRow('
				+ row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
		html += '</div>';
		return html;
	}
	
	// 删除，将公共数据重新返回数据元池
	function deletePublicRow(id) {
		layeConfirm = layer.confirm('您确定要删除么？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.post(pubUrl + 'delete', {
				id : id
			}, function(data) {
				layer.close(layeConfirm);
				$(tableId).bootstrapTable('refresh');
				layer.msg(data);
			}, 'json');
		});
	}
	
	// 添加公共信息项
	function ImportInfo () {
		inportLayeForm = layer.open({
			title: "选择公共信息项",
			type : 1,
			area : [ '80%', '90%' ],
			scrollbar : false,
			zIndex : 100,
			btn : [ '导入勾选项', '关闭' ],
			yes : function(index, layero) {
				var params = [];
				$.each($("#informationTable").bootstrapTable('getSelections'), function (index, item) {
					params.push(item.id);
				})
				params = JSON.stringify(params).substring(1, JSON.stringify(params).length - 1);
				$.ajax({
					url: pubUrl + 'toPub',
					data: {ids: params},
					type: "POST",
					success: function (res) {
						layer.close(layer.index);
						layer.msg("添加成功");
						$("#informationTable").bootstrapTable('refresh');
						$("#publicTable").bootstrapTable('refresh');
					}
				})
			},
			end : function() {
				
			},
			content : $("#import_layer_table"),
			cancel : function () {
			}
		});
		$("#informationTable").bootstrapTable('refresh');
	}
	
	// 添加公共信息项表格初始化
	var publicTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#informationTable").bootstrapTable({
				url : url + 'list?',
				method : 'get',
				checkbox: true,
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
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
			// 编号  审核状态  名称 search-chosen
			var importObj = {};
			importObj.nameCn = $("input[name=search_name]").val();
			importObj.companyId = $("select[name=search_company_id]").val();
			importObj.publicId = 0;
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				obj : JSON.stringify(importObj)
			};
			return temp;
		};
		return oTableInit;
	};
	
	// 添加公共信息项表格按钮
	function importTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailImportRow('
				+ row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		return html;
	}
	
	// 添加公共信息项详情
	function datailImportRow (id) {
		var row = $("#informationTable").bootstrapTable('getRowByUniqueId', id);
		importDetailLayeForm = layer.open({
			title: "信息项详情",
			type : 1,
			area : [ '60%', '60%' ],
			scrollbar : false,
			zIndex : 100,
			content : $("#import_layer_form"),
			cancel : function () {
				endMethod(formId, "close");
			}
		});
		loadToData(row, 'import_eform');
		// 然后将所有表单中的选项做一个禁选中操作
		$("#import_eform").find("input").each(function () {
			$(this).attr("disabled","disabled");
		});
		$("#import_eform").find("textarea").each(function () {
			$(this).attr("disabled","disabled");
		});
		// 判断select
		$("#import_eform select").prop("disabled", true);
		$("#import_eform select").trigger("chosen:updated");
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

