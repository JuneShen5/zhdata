<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body class="gray-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入机房名称"
								class="form-control col-sm-8">
                            <c:forEach var="att" items="${fns:getAttList(5)}">
                                     <c:if test="${att.searchType=='2'}">
                                            <input id="${att.id}" sName="${att.nameEn}" type="text" placeholder="输入${att.nameCn}"
                                                class="form-control col-sm-8" style="margin-left: 15px;">
                                     </c:if>
                            </c:forEach>
							<div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                	onclick="$('#computerRoomTable').bootstrapTable('refresh');"
									class="btn btn-primary">搜索</button>
							</div>
						</div>
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-primary"
									onclick="openLayer('机房清单新增');">新增</a>
							</div>
						</div>
					</div>
				</div>
				<table id="computerRoomTable">
					<thead>
						<tr>
							<th data-field="name">机房名称</th>
							<c:forEach var="att" items="${fns:getAttList(5)}">
								 <c:if test="${att.isShow=='yes'}"><th data-field="${att.nameEn}">${att.nameCn}</th></c:if>
							</c:forEach>
							<th data-field="companyName">责任部门</th>
							<th data-field="Score" data-formatter="initTableButton">操作</th>
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
				<label class="col-sm-3 control-label">责任部门 (*)：</label>
				<div class="col-sm-7">
					<select name="companyId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">机房名称 (*)：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" required>
				</div>
			</div>
			<c:set var="type" value="5" />
			<%@include file="/WEB-INF/views/include/autoForm.jsp"%>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#computerRoomTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/drs/computerRoom/';
		var obj = {
			name : $('#sName').val(),
		};
		var editTitle = "机房清单修改";
		var detailTitle = "机房清单详情";
		
	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
	
	<script>
	
	/* $(tableId).on("post-body.bs.table", function () {
		var columnField;
		var newColumnField;
		var moban = [{type: "1", ch: "类型1号"}, {type: "2", ch: "类型2号"}, {type: "3", ch: "类型3号"}, {type: "4", ch: "类型4号"}]
		$("#systemTable tbody tr").each(function (index, item) {
			columnField = $(this).children("td:nth-child(4)").html();
			switch(columnField)
			{
				case "1":
					newColumnField = "自建"
				break;
				case "2":
					newColumnField = "上级配发"
				break;
				case "3":
					newColumnField = "采购"
				break;
				case "4":
					newColumnField = "联合建设"
				break;
				case "5":
					newColumnField = "代建代维"
				break;
				default:break;
			};
			$(this).children("td:nth-child(4)").html(newColumnField);

			var asd = $(tableId).bootstrapTable('getData', true);
			console.log("asd: ", asd)
		})
	})
	 */
	</script>
</body>
</html>

