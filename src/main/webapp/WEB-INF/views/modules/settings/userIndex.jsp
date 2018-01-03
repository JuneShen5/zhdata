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
							<select type="text" name="searchType" class="form-control col-sm-6" style="margin-right: 5px">
								<option value="name">姓名</option>
								<option value="loginName">用户名</option>
							</select>
							<input id="sName" sName="name" type="text" placeholder="输入搜索项名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick="conditionalSearch();"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('用户新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData(8);"><i class='fa fa-sign-in'></i> Excel导入</button>
							</div>
						</div>
					</div>
				</div>
				<table id="userTable">
					<thead class="ele-hide">
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
				<label class="col-sm-3 control-label" layerData="登录名">登录名：</label>
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
					<input type="text" hasNoSpace="true" name="no" class="form-control" required>
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
					<input id="" name="companyId" class="form-control citySelId hide" type="text">
					<input id="" name="companyName" class="form-control citySel" type="text" ReadOnly required/>
					<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
				</div>
			</div>
		</form>
	</div>
	
	
	<!-- excel导入导出-->
	<c:set var="type" value="8" />
	<%@ include file="/WEB-INF/views/include/exp_importData.jsp"%>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#userTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var uploaderServer = "user";
		var url = '${ctx}/settings/user/';
		var obj = {
			name : $('#sName').val(),
            loginName: ''
		};
		var editTitle = "用户修改";
		var detailTitle = "用户详情";
		var validformCallback = false;
//		$(".reload").click(function () {
//            //parent.location.reload();
//            console.log($(".logo", window.parent.document).text());
//        });

        // 选择条件搜索
        function conditionalSearch() {
            var searchType = $('select[name=searchType]').val();
            $('#sName').attr('sName', searchType);
            $(tableId).bootstrapTable('refresh');
            obj[searchType] = '';
        }
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

