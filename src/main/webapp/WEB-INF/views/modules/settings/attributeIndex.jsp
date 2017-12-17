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
			<!-- <div class="ibox-title">表单配置</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入名称"
								   class="form-control col-sm-8 nameCn">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
										onclick="$('#userTable').bootstrapTable('refresh');"
										class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
							</div>
						</div>
					</div>
				</div>
				<table id="userTable">
					<thead>
						<tr>
							<th data-field="nameCn">名称</th>
							<th data-field="sort">排序</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display:none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<input type="text" name="type" class="hide" value="${fns:getParam('type')}">
			<div class="form-group">
				<label class="col-sm-3 control-label">名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">是否核心字段：</label>
				<div class="col-sm-7">
					<select name="isCore" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('is_core')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">说明文字：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">是否必填：</label>
				<div class="col-sm-7">
					<select name="isRequire" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('require')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group validate-form">
				<label class="col-sm-3 control-label">验证规则：</label>
				<div class="col-sm-7">
					<select name="validType" class="select-chosen validate-type">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('validation_rule')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">输入框类型：</label>
				<div class="col-sm-7">
					<select name="inputType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('gen_show_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">输入框长度：</label>
				<div class="col-sm-7">
					<select name="inputLength" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('inputLength')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">输入框取值：</label>
				<div class="col-sm-7">
					<input type="text" name="inputValue" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">是否为显示列：</label>
				<div class="col-sm-7">
					<select name="isShow" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">搜索框类型：</label>
				<div class="col-sm-7">
					<select name="searchType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('search')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">排序：</label>
				<div class="col-sm-7">
					<input type="text" name="sort" class="form-control" required>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#userTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/settings/attribute/';
		var obj = {
//			 name : $('#sName').val(),
			 type: ${fns:getParam('type')}
		};
		var editTitle = "修改";
		var detailTitle = "详情";

		$(".validate-form").hide();
		$("select[name=isRequire]").chosen({
			width : "100%"
		}).change(function (e) {
			var val = $(this).val();
			if (val == 1) {
				$(".validate-form").slideToggle();
			} else if (val == 2) {
				$(".validate-form").hide();
				$(".validate-type").val("");
				$(".validate-type").trigger("chosen:updated");
			};
			$(this).blur();
	    })
		
	</script>
	
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

