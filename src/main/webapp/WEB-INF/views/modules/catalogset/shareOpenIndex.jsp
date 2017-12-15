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
		.wrapper-main{
			margin: 10px 20px;
			padding: 10px;
			min-height: 200px;
			background-color: #fff;
		}
		.share-open-list{
			padding: 0;
			list-style: none;
			font-size: 0;
		}
		.share-open-item{
			display: inline-block;
			height: 80px;
			background-color: #edf3fb;
			position: relative;
			margin: 0 10px;
			border: 1px solid #e1e1e1;
			border-radius: 4px;
			font-size: 0;
			overflow: hidden;
			cursor: pointer;
		}
		.share-open-item:hover{
			background-color: #dce2ea;
		}
		.share-open-item>.fa{
			display: inline-block;
			font-size: 30px;
			color: #999;
			line-height: 78px;
			padding: 0 27px;
			background-color: #fff;
		}
		.share-item-right{
			display: inline-block;
			min-width: 170px;
			height: 100%;
			vertical-align: top;
			padding: 6px 10px;
			font-size: 16px;
			color: #aaa;
		}
		.share-item-right>p{
			line-height: 33px;
			margin: 0;
		}
		.item-right-count{
			font-size: 28px;
			color: #666;
		}
		.linkagesel-select-div {
			display: flex;
			justify-content: space-between;
			flex-wrap: wrap;
		}
		.chosen-container {
			margin-bottom: 10px;
		}
	</style>
</head>
<body class="white-bg body-style">
	<div class="wrapper-main animated fadeInRight">
		<ul id="shareOpenList" class="share-open-list">
			<li class="share-open-item" data-btn-id="2">
				<i class="fa fa-tree" aria-hidden="true"></i>
				<div class="share-item-right">
					<p class="item-right-count js-share-count">-</p>
					<p class="item-right-text">有条件共享</p>
				</div>
			</li>
			<li class="share-open-item" data-btn-id="1">
				<i class="fa fa-tree" aria-hidden="true"></i>
				<div class="share-item-right">
					<p class="item-right-count js-open-count">-</p>
					<p class="item-right-text">向社会开放</p>
				</div>
			</li>
		</ul>
	</div>
	<div id="layer_form_main" style="display: none;" class="ibox-content">
		<table id="shareTable">
			<thead>
			<tr>
				<th data-field="nameEn">信息资源代码</th>
				<th data-field="nameCn">信息资源名称</th>
				<!-- <th data-field="auditName">状态</th> -->
				<th data-field="Score" data-formatter="shareTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>
	<div id="layer_form" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/inforAutoForm.jsp"%>
			
			<input type="text" name="elementIds" id="elementIds" class="hide">
		</form>
		<table id="shareTable2">
			<thead>
			<tr>
				<th data-field="idCode">内部标识符</th>
				<th data-field="nameCn">信息项名称</th>
				<th data-field="dataTypeName">数据类型</th>
				<th data-field="len">数据长度</th>
				<th data-field="companyName">来源部门</th>
				<th data-field="Score" data-formatter="elementTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>

	<div id="element_layer_form" style="display:none" class="ibox-content">
		<form id="elementform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>

</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>

