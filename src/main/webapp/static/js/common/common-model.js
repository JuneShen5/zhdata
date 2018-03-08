$(function () {

    // select-chosen插件
    $(".select-chosen").chosen({
        width : "100%"
    }).change(function (e) {
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
        // 遍历dom节点将数据放入上面的隐藏域中
        var isCheckData = '';
        var that = event.currentTarget
        $(that).closest(".form-group").find("input[type=checkbox]:checked,input[type=radio]:checked").each(function (index, item) {
            // isCheckData.push($(this).val());
            isCheckData += ',' + $(this).val();
        })
        $(that).closest(".form-group").find("input.checkboxInput").val(isCheckData.slice(1))
        $(that).closest(".form-group").find("input.checkboxInput").blur();
    });

    // layertips提示框，在class中加上layerTips即可，data-tips-text是提示的内容
    $(document).on('mouseenter', '.layerTips', function(){
    // $(".layerTips").mouseenter(function(event) {
        var $this = $(this);
        var tipsIndex = "";
        tipsIndex = layer.tips($this.attr("data-tips-text"), $this, {tips: [3, 'rgba(68,68,68,.9)'],time: 0});
        var thisTagWidth = $("#layui-layer"+tipsIndex).width();
        var tipsLeft = parseInt($this.css("paddingLeft"))+parseInt($this.width())-thisTagWidth;
        if($this.attr("data-tips-text")==""){
            $("#layui-layer"+tipsIndex).css("display", "none");
        }
        $("#layui-layer"+tipsIndex).css("left", tipsLeft);
        $("#layui-layer"+tipsIndex).find("i").css({"border-left-color": "rgba(68, 68, 68, 0.9)","border-right-color": "transparent","border-bottom": "none","right":"5px","left":"auto"});
        // $(".layui-layer-tips").children(".layui-layer-content").css("color", "#666")
        $("#layui-layer"+tipsIndex).children(".layui-layer-content").css("padding", "2px 10px");
    }).on('mouseleave', '.layerTips', function(){
        layer.close(layer.index);
    });
})

// 表格初始化
// oTable = new TableInit(id, setting);
// oTable.Init();
var TableInit = function (id, setting) {
    var oTableInit = new Object();
    var defaultOption = new Object();
    // 初始化Table
    oTableInit.Init = function() {
        // 设置默认值
        defaultOption = {
            // url: url + 'list',
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
            params: {},
            temp: {}
        }
        var option = $.extend(defaultOption, setting);
        console.log("option: ", option)
        $('#' + id).bootstrapTable(option);
    };

    // 得到查询的参数
    oTableInit.queryParams = function(params) {
        var obj = {};
        obj = $.extend(obj, setting.params);
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
        temp = $.extend(temp, defaultOption.temp);
        return temp;
    };
    return oTableInit;
};

var loadTableInit = function (id, setting) {
    var oTableInit = new Object();
    var defaultOption = new Object();
    // 初始化Table
    oTableInit.Init = function() {
        // 设置默认值
        defaultOption = {
            data: [],  // 表格中的数据
            striped: true, // 是否显示行间隔色
            iconSize: 'outline',
            uniqueId: "id", // 每一行的唯一标识，一般为主键列
        }
        var option = $.extend(defaultOption, setting);
        $('#' + id).bootstrapTable(option);
    };

    return oTableInit;
};

// 新增修改的表单弹框
function openLayer (formId, layerId, setting) {
    console.log("setting: ", setting)
    var $formId = '#' + formId;
    var $layerId = '#' + layerId;
    $($formId).validate().form();
    var defaultOption = {
        title: '新增',
        type : 1,
        area : [ '100%', '100%' ],
        scrollbar : false,
        zIndex : 100,
        btn : [ '保存', '关闭' ],
        yes : function(index, layero) {
            $($formId).submit();
            // (tableId) ? $($tableId).bootstrapTable('refresh') : '';
        },
        end : function() {
            $($formId).resetForm();
            endMethod(formId, "close");
        },
        cancel: function () {
            $($formId).resetForm();
            endMethod(formId, "close");
        },
        content : $($layerId)
    }
    var option = $.extend(defaultOption, setting);
    layeForm = layer.open(option);
}

