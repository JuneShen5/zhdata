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
<body class="gray-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-title">信息系统审核</div>
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入信息系统名称"
								class="form-control col-sm-8 nameCn">
							<div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                	onclick="tableSearch()"
									class="btn btn-primary">搜索</button>
								<button type="button" id="searchFor"
                                	onclick="searchMore()" 
									class="btn btn-primary"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<button id="examineButton" data-toggle="modal" class="btn btn-primary"
									onclick="batchAudit()">批量审核</button>
							</div>
						</div>
					</div>
					<div class="search-list">
						<div class="check-search">
							<label class="">审核状态：</label>
							<div class="check-search-item" style="width:200px;">
								<select type="text" sName="isAudit" class="form-control search-chosen">
									<option value=0>未审核</option>
									<option value=1>已审核</option>
								</select>
							</div>
						</div>
						<div class="check-search">
							<label class="">编号：</label>
							<div class="check-search-item">
								<input type="text" sName="nameEn" class="form-control">
							</div>
						</div>
					</div>
				</div>
				<table id="systemTable">
					<thead>
						<tr>
							<th data-checkbox="true"></th>
							<!-- <th data-field="nameEn">信息系统编号</th> -->
							<th data-field="nameCn">信息系统名称</th>
							<th data-field="companyName">所属部门</th>
							<th data-field="auditName">状态</th>
							<th data-formatter="checkTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="layer_form" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label">信息系统名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">业务分类：</label>
				<div class="col-sm-7">
					<input type="text" name="infoType1" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">数据规模：</label>
				<div class="col-sm-7">
					<input type="text" name="infoType2" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">填报部门：</label>
				<div class="col-sm-7">
					<input type="text" name="companyName" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">状态：</label>
				<div class="col-sm-7">
					<input type="text" name="state" class="form-control" required>
				</div>
			</div>
			<c:set var="type" value="1" />
			<%@include file="/WEB-INF/views/include/autoForm.jsp"%>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/drs/system/';
		var obj = {};
		
		var checkId = "#systemTable";
		var itemState = 0;
		var detailTitle = "详情";
		
		$(function () {
			checkTable = new checkTableInit();
			checkTable.Init();
			$(".search-chosen").chosen({
				width : "100%"
			}).change(function (e) {
				var state = $(this).val();
				itemState = state;
		    });
		});
		
		// 搜索按钮
		function tableSearch () {
			$(checkId).bootstrapTable('refresh');
		};
		
		// 表格初始化
		var checkTableInit = function() {
			var oTableInit = new Object();
			// 初始化Table
			oTableInit.Init = function() {
				$(checkId).bootstrapTable({
					url : url + 'list',
					method : 'get',
					checkbox: true,
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
			};

			// 得到查询的参数
			oTableInit.queryParams = function(params) {
				// 编号  审核状态  名称 search-chosen
				obj.nameCn = $("input.nameCn").val();
				$(".search-list").find(".form-control").each(function (index, item) {
					obj[$(this).attr("sName")] = $(this).val();
				});
				console.log("obj: ", obj);
				var temp = {
					pageNum : params.offset / params.limit + 1,
					pageSize : params.limit,
					obj : JSON.stringify(obj)
				};
				return temp;
			};
			return oTableInit;
		};
		
		function checkTableButton(index, row, element) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white" onclick="checkDatail('
					+ row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
			if (itemState == 0) {
				html += '<button type="button" class="btn btn-white" id="edit"  onclick="releaseAudit('
					+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;发布审核</button>';
			}
			html += '</div>';
			return html;
		}
		
		// 批量审核
		function batchAudit () {
			if (itemState == 1) {
				return;
			}
			var data = $(checkId).bootstrapTable("getAllSelections");
			var postData = [];
			$.each(data, function (index, item) {
				postData.push(item.id)
			});
			if (postData.length <= 0) {
				layer.msg("请选择数据");
			}
			console.log("postData: ", JSON.stringify(postData))
			var ids = JSON.stringify(postData).substring(1, JSON.stringify(postData).length - 1);
			console.log("ids: ", ids);
			$.ajax({
				url: url + 'setAudit',
				type: 'post',
				data: {ids: ids},
				dataType: 'json',
				success: function (res) {
					layer.msg("通过审核!")
					$(checkId).bootstrapTable('refresh');
				}
			})
		};
		
		// 单独审批
		function releaseAudit (id) {
			console.log("id: ", id);
			var ids = id;
			$.ajax({
				url: url + 'setAudit',
				type: 'post',
				data: {ids: ids},
				dataType: 'json',
				success: function (res) {
					layer.msg("通过审核!")
					$(checkId).bootstrapTable('refresh');
				}
			})
		};
		
		// 详情弹框
		function checkDatail(id) {
			var row = $(checkId).bootstrapTable('getRowByUniqueId', id);
			openDetail();
			loadData(row);
			// 然后将所有表单中的选项做一个禁选中操作
			$(formId).find("input").each(function () {
				$(this).attr("disabled","disabled");
			});
		}
		
		// 搜素的下拉框
		function searchMore () {
			$(".search-list").slideToggle();
		};
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

