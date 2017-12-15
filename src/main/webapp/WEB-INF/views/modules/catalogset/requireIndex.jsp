<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="stylesheet"
		href="${ctxStatic}/css/plugins/bootstrap-table/bootstrap-table.min.css">
	<link href="${ctxStatic}/css/style-add.css" rel="stylesheet" />
</head>
<body class="white-bg body-style">
	<div class="wrapper-main animated fadeInRight">
		<div id="toolbar">
			<div class="form-inline">
				<div class="form-group">
					<input id="sName" sName="name" type="text" placeholder="输入所需资源名称"
						   class="form-control col-sm-8">
					<c:forEach var="att" items="${fns:getAttList(2)}">
						<c:if test="${att.searchType=='2'}">
							<input id="${att.id}" sName="${att.nameEn}" type="text" placeholder="输入${att.nameCn}"
								   class="form-control col-sm-8" style="margin-left: 15px;">
						</c:if>
					</c:forEach>
					<div class="input-group-btn col-sm-4">
						<button type="button" id="searchFor"
								onclick="$(tableId).bootstrapTable('refresh');"
								class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
					</div>
				</div>
				<div class="form-group js-add-btn" style="display: none;">
					<div class="text-center">
						<a data-toggle="modal" class="btn btn-green"
						   onclick="openShareLayerEdit2('');"><i class="fa fa-plus-square-o"></i> 新增</a>
					</div>
				</div>
			</div>
		</div>
		<table id="demandTable">
			<thead>
			<tr>
				<th data-field="code">序号</th>
				<th data-field="name">所需资源名称</th>
				<th data-field="dataName">具体数据项名称</th>
				<th data-field="companyName">资源所在部门</th>
				<th data-field="Score" data-formatter="shareTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>
	<div id="layer_form_demand" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">序号：</label>
				<div class="col-sm-7">
					<input type="text" name="code" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所需资源名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">具体数据项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="dataName" class="form-control" required>
				</div>
			</div>
			<%-- <div class="form-group">
				<label class="col-sm-3 control-label">资源所在部门：</label>
				<div class="col-sm-7">
					<select name="companyId" class="select-chosen" required>
						 <option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach> 
					</select>
				</div>
			</div> --%>
			
			
			<div class="form-group">
			<label class="col-sm-3 control-label">资源所在部门：</label>
			
				
					<div class="col-sm-7">
						<input id="" name="companyId" class="form-control citySelId hide" type="text">
						<input id="" name="companyName" class="form-control citySel" type="text" ReadOnly required />
						<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
						
					</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">信息资源格式：</label>
				<div class="col-sm-7">
					<select name="type" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('resource_format')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">主要用途：</label>
				<div class="col-sm-7">
					<input type="text" name="purpose" class="form-control" required>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">更新周期：</label>
				<div class="col-sm-7">
					<select name="period" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('update_cycle')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">备注：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" class="form-control" required>
				</div>
			</div>
		</form>
		
	</div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>

<style>
	.wrapper-main{
		margin: 10px 20px;
		padding: 10px;
		min-height: 200px;
		background-color: #fff;
	}
	.dataopen-content{
		margin-top: 15px;
		list-style: none;
	}
	.dataopen-content>label{
		font-size: 14px;
    	font-weight: normal;
	}
	.dataopen-content>label>em{
		font-weight: bold;
		font-style: normal;
		color: #FF4500;
	}
	.dataopen-content>li{
		display: block;
		border: solid 2px #ddd;
		margin: 10px 0;
	}
	.dataopen-result-container{
		padding: 10px 15px;
		cursor: default;
	}
	.dataopen-result-title{
		font-size: 16px;
		color: #444;
	}
	.dataopen-result-title>.label{
	    background-color: #337ab7;
		margin-left: 4px;
		padding: 4px 8px;
	}
	.dataopen-result-intro{
		margin-bottom: 0;
		font-size: 14px;
		color: #999;
	}
	.dataopen-result-btn>button{
		float: right;
		margin: 19px 0;
	}
	.data-open-form{
		width: 80%;
		height: 70%;
		margin: 100px auto 0;
	}
	.data-open-form>.jumbotron{
		cursor: default;
		height: 100%;
	}
</style>