// 修改，表单回显功能
function editRow(id, formId, layerId, tableId, setting) {
    if (setting) {
        setting.row = setting.row ? loadToData(formId, setting.row) : loadToData(formId, getTableRow(id, tableId));
    } else {
        loadToData(formId, getTableRow(id, tableId))
    }
    openLayer(formId, layerId, setting);
}

// 详情
function displayDetail (id, formId, layerId, tableId, setting) {
    if (setting) {
        setting.row = setting.row ? loadDetail(formId, setting.row) : loadDetail(formId, getTableRow(id, tableId));
    } else {
        loadDetail(formId, getTableRow(id, tableId))
    }
    var $formId = '#' + formId;
    var $layerId = '#' + layerId;
    var defaultOption = {
        title: '详情',
        type: 1,
        area: [ '100%', '100%' ],
        scrollbar: false,
        zIndex: 100,
        cancel: function () {
            $($formId).resetForm();
            $($formId).find('span').text('');
        },
        content: $($layerId)
    }
    var option = $.extend(defaultOption, setting);
    layer.open(option)
}

// 获取表格数据
function getTableRow (id, tableId) {
    var row = $('#' + tableId).bootstrapTable('getRowByUniqueId', id);
    return row;
}

// 删除数据
function deleteRow(id, tableId, setting) {
    var defaultOption = {
        id : id
    }
    var option = $.extend(defaultOption, setting);
    layeConfirm = layer.confirm('您确定要删除么？', {
        btn : [ '确定', '取消' ]
    }, function() {
        $.post(url + 'delete', option, function(data) {
            layer.close(layeConfirm);
            $('#' + tableId).bootstrapTable('refresh');
            layer.msg(data);
        }, 'json');
    });
}

function deleteAllRow (tableId) {
    var delData = $('#' + tableId).bootstrapTable('getSelections');
    if (delData.length == 0) {
        layer.msg("请至少选择一项数据");
        return;
    }
    var ids = new Array();
    $.each(delData, function (index, item) {
        ids.push(item.id);
    })
    ids = JSON.stringify(ids);
    layeConfirm = layer.confirm('您确定要删除么？', {
        btn : [ '确定', '取消' ]
    }, function() {
        $.post(url + 'delete', {ids: ids.slice(1, ids.length - 1)}, function(data) {
            layer.close(layeConfirm);
            $('#' + tableId).bootstrapTable('refresh');
            layer.msg(data);
        }, 'json');
    });
}

