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
			<!-- <div class="ibox-title">单位管理</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入单位名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#siteTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('单位新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<!-- <input id="btnExport" class="btn btn-primary" type="button" onclick="exportData();" value="导出"/>
								<input id="btnImport" class="btn btn-primary" type="button" onclick="importData();" value="导入"/> -->
							</div>
						</div>
					</div>
				</div>
				<table id="siteTable">
					<thead class="ele-hide">
						<tr>
							<th data-field="code">单位信用代码</th>
							<th data-field="name">单位名称</th>
							<th data-field="typeName">级别</th>
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
				<label class="col-sm-3 control-label">单位信用代码：</label>
				<div class="col-sm-7">
					<input type="text" name="code" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">单位名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">单位级别：</label>
				<div class="col-sm-7">
					<select name="typeId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('site_level')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
	<div id="importBox" style="display: none;">
		<form id="importForm" action="${ctx}/sys/site/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/site/import/template">下载模板</a>
			<br/><br/>导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！
		</form>
	</div>
	<div id="exportBox" style="display: none;">
		<form id="exportForm" action="${ctx}/sys/site/export" method="post" class="breadcrumb form-search ">
		</form>
	</div>
</body>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#siteTable';
		var toolbar = '#toolbar';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var importForm='#importForm';
		var importBox='#importBox';
		var exportForm='#exportForm';
		var exportBox='#exportBox';
		var url = '${ctx}/settings/site/';
		var obj = {
				name : $('#sName').val(),
			};
		var editTitle = "单位修改";
		var detailTitle = "单位详情";
	</script>
	<script src="${ctxStatic}/js/common/common.js"></script>
</html>
