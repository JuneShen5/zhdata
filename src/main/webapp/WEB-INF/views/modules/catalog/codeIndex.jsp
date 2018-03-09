<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<link rel="stylesheet"
    href="${ctxStatic}/css/plugins/bootstrap-table/bootstrap-table.min.css">
</head>
<style>
    .search-option {
        margin-right: 28px;
    }
</style>
<body class="white-bg skin-7">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="ibox float-e-margins">
            <!-- <div class="ibox-title">字典管理</div> -->
            <div class="ibox-content">
                <div id="toolbar">
                    <div class="form-inline">
                        <div class="form-group">
                            <input id="" sName="pname" type="text" placeholder="输入代码集名称"
                                class="form-control col-sm-8 search-option">
                            <input id="" sName="pcode" type="text" placeholder="输入代码集编码"
                                class="form-control col-sm-8 search-option">
                            <input id="" sName="pid" type="text" class="hide search-option" value=0>
                            <div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                    onclick="dictSearch()"
                                    class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
                            </div>
                        </div>
                        <!-- <div class="form-group" style="margin-left: 15px;">
                            <div class="text-center">
                                <a data-toggle="modal" class="btn btn-green"
                                    onclick="openDictLayer();"><i class="fa fa-plus-square-o"></i> 新增</a>
                            </div>
                        </div> -->
                    </div>
                </div>
                <table id="dictTable">
                    <thead>
                        <tr>
                            <th data-formatter="id">序号</th>
                            <th data-formatter="pcode">代码级编码</th>
                            <th data-field="pname">代码级名称</th>
                            <th data-field="Score" data-formatter="initTableButton" class="col-sm-4">操作</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <!-- 新增 -->
    <div id="elayer" style="display: none;" class="ibox-content">
        <form id="eform" class="form-horizontal">
            <input type="text" name="pid" class="hide">
            <div class="form-group hide">
                <label class="col-sm-3 control-label">id：</label>
                <div class="col-sm-7">
                    <input type="text" name="id" class="hide">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码集名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="pname" class="form-control hasNoSpace" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">说明：</label>
                <div class="col-sm-7">
                    <input type="text" name="explains" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">表示：</label>
                <div class="col-sm-7">
                    <input type="text" name="express" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">编码规则：</label>
                <div class="col-sm-7">
                    <input type="text" name="regular" class="form-control">
                </div>
            </div>
        </form>
    </div>

    <!-- 父级字典项 -->
    <div id="sup_layer" style="display: none;" class="ibox-content">
        <form id="sup_form" class="form-horizontal">
            <input sName="pid" type="text" class="hide search-option" name="pid">
            <div class="form-group hide">
                <label class="col-sm-3 control-label">id：</label>
                <div class="col-sm-7">
                    <input type="text" id="id" name="id" class="hide hasNoSpace">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码集名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="pname" class="form-control hasNoSpace" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">说明：</label>
                <div class="col-sm-7">
                    <input type="text" name="explains" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">表示：</label>
                <div class="col-sm-7">
                    <input type="text" name="express" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">编码规则：</label>
                <div class="col-sm-7">
                    <input type="text" name="regular" class="form-control">
                </div>
            </div>
        </form>
        <div id="sup_toolbar">
            <div class="form-inline">
                <div class="form-group" style="margin-left: 15px;">
                    <div class="text-center">
                        <input sName="pid" type="text" class="hide search-option" name="pid">
                        <a data-toggle="modal" class="btn btn-green"
                            onclick="openSubDictLayer(this, 'sub_form', 'sub_layer');"><i class="fa fa-plus-square-o"></i> 新增</a>
                    </div>
                </div>
            </div>
        </div>
        <table id="supTable">
            <thead>
                <tr>
                    <th data-field="label">代码名称</th>
                    <!-- <th data-field="type">序号</th> -->
                    <th data-field="value">代码集值</th>
                    <th data-field="Score" data-formatter="initSupTableButton" class="col-sm-4">操作</th>
                </tr>
            </thead>
        </table>
    </div>

    <!-- 父级字典项的详情 -->
    <div id="sup_detail_layer" style="display: none;" class="ibox-content">
        <form id="sup_detail_form" class="form-horizontal">
            <input type="text" name="id" class="hide">
            <input type="text" name="pid" class="hide">
            <div class="form-group">
                <label class="col-sm-3 control-label">代码集名称：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="pname"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">序号：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="pageIndex"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">说明：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="explains"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">表示：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="express"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">编码规则：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="regular"></span>
                </div>
            </div>
        </form>
        <div id="sup_detail_toolbar">
            <div class="form-inline">
                <div class="form-group">
                    <input sName="pid" type="text" class="hide search-option">
                </div>
            </div>
        </div>
        <table id="supDetailTable">
            <thead>
                <tr>
                    <th data-formatter="subCodeSort">序号</th>
                    <th data-field="label">代码名称</th>
                    <th data-field="value">代码</th>
                    <th data-field="Score" data-formatter="initSupTableButton" class="col-sm-4">操作</th>
                </tr>
            </thead>
        </table>
    </div>

    <!-- 子级字典项 -->
    <div id="sub_layer" style="display: none;" class="ibox-content">
        <form id="sub_form" class="form-horizontal">
            <input type="text" id="id" name="id" class="hide">
            <div class="form-group">
                <label class="col-sm-3 control-label">代码名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="label" class="form-control hasNoSpace" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码：</label>
                <div class="col-sm-7">
                    <input type="text" name="value" class="form-control hasNoSpace" required>
                </div>
            </div>
            
            <div class="form-group hide">
                <label class="col-sm-3 control-label">父级ID：</label>
                <div class="col-sm-7">
                    <input type="text" name="pid" class="form-control">
                </div>
            </div>
        </form>
    </div>

    <!-- 新增父级 -->
    <div id="new_sup_layer" style="display: none;" class="ibox-content">
        <form id="new_sup_form" class="form-horizontal">
            <div class="form-group hide has-success">
                <label class="col-sm-3 control-label">id：</label>
                <div class="col-sm-7">
                    <input type="text" name="id" class="hide">
                <span id="id-error" class="help-block m-b-none"></span></div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码集名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="pname" class="form-control hasNoSpace" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">说明：</label>
                <div class="col-sm-7">
                    <input type="text" name="explains" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">表示：</label>
                <div class="col-sm-7">
                    <input type="text" name="express" class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">编码规则：</label>
                <div class="col-sm-7">
                    <input type="text" name="regular" class="form-control">
                </div>
            </div>
        </form>
        <div id="new_sup_detail_toolbar">
            <div class="form-inline">
                <div class="form-group">
                    <input sName="pid" type="text" class="hide search-option">
                </div>
                <div class="form-group" style="margin-left: 15px;">
                    <div class="text-center">
                        <a data-toggle="modal" class="btn btn-green"
                            onclick="newSubDictLayer(this);"><i class="fa fa-plus-square-o"></i> 新增</a>
                    </div>
                </div>
            </div>
        </div>
        <table id="newSupDetailTable">
            <thead>
                <tr>
                    <th data-field="label">代码名称</th>
                    <th data-field="value">代码</th>
                    <th data-field="Score" data-formatter="initNewSupTableButton" class="col-sm-4">操作</th>
                </tr>
            </thead>
        </table>
    </div>

    <!-- 新增子级 -->
    <div id="new_sub_layer" style="display: none;" class="ibox-content">
        <form id="new_sub_form" class="form-horizontal">
            <input type="hidden" name="index">
            <div class="form-group">
                <label class="col-sm-3 control-label">代码名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="label" class="form-control hasNoSpace" required>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码：</label>
                <div class="col-sm-7">
                    <input type="text" name="value" class="form-control hasNoSpace" required>
                </div>
            </div>
        </form>
    </div>

    <!-- 子级字典项详情 -->
    <div id="sub_detail_layer" style="display: none;" class="ibox-content">
        <form id="sub_detail_form" class="form-horizontal">
            <input type="text" id="id" name="id" class="hide">
            <div class="form-group">
                <label class="col-sm-3 control-label">代码名称：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="label"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">序号：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="pageIndex"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">代码：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="value"></span>
                </div>
            </div>
            
            <div class="form-group">
                <label class="col-sm-3 control-label">父级ID：</label>
                <div class="col-sm-7">
                    <span class="col-sm-12 dt-span" name="pid"></span>
                </div>
            </div>
        </form>
    </div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script>
        var excelName = "代码集模板,子项模板";
        var importForm='#importForm';
       // var importBox='#importBox';
        var sheetIndex = "0,1"; //开始读取的sheet
        var columnIndex = "0,0"; //开始读取的列
        var startRow = "2,2"; //开始读取的行
        var exportForm='#exportForm';
       // var exportBox='#exportBox';
        var url = '${ctx}/catalog/code/';
        var uploaderServer = "codeSet";
        var templatFile = "codeTemplate.xlsx";
        var attributeType = "${type}"; //获取attribute的type值
        var rowInput = "#exportData input[name='obj']";
        var tableId;
        var subList = new Array();
        var sortIndex = 0;
        var subSortIndex = 0;
        var newIndex = 0;
        var editIndex = 0;

        $(function () {
            oTable = new TableInit('dictTable', {url: url + 'list'});
            oTable.Init();
            supTable = new TableInit('supTable', {toolbar: '#sup_toolbar'});
            supTable.Init();
            supDetailTable = new TableInit('supDetailTable', {toolbar: '#sup_detail_toolbar'});
            supDetailTable.Init();
            newSupDetailTable = new loadTableInit('newSupDetailTable', {uniqueId: 'index'});
            newSupDetailTable.Init();
            // initFormValide('eform', 'save', 'dictTable');
            initFormValide('sup_form', 'zijiSave', 'dictTable');
            initFormValide('sub_form', 'zijiSave', 'supTable', {submitHandler: submitHandler});
            // 父级新增
            initFormValide('new_sup_form', '', 'dictTable', {submitHandler: submitNewSup});
            // 子级新增
            initFormValide('new_sub_form', '', 'newSupDetailTable', {submitHandler: submitNewSub});
        })

        // 新增
        function openDictLayer (formId, layerId) {
            var cancelEvent = function () {
                $('#new_sup_form').resetForm();
                endMethod('new_sup_form', "close");
                subList = [];
            }
            openLayer('new_sup_form', 'new_sup_layer', {cancel: cancelEvent, end: cancelEvent});
            $('#newSupDetailTable').bootstrapTable('load', subList);
        }

        // 新增的父级提交
        var submitNewSup = function () {
            var obj = new Object();
            $('#new_sup_form input').each(function (index, item) {
                obj[$(this).attr('name')] = $(this).val();
            })
            obj.codeList = subList;
            $.ajax({
                url: url + 'save',
                contentType: "application/json; charset=utf-8", 
                dataType: "json",    
                type: 'post',
                data: JSON.stringify(obj),
                success: function (res) {
                    layer.closeAll();
                    layer.msg(res);
                    endMethod('new_sub_form');
                    subList = [];
                    $('#dictTable').bootstrapTable('refresh');
                }
            })
        }

        // 新增的子级提交
        var submitNewSub = function () {
            var obj = new Object();
            $('#new_sub_form input').each(function (index, item) {
                obj[$(this).attr('name')] = $(this).val();
            })
            if (obj.index != '') {
                console.log("edit: ", subList)
                // 如果不为空，代表是修改，需要将list里面的数据去掉
                $.each(subList, function (i, item) {
                    if (item.index == editIndex) {
                        subList.splice(i, 1)
                        return false
                    }
                })
            }
            obj.index = newIndex++;
            subList.push(obj);
            layer.close(layer.index);
            layer.msg('新增成功！')
            endMethod('new_sub_form');
            console.log("subList: ", subList);
            $('#newSupDetailTable').bootstrapTable('load', subList);
        }

        // 新增子级
        function newSubDictLayer (id) {
            openLayer('new_sub_form', 'new_sub_layer');
        }

        function initTableButton (value, row, index) {
            var html = '';
            html += '<div class="btn-group">';
            html += '<button type="button" class="btn btn-white" onclick="dictDetailRow('
                    + row.id + ', ' + index + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
            html += '<button type="button" class="btn btn-white" id="edit"  onclick="dictEditRow('
                    + row.id + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
            html += '<button type="button" class="btn btn-white" onclick="dictDeleteRow(this, '
                    + row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
            html += '</div>';
            return html;
        }

        // 详情
        function dictDetailRow (id, index) {
            subSortIndex = 0;
            var layerId = 'sup_detail_layer';
            var formId = 'sup_detail_form';
            $('#' + layerId).find('input[sName=pid]').val(id);
            var row = getTableRow(id, 'dictTable');
            var pageSize = $('#dictTable').bootstrapTable('getOptions').pageSize
            var size = $('#dictTable').bootstrapTable('getOptions').pageNumber
            row.pageIndex = (size - 1)*pageSize + index + 1;
            displayDetail(id, formId, layerId, 'dictTable', {row: row});
            $('#supDetailTable').bootstrapTable('refresh', {url: url + 'list'})
        }

        // 修改
        function dictEditRow (id) {
            var layerId = 'sup_layer';
            var formId = 'sup_form';
            $('#' + layerId).find('input[sName=pid]').val(id);
            var row = getTableRow(id, 'dictTable');
            editRow(id, formId, layerId, 'dictTable', {row: row});
            $('#supTable').bootstrapTable('refresh', {url: url + 'list'})
        }

        // 删除
        function dictDeleteRow (t, id) {
            tableId = $(t).closest('table').attr('id');
            deleteRow('', tableId, {ids: id})
        }

        // 新增子项
        function openSubDictLayer (t, formId, layerId) {
            $('#' + formId).find('input[name=pid]').val($('#sup_form input[name=id]').val());
            $('#' + formId).find('input[name=type]').val($('#sup_form input[name=type]').val())
            openLayer(formId, layerId);
            tableId = 'supTable';
        }

        // 详情修改的按钮
        function initSupTableButton (value, row, index) {
            var html = '';
            html += '<div class="btn-group">';
            html += '<button type="button" class="btn btn-white" onclick="dictSubDetailRow(this, '
                    + row.id + ', ' + index + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
            html += '<button type="button" class="btn btn-white" id="edit"  onclick="dictSubEditRow(this, '
                    + row.id + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
            html += '<button type="button" class="btn btn-white" onclick="dictSubDeleteRow(this, '
                    + row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
            html += '</div>';
            return html;
        }

        function dictSubDetailRow (t, id, index) {
            var layerId = 'sub_detail_layer';
            var formId = 'sub_detail_form';
            tableId = $(t).closest('table').attr('id');
            var row = getTableRow(id, tableId);
            var pageSize = $('#' + tableId).bootstrapTable('getOptions').pageSize
            var size = $('#' + tableId).bootstrapTable('getOptions').pageNumber
            row.pageIndex = (size - 1)*pageSize + index + 1;
            displayDetail(id, formId, layerId, tableId, {row: row});
        }

        function dictSubEditRow (t, id) {
            var layerId = 'sub_layer';
            var formId = 'sub_form';
            tableId = $(t).closest('table').attr('id');
            editRow(id, formId, layerId, tableId, {});
        }

        function dictSubDeleteRow (t, id) {
            tableId = $(t).closest('table').attr('id');
            deleteRow('', tableId, {ids: id})
        }

        var submitHandler = function () {
            var $tableId = '#' + tableId;
            var formId = 'sub_form';
            var $formId = '#' + formId;
            $($formId).ajaxSubmit({
                url : url + 'zijiSave',
                type : 'post',
                success : function (data) {
                    layer.close(layer.index);
                    console.log("$tableId: ", $tableId)
                    $($tableId).bootstrapTable('refresh');
                    layer.msg(data);
                    endMethod(formId);
                },
                error : function (XmlHttpRequest, textStatus, errorThrown) {
                    layer.close(layer.index);
                    $($tableId).bootstrapTable('refresh');
                    layer.msg("数据操作失败!");
                    endMethod(formId);
                },
                resetForm : true
            });
            return false;
        }

        function dictSearch () {
            $('#dictTable').bootstrapTable('refresh');
            var pageSize = $('#dictTable').bootstrapTable('getOptions').pageSize
            var size = $('#dictTable').bootstrapTable('getOptions').pageNumber
            sortIndex = (size - 1)*pageSize
        }

        // 新增的子表
        function initNewSupTableButton (value, row, index) {
            console.log("index: ", index)
            var html = '';
            html += '<div class="btn-group">';
            html += '<button type="button" class="btn btn-white" onclick="dictNewSubDetailRow('
                    + row.id + ', ' + row.index + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
            html += '<button type="button" class="btn btn-white" id="edit"  onclick="dictNewSubEditRow('
                    + row.id + ', ' + row.index + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
            html += '<button type="button" class="btn btn-white" onclick="dictNewSubDeleteRow('
                    + row.id + ', ' + row.index + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
            html += '</div>';
            return html;
        }

        function dictNewSubDetailRow (id, index) {
            var layerId = 'sub_detail_layer';
            var formId = 'sub_detail_form';
            var newTableId = 'newSupDetailTable';
            var row = getTableRow(index, newTableId);
            displayDetail(id, formId, layerId, newTableId, {row: row});
        }

        function dictNewSubEditRow (id, index) {
            editIndex = index;
            editRow(index, 'new_sub_form', 'new_sub_layer', 'newSupDetailTable', {});
        }

        function dictNewSubDeleteRow (id, index) {
            layeConfirm = layer.confirm('您确定要删除么？', {
                btn : [ '确定', '取消' ]
            }, function() {
                $.each(subList, function (i, item) {
                    if (item.index == index) {
                        subList.splice(i, 1)
                        return false
                    }
                })
                $('#newSupDetailTable').bootstrapTable('load', subList);
                layer.close(layeConfirm);
            });
        }

        // 自定义排序函数
        function codeSort () {
            return ++sortIndex
        }

        $('#dictTable').on('page-change.bs.table', function (number, size) {
            var pageSize = $('#dictTable').bootstrapTable('getOptions').pageSize
            sortIndex = (size - 1)*pageSize
        })

        // 子级排序
        function subCodeSort () {
            return ++subSortIndex
        }

        $('#supDetailTable').on('page-change.bs.table', function (number, size) {
            var pageSize = $('#supDetailTable').bootstrapTable('getOptions').pageSize
            sortIndex = (size - 1)*pageSize
        })

    </script>

    <script src="${ctxStatic}/js/common/common-model.js"></script>
    </body>
</html>
