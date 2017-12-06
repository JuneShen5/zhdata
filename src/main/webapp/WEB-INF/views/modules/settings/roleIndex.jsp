<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="stylesheet"
	href="${ctxStatic}/css/plugins/bootstrap-table/bootstrap-table.min.css">
</head>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">角色管理</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入角色名"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#roleTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('角色新增');"><i class="fa fa-plus-square-o"></i> 新增</a> <!-- <input id="btnExport"
									class="btn btn-primary" type="button" onclick="exportData();"
									value="导出" /> <input id="btnImport" class="btn btn-primary"
									type="button" onclick="importData();" value="导入" /> -->
							</div>
						</div>
					</div>
				</div>
				<table id="roleTable">
					<thead>
						<tr>
							<th data-field="name">角色名称</th>
							<th data-field="enname">描述</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
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
				<label class="col-sm-3 control-label">角色名：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">描述：</label>
				<div class="col-sm-7">
					<input type="text" name="enname" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">角色授权：</label>
				<div class="col-sm-ztree">
					<ul id="ztree_excheck" class="ztree" name="menuList"></ul>
				</div>
			</div>

			<!-- 作为上面树插件的隐藏域 -->
			<div class="form-group" style="visibility: hidden;">
				<div class="col-sm-ztree">
					<input id="menuIds" type="roleRequired" name="menuIds" class="form-control" required>
				</div>
			</div>
		</form>
	</div>
		
	<div id="importBox" style="display: none;">
		<form id="importForm" action="${ctx}/sys/role/import" method="post"
			enctype="multipart/form-data" class="form-search"
			style="padding-left: 20px; text-align: center;"
			onsubmit="loading('正在导入，请稍等...');">
			<br /> <input id="uploadFile" name="file" type="file"
				style="width: 330px" /><br />
			<br /> <input id="btnImportSubmit" class="btn btn-primary"
				type="submit" value="   导    入   " /> <a
				href="${ctx}/sys/role/import/template">下载模板</a> <br />
			<br />导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！
		</form>
	</div>
	<div id="exportBox" style="display: none;">
		<form id="exportForm" action="${ctx}/sys/role/export" method="post" class="breadcrumb form-search ">
		</form>
	</div>

</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<style>
.col-sm-ztree {
	width: 57%;
	overflow: auto;
	max-height: 350px;
	float: left;
	padding-left: 14px;
}

.ztree {
	border: 1px solid #e5e6e7;
}

#menuIds-error {
	visibility: visible;
	margin-left: 45%;
	margin-top: -35px;
}
</style>
<script>
	var tableId = '#roleTable';
	var toolbar = '#toolbar';
	var layerId = '#layer_form';
	var formId = '#eform'; //form id
	var importForm = '#importForm';
	var importBox = '#importBox';
	var exportForm='#exportForm';
	var exportBox='#exportBox';
	var url = '${ctx}/settings/role/';
	var obj = {
		name : $('#sName').val(),
	};
	var editTitle = "角色修改";
	var detailTitle = "角色详情";
	// ztree
	var ztreeSetting = {
		check : {
			enable : true,
			chkboxType : {
				"Y" : "s",
				"N" : "ps"
			}
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		view : {
			showLine : false,
			showIcon : false
		},
		callback : {
			onCheck : zTreeOnCheck
		}
	};
	var selectData;
	var zTree;
	$(document).ready(function() {
		$(function() {
			$.ajax({
				url : "/zhdata/settings/menu/list",
				success : function(data) {
					$.each(data, function(index, item) {
						item.pId = item.parentId;
						delete item.icon
					});
					$.fn.zTree.init($("#ztree_excheck"), ztreeSetting, data);
					zTree = $.fn.zTree.getZTreeObj("ztree_excheck");
					zTree.expandAll(true);
				}
			})
		})
	});

	// 勾选后的回调函数
	function zTreeOnCheck(event, treeId, treeNode) {
		selectData = zTree.getCheckedNodes(true);
		var checkData = [];
		$.each(selectData, function(index, item) {
			checkData.push({
				id : item.id
			});
		});
		$("#menuIds").val(JSON.stringify(checkData));
	};
	// 提交之后清空ztree
	function resetPage () {
		zTree.checkAllNodes(false);
	}
</script>

<script src="${ctxStatic}/js/common/common.js"></script>

</html>
