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
			<!-- <div class="ibox-title">信息项</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入信息项名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#elementTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
									<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('信息项新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
								<button class="btn btn-yellow" type="button" onclick="deleteAll();"><i class='fa fa-trash-o'></i> 批量删除</button>
								<button class="btn btn-red" type="button" onclick="deleteAllRows();"><i class='fa fa-trash-o'></i> 清空所有</button>
							</div>
						</div>
					</div>
					<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">来源部门：</label>
							<div class="check-search-item" style="width:200px;display: inline-block;">
								<select type="text" sName="companyId" class="form-control search-chosen select-chosen">
                        			<option value="">全部</option>
									<c:forEach var="company" items="${fns:getList('company')}">
										<option value="${company.id}">${company.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					
					
				</div>
				<table id="elementTable">
					<thead>
						<tr>
							<th data-checkbox="true"></th>
							<th data-field="idCode">内部标识符</th>
							<th data-field="nameCn">信息项名称</th>
							<th data-field="dataTypeName">数据类型</th>
							<th data-field="len">数据长度</th>
							<th data-field="companyName">来源部门</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display:none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	<!-- 导出数据开始 -->
	<div id="exportData" style="display: none;"  class="ibox-content">
		<form method="post" action="element/exportData" class="form-horizontal" id="exportForm">
			<div class="alert alert-info">如导出数据量大，下载请耐心等待！</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="信息项名称" nameEn="nameCn" inputType="input" inputValue="" checked/>
				信息项名称
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="英文名称" nameEn="nameEn" inputType="input" inputValue="" checked/>
				英文名称
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="数据类型" nameEn="dataTypen" inputType="dictselect" inputValue="data_type_en" checked/>
				数据类型
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="数据类型(子)" nameEn="dataType" inputType="dictselect" inputValue="data_type" checked/>
				数据类型(子)
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="数据长度" nameEn="len" inputType="input" inputValue="" checked/>
				数据长度
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="对象类型" nameEn="objectType" inputType="dictselect" inputValue="object_type" checked/>
				对象类型
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="数据标记" nameEn="dataLabel" inputType="dictselect" inputValue="yes_no" checked/>
				数据标记
			</div>
			
			<div class="col-md-3">
				<input type="checkbox" nameCn="来源部门" nameEn="companyId" inputType="companyselect" inputValue="company" checked/>
				来源部门
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="是否字典项" nameEn="isDict" inputType="dictselect" inputValue="yes_no" checked/>
				是否字典项
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="共享类型" nameEn="shareType" inputType="dictselect" inputValue="share_type" checked/>
				共享类型
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="共享条件" nameEn="shareCondition" inputType="dictselect" inputValue="share_condition" checked/>
				共享条件
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="共享方式" nameEn="shareMode" inputType="dictselect" inputValue="share_mode" checked/>
				共享方式
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="是否向全社会开放" nameEn="isOpen" inputType="dictselect" inputValue="yes_no" checked/>
				是否向全社会开放
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="开放条件" nameEn="openType" inputType="dictselect" inputValue="open_type" checked/>
				开放条件
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="更新周期" nameEn="updateCycle" inputType="dictselect" inputValue="update_cycle" checked/>
				更新周期
			</div>
		<!-- 	<div class="col-md-3">
				<input type="checkbox" nameCn="备注" nameEn="label" inputType="input" inputValue="" checked/>
				备注
			</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="排序" nameEn="sort" inputType="input" inputValue="" checked/>
				排序
			</div> -->
			<input type="hidden" name=obj value="">
		</form>
	</div>
	<!-- 导出数据结束 -->
	
	<!-- excel导入开始 -->
	<%@ include file="/WEB-INF/views/include/importData.jsp"%>
	<!-- excel导入结束 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#elementTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/catalog/element/';
		var obj = {
			nameCn : $('#sName').val()
		};
		var editTitle = "信息项修改";
		var detailTitle = "信息项详情";

		var exportBox = '#exportData';
		var exportForm = '#exportForm';
		var importBox = '#importData';
		var importForm = '#importForm';
		var rowInput = "#exportData input[name='obj']";
		var uploaderServer = "element";

        // 清空所有按钮事件
        function deleteAllRows() {
            layer.confirm('确定要删除所有数据？（选择确定将删除所有数据，请慎重）', function(index){
                $.ajax({
                    url: "${ctx}/catalog/element/deleteAll",
                    type: 'get',
                    success: function (data) {
                        layer.msg('删除成功！');
                        $(tableId).bootstrapTable('refresh');
                    }
                });
                layer.close(index);
                //向服务端发送删除指令
            });

        }

		// 共享方式
		var gxtjSelect = $("select[name=shareCondition]");
		var gxfsSelect = $("select[name=shareMode]");
		gxtjSelect.closest('.form-group').hide();
		gxtjSelect.removeAttr("required");
		gxfsSelect.closest('.form-group').hide();
		gxfsSelect.removeAttr("required");
		$("select[name=shareType]").chosen({
			width : "100%"
		}).change(function () {
			if ($(this).val() == 1) {
				gxfsSelect.closest('.form-group').hide();
				gxfsSelect.closest('.form-group').slideToggle();
				gxfsSelect.attr("required", "required");
				gxtjSelect.closest('.form-group').hide();
				gxtjSelect.val("");
				gxtjSelect.trigger("chosen:updated");
				gxtjSelect.removeAttr("required");
			} else if ($(this).val() == 2) {
				gxfsSelect.closest('.form-group').hide();
				gxtjSelect.closest('.form-group').hide();
				gxfsSelect.closest('.form-group').slideToggle();
				gxfsSelect.attr("required", "required");
				gxtjSelect.closest('.form-group').slideToggle();
				gxtjSelect.attr("required", "required");
			} else if ($(this).val() == 3) {
				gxfsSelect.closest('.form-group').hide();
				gxfsSelect.val("");
				gxfsSelect.trigger("chosen:updated");
				gxfsSelect.removeAttr("required");
				gxtjSelect.closest('.form-group').hide();
				gxtjSelect.val("");
				gxtjSelect.trigger("chosen:updated");
				gxtjSelect.removeAttr("required");
			}
		});

		// 是否向社会开放
		$("select[name=openType]").closest('.form-group').hide();
		$("select[name=openType]").removeAttr("required");
		// 判断是否使用其他部门数据与是否提供数据给其他部门
		$("select[name=isOpen]").chosen({
			width : "100%"
		}).change(function () {
			if ($(this).val() == 1) {
				$("select[name=openType]").closest('.form-group').slideToggle();
				$("select[name=openType]").attr("required", "required");
			} else if ($(this).val() == 0) {
				$("select[name=openType]").closest('.form-group').hide();
				$("select[name=openType]").val("");
				$("select[name=openType]").trigger("chosen:updated");
				$("select[name=openType]").removeAttr("required");
			}
		});
	</script>
	
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

