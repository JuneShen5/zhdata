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
			<!-- <div class="ibox-title">部门管理</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入部门名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#companyTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('部门新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
							</div>
						</div>
					</div>
				</div>
				<table id="companyTable">
					<thead>
						<tr>
							<th data-field="code">部门代码</th>
							<th data-field="name">部门名称</th>
							<th data-field="siteName">所属单位</th>
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
				<label class="col-sm-3 control-label">部门名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">部门代码：</label>
				<div class="col-sm-7">
					<input type="text" name="code" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">地址：</label>
				<div class="col-sm-7">
					<input type="text" name="address" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属单位：</label>
				<div class="col-sm-7">
					<select name="siteId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="site" items="${fns:getList('site')}">
							<option value="${site.id}">${site.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
		<!-- 导出数据开始 -->
	<div id="exportData" style="display: none;"  class="ibox-content">
		<form method="post" action="company/exportData" class="form-horizontal" id="exportForm">
			<div class="alert alert-info">如导出数据量大，下载请耐心等待！</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="部门名称" nameEn="name" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				部门名称
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="部门代码" nameEn="code" inputType="input" inputValue="role" checked/> <!-- inputType="companyselect" -->
				部门代码
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="地址" nameEn="address" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				地址
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="所属单位" nameEn="siteId" inputType="select" inputValue="site" checked/> <!-- inputType="companyselect" -->
				所属单位
			</div>
			
			<input type="hidden" name="obj" value="">
		</form>
	</div>
	<!-- 导出数据结束 -->
	
	<!-- excel导入开始 -->
	<%@ include file="/WEB-INF/views/include/importData.jsp"%>
</body>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#companyTable';
		var toolbar = '#toolbar';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var importForm='#importForm';
		var exportForm='#exportForm';
		
		var exportBox = '#exportData';
		var importBox = '#importData';
		var uploaderServer = "company";
		
		var url = '${ctx}/settings/company/';
		var obj = {
				name : $('#sName').val(),
			};
		var editTitle = "部门修改";
		var detailTitle = "部门详情";
	</script>
	
	<script src="${ctxStatic}/js/common/common.js"></script>
</html>
