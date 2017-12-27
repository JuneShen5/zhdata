<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>表格</title>
        <%@ include file="/WEB-INF/views/include/head.jsp"%>
        <link href="${ctxStatic}/css/style-add.css" rel="stylesheet" />
    </head>

    <body class="white-bg">
    <c:set var="type" value="4" />
        <div class="wrapper wrapper-content animated fadeInRight">
            <div class="ibox float-e-margins">
                <!-- <div class="ibox-title">信息系统普查</div> -->
                <div class="ibox-content">
                    <div id="toolbar">
                        <div class="form-inline">
                            <div class="form-group">
                                <input id="sName" sName="xtmc" type="text" placeholder="输入信息系统名称"
                                       class="form-control col-sm-8">
                                <div class="input-group-btn col-sm-4">
                                    <button type="button" id="searchFor"
                                            onclick="$('#yjSystemTable').bootstrapTable('refresh');"
                                            class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="text-center">
                                    <a data-toggle="modal" class="btn btn-green"
                                       onclick="openAdd();"><i class="fa fa-plus-square-o"></i> 新增</a>
                                    <button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
                                    <button class="btn btn-purple" type="button" onclick="importData(4);"><i class='fa fa-sign-in'></i> Excel导入</button>
                                    <button class="btn btn-yellow" type="button" onclick="deleteBatch();"><i class='fa fa-trash-o'></i> 批量删除</button>
                                </div>
                            </div>
                        </div>
                        <!--<div class="search-list" style="display: none;">
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
                        </div>-->
                    </div>
                    <table id="yjSystemTable">
                        <thead>
                            <tr>
                                <th data-checkbox="true"></th>
                                <th data-field="id">序号</th>
                                <th data-field="xtmc">信息系统名称</th>
                                <th data-field="ywgn">业务功能</th>
                                <th data-field="companyName">单位名称</th>
                                <th data-field="spsj">审批时间</th>
                                <th data-field="Score" data-formatter="mainTableBtn">操作</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <div id="layer_form" style="display: none" class="ibox-content" >
            <form role="form" id="mainForm" class="form-horizontal main-form">
                <input type="text" name="id" class="hide">
                <!-- 基本信息 -->
                <%@include file="/WEB-INF/views/modules/assets/systemTable/nj_baseInfo.jsp"%>
                <!-- 系统建设必要性 -->
                <%@include file="/WEB-INF/views/modules/assets/systemTable/nj_necessaryInfo.jsp"%>
                <!-- 备注与说明 -->
                <%@include file="/WEB-INF/views/modules/assets/systemTable/comm-remarks.jsp"%>
            </form>
        </div>
        
 		<!-- excel导入导出-->
       <%--  <c:set var="type" value="4" /> --%>
		<%@ include file="/WEB-INF/views/include/exp_importData.jsp"%>
        <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script src="${ctxStatic}/js/common/common-h.js"></script>
    <script>
    
		/*导入导出定义的全部变量 */
		var uploaderServer = "njSystem";

        // 1.设置Table参数和表格按钮
        var mainTableOption = {
            tableId: 'yjSystemTable',
            url: '${ctx}/assets/njSystem/list',
            toolbar: 'toolbar',
            pageNumber: 1,
            pageSize: 10,
            obj: {}
        };
        var mainTableBtnOption = {
            btnNeed: 'default'
        };
        // 2.初始化Table
        // 最外层table
        var mainTable = new TableInit(mainTableOption,mainTableBtnOption);
        mainTable.Init();
        var mainTableBtn = function (value, row, element) {
            return mainTable.InitButton(row);
        };

        // 3.初始化弹框
        var options = {
            title: '新增',
            containerSize: ['100%','100%'],
            button: 'default',
            dataTable: '#yjSystemTable',
            dataTableId: '',
            submitUrl: '${ctx}/assets/njSystem/save'
        };
        // 新增
        function openAdd() {
            options.title = '新增';
            options['button'] = 'default';
            options.dataTableId = '';
            $('#layer_form').layerSetting('openAdd', options);
        }

        function datailRow(id) {
            options.title = '详情';
            options['button'] = [];
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $('#layer_form').layerSetting('openDetail', options);
        }
        function editRow(id) {
            options.title = '修改';
            options['button'] = 'default';
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $('#layer_form').layerSetting('openEdit', options);
        }
        var deleteOptions = {
            onlyConfirm: true,
            submitUrl: '${ctx}/assets/njSystem/delete',
            dataTable: '#yjSystemTable'
        };
        function deleteRow(id) {
            deleteOptions.dataTableId = id;
            $('#layer_form').layerSetting('deleteRow', deleteOptions);
        }

        //批量删除
        function deleteBatch() {
            var delData = $(deleteOptions.dataTable).bootstrapTable('getSelections');
            if (delData.length == 0) {
                layer.msg("请至少选择一项数据");
                return;
            }
            var ids = new Array();
            $.each(delData, function (index, item) {
                ids.push(item.id);
            })
            ids = JSON.stringify(ids);
            deleteOptions.dataTableId = ids.slice(1, ids.length - 1);
            $('#layer_form').layerSetting('deleteRow', deleteOptions);
        }
    </script>

    </body>
</html>
