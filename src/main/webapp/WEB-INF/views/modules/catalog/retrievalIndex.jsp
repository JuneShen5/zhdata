<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="stylesheet"
		href="${ctxStatic}/css/plugins/bootstrap-table/bootstrap-table.min.css">
	<link href="${ctxStatic}/css/style-add.css" rel="stylesheet" />
	<style>
		.linkagesel-select-div {
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
		}
		.chosen-container {
			margin-bottom: 10px;
		}
		.department-select{
			list-style: none;
			padding: 5px;
			margin: 0;
			font-size: 0;
			text-align: center;
		}
		.department-select>li{
			display: inline-block;
			padding: 5px 10px;
			font-size: 16px;
			line-height: 1.5em;
			text-align: center;
			cursor: pointer;
		}
		.department-select>li:hover{
			background-color: #e4eaeb;
			color: #0d8ddb;
		}
		.department-select-container{
			max-width: 60%;
			border: solid 1px #ccc;
			background-color: white;
			position: absolute;
			top: 70px;
			left: 270px;
			opacity: .9;
			border-radius: 5px;
			-webkit-border-radius: 5px;
			-moz-border-radius: 5px;
		}
		.arrow{
			content: '';
			position: absolute;
			border: solid 11px transparent;
			width: 0;
			height: 0;
			border-top: none;
			border-bottom-color: #ccc;
			top: -13px;
			left: 50px;
		}
		.arrow:before{
			content: '';
			position: absolute;
			border: solid 10px transparent;
			width: 0;
			height: 0;
			border-top: none;
			border-bottom-color: white;
			top: 1px;
			left: -10px;
		}
		.department-select i {
			color: #f00;
			font-size: 12px;
			font-style: normal;
			position: relative;
			color: #fff;
			background: #f00;
			text-align: center;
			border-radius: 20px;
			padding: 1px 5px;
			margin-right: 5px;
			top: -8px;
			right: 4px;
		}
		.keyword-area{
			line-height: 1.5em;
			cursor: default;
		}
		.keyword-title{
			margin: 0;
			display: inline-block;
		}
		.keyword-area>span{
			display: inline-block;
			margin-right: 5px;
			color: #1a7bb9;
			cursor: pointer;
		}
		.keyword-area>span:hover{
			opacity: .8;
		}
	</style>
</head>
<body class="white-bg body-style">
	<div class="wrapper animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">信息资源普查</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<select type="text" tName="infoType1" class="form-control search-chosen col-sm-6" style="margin-right: 5px">
								<option value=''>全部</option>
							</select>
							<select type="text" tName="infoType2" class="form-control search-chosen col-sm-6 js-infoType-child" style="display: none" disabled>
								<option value=''>全部</option>
							</select>
							<input id="sName" sName="nameCn" type="text" placeholder="输入信息资源名称"
								   class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
										onclick="setSearchParam();$(tableId).bootstrapTable('refresh');"
										class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<!--<div class="form-group">
							<div class="text-center">
								<button id="infoTypeSearch" class="btn btn-green"><i class="fa fa-search"></i> 部门搜索</button>
								<button class="btn btn-purple" type="button" onclick="addRetrieval();"><i class='fa fa-plus-square-o'></i> 新增需求</button>
							</div>
						</div>-->
						<div class="keyword-area">
							<p class="keyword-title">热门关键词：</p>
						</div>
					</div>
				</div>
				<table id="retrievalTable">
					<thead class="ele-hide">
					<tr>
						<th data-field="nameEn">信息资源编号</th>
						<th data-field="nameCn">信息资源名称</th>
						<th data-field="companyName">信息资源提供方</th>
						 <th data-field="departName">审核部门</th>
						<th data-width="230px" data-field="name" data-formatter="initRetrievalTableButton">操作</th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<!-- 部门选择框 -->
	<div id="departmentSelect" class="department-select-container" style="display: none;">
		<div class="arrow"></div>
		<ul class="department-select">

		</ul>
	</div>

	<!-- 新增弹框 -->
	<div id="layer_form_add" style="display:none" class="ibox-content">
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
			<div class="form-group">
				<label class="col-sm-3 control-label">资源所在部门：</label>
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

	<!-- 一级弹框 -->
	<div id="layer_form" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/inforAutoForm.jsp"%>
			
			<input type="text" name="elementIds" id="elementIds" class="hide">
		</form>
		<table id="retrievalTable2">
			<thead>
				<tr>
                    <th data-field="nameCn">信息项名称</th>
                    <th data-field="name">数据元名称</th>
                    <th data-field="type">数据类型</th>
                    <th data-field="len">数据长度</th>
                    <%-- <th data-field="companyName">来源部门</th> --%>
                    <th data-field="Score" data-formatter="initRetrievalTableButton2">操作</th>
                </tr>
			</thead>
		</table>
	</div>
	<!-- 二级弹框 -->
	<div id="element_layer_form" style="display:none" class="ibox-content">
		<form id="elementform" class="form-horizontal">
			<fieldset id="eleForm">
                <%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
            </fieldset>
            <fieldset id="itemForm">
                <%@include file="/WEB-INF/views/include/itemAutoForm.jsp"%>
            </fieldset>
			
			
		</form>
	</div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>