// 修改中的回显数据
function loadToData(formId, row) {
    console.log("row: ", row);
    var obj = row;
    var key, value, tagName, type, arr;
    for (x in obj) {
        key = x;
        value = obj[x];
        $('#' + formId).find("[name='" + key + "'],[name='" + key + "[]']").each(function() {
            tagName = $(this)[0].tagName;
            type = $(this).attr('type');
            if (tagName == 'INPUT') {
                if (type == 'radio') {
                    $(this).attr('checked', $(this).val() == value);
                } else {
                    $(this).val(value);
                    if ($(this).attr("stype") == "checkbox") {
                        var fthis = $(this).closest(".form-group");
                        arr = value.split(',');
                        console.log("arr: ", arr);
                        for (var i = 0; i < arr.length; i++) {
                            /*if ($(this).val() == arr[i]) {
                                $(this).attr('checked', true);
                                break;
                            }*/
                            fthis.find("input").each(function (index, item) {
                                if ($(this).val() == arr[i]) {
                                    $(this).iCheck('check');
                                };
                            });
                        };
                    }
                }
            } else if (tagName == 'TEXTAREA') {
                $(this).val(value);
            } else if (tagName == 'SELECT') {
                // 判断是否是联动
                if ($(this).attr("id") == "linkageSelSelect") {
                    var linkageSelData = new Array();
                    linkageSelData.push(value);
                    // 判断是否存在后续的数据
                    for (var i = 2; i < 100; ++i) {
                        if (row["infoType" + i] !== undefined) {
                            linkageSelData.push(row["infoType" + i]);
                        } else {
                            break;
                        }
                    }
                    console.log(linkageSelData);
                    loadLinkageSel(linkageSelData);
                } else {
                    // 是否是多选
                    if ($(this).attr('multiple')) {
                        value = value.split(",")
                        console.log("value: ", value)
                    }
                    $(this).val(value);
                    $(this).change();
                    $(this).trigger("chosen:updated");
                }
            } else if (tagName == 'UL') {
                console.log("树回显: ", value);
                // 在回显的时候暂时先将父级影响子级关闭，回显结束之后再将其打开
                zTree.setting.check.chkboxType = {"Y": "", "N": "ps"}
                zTree.checkAllNodes(false);
                var checkData = []
                for (var i in value) {
                    zTree.checkNode(zTree.getNodeByParam("id", value[i].id, null), true, true);
                    checkData.push({
                        id : value[i].id
                    });
                };
                zTree.setting.check.chkboxType = {"Y": "s", "N": "ps"}
                $("#menuIds").val(JSON.stringify(checkData));
            }
        });
    }
    // 数据回显之后自动更新插件回显
    $('.i-checks').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
    });
    shareToggleName(formId);
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
            // $(this).text(value);
            if (tagName == 'SPAN') {
                $(this).text(value);
            } else if (tagName == 'SELECT') {
                // 是否是多选
                if ($(this).attr('multiple')) {
                    value = value.split(",")
                }
                $(this).val(value);
                $(this).change();
                var selectVal = '';
                $(this).find('option:checked').each(function () {
                    selectVal += $(this).text() + ',';
                })
                $(this).siblings('span').text(selectVal.slice(0, selectVal.length - 1));
            } else if (tagName == 'INPUT') {
                if (type == 'radio') {
                    $(this).attr('checked', $(this).val() == value);
                    $('.i-checks').iCheck('disable');
                } else {
                    $(this).val(value);
                    if ($(this).attr("stype") == "checkbox") {
                        var fthis = $(this).closest(".form-group");
                        arr = value.split(',');
                        for (var i = 0; i < arr.length; i++) {
                            fthis.find("input").each(function (index, item) {
                                if ($(this).val() == arr[i]) {
                                    $(this).iCheck('check');
                                };
                            });
                        };
                    }
                }
            }
        });
    }
    detailShareToggleName(formId)
}

// 执行提交之后统一执行的方法
// 第一个属性是提交表单的id，第二个属性是判断事件属于提交事情还是关闭事件
function endMethod (closeId, status) {
    console.log("closeId: ", closeId)
    var $closeId = '#' + closeId;
    // 将表单验证去掉
    $($closeId).validate().resetForm();
    // 将插件加上的属性去掉
    $($closeId).find("input").val("");
    $($closeId).find("select").val("").trigger("chosen:updated");
    $($closeId).find(".i-checks input").removeAttr("checked");
    $($closeId).find(".i-checks div.checked").removeClass("checked");
    try{
        if(resetPage) {
            resetPage(closeId, status);
        };
    } catch (e) {};
}

