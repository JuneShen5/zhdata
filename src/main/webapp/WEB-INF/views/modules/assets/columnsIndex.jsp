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
			<!-- <div class="ibox-title">数据字段</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入数据字段名"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#columnsTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-yellow"
									onclick="deleteAll()"><i class='fa fa-trash-o'></i> 批量删除</a>
							</div>
						</div>
					</div>
					<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">字段代码：</label>
							<div class="check-search-item" style="width:200px;display: inline-block;">
								<input type="text" sName="nameEn" class="form-control" placeholder="请输入字段代码">
							</div>
						</div>
					</div>
				</div>
				<table id="columnsTable">
					<thead class="ele-hide">
						<tr>
						    <th data-checkbox="true"></th>
						    <th data-field="nameEn">字段代码</th>
							<th data-field="nameCn">字段名</th>
							<th data-field="tbName">所属表</th>
							<th data-field="type">类型</th>
							<th data-field="length">长度</th>
							<th data-field="Score" data-formatter="TableButton" class="col-sm-4" data-width=420>操作</th>
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
				<label class="col-sm-3 control-label">字段代码：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">字段名：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属表：</label>
				<div class="col-sm-7">
					<select name="tbId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="tb" items="${fns:getDrList('tables')}">
							<option value="${tb.id}">${tb.nameEn}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">类型：</label>
				<div class="col-sm-7">
					<select name="type" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('data_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">长度：</label>
				<div class="col-sm-7">
					<input type="text" name="length" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">是否为主键：</label>
				<div class="col-sm-7">
					<select name="isKey" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">备注：</label>
				<div class="col-sm-7">
					<input type="text" name=remarks class="form-control">
					<div class="Validform_checktip"></div>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#columnsTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/assets/columns/';
		var obj = {
			nameCn : $('#sName').val(),
		};
		var editTitle = "数据字段修改";
		var detailTitle = "数据字段详情";
        /* var pageParams = {
            tableId: '#columnsTable',
            layerId: '#layer_form',
            formId: '#eform',
            toolbar: '#toolbar',
            url: '${ctx}/assets/columns/',
            editTitle: '数据字段修改',
            detailTitle: '数据字段修改'
        }; */
	</script>

	<script>
	function columsToElement(id, status) {
		if (status == 1) {
			layer.msg("此条数据已同步")
			return
		} else if (status == 0) {
			$.get(url + 'columsToElement',{id:id},function(data){
				layer.msg(data);
				$(tableId).bootstrapTable('refresh');
			})
		}
	}
	
	function TableButton(index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
				+ row.id
				+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
				+ row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
		html += '<button type="button" class="btn btn-white" onclick="deleteRow(\''
				+ row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
		html += '</div>';
		return html;
	}
	</script>
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