<script>
    var tableId = '#retrievalTable';
    var layerId = '#layer_form';
    var formId = '#eform'; //form ids
    var toolbar = '#toolbar';
    var url = '${ctx}/catalog/information/';
    var obj = {
        isAudit : 2,
        isAuthorize:1
    };
    var editTitle = "共享开放修改";
    var detailTitle = "资源目录详情";

    var tableId2 = '#retrievalTable2';
    var layerId2 = '#element_layer_form';
    var formId2 = '#elementform';

    var addlayerId = '#layer_form_add';
    var addFormId = '#eform';
    var addUrl = '${ctx}/catalogset/require/save';

    // 搜索条件改变事件
	$(function () {
        // 获取热门关键词
        $.ajax({
            url:'${ctx}/panel/overview/list',
            dataType: 'json',
            type:'get',
            success: function (data) {
                $.each(data,function (index,keyWordItem) {
                    $("<span></span>").text(keyWordItem.keyword).appendTo($(".keyword-area"));
                });
            }
        });
        // 获取第一级搜索下拉框数据
        $.ajax({
            url:'${ctx}/catalogset/res/queryByPid',
            data:{
                id: '0'
            },
            dataType: 'json',
            type:'get',
            success: function (data) {
                $.each(data,function (index,pItem) {
					$("<option></option>").val(pItem.id).text(pItem.name+"资源分类").appendTo($("select[tName='infoType1']"));
                });
            }
        });
		// 一级下拉框改变后获取二级下拉框
		$("select[tName='infoType1']").change(function () {
			var thisValue = $(this).val();
			if (thisValue!=""){
			    $(".js-infoType-child").show().removeProp('disabled');
			    $("input[sName='nameCn']").val("").hide().prop('disabled');
                $.ajax({
                    url:'${ctx}/catalogset/res/queryByPid',
                    type:'get',
                    data: {id:thisValue},
                    success: function (data) {
                        $(".js-infoType-child").empty();
                        $("<option></option>").val("").text("全部").appendTo($(".js-infoType-child"));
						$.each(data,function (index,cItem) {
							$("<option></option>").val(cItem.id).text(cItem.name).appendTo($("select[tName='infoType2']"));
						});
                    }
                });
                delete obj[$(this).next("select").attr("tName")];
			}else{
                $(".js-infoType-child").empty().hide().prop('disabled');
                $("input[sName='nameCn']").val("").show().removeProp('disabled');
                $("<option></option>").val("").text("全部").appendTo($(".js-infoType-child"));
                delete obj[$(this).attr("tName")];
                delete obj[$(this).next("select").attr("tName")];
			}
        });
        $("select[tName='infoType2']").change(function () {
            if ($(this).val()==="") {
                delete obj[$(this).attr("tName")];
            }
		});
    });
	// 设置搜索参数（点击搜索按钮时设置参数为数字类型）
	function setSearchParam() {
		$("#toolbar").find("select").each(function (index) {
			if ($(this).val()!==""){
                obj[$(this).attr("tName")] = parseInt($(this).val());
			}
        });
    }

    // 热门关键词点击事件
	$(function () {
		$(document).on("click",".keyword-area>span",function () {
			var keywordText = $(this).text();
			if ($("select[tName='infoType1']").val()==""){
                $("#sName").val(keywordText);
			}
        });
    });

	// 部门搜索点击弹出弹框及项目点击事件
	$(function () {
        $.ajax({
            url:'${ctx}/catalogset/res/companyList',
            type:'get',
			data: {"isAudit":1},
            success: function (data) {
                $.each(data,function (index,item) {
                    if (item.count>0){
                        $(".department-select").append('<li sName="companyId" data-sName='+item.id+'>'+item.name+'<i>' + item.count + '</i></li>');
                    }
                });
            }
        });
        $("#infoTypeSearch").click(function () {
			$("#departmentSelect").toggle();
        });
        $("#departmentSelect").on("click",".department-select>li",function () {
            obj[$(this).attr("sName")] = parseInt($(this).attr("data-sName"));
            obj['isAuthorize'] = 0;
            $(tableId).bootstrapTable('refresh');
            obj['isAuthorize'] = 1;
            delete obj[$(this).attr("sName")];
            $("#departmentSelect").hide(500);
        });
    });

    // 新增需求方法
	function addRetrieval() {
        layeForm = layer.open({
            title: '新增需求',
            type : 1,
            area : [ '100%', '100%' ],
            scrollbar : false,
            closeBtn: 1,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
            yes : function(index, layero) {
                // submit();
                // $(addFormId).submit();
                $(addFormId).ajaxSubmit({
                    url : addUrl,
                    type : 'post',
                    success : function(data){
                        layer.close(index);
                        $(tableId).bootstrapTable('refresh');
                        layer.msg(data);
                        endMethod(addFormId);
                    },
                    error : function(XmlHttpRequest, textStatus, errorThrown){
                        layer.close(index);
                        $(tableId).bootstrapTable('refresh');
                        layer.msg("数据操作失败!");
                        endMethod(addFormId);
                    },
                    resetForm : true
                });
            },
            end : function() {
                endMethod(addFormId);
            },
            content : $(addlayerId)
        });
        $(addFormId).validate().form();
    }

    // 外层表格按钮创建
    function initRetrievalTableButton(index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="openRetrievalLayer(\''
            + row.id
            + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '<button type="button" class="btn btn-red" onclick="checkCancel(\''
            + row.id
            + '\')"><i class="fa fa-times-circle-o"></i>&nbsp;注销审核</button>';
        html += '</div>';
        return html;
    }
    // 打开第一层弹出框
    function openRetrievalLayer(id) {
        var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
        // 实例化表格
        mTable = new TableInit2($(tableId2));
        mTable.Init();
        datailRow(id);
    }
    // 注销审核
	function checkCancel(id) {
        var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
        layer.confirm('确定注销此条已审核资源（此操作将此条资源退回至未发布状态）？', {icon: 3, title:'提示'}, function(index){
            $.ajax({
                url: url + 'cancelAudit',
                type: 'post',
                data: {
                    id: row.id
                },
                dataType: 'json',
                success: function (res) {
                    layer.msg("注销审核成功!");
//                            layer.msg("发布成功!");
//                            parent.updateCount();
					$(tableId).bootstrapTable('refresh');
                },
                error: function () {
                    layer.msg('操作失败，请重试');
//                            layer.msg('发布不成功，请重试');
//                            layer.close(layerIndex);
//                            endMethod(formId, "close");
                }
            });
            layer.close(layer.index);
        });
    }

    /* 四级联动相关方法---begain*/
	$(function () {
        var relConfigInfo = {
            ajax: '${ctx}/catalogset/infoSort/queryList',
            select: '.linkagesel-select-info',
            loaderImg: ''
        };
        window.linkRelInfo = new LinkageSel(relConfigInfo);
        // 没有找到数据返回之后的回调函数，所以写了一个延时效果
        setTimeout(function () {
            $(".LinkageSel").hide();
            $(".LinkageSel").chosen({width: "100%"});
            $(".LinkageSel").trigger("chosen:updated");
        }, 500);
        changeInit();
    });

    function changeInit () {
        linkRelInfo.onChange(function () {
            $(".linkagesel-select-div select").each(function (index, item) {
                var hideHtml = "div:eq(" + index + ")";
                // 如果为零表示是select为空，隐藏掉，并且将select的name值去掉
                if ($(this).children('option').length == 0) {
                    $(".linkagesel-select-div").children(hideHtml).hide();
                    $(this).removeAttr("name");
                    $(this).removeAttr("required");
                } else {
                    $(".linkagesel-select-div").children(hideHtml).show();
                    $(this).attr("name", "infoType" + (index + 1));
                    $(this).attr("required", "required");
                }
            });
            // 由于执行存在顺序的原因，加上延时，模拟回调函数
            setTimeout(function () {
                $(".linkagesel-select-div").find("div.chosen-container").width("48%");
                $(".LinkageSel").hide();
                $(".LinkageSel").chosen({width: "48%"});
                $(".LinkageSel").trigger("chosen:updated");
            }, 0)
        })
    }
    // 动态的将数据赋值进去
    function loadLinkageSel (data) {
        linkRelInfo.changeValues(data, true);
    };
    /* 四级联动相关方法---end*/

    // 第一层内部表格初始化
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
    // 外层表格按钮创建
    function initRetrievalTableButton2(index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="openRetrievalLayer2(\''
            + row.id
            + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '</div>';
        return html;
    }

    // 打开第二层弹出框
    function openRetrievalLayer2(id) {
        var row = $(tableId2).bootstrapTable('getRowByUniqueId', id);
        layeForm = layer.open({
            title: row.nameCn + '详情',
            type : 1,
            area : [ '80%', '95%' ],
            scrollbar : false,
            closeBtn: 1,
            zIndex : 100,
            content : $(layerId2)
        });
        loadToData(row, 'elementform');
        disabledMenu(formId2);
        // input
//        $(layerId2).find("input").prop("disabled", true);
//        // 判断select
//        $(layerId2).find("select").prop("disabled", true);
//        $(layerId2).find("select").trigger("chosen:updated");
//        // checkbox
//        $(layerId2).find('.i-checks').iCheck('disable');
//        $(layerId2).find('.i-checks').parents('.form-group').removeClass('has-success');
    }

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
