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
			<!-- <div class="ibox-title">字典管理</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="label" type="text" placeholder="输入字典名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#dictTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('字典新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<!-- <input id="btnExport" class="btn btn-primary" type="button" onclick="exportData();" value="导出"/>
								<input id="btnImport" class="btn btn-primary" type="button" onclick="importData();" value="导入"/> -->
							</div>
						</div>
					</div>
				</div>
				<table id="dictTable">
					<thead class="ele-hide">
						<tr>
							<th data-field="label">字典名称</th>
							<th data-field="type">字典号</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" id="id" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">字典名称：</label>
				<div class="col-sm-7">
					<input type="text" name="label" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">字典号：</label>
				<div class="col-sm-7">
					<input type="text" name="type" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">字典值：</label>
				<div class="col-sm-7">
					<input type="text" name="value" class="form-control" required>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">父级ID：</label>
				<div class="col-sm-7">
					<input type="text" name="pid" class="form-control">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">排序：</label>
				<div class="col-sm-7">
					<input type="text" name="sort" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">备注：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" class="form-control" required>
				</div>
			</div>
		</form>
	</div>
	<div id="importBox" style="display: none;">
		<form id="importForm" action="${ctx}/sys/dict/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/dict/import/template">下载模板</a>
			<br/><br/>导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！
		</form>
	</div>
	<div id="exportBox" style="display: none;">
		<form id="exportForm" action="${ctx}/sys/dict/export" method="post" class="breadcrumb form-search ">
		</form>
	</div>
</body>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#dictTable';
		var toolbar = '#toolbar';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var importForm='#importForm';
		var importBox='#importBox';
		var exportForm='#exportForm';
		var exportBox='#exportBox';
		var url = '${ctx}/settings/dict/';
		var obj = {
			label : $('#sName').val(),
		};
		var editTitle = "字典修改";
		var detailTitle = "字典详情";
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</html>
