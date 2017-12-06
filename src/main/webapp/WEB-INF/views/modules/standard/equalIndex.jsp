<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style type="text/css">
.com-count {
    padding: 7px 15px 7px 15px;
    color: #333;
    cursor: pointer;
}

.com-count .badge {
    margin-left: 5px;
}

.label-info, .badge-info {
    font-size: 14px;
}
.rr .form-group {
    display:inline-block;
}

.rr .form-control{
    display: inline-block;
    width: auto;
}
#repeatForm .form-group {
    display:block;
}
#repeatForm .form-group input{
    width: 100%;
}
.rr .form-group {margin:0;}
</style>
<body class="white-bg skin-7">
    <div class="wrapper wrapper-content animated fadeInRight">
    
        <div class="ibox float-e-margins">
            <div class="ibox-content ">
                <div class="form-group rr" style="margin-bottom: 10px;">
                    <div class="form-group">
                        <input type="text" placeholder="输入同义词配置名" name="search_nameCn" value="" class="form-control">
                        <div class="btn-group">
                            <button class="btn btn-primary" type="submit"
                                onclick="initWebSearch();"><i class="iconfont gm-search"></i>搜索</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary  btn-cyan change-sort" onclick="sort()">
                            按次数排序&nbsp;<i class="fa fa-sort-desc"></i>
                        </button>
                    </div>
                    <div class="form-group">
                         <button class="btn btn-primary  btn-purple" onclick="toConfigure()">
                            <i class="fa fa-cog"></i> 同义词配置&nbsp;
                        </button>
                     </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
                <div class="hr-line-dashed"
                    style="margin-top: 0px; margin-bottom: 0px;"></div>
                <div class="panel panel-default">
                    <div class="p-xs panel-heading">
                        <h3>重复数据</h3>
                    </div>
                    
                    <div id="content" class="panel-body">
                        <div class="col-sm-12 repeat-content">
                            
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    
    <!-- 同义词配置 -->
    <div id="layer_form" style="display: none;" class="ibox-content">
        <div id="eForm" class="form-horizontal">
            <div class="ibox-content">
                <div id="toolbar">
                    <div class="form-inline">
                        <div class="form-group">
                            <input name="equal_name" type="text" placeholder="输入同义词配置名称"
                                class="form-control col-sm-8">
                            <div class="input-group-btn col-sm-4">
                                <button type="button" id="searchFor"
                                    onclick=" $('#equalTable').bootstrapTable('refresh');"
                                    class="btn btn-primary">搜索</button>
                            </div>
                        </div>
                        <div class="form-group" style="margin-left: 15px;">
                            <div class="text-center">
                                <a data-toggle="modal" class="btn btn-primary btn-green"
                                    onclick="addEqual();"><i class="fa fa-plus"></i> 新增同义词配置</a>
                            </div>
                        </div>
                    </div>
                </div>
                <table id="equalTable">
                    <thead>
                        <tr>
                            <th data-field="name">同义词配置名称</th>
                            <th data-field="Score" data-formatter="equalTableButton" class="col-sm-4">操作</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    
    <!-- 同义词配置新增 -->
    <div id="add_equal_layer" style="display: none;" class="ibox-content">
        <form id="add_equal_form" class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">同义词配置名称：</label>
                <div class="col-sm-7">
                    <input type="text" name="name" class="form-control" placeholder="同义词配置名称" required>
                </div>
                <input type="text" name="id" class="form-control hide" />
                <input type="text" name="parentId" class="form-control hide" value=0 />
                <input type="text" name="levels" class="form-control hide" value=1 />
            </div>
        </form>
    </div>
    
    <!-- 同义词详情修改弹框 -->
    <div id="detail_equal_layer" style="display: none;" class="ibox-content">
        <form id="detail_equal_form" class="form-horizontal">
            <div class="ibox-content">
                <div class="detail-equal-search">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">同义词配置名称：</label>
                        <div class="col-sm-9">
                            <input type="text" name="name" class="form-control">
                        </div>
                        <input type="text" name="id" class="form-control hide" />
                        <input type="text" name="parentId" class="form-control hide" value=0 />
                        <input type="text" name="levels" class="form-control hide" value=1 />
                        <input type="text" name="detail_parentId" class="form-control hide" />
                        <input type="text" name="detail_levels" class="form-control hide" value=2 />
                    </div>
                    <div class="form-group">
                        <a data-toggle="modal" class="btn btn-primary" onclick="addNewXM();" href="#">添加同义词</a>
                    </div>
                </div>
                <table id="equalDetailTable">
                    <thead>
                        <tr>
                            <th data-field="name">同义词</th>
                            <th data-field="Score" data-formatter="detailTableButton" class="col-sm-4">操作</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </form>
    </div>
    
    <!-- 添加同义词 -->
    <div id="addxm_equal_layer" style="display: none;" class="ibox-content">
        <form id="addxm_equal_form" class="form-horizontal">
            <div class="alert alert-info">*匹配多个字符，_匹配一个字符。</div>
            <div class="form-group">
                <label class="col-sm-3 control-label">同义词：</label>
                <div class="col-sm-9">
                    <input type="text" name="name" class="form-control">
                </div>
            </div>
            <input type="text" name="id" class="form-control hide" />
            <input type="text" name="parentId" class="form-control hide" />
            <input type="text" name="levels" class="form-control hide" value=2 />
        </form>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <%@ include file="/WEB-INF/views/modules/standard/equalPaging.jsp"%>
    <script>
    var tableId = '';
    var toolbar = '';
    var layerId = '#layer_form';
    var formId = '#eForm'; //form id
    var url = '${ctx}/standard/equal/';
    var obj = {};
    var editTitle = "选择数据元";
    var detailTitle = "";
    
    var equalTableId = "#equalTable"; // 同义词配置表格
    var addLayerId = "#add_equal_layer"; // 同义词配置新增菜单
    var addFormId = "#add_equal_form"; // 同义词配置新增表单
    var detailTableId = "#equalDetailTable"; // 同义词详情弹框表格
    var detailLayerId = "#detail_equal_layer"; // 同义词详情修改弹框
    var detailFormId = "#detail_equal_form"; // 同义词修改弹框表单
    var webListData = new Array();
    var sortModel = true;
    var addParentId = 0;
    
    $(function () {
        initWeb();
        // 同义词配置表单初始化
        equalTable = new equalTableInit();
        equalTable.Init();
        // 同义词详情修改表单初始化
        detailTable = new detailTableInit();
        detailTable.Init();
        // 同义词配置新增菜单验证初始化
        addFormvalid();
    })
    
    function initWeb () {
        $.ajax({
            url: url + 'allList',
            success: function (res) {
                webListData = res;
                initList(res);
            }
        })
    }
    
    function initList (res) {
        console.log("res: ", res)
        $(".repeat-content").html("");
        if (res.length == 0) {
            $(".repeat-content").html('<div class="alert alert-success" style="margin:10px;">暂无符合条件的同义信息项需要清洗。 </div>')
            return
        }
        var html = '';
        $.each(res, function (index, item) {
            if (item.count == 0) {
                return
            }
            html += '<div class="com-count col-sm-3" index="' + item.id + '">' + item.name + ' (' + item.count + ')</div>';
        })
        if (html == "") {
            $(".repeat-content").html('<div class="alert alert-success" style="margin:10px;">暂无符合条件的同义信息项需要清洗。 </div>')
            return
        }
        $(".repeat-content").html("");
        $(".repeat-content").append(html);
        $(".com-count").click(function () {
            $("#select_Form input[name=id]").val($(this).attr("index"))
            openSelectLayer(editTitle);
        })
    }
    
    // 搜索功能
    function initWebSearch () {
        var newWebListData = new Array();
        var nameCn = $("input[name=search_nameCn]").val();
        $.each(webListData, function (index, item) {
            if (item.name.toLowerCase().indexOf(nameCn.toLowerCase()) >= 0) {
                newWebListData.push(item);
            }
        })
        initList(newWebListData);
    }
    
    // 升序降序
    function sortBy (attr, rev){
        // 第二个参数没有传递 默认升序排列
        if (rev == undefined) {
            rev = 1;
        } else {
            rev = (rev) ? 1 : -1;
        }
        return function(a,b){
            a = a[attr];
            b = b[attr];
            if(a < b){
                return rev * -1;
            }
            if(a > b){
                return rev * 1;
            }
            return 0;
        }
    }

    // 排序
    function sort () {
        sortModel = !sortModel;
        if (sortModel) {
            $('.change-sort i').addClass('fa-sort-asc');
            $('.change-sort i').removeClass('fa-sort-desc');
        } else {
            $('.change-sort i').addClass('fa-sort-desc');
            $('.change-sort i').removeClass('fa-sort-asc');
        }
        var newData = new Array();
        newData = webListData.sort(sortBy('count', sortModel));
        console.log('newData: ', newData);
        initList(newData);
    }
    
    // 同义词配置
    function toConfigure () {
        $(equalTableId).bootstrapTable('refresh');
        layeForm = layer.open({
            title: "同义词配置",
            type : 1,
            area : [ '80%', '80%' ],
            scrollbar : false,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
            yes : function(index, layero) {
                $(formId).submit();
            },
            end : function() {
            },
            content : $(layerId)
        });
    }
    
    // 同义词配置表单
    var equalTableInit = function() {
        var oTableInit = new Object();
        // 初始化Table
        oTableInit.Init = function() {
            $(equalTableId).bootstrapTable({
                url : url + 'list',
                method : 'get',
                toolbar : toolbar, // 工具按钮用哪个容器
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
            var equalObj = {};
            equalObj.name = $("input[name=equal_name]").val();
            equalObj.levels = 1;
            equalObj.parentId = null;
            var temp = {
                pageNum : params.offset / params.limit + 1,
                pageSize : params.limit,
                obj : JSON.stringify(equalObj)
            };
            return temp;
        };
        return oTableInit;
    };
    
    function equalTableButton (index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="datailEqualRow('
                + row.id + ',\'' + row.name + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '<button type="button" class="btn btn-white" id="edit"  onclick="editEqualRow('
                + row.id + ',\'' + row.name + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
        html += '<button type="button" class="btn btn-white" onclick="deleteEqualRow('
                + row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
        html += '</div>';
        return html;
    }
    
    // 新增同义词配置
    function addEqual () {
        addLayeForm = layer.open({
            title: "同义词配置",
            type : 1,
            area : [ '60%', '60%' ],
            scrollbar : false,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
            yes : function(index, layero) {
                $(addFormId).submit();
            },
            end : function() {
                $(addFormId).resetForm();
                endMethod(addFormId, "close");
            },
            content : $(addLayerId)
        });
    }
    
    // 同义词配置新增表单验证
    function addFormvalid () {
        $(addFormId).validate({
            submitHandler: function(form){
                $(addFormId).ajaxSubmit({
                    url : url + 'save',
                    type : 'post',
                    success : function(data){
                        layer.close(addLayeForm);
                        $(equalTableId).bootstrapTable('refresh');
                        layer.msg(data);
                        initWeb();
                    },
                    error : function(XmlHttpRequest, textStatus, errorThrown){
                        layer.close(addLayeForm);
                        $(equalTableId).bootstrapTable('refresh');
                        layer.msg("数据操作失败!");
                    },
                    resetForm : true
                });
                return false;
            }
        });
    }
    
    // 同义词详情按钮
    function datailEqualRow (id, name) {
        $("#detail_equal_form input[name=id]").val(id);
        $("#detail_equal_form input[name=name]").val(name);
        $("#detail_equal_form input[name=name]").attr("readOnly", true);
        $("#detail_equal_form input[name=detail_parentId]").val(id);
        addParentId = id;
        $(detailTableId).bootstrapTable('refresh');
        detailLayeForm = layer.open({
            title: "同义词详情",
            type : 1,
            area : [ '60%', '60%' ],
            scrollbar : false,
            zIndex : 100,
            cancel: function () {
                $("#detail_equal_form input[name=name]").attr("readOnly", false);
            },
            content : $(detailLayerId)
        });
    }
    
    // 同义词修改按钮
    function editEqualRow (id, name) {
        console.log("id: ", id);
        $("#detail_equal_form input[name=id]").val(id);
        $("#detail_equal_form input[name=name]").val(name);
        $("#detail_equal_form input[name=detail_parentId]").val(id);
        addParentId = id;
        $(detailTableId).bootstrapTable('refresh');
        detailLayeForm = layer.open({
            title: "同义词修改",
            type : 1,
            area : [ '60%', '60%' ],
            scrollbar : false,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
            yes : function(index, layero) {
                $(detailFormId).submit();
            },
            end : function() {
                $(detailFormId).resetForm();
            },
            content : $(detailLayerId)
        });
    }
    
    // 同义词修改表单验证
    $(function detailFormvalid () {
        $(detailFormId).validate({
            submitHandler: function(form){
                $(detailFormId).ajaxSubmit({
                    url : url + 'save',
                    type : 'post',
                    success : function(data){
                        layer.close(detailLayeForm);
                        $(equalTableId).bootstrapTable('refresh');
                        layer.msg(data);
                        initWeb();
                    },
                    error : function(XmlHttpRequest, textStatus, errorThrown){
                        layer.close(detailLayeForm);
                        $(equalTableId).bootstrapTable('refresh');
                        layer.msg("数据操作失败!");
                    },
                    resetForm : true
                });
                return false;
            }
        });
    })
    
    // 同义词删除数据
    function deleteEqualRow(id) {
        deleteLayer = layer.confirm('您确定要删除么？', {
            btn : [ '确定', '取消' ]
        }, function() {
            $.post(url + 'delete', {
                id : id
            }, function(data) {
                layer.close(deleteLayer);
                initWeb();
                $(equalTableId).bootstrapTable('refresh');
                layer.msg(data);
            }, 'json');
        });
    }
    
    // 同义词详情修改表格
    var detailTableInit = function() {
        var oTableInit = new Object();
        // 初始化Table
        oTableInit.Init = function() {
            $(detailTableId).bootstrapTable({
                url : url + 'list',
                method : 'get',
                striped : true, // 是否显示行间隔色
                pagination : true, // 是否显示分页（*）
                queryParams : oTableInit.queryParams, // 传递参数（*）
                sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
                pageNumber : 1, // 初始化加载第一页，默认第一页
                pageSize : 10, // 每页的记录行数（*）
                pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
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
            var equalObj = {};
            equalObj.name = "";
            equalObj.levels = 2;
            equalObj.parentId = parseInt($("#detail_equal_form input[name=detail_parentId]").val());
            var temp = {
                pageNum : params.offset / params.limit + 1,
                pageSize : params.limit,
                obj : JSON.stringify(equalObj)
            };
            return temp;
        };
        return oTableInit;
    };
    
    // 同义词详情表格按钮
    function detailTableButton (index, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="editDetailRow('
                + row.id + ',\'' + row.name + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
        html += '<button type="button" class="btn btn-white" onclick="deleteDetailRow('
                + row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
        html += '</div>';
        return html;
    }
    
    // 同义词修改中的删除
    function deleteDetailRow(id) {
        addxmDeleteLayer = layer.confirm('您确定要删除么？', {
            btn : [ '确定', '取消' ]
        }, function() {
            $.post(url + 'delete', {
                id : id
            }, function(data) {
                layer.close(addxmDeleteLayer);
                $(detailTableId).bootstrapTable('refresh');
                initWeb();
                layer.msg(data);
            }, 'json');
        });
    }
    
    // 添加同义词
    function addNewXM () {
        openDetailRow("新增")
    }
    
    // 修改同义词中的修改
    function editDetailRow (id, name) {
        $("#addxm_equal_form input[name=id]").val(id);
        $("#addxm_equal_form input[name=name]").val(name);
        openDetailRow("修改");
    }
    
    // 上面两个方法的公共方法
    function openDetailRow (title) {
        $('#addxm_equal_form input[name=parentId]').val(addParentId);
        addxmLayeForm = layer.open({
            title: title,
            type : 1,
            area : [ '45%', '45%' ],
            scrollbar : false,
            zIndex : 100,
            btn : [ '保存', '关闭' ],
            yes : function(index, layero) {
                $("#addxm_equal_form").submit();
            },
            end : function() {
                $("#addxm_equal_form").resetForm();
            },
            content : $("#addxm_equal_layer")
        });
    }
    
    // 添加同义词表单验证
    $(function () {
        $("#addxm_equal_form").validate({
            submitHandler: function(form){
                $("#addxm_equal_form").ajaxSubmit({
                    url : url + 'save',
                    type : 'post',
                    success : function(data){
                        layer.close(addxmLayeForm);
                        $(detailTableId).bootstrapTable('refresh');
                        initWeb();
                        layer.msg(data);
                        $("#addxm_equal_form input[name=name]").val("");
                        $("#addxm_equal_form input[name=id]").val(null);
                    },
                    error : function(XmlHttpRequest, textStatus, errorThrown){
                        layer.close(addxmLayeForm);
                        $("#equalDetailTable").bootstrapTable('refresh');
                        $("#addxm_equal_form input[name=name]").val("");
                        $("#addxm_equal_form input[name=id]").val(null);
                        layer.msg("数据操作失败!");
                    },
                    // resetForm : true
                });
                return false;
            }
        });
    })
    </script>

    <script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