// 验证
function initFormValide (formId, suburl, tableId, setting) {
    console.log("tableId: ", tableId)
    suburl = suburl ? suburl = suburl : suburl = 'save';
    var $formId = '#' + formId;
    var $tableId = '#' + tableId;
    defaultOption = {
        ignore: ":hidden:not(select,input)",
        submitHandler: function (form) {
            $($formId).ajaxSubmit({
                url : url + suburl,
                type : 'post',
                success : function (data) {
                    console.log("tableId: ", tableId)
                    layer.closeAll();
                    console.log("$tableId: ", $tableId)
                    $($tableId).bootstrapTable('refresh');
                    layer.msg(data);
                    endMethod(formId);
                },
                error : function (XmlHttpRequest, textStatus, errorThrown) {
                    layer.closeAll();
                    $($tableId).bootstrapTable('refresh');
                    layer.msg("数据操作失败!");
                    endMethod(formId);
                },
                resetForm : true
            });
            return false;
        }
    }
    var option = $.extend(defaultOption, setting);
    $($formId).validate(option);
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

// 四级联动的监听项
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

// 上传控件
function uploadFile (that) {
    $(that).next(".uploadFile").click();
    $(that).next(".uploadFile").on('change', function () {
        $(that).parents('.form-group').find('.form-control').val($(that).next(".uploadFile").val());
    })
}

// 下载
function downloadFile (that) {
    window.open($(that).parents('.form-group').find('.form-control').val());
}

// 获取当前时间
function getNowDate () {
    var myDate = new Date();
    var date = myDate.getFullYear() + '-' + (myDate.getMonth() + 1) + '-' + myDate.getDate();
    return date
}

// 页面中存在的下拉框收缩功能 先引入这个方法
function shareToggleMethod() {
    // 是否向社会开放
    var isOpenSelect = $("select[name=isOpen]");
    if (isOpenSelect !== undefined) {
        console.log('2oo');
        var kflxSelect = isOpenSelect.closest('form').find("[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        isOpenSelect.on('change', function () {
            var thisValue = parseInt($(this).val());
            if (thisValue === 1) {
                kflxSelect.closest('.form-group').slideToggle();
                kflxSelect.attr("required", "required");
            } else if (thisValue === 0) {
                kflxSelect.closest('.form-group').hide();
                kflxSelect.val("");
                // kflxSelect.trigger("chosen:updated");
                kflxSelect.removeAttr("required");
            }
        });
    }
}

// 在具体的代码中使用这个
function shareToggleName (formId) {
    var gxlxSelect = $('#' + formId).find("select[name=shareType]");
    var isOpenSelect = $('#' + formId).find("select[name=isOpen]");
    shareToggleChange(gxlxSelect, isOpenSelect);
}

function shareToggleChange (gxlxSelect, isOpenSelect) {
    if (isOpenSelect !== undefined) {
        console.log('2xx');
        var kflxSelect = isOpenSelect.closest('form').find("[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        if (isOpenValue === 1) {
            kflxSelect.closest('.form-group').slideToggle();
            kflxSelect.attr("required", "required");
        } else if (isOpenValue === 0 || isOpenValue === '') {
            kflxSelect.closest('.form-group').hide();
            kflxSelect.val("");
            // kflxSelect.trigger("chosen:updated");
            kflxSelect.removeAttr("required");
        }
    }
}

// 详情中共享类型和是否想社会开放的实际变化
function detailShareToggleMethod() {
    // 是否向社会开放
    var isOpenSelect = $("select[name=isOpen]");
    if (isOpenSelect !== undefined) {
        console.log('2oo');
        var kflxSelect = isOpenSelect.closest('form').find("[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        kflxSelect.removeAttr("required");
        isOpenSelect.change(function(event) {
            var thisValue = parseInt($(this).val());
            if (thisValue === 1) {
                kflxSelect.closest('.form-group').slideToggle();
            } else if (thisValue === 0) {
                kflxSelect.closest('.form-group').hide();
                kflxSelect.val("");
            }
        });
    }
}

// 详情中共享类型和是否想社会开放的初始化设定
function detailShareToggleName (formId) {
    var gxlxSelect = $('#' + formId).find("select[name=shareType]");
    var isOpenSelect = $('#' + formId).find("select[name=isOpen]");
    if (isOpenSelect !== undefined) {
        var kflxSelect = isOpenSelect.closest('form').find("[name=openType]");
        var isOpenValue = parseInt(isOpenSelect.val());
        kflxSelect.closest('.form-group').hide();
        if (isOpenValue === 1) {
            kflxSelect.closest('.form-group').slideToggle();
        } else if (isOpenValue === 0 || isOpenValue === '') {
            kflxSelect.closest('.form-group').hide();
            kflxSelect.val("");
        }
    }
}