<script>
	var pageType = ${fns:getParam('type')};

    var tableId = '#demandTable';
    var layerId = '#layer_form_demand';
    var formId = '#eform'; //form ids
    var toolbar = '#toolbar';
    var url = '${ctx}/catalogset/require/';
    var obj = {

    };
    var editTitle = "共享开放修改";
    var detailTitle = "共享开放详情";


    var layerId2 = '#layer_form_demand';
    var tableId2 = '#shareTable2';

    // 第一层表格按钮创建
    function shareTableButton(index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="openShareLayer2(\''
            + row.id
            + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        if (pageType){
            html += '<button type="button" class="btn btn-white" id="edit"  onclick="openShareLayerEdit2(\''
                + row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
            html += '<button type="button" class="btn btn-white" onclick="deleteRow(\''
                + row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
            $(".js-add-btn").show();
        }
        html += '</div>';
        return html;
    }

    // 第二层弹出框
    function openShareLayer2(id) {
        var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
        // 实例化表格
        mTable = new TableInit2($(tableId2));
        mTable.Init();
        loadData(row);
        // input
        $(layerId2).find("input").prop("disabled", true);
        // 判断select
        $(layerId2).find("select").prop("disabled", true);
        $(layerId2).find("select").trigger("chosen:updated");
        // checkbox
        $(layerId2).find('.i-checks').iCheck('disable');
        $(layerId2).find('.i-checks').parents('.form-group').removeClass('has-success');
        // 弹出框设置
        layeForm = layer.open({
            title: row.nameCn,
            type : 1,
            area : [ '90%', '90%' ],
            scrollbar : false,
            closeBtn: 1,
            zIndex : 100,
            cancel : function () {
				// 当弹框被关闭的时候将所有加上的属性移除掉
				$(formId).find("input").each(function () {
					$(this).removeAttr("disabled");
				});
				$(formId).find("textarea").each(function () {
					$(this).removeAttr("disabled");
				});
				try{
					if(zTree) {
						var allnodes = zTree.getNodes();
						for (var i in allnodes) {
							zTree.setChkDisabled(allnodes[i], false, true, true);
						};
					};
				} catch (e) {}
				$(formId).find("select").prop("disabled", false);
				$(formId).find("select").trigger("chosen:updated");
				$('.i-checks').iCheck('enable');
				endMethod(formId, "close");
			},
            content : $(layerId2)
        });
    }
    function openShareLayerEdit2(id) {
        var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
        // 实例化表格
        mTable = new TableInit2($(tableId2));
        mTable.Init();
        if (id){
            loadData(row);
		}

        // 弹出框设置
        layeForm = layer.open({
            title: row.nameCn,
            type : 1,
            area : [ '90%', '90%' ],
            scrollbar : false,
            closeBtn: 1,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
			yes : function(index, layero) {
                $(formId).submit();
            },
            end : function() {
                $(formId).resetForm();
                endMethod(formId, "close");
            },
            content : $(layerId2)
        });
        $(formId).validate().form();
    }
    // 第二层表格操作按钮构建
    function elementTableButton(index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="elementDatailRow(\''
            + row.id
            + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '</div>';
        return html;
    }

    // 第二层表格初始化配置
    var TableInit2 = function(e) {
        var oTableInit = new Object();
        // 初始化Table
        oTableInit.Init = function() {
            e.bootstrapTable({
                method : 'get',
                striped : true, // 是否显示行间隔色
                pagination : true, // 是否显示分页（*）
                queryParams : oTableInit.queryParams, // 传递参数（*）
                sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
                pageNumber : 1, // 初始化加载第一页，默认第一页
                pageSize : 10, // 每页的记录行数（*）
                pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
                showColumns : true, // 是否显示所有的列
                showRefresh : true, // 是否显示刷新按钮
                iconSize : 'outline',
                icons : {
                    refresh : 'glyphicon-repeat',
                    columns : 'glyphicon-list'
                },
                uniqueId : "id", // 每一行的唯一标识，一般为主键列
            });
        };

        // 得到查询的参数
        oTableInit.queryParams = function(params) {
            obj={};
            $("#searchForElement").parents(".form-inline").find("input").each(function (index, item) {
                if($(this).attr("eName")!=undefined)
                    obj[$(this).attr("eName")] = $(this).val();
                else
                    obj["dataType"]=$('#dataTypeSelect').val();
            });
            var temp = {
                pageNum : params.offset / params.limit + 1,
                pageSize : params.limit,
                obj : JSON.stringify(obj)
            };
            return temp;
        };
        return oTableInit;
    };


    // 向弹出列表添加数据
    function dataTo(value){
        dataEles=value;
        var ck=",";
        for(var j=0;j<dataEles.length;j++){
            ck+=dataEles[j].id+",";
        }
        checkedIds =ck;
        $("#selectElement").addClass("hide");
        $(tableId2).bootstrapTable('refreshOptions',{
            data:value,
            totalRows:value.length
        });
    }

</script>
<script src="${ctxStatic}/js/common/common.js"></script>