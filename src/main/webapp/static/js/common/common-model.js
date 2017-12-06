$(function () {

    // select-chosen插件
    $(".select-chosen").chosen({
        width : "100%"
    }).change(function (e) {
        console.log("select")
        $(e.currentTarget).blur();
    });
    $(".linkagesel-select-list").on("change",".LinkageSel",function(e){
        $(e.currentTarget).blur();
    });
    
    // 时间插件
    $('.datepicker').datepicker({
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true,
        todayHighlight:true
    }).on("changeDate", function (e) {
        $(this).blur();
    });
    
    // checkbox、radio插件
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    })
    $('.i-checks').on('ifChanged', function(e){
        setTimeout(function () {
            $(e.currentTarget).siblings("input").blur();
        }, 0)
    });
})

// 表格初始化
var TableInit = function (id, setting) {
    var oTableInit = new Object();
    var defaultOption = new Object();
    // 初始化Table
    oTableInit.Init = function() {
        // 设置默认值
        defaultOption = {
            url: url + 'list',
            method: 'get',
            toolbar: '#toolbar', // 工具按钮用哪个容器
            striped: true, // 是否显示行间隔色
            pagination: true, // 是否显示分页（*）
            queryParams: oTableInit.queryParams, // 传递参数（*）
            sidePagination: "server", // 分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1, // 初始化加载第一页，默认第一页
            pageSize: 10, // 每页的记录行数（*）
            pageList: [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
            showColumns: true, // 是否显示所有的列
            showRefresh: true, // 是否显示刷新按钮
            iconSize: 'outline',
            icons: {
                refresh: 'glyphicon-repeat',
                columns: 'glyphicon-list'
            },
            uniqueId: "id", // 每一行的唯一标识，一般为主键列
        }
        var option = $.extend(defaultOption, setting);
        console.log("option: ", option)
        $('#' + id).bootstrapTable(option);
    };

    // 得到查询的参数
    oTableInit.queryParams = function(params) {
        var obj = {};
        $(defaultOption.toolbar).find(".search-option").each(function (index, item) {
            console.log("sName: ", $(this).attr("sName"))
            if ($(this).attr("sName") !== undefined){
                obj[$(this).attr("sName")] = $(this).val();
            }
        })
        if ($(".search-list").length > 0){
            $(".search-list").find(".form-control").each(function (index, item) {
                if ($(this).attr("sName") !== undefined) {
                    obj[$(this).attr("sName")] = $(this).val();
                }
            });
        }
        var temp = {
            pageNum : params.offset / params.limit + 1,
            pageSize : params.limit,
            obj : JSON.stringify(obj)
        };
        return temp;
    };
    return oTableInit;
};

// 新增修改的表单弹框
function openLayer (formId, layerId,  title) {
    title = title ? title = title : title = '新增';
    $formId = '#' + formId;
    $layerId = '#' + layerId;
    $($formId).validate().form();
    layeForm = layer.open({
        title: title,
        type : 1,
        area : [ '100%', '100%' ],
        scrollbar : false,
        zIndex : 100,
        btn : [ '保存', '关闭' ],
        yes : function(index, layero) {
            $($formId).submit();
        },
        end : function() {
            $($formId).resetForm();
            endMethod(formId, "close");
        },
        content : $($layerId)
    });
}

// 修改，表单回显功能
function editRow(id, formId, layerId, title) {
    title = title ? title = title : title = '修改';
    loadData(getTableRow(id));
    openLayer(formId, layerId, title);
}

// 详情
function displayDetail (row, formId, layerId, title) {
    loadDetail(formId, row);
    var $formId = '#' + formId;
    var $layerId = '#' + layerId;
    layer.open({
        title: title,
        type: 1,
        area: [ '100%', '100%' ],
        scrollbar: false,
        zIndex: 100,
        cancel: function () {
            $($formId).find('span').text('');
        },
        content: $($layerId)
    })
}

// 获取表格数据
function getTableRow (id, tableId) {
    var row = $('#' + tableId).bootstrapTable('getRowByUniqueId', id);
    return row;
}

// 详情具体的回显功能 
function loadDetail (formId, row) {
    console.log("row: ", row);
    var obj = row;
    var key, value, tagName, type, arr;
    for (x in obj) {
        key = x;
        value = obj[x];
        $('#' + formId).find("[name='" + key + "'],[name='" + key + "[]']").each(function() {
            tagName = $(this)[0].tagName;
            type = $(this).attr('type');
            $(this).text(value);
        });
    }
}

// 执行提交之后统一执行的方法
// 第一个属性是提交表单的id，第二个属性是判断事件属于提交事情还是关闭事件
function endMethod (closeId, status) {
    $closeId = '#' + closeId;
    // 将表单验证去掉
    $($closeId).validate().resetForm();
    // 将插件加上的属性去掉
    $($closeId).find("select").val("");
    $($closeId).find("select").trigger("chosen:updated");
    $($closeId).find(".i-checks input").removeAttr("checked");
    $($closeId).find(".i-checks div.checked").removeClass("checked");
    try{
        if(resetPage) {
            resetPage(closeId, status);
        };
    } catch (e) {};
}

// 验证
function initFormValide (formId, suburl, tableId) {
    suburl = suburl ? suburl = suburl : suburl = 'save';
    $formId = '#' + formId;
    $tableId = '#' + tableId;
    $($formId).validate({
        ignore: ":hidden:not(select,input)",
        submitHandler: function (form) {
            $($formId).ajaxSubmit({
                url : url + suburl,
                type : 'post',
                success : function (data) {
                    layer.close(layer.index);
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
    });
}

// 设置验证信息的默认字段
$.validator.setDefaults({
    highlight: function (element) {
        if($(element).hasClass('LinkageSel')){
            $(element).closest(".form-group").children("label").removeClass('has-success-tips').addClass("has-error-tips");
            $(element).next().removeClass('has-success-s').addClass('has-error-s');
        } else {
            $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
        }
    },
    success: function (element) {
        var thisErrID = $(element).attr("id");
        var thisSelect = $("select[aria-describedby='"+thisErrID+"']");
        if(thisSelect.hasClass('LinkageSel')){
            thisSelect.next().removeClass('has-error-s').addClass('has-success-s');
            $(".linkagesel-select-div").find(".LinkageSel").next().each(function(){
                thisSelect.closest(".form-group").children("label").removeClass('has-error-tips has-success-tips');
                if(!$(this).hasClass('has-error-s')){
                    thisSelect.closest(".form-group").children("label").removeClass('has-error-tips').addClass("has-success-tips");
                } else {
                    thisSelect.closest(".form-group").children("label").removeClass('has-success-tips').addClass("has-error-tips");
                    thisSelect.closest(".form-group").find(".help-block").removeClass('has-success-tips').addClass("has-error-span");
                }
            });
        } else {
            $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
        }
    },
    errorElement: "span",
    errorPlacement: function (error, element) {
        if (element.is(":radio") || element.is(":checkbox")) {
            error.appendTo(element.parent().parent().parent());
        } else if(element.hasClass('LinkageSel')) {
            error.appendTo(element.parent().parent());
            error.addClass("has-error-span");
        } else {
            error.appendTo(element.parent());
        }
    },
    errorClass: "help-block m-b-none",
    validClass: "help-block m-b-none"
});