<script>
    var tableId = '#shareTable';
    var layerId = '#layer_form_main';
    var formId = '#eform'; //form ids
    var toolbar = '#toolbar';
    var url = '${ctx}/catalogset/shareOpen/';
    var obj = {
        shareType : '',
		openType : '',
		isAuthorize:0
    };
    var editTitle = "共享开放修改";
    var detailTitle = "共享开放详情";

    var layerId2 = '#layer_form';
    var tableId2 = '#shareTable2';

    var layerId3 = '#element_layer_form';
    var formId3 = '#elementform';

    $(function () {
        $.ajax({
			url:'${ctx}/catalogset/shareOpen/list',
			type:'get',
			success: function (data) {
				$(".js-share-count").text(data.shareCount);
                $(".js-open-count").text(data.openCount);
			}
		});
		$(".share-open-item").click(function () {
            var thisBtnId = parseInt($(this).attr('data-btn-id'));
//            var thisBtnId = $(this).attr('data-btn-id');
            console.log(thisBtnId);
            if(thisBtnId===2){
                obj.shareType = thisBtnId;
                obj.nameCn = "";
                delete obj['openType'];
			}else{
                obj.openType = thisBtnId;
                obj.nameCn = "";
                delete obj['shareType'];
			}
            $(tableId).bootstrapTable('refresh', {url: '${ctx}/catalog/information/list'});
            openShareLayer();
        });
    });


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

    // 打开第一层弹出框
    function openShareLayer() {
        layeForm = layer.open({
            title: false,
            type : 1,
            area : [ '100%', '100%' ],
            scrollbar : false,
            closeBtn: 0,
            zIndex : 100,
            btn : [ '返回' ],
            yes : function(index, layero) {
                layer.close(index);
            },
            content : $(layerId)
        });
    }
    // 第一层表格按钮创建
    function shareTableButton(index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="openShareLayer2(\''
            + row.id
            + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '</div>';
        return html;
    }

    // 第二层弹框内容相关方法
	// 第二层弹出框
    function openShareLayer2(id) {
         var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
        // 实例化表格
        mTable = new TableInit2($(tableId2));
        mTable.Init();
        loadData(row);
        shareToggle();
        // input
        $(formId).find("input").prop("disabled", true);
        // 判断select
        $(formId).find("select").prop("disabled", true);
        $(formId).find("select").trigger("chosen:updated");
        // checkbox
        $(formId).find('.i-checks').iCheck('disable');
        $(formId).find('.i-checks').parents('.form-group').removeClass('has-success');
        // 弹出框设置
        layeForm = layer.open({
            title: row.nameCn,
            type : 1,
            area : [ '90%', '90%' ],
            scrollbar : false,
            closeBtn: 1,
            zIndex : 100,
            content : $(layerId2)
        });
        // 判断select
        $(formId).find("select").prop("disabled", true);
        $(formId).find("select").trigger("chosen:updated");
        setTimeout(function(){
            $(formId).find(".linkagesel-select-div").find(".LinkageSel").prop("disabled", true);
            $(formId).find(".linkagesel-select-div").find(".LinkageSel").trigger("chosen:updated");
            $(formId).find(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
            // i-ckeck将自动验证去掉
            $(formId).find('.i-checks').closest(".form-group").removeClass("has-success");
        },500);
        // checkbox
        $(formId).find('.i-checks').iCheck('disable');

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

    // 第三层弹出框相关方法
    //第三个弹出框（弹出框设置）
    function mOpenDetail(l,f,row) {
        layeForm = layer.open({
            title: row.nameCn,
            type : 1,
            area : [ '80%', '95%' ],
            scrollbar : false,
            zIndex : 100,
            content : l,
            cancel : function () {
                // 当弹框被关闭的时候将所有加上的属性移除掉
//                f.find("input").each(function () {
//                    $(this).removeAttr("disabled");
//                });
//                f.find(".select-chosen").prop("disabled", false);
//                f.find(".select-chosen").trigger("chosen:updated");
//                f.find('.i-checks').iCheck('enable');
            }
        });
    }
    // 第三个弹框
    function elementDatailRow(id) {
        var row = $(tableId2).bootstrapTable('getRowByUniqueId', id);
        mOpenDetail($(layerId3),$(formId3),row);
        loadData(row);
        // 然后将所有表单中的选项做一个禁选中操作
        $(formId3).find("input").each(function () {
            $(this).attr("disabled","disabled");
        });
        // 判断select
        $(formId3).find("select").prop("disabled", true);
        $(formId3).find("select").trigger("chosen:updated");
        // checkbox
        $(formId3).find('.i-checks').iCheck('disable');
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

    function shareToggle() {
        // 共享方式
        var gxlxSelect = $("select[name=gongxiangtiaojian]");
        var gxtjSelect = $("select[name=gongxiangtiaojian]");
        var gxfsSelect = $("select[name=gongxiangfangshi]");
        var isOpenSelect = $("select[name=shifouxiangshehuikaifang]");
        var kflxSelect = $("select[name=kaifangleixing]");
        gxtjSelect.closest('.form-group').hide();
        gxtjSelect.removeAttr("required");
        gxfsSelect.closest('.form-group').hide();
        gxfsSelect.removeAttr("required");
        if (gxlxSelect.val() == 1) {
            gxfsSelect.closest('.form-group').hide();
            gxfsSelect.closest('.form-group').slideToggle();
            gxfsSelect.attr("required", "required");
            gxtjSelect.closest('.form-group').hide();
            gxtjSelect.val("");
            gxtjSelect.trigger("chosen:updated");
            gxtjSelect.removeAttr("required");
        } else if (gxlxSelect.val() == 2) {
            gxfsSelect.closest('.form-group').hide();
            gxtjSelect.closest('.form-group').hide();
            gxfsSelect.closest('.form-group').slideToggle();
            gxfsSelect.attr("required", "required");
            gxtjSelect.closest('.form-group').slideToggle();
            gxtjSelect.attr("required", "required");
        } else if (gxlxSelect.val() == 3) {
            gxfsSelect.closest('.form-group').hide();
            gxfsSelect.val("");
            gxfsSelect.trigger("chosen:updated");
            gxfsSelect.removeAttr("required");
            gxtjSelect.closest('.form-group').hide();
            gxtjSelect.val("");
            gxtjSelect.trigger("chosen:updated");
            gxtjSelect.removeAttr("required");
        }

        // 是否向社会开放
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        if (isOpenSelect.val() == 1) {
            kflxSelect.closest('.form-group').slideToggle();
            kflxSelect.attr("required", "required");
        } else if (isOpenSelect.val() == 0) {
            kflxSelect.closest('.form-group').hide();
            kflxSelect.val("");
            kflxSelect.trigger("chosen:updated");
            kflxSelect.removeAttr("required");
        }
    }

    $(function () {
        // 共享方式
        var gxtjSelect = $("select[name=gongxiangtiaojian]");
        var gxfsSelect = $("select[name=gongxiangfangshi]");
        gxtjSelect.closest('.form-group').hide();
        gxtjSelect.removeAttr("required");
        gxfsSelect.closest('.form-group').hide();
        gxfsSelect.removeAttr("required");
        $("select[name=gongxiangleixing]").chosen({
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
        $("select[name=kaifangleixing]").closest('.form-group').hide();
        $("select[name=kaifangleixing]").removeAttr("required");
        // 判断是否使用其他部门数据与是否提供数据给其他部门
        $("select[name=shifouxiangshehuikaifang]").chosen({
            width : "100%"
        }).change(function () {
            if ($(this).val() == 1) {
                $("select[name=kaifangleixing]").closest('.form-group').slideToggle();
                $("select[name=kaifangleixing]").attr("required", "required");
            } else if ($(this).val() == 0) {
                $("select[name=kaifangleixing]").closest('.form-group').hide();
                $("select[name=kaifangleixing]").val("");
                $("select[name=kaifangleixing]").trigger("chosen:updated");
                $("select[name=kaifangleixing]").removeAttr("required");
            }
        });
    });
</script>
<script src="${ctxStatic}/js/common/common.js"></script>
