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
			<!-- <div class="ibox-title">信息系统普查</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入信息系统名称"
								class="form-control col-sm-8">
                            <c:forEach var="att" items="${fns:getAttList(1)}">
                                     <c:if test="${att.searchType=='2'}">
                                            <input id="${att.id}" sName="${att.nameEn}" type="text" placeholder="输入${att.nameCn}"
                                                class="form-control col-sm-8" style="margin-left: 15px;">
                                     </c:if>
                            </c:forEach>
							<div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                	onclick="$('#systemTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
									<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('系统清单新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
								<button class="btn btn-yellow" type="button" onclick="deleteAll();"><i class='fa fa-trash-o'></i> 批量删除</button>
								<button class="btn btn-blue other-url" type="button" id="272" url="${ctx}/settings/attribute?type=1" name="信息系统配置"><i class='fa fa-cog'></i> 配置</button>
							</div>
						</div>
					</div>
					<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">责任部门：</label>
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
				<table id="systemTable">
					<thead>
						<tr>
							<th data-checkbox="true"></th>
							<th data-field="id">序号</th>
							<th data-field="nameCn">信息系统名称</th>
							<c:forEach var="att" items="${fns:getAttList(1)}">
								 <c:if test="${att.isShow=='1'}"><th data-field="${att.nameEn}">${att.nameCn}</th></c:if>
							</c:forEach>
							<th data-field="companyName">责任部门</th>
							<th data-field="Score" data-formatter="initTableButton">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="layer_form" style="display: none" class="ibox-content" >
		<form id="eform" class="form-horizontal" enctype="multipart/form-data">
			<input type="text" name="id" class="hide">
			<c:set var="user" value="${fns:getCurrentUser()}" />
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="例：XX管理系统">信息系统名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="例：XX管理系统" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="例：XX市XX局 / 单位人事管理 / 统计分析">责任部门：</label>
				<c:choose>
					<c:when test="${user.roleId==1}">
							<div class="col-sm-7">
								<input id="" name="companyId" class="form-control citySelId hide" type="text">
						        <input id="" name="companyName" class="form-control citySel" type="text" ReadOnly required />
						        <%@include file="/WEB-INF/views/include/companyTree.jsp"%>
							</div>
					</c:when>
					<c:otherwise>
						<div class="col-sm-7">
							<input type="text" name="companyName" class="form-control" value="${fns:queryCompanyName()}" required>
							<input type="text" name="companyId" class="form-control hide" value="${user.companyId}">
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			
			<c:set var="type" value="1" />
			<%@include file="/WEB-INF/views/include/autoForm.jsp"%>
		</form>
	</div>
	
	<!-- 导出数据开始 -->
	<div id="exportData" style="display: none;"  class="ibox-content">
		<form method="post" action="system/exportData" class="form-horizontal" id="exportForm">
			<div class="alert alert-info">如导出数据量大，下载请耐心等待！</div>
			<div class="col-md-3">
				<input type="checkbox" nameCn="信息系统名称" nameEn="nameCn" inputType="input" inputValue="" checked/> <!-- inputType="companyselect" -->
				信息系统名称
			</div>
			
			<c:choose>
				<c:when test="${user.roleId==1}">
					<div class="col-md-3">
						<input type="checkbox" nameCn="责任部门" nameEn="companyId" inputType="companyselect" inputValue="company" checked/>
						责任部门
					</div>
				</c:when>
				
				<c:otherwise>
					<div class="col-md-3">
						<input type="checkbox" nameCn="责任部门" nameEn="companyName" inputType="input" inputValue="" checked/>
						责任部门
					</div>
				</c:otherwise>
					
			</c:choose>
			
			<c:forEach var="att" items="${fns:getAttList(type)}">
				<div class="col-md-3">
					<input type="checkbox" nameEn="${att.nameEn}" nameCn="${att.nameCn}" inputType="${att.inputType}"  inputValue="${att.inputValue}" checked/>
					${att.nameCn}
				</div>
			</c:forEach>
			<input type="hidden" name="obj" value="">
		</form>
	</div>
	<!-- 导出数据结束 -->
	
	<!-- excel导入开始 -->
	<%@ include file="/WEB-INF/views/include/importData.jsp"%>
	<!-- excel导入结束 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>

		var tableId = '#systemTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/assets/system/';
		var obj = {
			name : $('#sName').val(),
		};
		var editTitle = "系统清单修改";
		var detailTitle = "系统清单详情";
		var exportBox = '#exportData';
		var exportForm = '#exportForm';
		var importBox = '#importData';
		var importForm = '#importForm';
		var rowInput = "#exportData input[name='obj']";
		var uploaderServer = "system";
        /*var pageParams = {
            tableId: '#systemTable',
            layerId: '#layer_form',
            formId: '#eform',
            toolbar: '#toolbar',
            url: '${ctx}/assets/system/',
            editTitle: '用户修改',
            detailTitle: '项目详情'
        };*/
        // 配置按钮打开配置页
        $(function () {
//             $("#side-menu .J_menuItem[id="+pageId+"]", window.parent.document).trigger("click");
//             console.log($("#side-menu .J_menuItem[id="+pageId+"]", window.parent.document).attr("id"));
            $('.other-url').click(function() {
                var url = $(this).attr('url')
                var id = $(this).attr('id')
                var name = $(this).attr('name')
                var isClose = $(this).attr('isClose') || false
                var noJump =  $(this).attr('noJump') || false
                if (noJump) return
                parent.newTab(
                    {url: url, id: id, name: name, isClose: isClose}
                )
            })
        });
	</script>

	<%--<script src="${ctxStatic}/js/common/common-copy.js"></script>--%>
	<%--<script src="${ctxStatic}/js/common/special.js"></script>--%>
	<%--<script src="${ctxStatic}/js/common/uploader.js"></script>--%>

	<script src="${ctxStatic}/js/common/common.js"></script>
	<script>

	$(tableId).on("post-body.bs.table", function () {
		var columnField;
		var newColumnField;
		var moban = [{type: "1", ch: "类型1号"}, {type: "2", ch: "类型2号"}, {type: "3", ch: "类型3号"}, {type: "4", ch: "类型4号"}]
		$("#systemTable tbody tr").each(function (index, item) {
			columnField = $(this).children("td:nth-child(4)").html();
			switch(columnField)
			{
				case "1":
					newColumnField = "windows"
				break;
				case "2":
					newColumnField = "unix"
				break;
				case "3":
					newColumnField = "linux"
				break;
				case "4":
					newColumnField = "其他"
				break;
				/* case "5":
					newColumnField = "代建代维"
				break; */
				default:break;
			};
			$(this).children("td:nth-child(4)").html(newColumnField);

			/* var asd = $(tableId).bootstrapTable('getData', true);
			console.log("asd: ", asd) */
		})
	})

	// 提供数据选项隐藏
	var sysjms = $("input[name=shiyongshujumiaoshu]");
	var tgsjms = $("input[name=tigongshujumiaoshu]");
	var sjzdsc = $("input[name=shujuzidianshangchuan]");
	sysjms.closest('.form-group').hide();
	sysjms.removeAttr("required");
	tgsjms.closest('.form-group').hide();
	tgsjms.removeAttr("required");
	sjzdsc.closest('.form-group').hide();
	sjzdsc.closest('.form-group').find("input").removeAttr("required");
	// 判断是否使用其他部门数据与是否提供数据给其他部门
	$("select[name=shifouzaiyongqitabumenshuju]").chosen({
		width : "100%"
	}).change(function () {
		if ($(this).val() == 1) {
			sysjms.closest('.form-group').slideToggle();
			sysjms.attr("required", "required");
		} else if ($(this).val() == 0) {
			sysjms.closest('.form-group').hide();
			sysjms.val("");
			sysjms.removeAttr("required");
		}
	});
	$("select[name=shifoutigongshujugeiqitabumen]").chosen({
		width : "100%"
	}).change(function () {
		if ($(this).val() == 1) {
			tgsjms.closest('.form-group').slideToggle();
			tgsjms.attr("required", "required");
		} else if ($(this).val() == 0) {
			tgsjms.closest('.form-group').hide();
			tgsjms.val("");
			tgsjms.removeAttr("required");
		}
	});
/* 	$("select[name=shifouyoushujuzidian]").chosen({
		width : "100%"
	}).change(function () {
		if ($(this).val() == 1) {
			sjzdsc.closest('.form-group').slideToggle();
			sjzdsc.closest('.form-group').find("input").attr("required", "required");
		} else if ($(this).val() == 0) {
			sjzdsc.closest('.form-group').hide();
			sjzdsc.closest('.form-group').find("input").val("");
			sjzdsc.closest('.form-group').find("input").removeAttr("required");
		}
	}); */

	$("input[name=jiansheyiju]").attr("placeholder", "填写信息系统建设依据，包括具体发布政策名字及相关建设方案、批复文件");
	$("input[name=yewushixiang]").attr("placeholder", "填写系统所服务具体业务，如在办公自动化、行政审批等");
	$("input[name=shenpibumen]").attr("placeholder", "填写信息系统建设的审批部门");

	// 建设经费来源的提示信息
	var textVal = "上级配套资金__________（具体经费来源渠道）\n省财政资金__________（具体经费来源渠道）\n市财政资金__________（具体经费来源渠道）\n单位自筹资金__________（具体经费来源渠道）\n其他资金__________   （具体经费来源渠道）";
	var jsjfly = $("textarea[name=jianshejingfeilaiyuan]");
	jsjfly.focus(function () {
		if (jsjfly.val() == textVal) {
			jsjfly.val("");
			jsjfly.css("color", "#000")
		}
	});
	jsjfly.blur(function () {
		if (jsjfly.val() == "") {
			jsjfly.val(textVal);
			jsjfly.css("color", "#aaa")
		}
	});
	
	
	/*根据自定义表单生成导出选框开始 暂时写不下去了*/
/* 	$(function(){
		$("#layer_form").find(".form-group").each(function(index,data){
			var inpurType = $(this).find("input:first-child").attr("type");
			var inpurName = $(this).find("input:first-child").attr("name");
			if(inpurName != undefined){
				console.log("inpurType:",inpurType);
				switch (inpurType){
				case "text":
					break;
				case "text":
					break;	
				}
				
			}
			
		})
	}) */
	/*根据自定义表单生成导出选框结束*/
	</script>
</body>
</html>

