<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style>
.wrapper-main {
	margin: 10px 20px;
	padding: 10px;
	min-height: 200px;
	background-color: #fff;
}
.search-list {
	padding: 5px 0;
	height: 50px;
    display: none;
}
.check-search {
	display: inline-block;
	margin-right: 20px;
}
.check-search-item {
	display: inline-block;
}
.linkagesel-select-list .chosen-container {
	margin-bottom: 10px;
}
.linkagesel-select-div {
	 display: flex;
	 justify-content: space-between;
	 flex-wrap: wrap;
 }
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="nameCn" type="text" placeholder="输入信息资源名称"
								class="form-control col-sm-8 nameCn">
							<div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                	onclick="tableSearch()"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								<!-- <button type="button" id=""
                                	onclick="searchMore()" 
									class="btn btn-primary btn-drop"><span class="caret"></span></button> -->
							</div>
						</div>
						<!-- <div class="form-group">
							<div class="text-center">
								<button id="examineButton" data-toggle="modal" class="btn btn-yellow"
									onclick="batchAudit()"><i class="fa fa-calendar-check-o"></i> 审核通过</button>
								<button id="examineButton2" data-toggle="modal" class="btn btn-red"
										onclick="batchAuditAll()"><i class="fa fa-calendar-check-o"></i> 一键审核</button>
							</div>
						</div> -->
						<div class="search-list">
							<!--<div class="check-search hide">
								<label class="">审核状态：</label>
								<div class="check-search-item" style="width:200px;">
									 <select type="text" sName="isAudit" class="form-control search-chosen select-chosen">
									<option value="">全部</option>
									<c:forEach var="dict" items="${fns:getDictList('audit_status')}">
										<option value="${dict.value}">${dict.label}</option>
									</c:forEach>
								</select>
								</div>
							</div>-->
							<!-- <div class="check-search">
								<label class="">信息资源代码：</label>
								<div class="check-search-item">
									<input type="text" sName="nameEn" class="form-control">
								</div>
							</div> -->
						</div>
					</div>
				</div>
				<table id="systemTable">
					<thead class="ele-hide">
						<tr>
							<th data-checkbox="true"></th>
							<th data-field="nameEn">信息资源代码</th>
							<th data-field="nameCn">信息资源名称</th>
							<th data-field="companyName">资源提供方</th>
							<th data-field="departName">审核部门</th>
							<th data-field="auditName">状态</th>
							<th data-width="90px" data-formatter="checkTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<div id="layer_form" style="display: none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/inforAutoForm.jsp"%>
			
			<input type="text" name="elementIds" id="elementIds" class="hide">
		</form>

		<div class="form-group hide" style="margin-left: 15px;" id="selectElement">
			<div class="text-center" style="float:left">
				<a data-toggle="modal" class="btn btn-primary"
				   onclick="openEleLayer('选择数据元');">选择数据元</a>
			</div>
		</div>
		<table id="elementTable">
			<thead>
			<tr>
				<th data-field="nameCn">信息项名称</th>
                <th data-field="name">数据元名称</th>
                <th data-field="type">数据类型</th>
                <th data-field="len">数据长度</th>
				<th data-field="Score" data-formatter="elementTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>

	<!-- 查看sql -->
	<div id="sql_layer_form" style="display: none" class="ibox-content">
		<pre class="sql_content"></pre>
	</div>

	<!-- 查看数据 -->
	<%-- <%@include file="/WEB-INF/views/modules/drs/dataIndex.jsp"%> --%>

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
	<div id="element_layer_form2" style="display: none" class="ibox-content form-horizontal">
		<div class="form-group">
			<label class="col-sm-2 control-label">已选择数据元：</label>
			<div class="col-sm-5">
				<div class="chosen-container chosen-container-multi">
					<ul class="chosen-choices c-list" style="min-width: 200px;">
					</ul>
				</div>
			</div>
		</div>
		<div id="elementInfoToolbar">
			<div class="form-inline">
				<label class="col-sm-2 control-label">数据类：</label>
				<div class="col-sm-5">
					<select name="dataType" id="dataTypeSelect" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('data_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
				<input id="eName" eName="nameCn" type="text" placeholder="输入名称"
					   class="form-control col-sm-5">
				<div class="input-group-btn col-sm-6">
					<button type="button" id="searchForElement"
							onclick=" $('#elementTable2').bootstrapTable('refresh');"
							class="btn btn-primary">搜索</button>
				</div>
			</div>
		</div>
		<table id="elementTable2">
			<thead>
			<tr>
				<th data-field="selectId" data-formatter="checkFormatter">添加</th>
				<th data-field="idCode">内部标识符</th>
				<th data-field="nameCn">中文名称</th>
				<th data-field="len">数据长度</th>
				<th data-field="companyName">来源部门</th>
				<th data-field="source">来源</th>
				<th data-field="Score" data-formatter="elementTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>

	<div id="notThrough_layer" style="display: none" class="ibox-content form-horizontal">
		<form id="notThrough_form" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<div class="col-sm-12">
					<textarea name="reason" class="form-control" style="min-height: 130px;width: 100%;"></textarea>
				</div>
			</div>
		</form>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#systemTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/catalog/information/';
		var obj = {
			isAuthorize: 1,
            isAudit: 1
		};

        var editTitle = "信息资源修改";
        var detailTitle = "待办事宜详情";
        var sqlTableId = "#sql_layer_form";
        var dataTableId = "#data_layer_form";

        var elementTableId = '#elementTable';
        var elementLayerId = '#element_layer_form';
        var elementFormId = '#elementform'; //form ids

        var elementTableId2 = '#elementTable2';

        var exportBox = '#exportData';
        var exportForm = '#exportForm';
        var importBox = '#importData';
        var importForm = '#importForm';
        var rowInput = "#exportData input[name='obj']";
        var uploaderServer = "information";

        var itemState = 0;

        var flag=false;
        var checkedIds = ",";
        var dataEles = new Array();//存放选中的数据元
        
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

        $(function () {
            // 表单里面的表格
            mTable = new TableInit2($(elementTableId));
            mTable.Init();

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

        // 动态的将数据赋值进去
        function loadLinkageSel (data) {
            linkRelInfo.changeValues(data, true);
        };

        // 弹框关闭之后将多级联动回复初始化
        function resetPage (data) {
            linkRelInfo.reset();
            // 将code的input隐藏
            $("input[name=code]").closest(".form-group").hide();
        }

        // 在查看详情时将提供方代码显示出来
        function datailRowBefore (id) {
            $("input[name=code]").closest(".form-group").show();
            datailRow(id);
            console.log('getData：');
            console.log($(elementTableId).bootstrapTable('getData'));
            var data1 = $(elementTableId).bootstrapTable('getData');
            //合并单元格
            mergeCells(data1, "dataTypeName", 1, $(elementTableId));
        }
        // 判断是否审核
        function dataIsAudit(type) {
            if (type == 0) {
                return "发布审核";
            } else if (type == 1) {
                return "已审核"
            }
        }
        // 单独审批
        function releaseAudit (id) {
        	$("input[name=code]").closest(".form-group").show();
			var row = $(tableId).bootstrapTable('getRowByUniqueId', id);
			layer.open({
				title: '审核',
				type : 1,
				area : [ '100%', '100%' ],
				scrollbar : false,
				zIndex : 100,
				btn : [ '审核通过', '审核不通过' ],
				btn1 : function(index, layero) {
					var ids = id;
		            $.ajax({
		                url: url + 'setAudit',
		                type: 'post',
		                data: {ids: ids},
		                dataType: 'json',
		                success: function (res) {
		                    layer.msg("通过审核!");
		    				updateCount();
		                    $(tableId).bootstrapTable('refresh');
		                },
		                error: function () {
		                	layer.msg('审核不通过，请重试')
		                }
		            })
		            layer.close(layer.index);
					endMethod(formId, "close");
				},
				btn2: function () {
                	notThrough(id);
					endMethod(formId, "close");
				},
				end : function() {
					endMethod(formId, "close");
				},
				content : $(layerId),
				cancel : function () {
					endMethod(formId, "close");
				}
			});
			// loadData(row);
			loadToData(row, 'eform')
			// 然后将所有表单中的选项做一个禁选中操作
			$(formId).find("input").each(function () {
				$(this).attr("disabled","disabled");
			});
			$(formId).find("textarea").each(function () {
				$(this).attr("disabled","disabled");
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
			$('.i-checks').iCheck('disable');
            var data1 = $(elementTableId).bootstrapTable('getData');
        	//合并单元格
        	mergeCells(data1, "dataTypeName", 1, $(elementTableId));
        }

        function notThrough (id) {
        	layer.open({
				title: '审核意见',
				type : 1,
				area : [ '40%', '60%' ],
				scrollbar : false,
				zIndex : 100,
				btn : [ '确定', '取消' ],
				yes : function(index, layero) {
					$('#notThrough_form').submit();
					endMethod('#notThrough_form', "close");
				},
				end : function() {
					endMethod('#notThrough_form', "close");
				},
				content : $('#notThrough_layer'),
				cancel : function () {
					endMethod('#notThrough_form', "close");
				}
			})
        }
        $(function () {
			$('#notThrough_form').validate({
				// ignore: ":hidden:not(select,input)",
		        submitHandler: function(form){
		        	$('#notThrough_form').ajaxSubmit({
		    			url : url + 'updateReason',
		    			type : 'post',
		    			success : function(data){
		    				layer.close(layer.index);
		    				$(tableId).bootstrapTable('refresh');
		    				layer.msg(data);
		    				endMethod('#notThrough_form');
		    			},
		    			error : function(XmlHttpRequest, textStatus, errorThrown){
		    				layer.close(layer.index);
		    				$(tableId).bootstrapTable('refresh');
		    				layer.msg("数据操作失败!");
		    				endMethod('#notThrough_form');
		    			},
		    			resetForm : true
		    		});
		    		return false;
		        }
		    });
		})

        //用于elementTable
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

        // 查看表单
        function elementDatailRow(id) {
            var row;
            if(flag==false){
                row = $(elementTableId).bootstrapTable('getRowByUniqueId', id);
            }else{
                row = $(elementTableId2).bootstrapTable('getRowByUniqueId', id);
            }
            mOpenDetail($(elementLayerId),$(elementFormId));
            // loadData(row);
            loadToData(row, 'elementform')
            // 然后将所有表单中的选项做一个禁选中操作
            $(elementFormId).find("input").each(function () {
                $(this).attr("disabled","disabled");
            });
            // 判断select
            $(elementFormId).find("select").prop("disabled", true);
            $(elementFormId).find("select").trigger("chosen:updated");
            // checkbox
            $(elementFormId).find('.i-checks').iCheck('disable');
        }

        // 查看详情弹框
        function mOpenDetail(l,f) {
            layeForm = layer.open({
                title: '信息项详情',
                type : 1,
                area : [ '100%', '100%' ],
                scrollbar : false,
                zIndex : 100,
                content : l,
                cancel : function () {
                    // 当弹框被关闭的时候将所有加上的属性移除掉
                    f.find("input").each(function () {
                        $(this).removeAttr("disabled");
                    });
                    f.find("select").prop("disabled", false);
                    f.find("select").trigger("chosen:updated");
                    f.find('.i-checks').iCheck('enable');
                }
            });
        }

        function elementTableButton(index, row, element) {
            var html = '';
            html += '<div class="btn-group">';
            html += '<button type="button" class="btn btn-white" onclick="elementDatailRow(\''
                + row.id
                + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
            return html;
        }

        function checkFormatter(index, row, element) {
            var html = '';
            if (checkedIds.indexOf("," + row.id + ",") > -1) {
                html += '<input type="checkbox" name="des" data-id="'+element+'" value="' + row.id + '" data-name="'
                    + row.nameCn
                    + '" onclick="selectDE(this);" checked="checked"/>';
            } else {
                html += '<input type="checkbox" name="des" data-id="'+element+'" value="' + row.id + '" data-name="'
                    + row.nameCn + '" onclick="selectDE(this);"/>';
            }
            return html;
        }
        function selectDE(t) {
            if ($(t).is(':checked')) {
                checkedIds += $(t).attr('value') + ",";
                var data = $(elementTableId2).bootstrapTable('getRowByUniqueId', $(t).val());
                dataEles.push(data);
            } else {
                checkedIds = checkedIds.replace("," + $(t).val() + ",", ",");
                unCheck($(t).val());
            }
            initText();
        }
        function unCheck(id){
            var arr=new Array();
            var ck=",";
            for(var j=0;j<dataEles.length;j++){
                if(dataEles[j].id!=id){
                    arr.push(dataEles[j]);
                    ck+=dataEles[j].id+",";
                }
            }
            $('#elementTable2 input[value="'+id+'"]').removeAttr("checked");
            checkedIds =ck;
            dataEles=arr;
            initText();
        }
        //加载选中框的内容
        function initText() {
            var ids = checkedIds.split(",");
            var checkedEles = new Array();
            if (ids.length) {
                for (var i = 0; i < ids.length; i++) {

                    if (ids[i] != "") {
                        for (var j = 0; j < dataEles.length; j++) {
                            if (ids[i] == dataEles[j].id) {
                                checkedEles.push(dataEles[j]);
                            }
                        }
                    }
                }
            }
            if (checkedEles.length) {
                var html = '';
                for (var k = 0; k < checkedEles.length; k++) {
                    html += '<li class="search-choice">'
                        +'<span onclick="detail(\'' + checkedEles[k].id+'\');">'
                        + checkedEles[k].nameCn + '</span><a class="search-choice-close" onclick="unCheck(\''
                        + checkedEles[k].id + '\');"></a></li>';
                }
                $('.c-list').html(html);
            } else {
                $('.c-list').html('');
            }

        }
        function dataTo(value){
            dataEles=value;
            var ck=",";
            for(var j=0;j<dataEles.length;j++){
                ck+=dataEles[j].id+",";
            }
            checkedIds =ck;
            $("#selectElement").addClass("hide");
            $(elementTableId).bootstrapTable('refreshOptions',{
                data:value,
                totalRows:value.length
            })
        }

        function removeClassAndData(){
            $("#selectElement").removeClass("hide");
            dataEles=[];
            checkedIds = ",";
            $(elementTableId).bootstrapTable('refreshOptions',{
                data:{},
                totalRows:0
            })
        }

        // 选择数据元
        function openEleLayer(title) {
            flag=true;
            mTable2 = new TableInit2($(elementTableId2));
            mTable2.Init();
            initText();
            //增加搜索按钮
            $(elementTableId2).bootstrapTable('refresh', {url: '${ctx}/catalog/element/'+ 'list?',toolbar : "#elementInfoToolbar"});
            layeForm2 = layer.open({
                title: title,
                type : 1,
                area : [ '100%', '100%' ],
                scrollbar : false,
                zIndex : 100,
                btn : [ '保存', '关闭' ],
                yes : function(index, layero) {
                    $(elementTableId).bootstrapTable('refreshOptions',{
                        data:dataEles,
                        totalRows:dataEles.length
                    });
                    flag=false;
                    obj={isAuthorize:1};
                    layer.close(layeForm2);
                },
                end : function() {
                    obj={isAuthorize:1};
                    flag=false;
                    layer.close(layeForm2);
                },
                content : $(element_layer_form2)
            });
        }

        function addElementList () {
            var checkData = [];
            $.each(dataEles, function(index, item) {
                checkData.push({
                    id : item.id
                });
            });
            $("#elementIds").val(JSON.stringify(checkData));
        };

        function dictInit(value){
            value=value.replace(/\"|{|}/g, "");
            value=value.replace(/: /g, ":");
            value=value.replace(/, /g, ",");
            $("#dictId").val(value);
        }
        function getCode(){
            $.ajax({
                url: "${ctx}/catalog/information/getCode",
                type: 'get',
                success: function (data) {
                    $("input[name='nameEn']").val(data);
                    $("input[name='nameEn']").blur();
                }
            });
        }

        // 信息资源格式的值写死成数据库
        $("input[name=xinxiziyuangeshi]").val("数据库");

        // 共享类型、是否向社会开放--暂时性开放（后续自己填写的时候需要开放）
        $("select[name=gongxiangleixing]").closest(".form-group").show();
        $("select[name=shifouxiangshehuikaifang]").closest(".form-group").show();

        function mergeCells(data,fieldName,colspan,target){
            //声明一个map计算相同属性值在data对象出现的次数和
            var sortMap = {};
            for(var i = 0 ; i < data.length ; i++){
                for(var prop in data[i]){
                    if(prop == fieldName){
                        var key = data[i][prop];
                        if(sortMap.hasOwnProperty(key)){
                            sortMap[key] = sortMap[key] * 1 + 1;
                        } else {
                            sortMap[key] = 1;
                        }
                        break;
                    }
                }
            }
            for(var prop in sortMap){
                console.log(prop,sortMap[prop])
            }
            var index = 0;
            for(var prop in sortMap){
                var count = sortMap[prop] * 1;
                $(target).bootstrapTable('mergeCells',{index:index, field:fieldName, colspan: colspan, rowspan: count});
                index += count;
            }
        }

		function checkTableButton(index, row, element) {
			var html = '';
			html += '<div class="btn-group">';
			html += '<button type="button" class="btn btn-white" onclick="datailRowBefore('
					+ row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
           /*  html += '<button type="button" class="btn btn-white" onclick="editRow('
                + row.id + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
			if (itemState == 0) {
				html += '<button type="button" class="btn btn-white" id="edit"  onclick="releaseAudit('
					+ row.id + ')"><i class="fa fa-calendar-check-o"></i>&nbsp;发布审核</button>';
			}
			html += '</div>'; */
			return html;
		}


        // 搜索按钮
        function tableSearch () {
            $(tableId).bootstrapTable('refresh');
        }
        // 搜素的下拉框
        function searchMore () {
            $(".search-list").slideToggle();
        }

        // 一键审核
		function batchAuditAll() {
            layer.confirm('确定要审核所有条目？', function(index){
                $.ajax({
                    url: "${ctx}/catalog/information/setAllAudit",
                    type: 'get',
                    success: function (data) {
                        layer.msg('审核成功！');
                        $(tableId).bootstrapTable('refresh');
                        updateCount();
                    }
                });
                layer.close(index);
                //向服务端发送删除指令
            });
        }
		// 批量审核
		function batchAudit () {
			if (itemState == 1) {
				return;
			}
			var data = $(tableId).bootstrapTable("getAllSelections");
			var postData = [];
			$.each(data, function (index, item) {
				postData.push(item.id)
			});
			if (postData.length <= 0) {
				layer.msg("请选择数据");
			}else{
                var ids = JSON.stringify(postData).substring(1, JSON.stringify(postData).length - 1);
                $.ajax({
                    url: url + 'setAudit',
                    type: 'post',
                    data: {ids: ids},
                    dataType: 'json',
                    success: function (res) {
                        layer.msg("通过审核!")
                        $(tableId).bootstrapTable('refresh');
                        updateCount();
                    }
                });
			}
		}

	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

