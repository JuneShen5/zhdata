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
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入数据库名"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#dbsTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('新增')"><i class='fa fa-plus-square-o'></i> 新增</a>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-cyan"
									onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</a>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-purple"
									onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</a>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-yellow"
									onclick="deleteAll()"><i class='fa fa-trash-o'></i> 批量删除</a>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-blue"
									onclick="openDatabase()"><i class='fa fa-database'></i> 数据库连接</a>
							</div>
						</div>
					</div>
					<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">所属机构：</label>
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
				<table id="dbsTable">
					<thead class="ele-hide">
						<tr>
						    <th data-checkbox="true"></th>
						    <th data-field="nameEn">数据库代码</th>
							<th data-field="nameCn">数据库名称</th>
						    <th data-field="companyName">所属机构</th>
						    <th data-field="sysName">所属系统</th>
							<th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="mid_layer_form" style="display:none" class="ibox-content">
		<form id="midform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">数据库类型：</label>
				<div class="col-sm-7">
					<select name="type" class="select-chosen" required>
						<option value=""></option>
						<option value="mysql">mySql</option>
						<option value="oracle">oracle</option>
						<option value="db2">db2</option>
						<option value="sqlserver">sqlServer</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">用户名：</label>
				<div class="col-sm-7">
					<input type="text" name="user" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">密码：</label>
				<div class="col-sm-7">
					<input type="password" name="password" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">IP地址：</label>
				<div class="col-sm-7">
					<input type="text" name="host" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">端口号：</label>
				<div class="col-sm-7">
					<input type="text" name="port" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">数据库英文名：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">数据库中文名：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属系统：</label>
				<div class="col-sm-7">
					<select name="sysId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="sys" items="${fns:getList('sys')}">
							<option value="${sys.id}">${sys.nameCn}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属机构：</label>
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
	
	<div id="list_layer_form" style="display:none" class="ibox-content">
		<form id="listform" class="form-horizontal">
			<div class="form-group" id="list_layer_detail" style="padding: 20px 100px;">
			</div>
			<input type="text" name="nameCn" class="form-control hide">
			<input type="text" name="nameEn" class="form-control hide">
		</form>
	</div>
	
	<div id="layer_form" style="display:none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-4 control-label">数据库代码：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">数据库名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-4 control-label">所属机构：</label>
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
			<div class="form-group">
				<label class="col-sm-4 control-label">所属系统：</label>
				<div class="col-sm-7">
					<select name="sysId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="sys" items="${fns:getList('sys')}">
							<option value="${sys.id}">${sys.nameCn}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</form>
	</div>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
        var validformCallback = false;

        var layerIndex = "test";
        var midLayerId = "#mid_layer_form";
        var listLayerId = "#list_layer_form";
        var midformId = '#midform';
        var listformId = "#listform";
		var tableId = '#dbsTable';
		var layerId = '#layer_form';
		var formId = '#eform'; // form id
		var toolbar = '#toolbar';
		var url = '${ctx}/assets/dbs/';
		var obj = {
			 nameCn : $('#sName').val(),
		};
		var editTitle = "数据库修改";

		var detailTitle = "数据库详情";
		
		var exportBox = '#exportData';
		var importBox = '#importData';
		var uploaderServer = "dbs";
		
		// 数据库连接
		function openDatabase () {
			$(midformId).resetForm();
			newlyForm(midformId);
			$(midformId).submit();
			layeForm = layer.open({
				title: "连接数据库",
				type : 1,
				area : [ '100%', '100%' ],
				scrollbar : false,
				zIndex : 100,
				btn : ["测试", "下一步", "关闭"],
				yes : function(index, layero) {
					layerIndex = "test";
					$(midformId).submit();
				},
				btn2: function () {
					layerIndex = "next";
					$(midformId).submit();
					endMethod(midformId, "close");
					return false
				},
				btn3 : function() {
					$(midformId).resetForm();
					endMethod(midformId, "close");
				},
				cancal: function () {
					$(midformId).resetForm();
					endMethod(midformId, "close");
				},
				content : $(midLayerId)
			});
		}
		
		//  选择表
		function openSurface () {
			newlyForm(listformId);
			layeForm = layer.open({
				title: "选择表",
				type : 1,
				area : [ '100%', '100%' ],
				scrollbar : false,
				zIndex : 100,
				btn : ["保存", "关闭"],
				// closeBtn: 0,
				yes : function(index, layero) {
					layerIndex = "list";
					$(listformId).submit();
				},
				end : function() {
					$(listformId).resetForm();
					endMethod(listformId, "close");
					$("#list_layer_detail").html("");
				},
				cancel: function () {
					$(listformId).resetForm();
					endMethod(listformId, "close");
					$("#list_layer_detail").html("");
				},
				content : $(listLayerId)
			});
		}
		
		// 第一个弹框请求返回成功
		function midSubmit (data) {
			// 拼接列表html
			var listHtml = '';
			$.each(data, function (index, item) {
				listHtml += '<div class="col-sm-4"><label class="checkbox-inline i-checks"><input type="checkbox" value="' + item.nameEn + '" nameCn="' + item.nameCn + '">' + item.nameEn + '</label></div>'
			})
			$("#list_layer_detail").append(listHtml);
			checkInit();
			layer.msg("连接成功！");
			layer.close(layeForm);
			openSurface();
		};
		// 第二个弹框请求返回成功
		function listSubmit (data) {
			layer.close(layeForm);
			$(tableId).bootstrapTable('refresh');
			layer.msg(data);
			endMethod(listLayerId);
			$("#list_layer_detail").html("");
		};
		
		function newlyForm (newlyformId) {
			$(newlyformId).validate({
				ignore: ":hidden:not(select,input)",
				submitHandler: function (form) {
					if (layerIndex == "test") {
						layerTest = layer.load(1)
						$(midformId).ajaxSubmit({
							url : url + "testLink",
							type : 'post',
							success : function(data){
								layer.close(layerTest)
								layer.msg(data)
							},
							error : function(XmlHttpRequest, textStatus, errorThrown){
								layer.close(layerTest)
								layer.msg("连接失败，请检查你的数据库连接配置");
							}
						});
					} else if (layerIndex == "next") {
						layerLink = layer.load(1)
						$(midformId).ajaxSubmit({
							url : url + "importDb",
							type : 'post',
							success : function(data){
								layer.close(layerLink)
								console.log("list")
								midSubmit(data);
							},
							error : function(XmlHttpRequest, textStatus, errorThrown){
								layer.close(layerLink)
								layer.msg("连接失败，请检查你的数据库连接配置");
							},
							resetForm : true
						});
					} else if (layerIndex == "list") {
						layerText = layer.load(1)
						$(listformId).ajaxSubmit({
							url : url + "saveAll",
							type : 'post',
							success : function(data){
								layer.close(layerText)
								listSubmit(data);
							},
							error : function(XmlHttpRequest, textStatus, errorThrown){
								layer.close(layerText)
								layer.msg("保存失败");
							},
							resetForm : true
						});
					}
					return false;
				},
			});
		}
		
		// checkbox初始化
		function checkInit () {
			$('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
            $('.i-checks').on('ifChanged', function(event){ 
           		// 遍历dom节点将数据放入上面的隐藏域中
           		var nameEns = [];
           		var nameCns = [];
           		var nameCn;
           		// 回调函数执行顺序存在问题，先执行的回调函数方法，再改变样式
           		setTimeout(function () {
           			$("div.checked").each(function (index, item) {
           				nameEns.push($(this).children("input").val());
           				nameCn = $(this).children("input").attr("nameCn");
           				if (nameCn == "") {
           					nameCns.push("null");
           				} else {
               				nameCns.push(nameCn);
           				};
               		});
               		$(listformId).find("input[name=nameEn]").val(nameEns);
               		$(listformId).find("input[name=nameCn]").val(nameCns);
           		}, 0)
           	});
		};
		function resetPage () {
       		// 将所有的input框的选中状态都清空
       		$('.i-checks').iCheck('uncheck');
		}
		
		/* String ip = "183.245.210.26";
        String port = "1601";
        String dbname = "orcl";
        String username = "SYSMAN";
        String password = "123456";
        String databasetype = "oracle"; */
        
        /*Integer type = 1;
        String host = "183.245.210.26";
        String port = "3310";
        String user = "root";
        String password = "root";
        String dbName = "qxdata";*/
        
        /* 
        "183.245.210.26";
       	端口50666；
       	数据库：sample
		账户：db2inst1
      		db2fenc1
      		db2dasusr1
		密码 123456
        */
	</script>
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

