<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">用户管理</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入姓名"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#userTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('用户新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
							</div>
						</div>
					</div>
				</div>
				<table id="userTable">
					<thead>
						<tr>
							<th data-field="id">id</th>
							<th data-field="loginName">用户名</th>
							<th data-field="name">姓名</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
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
				<label class="col-sm-3 control-label layerTips" layerData="登录名">登录名：</label>
				<div class="col-sm-7">
					<input type="text" name="loginName" class="form-control" required>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label">角色：</label>
				<div class="col-sm-7">
						<select name="roleId" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="role" items="${fns:getList('role')}">
								<option value="${role.id}">${role.name}</option>
							</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">姓名：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" rangelength="[1,10]" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">工号：</label>
				<div class="col-sm-7">
					<input type="posNum" name="no" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">邮箱：</label>
				<div class="col-sm-7">
					<input type="email" name="email" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">电话：</label>
				<div class="col-sm-7">
					<input type="text" name="phone" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">手机：</label>
				<div class="col-sm-7">
					<input type="mobilePhone" name="mobile" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属部门：</label>
				<div class="col-sm-7">
					<%-- <select name="companyId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select> --%>
					<input id="citySelId" name="companyId" class="form-control hide" type="text">
					<input id="citySel" name="companyName" class="form-control" type="text" ReadOnly />
					<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
				</div>
			</div>
		</form>
	</div>
	
		<!-- 导出数据开始 -->
	<div id="exportData" style="display: none;"  class="ibox-content">
		<form method="post" action="user/exportData" class="form-horizontal" id="exportForm">
			<div class="alert alert-info">如导出数据量大，下载请耐心等待！</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="登录名" nameEn="loginName" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				登录名
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="角色" nameEn="roleId" inputType="select" inputValue="role" checked/> <!-- inputType="companyselect" -->
				角色
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="姓名" nameEn="name" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				姓名
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="工号" nameEn="no" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				工号
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="邮箱" nameEn="email" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				邮箱
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="电话" nameEn="phone" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				电话
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="手机" nameEn="mobile" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				手机
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="所属部门" nameEn="companyId" inputType="companyselect" inputValue="company" checked/> <!-- inputType="companyselect" -->
				所属部门
			</div>
			
			<input type="hidden" name="obj" value="">
		</form>
	</div>
	<!-- 导出数据结束 -->
	
		<!-- excel导入开始 -->
	<%@ include file="/WEB-INF/views/include/importData.jsp"%>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#userTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var exportBox = '#exportData';
		var importBox = '#importData';
		var uploaderServer = "user";
		var url = '${ctx}/settings/user/';
		var obj = {
			name : $('#sName').val(),
		};
		var editTitle = "用户修改";
		var detailTitle = "用户详情";
		var validformCallback = false;
//		$(".reload").click(function () {
//            //parent.location.reload();
//            console.log($(".logo", window.parent.document).text());
//        });
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

