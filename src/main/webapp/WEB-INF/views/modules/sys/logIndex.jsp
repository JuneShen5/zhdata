<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<style>
		#systemTable td{
			max-width: 285px;
			white-space:nowrap;
			overflow:hidden;
			text-overflow:ellipsis;
		}
	</style>
</head>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!--<div class="ibox-title">操作日志</div>-->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="title" type="text" placeholder="输入日志标题"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                	onclick="$('#systemTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
					</div>
				</div>
				<table id="systemTable">
					<thead class="ele-hide">
						<tr>
							<!-- <th data-field="nameEn">信息系统编号</th> -->
							<th data-field="title">日志标题</th>
							<th data-field="userName">操作用户</th>
							 <th data-field="createDate" data-width="158">操作时间</th>
							<!-- <th><fmt:formatDate value="createDate"/>操作时间</th> -->
							<th data-field="remoteAddr">操作地址</th>
							<!-- <th data-field="userAgent">用户代理</th> -->
							<th data-field="requestUri">URI</th>
							<th data-field="method">提交方式</th>
							<th data-field="paramse">操作数据</th>
							
							<!--<c:forEach var="log" items="${}">
								 <c:if test="${att.isShow=='yes'}"><th data-field="${att.nameEn}">${att.nameCn}</th></c:if>
							</c:forEach>-->
							<th data-field="Score" data-formatter="resTableButton">操作</th>
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
				<label class="col-sm-3 control-label layerTips">日志标题：</label>
				<div class="col-sm-7">
					<input type="text" name="title" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">操作用户：</label>
				<div class="col-sm-7">
					<input type="text" name="userName" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">操作时间：</label>
				<div class="col-sm-7">
					<input type="text" name="createDate" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">操作地址：</label>
				<div class="col-sm-7">
					<input type="text" name="remoteAddr" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">用户代理：</label>
				<div class="col-sm-7">
					<input type="text" name="userAgent" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">URI：</label>
				<div class="col-sm-7">
					<input type="text" name="requestUri" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">提交方式：</label>
				<div class="col-sm-7">
					<input type="text" name="method" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips">操作数据：</label>
				<div class="col-sm-7">
					<input type="text" name="paramse" class="form-control" required>
				</div>
			</div>

			
		</form>
	</div>
	
    <%--<%@include file="/WEB-INF/views/include/autoForm.jsp"%>	--%>
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script>
		var tableId = '#systemTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/sys/logIndex/';
		var obj = {};
		var editTitle = "系统清单修改";
		var detailTitle = "系统清单详情";
		var exportBox = '#exportData';
		var exportForm = '#exportForm';
		var importBox = '#importData';
		var importForm = '#importForm';
		var rowInput = "#exportData input[name='obj']";
		var uploaderServer = "system";
		
		
		
		function resTableButton(index, row, element) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
					+ row.id
					+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
			html += '</div>';
			return html;
		}	
		
		
	</script>
	
	<script src="${ctxStatic}/js/common/common.js"></script>
	
	
</body>
</html>