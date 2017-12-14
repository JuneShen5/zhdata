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
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#manageTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								<button type="button" id=""
                                	onclick="searchMore()" 
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-blue"
									onclick="ImportInfo('导入信息项');"><i class="fa fa-reply"></i> 导入信息项</a>
								<a data-toggle="modal" class="btn btn-danger"
									onclick="deleteAllData()"><i class="fa fa-trash"></i> 清空所有</a>
							</div>
						</div>
					</div>
					<div class="search-list">
						<div class="check-search">
							<label class="">是否为公共数据：</label>
							<div class="check-search-item" style="width:200px;">
								<select type="text" sName="publicId" class="form-control search-chosen publicId">
									<option value="">全部</option>
									<option value=0>否</option>
									<option value=1>是</option>
								</select>
							</div>
						</div>
						<div class="check-search">
							<label class="">来源部门：</label>
							<div class="check-search-item" style="width:200px;">
								<select type="text" sName="companyId" class="form-control search-chosen companyId">
									<option value="">全部</option>
									<c:forEach var="company" items="${fns:getList('company')}">
										<option value="${company.id}">${company.name}</option>
									</c:forEach>
									
								</select>
							</div>
						</div>
					</div>
				</div>
				<table id="manageTable">
					<thead>
						<tr>
							<th data-field="idCode">内部标识符</th>
							<th data-field="nameCn">中文名称</th>
							<th data-field="nameEn">英文名称</th>
							<th data-field="dataTypeName">信息项类型</th>
							<th data-field="companyName">来源部门</th>
							<th data-field="Score" data-formatter="manageTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	
	<div id="import_layer_table" style="display: none;" class="ibox-content">
		<div class="alert alert-info">
			将当前搜索结果的每一页数据全部导入。如导入数据量大，请耐心等待。 <a class="alert-link" href="javascript:importAll();">导入全部</a>.
		</div>
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
									<select name="seach_company_id" data-placeholder=" " class="select-chosen name1 form-control" style="width: 350px;">
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
								<input type="text" placeholder="输入名称" name="seach_name" class="form-control">
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
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	var tableId = '#manageTable';
	var toolbar = '#toolbar';
	var layerId = '#layer_form';
	var formId = '#eform'; // form id
	var url = '${ctx}/standard/manage/';
	var obj = {};
	var editTitle = "数据元池修改";
	var detailTitle = "数据元池详情";
	
	$(function () {
		importTable = new importTableInit();
		importTable.Init();
	})
	
	function manageTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
				+ row.id
				+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
				+ row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
		html += '<button type="button" class="btn btn-white" onclick="deleteManageRow(\''
				+ row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
		html += '<button type="button" class="btn btn-white ' + publicShow(row.publicId) + '" onclick="addPublicRow(\''
				+ row.id + '\')"><i class="fa fa-plus"></i>&nbsp;添加公共</button>';
		html += '</div>';
		return html;
	}
	
	// 删除，将数据元池中的数据删除，放回到信息项中去
	function deleteManageRow (id) {
		layeConfirm = layer.confirm('您确定要删除么？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.post(url + 'delete', {
				id : id
			}, function(data) {
				layer.close(layeConfirm);
				$(tableId).bootstrapTable('refresh');
				layer.msg(data);
			}, 'json');
		});
	}
	
	// 根据publicId显示按钮
	function publicShow (id) {
		if (id == 0) {
			return "show";
		} else if (id == 1) {
			return "hide";
		}
	}
	
	// 添加公共
	function addPublicRow (id) {
		layeConfirm = layer.confirm('是否确定添加为公共？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.ajax({url: url + "addPublic?id=" + id, success: function (res) {
				layer.msg(res);
				$(tableId).bootstrapTable('refresh');
			}})
		});
	}
	
	// 搜素的下拉框
	function searchMore () {
		$(".search-list").slideToggle();
	};
	
	// 导入信息项
	function ImportInfo () {
		inportLayeForm = layer.open({
			title: "选择导入信息项",
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
				$.ajax({
					url: url+"import",
					data: {params: JSON.stringify(params)},
					type: "POST",
					success: function (res) {
						layer.msg("添加成功");
						$(tableId).bootstrapTable('refresh');
						$("#informationTable").bootstrapTable('refresh');
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
	
	// 导入数据项表格初始化
	var importTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#informationTable").bootstrapTable({
				url : '${ctx}/catalog/element/' + 'list?',
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
			importObj.nameCn = $("input[name=seach_name]").val();
			// importObj.sourceId = $("select[name=seach_source_id]").val();
			importObj.companyId = $("select[name=seach_company_id]").val();
			importObj.toPool=0;
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				obj : JSON.stringify(importObj)
			};
			return temp;
		};
		return oTableInit;
	};
	
	// 导入信息项按钮
	function importTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailImportRow('
				+ row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		return html;
	}
	
	// 导入信息项详情
	function datailImportRow (id) {
		var row = $("#informationTable").bootstrapTable('getRowByUniqueId', id);
		importDetailLayeForm = layer.open({
			title: "信息项详情",
			type : 1,
			area : [ '80%', '80%' ],
			scrollbar : false,
			zIndex : 100,
			content : $("#import_layer_form"),
			cancel : function () {
				endMethod(formId, "close");
				$("#import_eform").find("input").each(function () {
					$(this).removeAttr("disabled");
				});
				$("#import_eform").find("textarea").each(function () {
					$(this).removeAttr("disabled");
				});
				$("select").prop("disabled", false);
				$("select").trigger("chosen:updated");
			}
		});
		loadData(row);
		// 然后将所有表单中的选项做一个禁选中操作
		$("#import_eform").find("input").each(function () {
			$(this).attr("disabled","disabled");
		});
		$("#import_eform").find("textarea").each(function () {
			$(this).attr("disabled","disabled");
		});
		// 判断select
		$("select").prop("disabled", true);
		$("select").trigger("chosen:updated");
	}
	
	function deleteAllData () {
		layeConfirm = layer.confirm('您确定要删除么？', {
			btn : [ '确定', '取消' ]
		}, function() {
			$.post(url + 'deleteAll', {}, function(data) {
				layer.close(layeConfirm);
				$(tableId).bootstrapTable('refresh');
				layer.msg(data);
			}, 'json');
		});
	}
	
	function importAll () {
		$.ajax({
			url: url + 'import',
			data: {params: '[]'},
			type: "POST",
			success: function () {
				layer.msg("导入全部成功")
				$(tableId).bootstrapTable('refresh');
				$("#informationTable").bootstrapTable('refresh');
			},
			error: function () {
				layer.msg("全部导入失败，请重试")
			}
		})
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

