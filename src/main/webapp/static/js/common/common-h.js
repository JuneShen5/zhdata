/*** 公用功能---begin ***/

// 表格初始化、表格按钮创建
var TableInit = function(tableOption,btnOption) {
    var oTableInit = {
        // 初始化Table
        Init : function () {
            // 设置默认值
            tableOption.toolbar = (tableOption.toolbar === undefined) ? '#toolbar' : '#' + tableOption.toolbar;
            tableOption.pageNumber = (tableOption.pageNumber === undefined) ? 1 : tableOption.pageNumber;
            tableOption.pageSize = (tableOption.pageSize === undefined) ? 10 : tableOption.pageSize;
            var tableInitParams = {
                method: 'get',
                toolbar: tableOption.toolbar, // 工具按钮用哪个容器
                striped: true, // 是否显示行间隔色
                pagination: true, // 是否显示分页（*）
                queryParams: oTableInit.queryParams, // 传递参数（*）
                sidePagination: "server", // 分页方式：client客户端分页，server服务端分页（*）
                pageNumber: parseInt(tableOption.pageNumber), // 初始化加载第一页，默认第一页
                pageSize: parseInt(tableOption.pageSize), // 每页的记录行数（*）
                pageList: [10, 25, 50, 100], // 可供选择的每页的行数（*）
                showColumns: true, // 是否显示所有的列
                showRefresh: true, // 是否显示刷新按钮
                iconSize: 'outline',
                icons: {
                    refresh: 'glyphicon-repeat',
                    columns: 'glyphicon-list'
                },
                uniqueId: "id" // 每一行的唯一标识，一般为主键列
            };
            if (tableOption.url === undefined && tableOption.data !== undefined){
                delete tableInitParams['url'];
                tableInitParams['data'] = tableOption.data;
            }else {
                delete tableInitParams['data'];
                tableInitParams['url'] = tableOption.url;
            }
            $('#' + tableOption.tableId).bootstrapTable(tableInitParams);
            $('#' + tableOption.tableId).on('post-body.bs.table', function (e) {
                $(this).find('thead').removeClass('ele-hide');
            });
        },

        // 得到查询的参数
        queryParams : function (params) {
            $(tableOption.toolbar).find(".form-control").each(function (index, item) {
                if ($(this).attr("sName") !== undefined) {
                    tableOption.obj[$(this).attr("sName")] = $(this).val();
                }
            });
            console.log("obj: ", tableOption.obj);
            if ($(".search-list").length > 0) {
                $(".search-list").find(".form-control").each(function (index, item) {
                    if ($(this).attr("sName") !== undefined) {
                        tableOption.obj[$(this).attr("sName")] = $(this).val();
                    }
                });
            }
            var temp = {
                pageNum: params.offset / params.limit + 1,
                pageSize: params.limit,
                obj: JSON.stringify(tableOption.obj)
            };
            return temp;
        },

        // 设置表格按钮
        InitButton : function (row) {
            var html = '';
            btnOption.btnNeed = (btnOption.btnNeed === undefined) ? 'default' : btnOption.btnNeed;
            if (btnOption.btnNeed === 'default') {
                html += '<div class="btn-group">';
                html += '<button type="button" class="btn btn-white detail-btn" onclick="datailRow(\''
                    + row.id
                    + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
                html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
                    + row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
                html += '<button type="button" class="btn btn-white" onclick="deleteRow(\''
                    + row.id + '\')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
                html += '</div>';
            } else if (btnOption.btnNeed && btnOption.btnNeed !== 'default') {
                html += '<div class="btn-group">';
                $.each(btnOption.button, function (index, btns) {
                    btns.color = (btns.color === undefined || btns.color === '') ? 'btn-white' : btns.color;
                    btns.icon = (btns.icon === undefined || btns.icon === '') ? 'fa-circle' : btns.icon;
                    html += '<button class="detail-btn btn ' + btns.color + '" id="' + btns.id + '" onclick="' + btns.event + '(\'' + row.id + '\')"><i class="fa ' + btns.icon + '"></i>&nbsp;' + btns.text + '</button>';
                });
                html += '</div>';
            }
            return html;
        }
    };
    return oTableInit;
};
;(function () {
    // 弹框初始化及相关方法
    var LayerEvent = function(ele, options) {
        this.$element = ele;
        this.options = $.extend({}, LayerEvent.DEFAULTS, options);
        this.init();
    };
    LayerEvent.DEFAULTS = {
        title: '未命名弹出框',
        type: 1,
        containerSize: ['90%','96%'],
        scrollbar: false,
        button: 'default',
        onlyConfirm: false,
        submitHandle: false,
        submitUrl: ''
    };
    LayerEvent.prototype.init = function () {
        if (this.options.onlyConfirm === false || this.options.onlyConfirm === undefined){
            this.initContainer();
        }
    };
    // 弹框容器初始化---列表
    LayerEvent.prototype.initContainer = function () {
        var that = this;
        var btnText = [];
        var btnFunction = [];
        if (this.options.button === 'default'){
            this.options.button = [{
                text: '保存',
                event: 'that.layerSubmit()'
            }, {
                text: '关闭',
                event: 'that.layerClose()'
            }];
        }
        $.each(this.options.button, function (index, btns) {
            btnText.push(btns.text);
            btnFunction.push(btns.event);
        });
        layer.open({
            title: this.options.title,
            type : this.options.type,
            area : this.options.containerSize,
            scrollbar: false,
            zIndex : 100,
            btn : btnText,
            yes : function(index, layero) {
                btnFunction[0];
                that.$element.find('form').submit();
            },
            end : function() {
                btnFunction[1];
                that.resetLayerForm("close");
//                    $(data.formId).resetForm();
//                    endMethod(data.formId, "close");
            },
            content : this.$element
        });
        this.initFormPlugins();
    };
    // 确认弹框
    LayerEvent.prototype.initConfirm = function () {
        var that = this;
        var layeConfirm = layer.confirm('您确定要删除么？', {
            btn : [ '确定', '取消' ]
        },  function(index, layero) {
            $.post(that.options.submitUrl, {ids : that.options.dataTableId}, function(data) {
                layer.close(layeConfirm);
                $(that.options.dataTable).bootstrapTable('refresh');
                layer.msg(data);
            }, 'json');
        },function(index){
            // 取消的回调
        });
    };
//            LayerEvent.prototype.layerSubmit = function () {
//                console.log("Submit!");
//                layer.close(layer.index);
//            };
//            LayerEvent.prototype.layerClose = function () {
//                console.log("Close!");
//                layer.close(layer.index);
//            };
    // 初始化全局表单相关插件(select-chosen、datepicker、i-checks)
    LayerEvent.prototype.initFormPlugins = function () {
        var that = this;
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
        // 多选下拉框插件
        $('.is-multiple-select').select2({width:'100%',placeholder:'  == 请选择（可多选） =='});
        $(".is-multiple-select").change(function(){
            $(this).valid();
        });

        // checkbox、radio插件
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
        $('.i-checks').on('ifChanged', function(e){
            setTimeout(function () {
                $(e.currentTarget).siblings("input").blur();
            }, 0)
        });
        // checkbox取值--注意放在最下面
        $('.i-checks').on('ifChanged', function(event){
            // 遍历dom节点将数据放入上面的隐藏域中
            var isCheckData = [];
            // 回调函数执行顺序存在问题，先执行的回调函数方法，再改变样式
            setTimeout(function () {
                var that = event.currentTarget
                $(that).parents(".form-group").find("div.checked").each(function (index, item) {
                    isCheckData.push($(this).children("input").val());
                });
                $(that).siblings(".checkboxInput").val(isCheckData)
            }, 0)
        });
        // 设置表单逻辑字段
        $('.js-hasChild').on('change', function () {
            var parentName = $(this).attr('name');
            if ($(this).val() === '1') {
                $('[data-parent=' + parentName + ']').slideDown().find('input,select,textarea').prop('required', true).val('');
                $('[data-parent=' + parentName + ']').find('.is-multiple-select').select2('destroy');
                $('[data-parent=' + parentName + ']').find('input,select,textarea').each(function () {
                    $(this).valid();
                });
                $('[data-parent=' + parentName + ']').find('.is-multiple-select').select2({width:'100%',placeholder:'  == 请选择（可多选） =='});
            }else {
                $('[data-parent=' + parentName + ']').slideUp().find('input,select,textarea').prop('required', false).val('');
                $('[data-parent=' + parentName + ']').find('input,select,textarea').each(function () {
                    $(this).valid();
                });
            }
        });

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
    };
    // 重置表单
    LayerEvent.prototype.resetLayerForm = function (status) {
        var thisLayerForm = this.$element.find('form');
        // 当弹框被关闭的时候将所有加上的属性移除掉
        thisLayerForm.find("input").each(function () {
            $(this).removeAttr("disabled");
        });
        thisLayerForm.find("textarea").each(function () {
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
        thisLayerForm.find(".select-chosen").prop("disabled", false);
        thisLayerForm.find(".select-chosen").trigger("chosen:updated");
        thisLayerForm.find("select").each(function () {
            $(this).removeAttr("disabled");
        });
        thisLayerForm.find('.i-checks').iCheck('enable');
        // 将表单验证去掉
        thisLayerForm.validate().resetForm();
        setTimeout(function () {
            thisLayerForm.find("#linkageSelSelect_chosen").width('100%');
        },500);
        thisLayerForm.find(".form-group").each(function (item) {
            $(this).removeClass("has-error");
            $(this).removeClass("has-success");
            $(this).children("label").removeClass("has-success-tips has-error-tips");
            $(this).find(".chosen-container").removeClass("has-success-s has-error-s");
            $(this).find(".i-checks>div").removeClass("checked");
            // $(this).find(".help-block").remove();
        });
        // 将插件加上的属性去掉
        // $(".chosen-container").find("span").text("");
        thisLayerForm.find("select").val("");
        thisLayerForm.find(".select-chosen").trigger("chosen:updated");
        thisLayerForm.find(".i-checks").find("input").removeAttr("checked");
        thisLayerForm.find(".i-checks").find("div.checked").removeClass("checked");
        thisLayerForm.find(".is-multiple-select").val('').trigger("change");
        // 将相关下拉框选项隐藏
        $('.js-hasChild').each(function (index) {
            var parentName = $(this).attr('name');
            $('[data-parent=' + parentName + ']').addClass('ele-hide').find('input,select,textarea').prop('required', false).val('');
        });
        try{
            if(resetPage) {
                resetPage(status);
            };
        } catch (e) {};
    };
    // 禁用form表单
    LayerEvent.prototype.forbiddenForm = function () {
        var thisLayerForm = this.$element.find('form');
        // 然后将所有表单中的选项做一个禁选中操作
        thisLayerForm.find("input").each(function () {
            $(this).attr("disabled","disabled");
        });
        thisLayerForm.find("textarea").each(function () {
            $(this).attr("disabled","disabled");
        });
        // 判断是否存在树插件，禁止check改变
        try{
            if(zTree) {
                var allnodes = zTree.getNodes();
                for (var i in allnodes) {
                    zTree.setChkDisabled(allnodes[i], true, true, true);
                };
            };
        } catch (e) {}
        // 判断select
        thisLayerForm.find(".select-chosen").prop("disabled", true);
        thisLayerForm.find(".select-chosen").trigger("chosen:updated");
        thisLayerForm.find("select").each(function () {
            $(this).attr("disabled","disabled");
        });
        setTimeout(function(){
            thisLayerForm.find(".linkagesel-select-div").find(".LinkageSel").prop("disabled", true);
            thisLayerForm.find(".linkagesel-select-div").find(".LinkageSel").trigger("chosen:updated");
            thisLayerForm.find(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
            // i-ckeck将自动验证去掉
            thisLayerForm.find('.i-checks').closest(".form-group").removeClass("has-success");
        },500);
        // checkbox
        thisLayerForm.find('.i-checks').iCheck('disable');
        thisLayerForm.find('.form-group').removeClass('has-success has-error');
    };

    // 获取表格行数据
    LayerEvent.prototype.getRowData = function () {
        return $(this.options.dataTable).bootstrapTable('getRowByUniqueId', this.options.dataTableId);
    };
    // 查看详情和修改时载入数据
    LayerEvent.prototype.loadData = function (rowData) {
        var that = this;
        var obj = rowData;
        var key, value, tagName, type, arr;
        for (x in obj) {
            key = x;
            value = obj[x];
            $("[name='" + key + "'],[name='" + key + "[]']").each(function() {
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
                        // 清除四级联动查看及修改额外样式
                        // setTimeout(function(){
                        // 	$(".linkagesel-select-group-info ").children(".control-label").removeClass("has-error-tips has-success-tips");
                        // 	$(".linkagesel-select-group-info ").find(".chosen-container").removeClass("has-error-s has-success-s");
                        // },500);
                    }else if ($(this).hasClass('is-multiple-select')){
                        var values = new Array(); //定义一数组
                        values = value.split(",");
                        $(this).val(values).trigger("change");
                        $(this).closest('.form-group').removeClass('has-success has-error');
                    }else {
                        $(this).val(value);
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
                } else if (tagName === 'TABLE'){
                    var innerTableData = [];
                    $.each(value, function (index, item) {
                        innerTableData.push({'id': item.id});
                    });
                    $('#elementIds').val(JSON.stringify(innerTableData));
                }
            });
        }
        // 数据回显之后自动更新插件回显
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green'
        });
        // 判断相关下拉框选项
        $('.js-hasChild').each(function (index) {
            var parentName = $(this).attr('name');
            if ($(this).val() === '1') {
                $('[data-parent=' + parentName + ']').removeClass('ele-hide').find('input,select,textarea').prop('required', true);
                $('[data-parent=' + parentName + ']').find('.is-multiple-select').select2('destroy');
                $('[data-parent=' + parentName + ']').find('input,select,textarea').each(function () {
                    $(this).valid();
                });
                $('[data-parent=' + parentName + ']').find('.is-multiple-select').select2({width:'100%',placeholder:'  == 请选择（可多选） =='});
            }else {
                $('[data-parent=' + parentName + ']').slideUp().find('input,select,textarea').prop('required', false).val('');
            }
            // $('[data-parent=' + parentName + ']').find('input,select,textarea').each(function () {
            //     that.$element.find('form').validate().element($(this));
            // });
        });
    };
    LayerEvent.prototype.validate = function () {
        var that = this;
        this.$element.find('form').validate({
            ignore: ":hidden:not(select,input)",
            submitHandler: function(form){
                if (!that.options.submitHandle){
                    that.defaultSubmit();
                }else {
                    $(that.options.submitHandle);
                    that.resetLayerForm();
                }
            }
        });
        // 打开弹框验证
        this.$element.find('form').validate().form();
    };
    LayerEvent.prototype.defaultSubmit = function () {
        var that = this;
        // var layerSubmitBtn = this.$element.parents('.layui-layer').find('.layui-layer-btn0');
        this.$element.parents('.layui-layer').on('click', '.layui-layer-btn0', function () {
            $(this).hide();
            $(this).before('<button class="btn btn-primary a-disabled" disabled>操作中...</button>');
        });
        that.$element.find('form').ajaxSubmit({
            url : that.options.submitUrl,
            type : 'post',
            success : function(data){
                layer.close(layer.index);
                $(that.options.dataTable).bootstrapTable('refresh');
                layer.msg(data);
                that.resetLayerForm();
            },
            error : function(XmlHttpRequest, textStatus, errorThrown){
                layer.close(layer.index);
                $(that.options.dataTable).bootstrapTable('refresh');
                layer.msg("数据操作失败!");
                that.resetLayerForm();
            },
            resetForm : true
        });
        return false;
    };
    LayerEvent.prototype.openAdd = function () {
        this.validate();
    };
    LayerEvent.prototype.openDetail = function () {
        this.loadData(this.getRowData());
        this.forbiddenForm();
    };
    LayerEvent.prototype.openEdit = function () {
        this.validate();
        this.loadData(this.getRowData());
        // 验证初始化
        this.validate();
    };
    LayerEvent.prototype.deleteRow = function () {
        this.initConfirm();
    };
    // 导入
    LayerEvent.prototype.importData = function () {

    };
    // 导出
    LayerEvent.prototype.exportData = function () {

    };

    var allowedMethods = [
        'openAdd','openDetail','openEdit','deleteRow','exportData','importData','getRowData'
    ];
    // 命名空间
    $.fn.layerSetting = function (option) {
        if (typeof option === 'string') {
            if ($.inArray(option, allowedMethods) < 0) {
                throw new Error("Unknown method: " + option);
            }else {
                var layerEvent = new LayerEvent(this, Array.prototype.slice.call(arguments, 1)[0]);
                return layerEvent[option].apply(layerEvent);
            }
        } else if (typeof option === 'object' || !option) {
            var layerEvent2 = new LayerEvent(option);
        } else {
            $.error('参数错误');
        }
    };
    $.fn.layerSetting.methods = allowedMethods;

    $(document).on('click', '[data-click-event=add]', function () {

    });

})(jQuery);

/*** 公用功能---end ***/


/**********************************导入导出EXCEL开始**********************************************/
	
/*导入导出定义的全部变量 */
	var exportForm = '#exportForm';
	var importForm = '#importForm';
	var exportBox = '#exportData';
	var importBox = '#importData';
	
	$(function(){
		rowName();
		$($("#importData input[name='obj']")).val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
		//$("#obj").val($("#exportData input[name='obj']").val());//下载模板页面也加载完所有勾选字段
	})
	/*导出字段勾选开始*/
	$("#exportData input[type='checkbox']").click(function(){
		rowName();
	})
	
	//更改导出弹框复选框都选字段
	function rowName(){
		var obj = "";
		$("#exportData input[type='checkbox']:checked").each(function(){
			var nameEn = $(this).attr("nameEn");
			var nameCn = $(this).attr("nameCn");
			var inputType = $(this).attr("inputType");
			var inputValue = tf($(this).attr("inputValue")); //有关联数据时需要用到_,所以这边先装换一下
			
			obj += nameCn+"_"+nameEn+"_"+inputType+"_"+inputValue+",";
		})
		$("#exportData input[name='obj']").val(obj.substring(0,obj.length-1));
	}
	
	function tf(str){
		  var arr=str.split("_");
		  for(var i=1;i<arr.length;i++){
		    arr[i]=arr[i].charAt(0).toUpperCase()+arr[i].substring(1);
		  }
		  return arr.join("");
		};
	// 导出
	function exportData() {
		rowName();//重新点开时，吧勾选的重新复制一遍
		layer.open({
			type : 1,
			title : '确认要导出用户数据吗？',
			btn : [ '确定', '取消' ],
			scrollbar : false,
			area : [ '60%', '50%' ],
			zIndex : 100,
			yes : function(index, layero) {
				layer.close(index);
				$(exportForm).attr("action",uploaderServer+"/exportData");
				$(exportForm).submit();
			},
			end : function() {
				$(exportForm).resetForm();
			},
			content : $(exportBox)
		});
	}
	
	// 导入
	function importData(attributeType) {
		$("#file-message").html("");//清空上次上传后的提示信息
		$("#message").html("");
		console.log("attributeType:",attributeType)
	var importDataLayer	= layer.open({
			type : 1,
			title : '导入数据',
			scrollbar : false,
			area : [ '50%', '60%' ],
			zIndex : 100,
			success: function(layero, index){
				initUploader(importDataLayer,attributeType);
			},
			content : $(importBox),
			
		});
	}
	
	//下载模板
	function downloadTemplate(){
		//设置下载模板的请求路径
		$(importForm).attr("action",uploaderServer+"/downloadTemplate")
		$(importForm).submit();
	}
	
	//文件导入方法
	function initUploader(importDataLayer,attributeType){
		$("#filePicker").text("上传数据文件");
		uploader = WebUploader.create({
			// 选完文件后，是否自动上传。
			auto: true,
			// swf文件路径
			swf: '${ctxStatic}/js/plugins/webuploader/Uploader.swf',
			//传输的参数
			formData: {"attributeType":attributeType},//参数列表  
			// 文件接收服务端。
			server: uploaderServer+'/importData',
			// 选择文件的按钮。可选。
			pick: '#filePicker',
			// 只允许选择Excel文件。
			timeout: 0,
			duplicate :true ,
			accept: {
			    title: 'Excel',
			    extensions: 'xls,xlsx',
			    mimeTypes: 'Excel/*'
			}
		});
	
		uploader.on( 'fileQueued', function( file ) {
			var html = '<div style="display: inline-block; vertical-align: top;"><img src="${ctxStatic}/js/plugins/webuploader/img/excel.png"  alt="excel" /></div>'+
						'<div id="' + file.id + '" class="item" style="display: inline-block; vertical-align: top;">' +
				        '<h4 class="info">' + file.name + '</h4>' +
				    '</div>';
			$("#file-message").html(html);
		});
	
		// 文件上传过程中创建进度条实时显示。
		uploader.on( 'uploadProgress', function( file, percentage ) {
		    var $li = $( '#'+file.id ),
		        $percent = $li.find('.progress .progress-bar');
		    // 避免重复创建
		    if ( !$percent.length ) {
		        $percent = $('<div class="progress progress-striped active">' +
		          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
		          '</div>' +
		        '</div>').appendTo( $li ).find('.progress-bar');
		    }
		    $("#message").text("上传中");
		    $percent.css( 'width', percentage * 100 + '%' );
		});
		
		uploader.on("uploadAccept", function( file, data){
			if(data=="上传成功！"){
				$("#message").text(data).css("color", "#1ab394");
				layer.close(importDataLayer);
				$(tableId).bootstrapTable('refresh');
			}else{
				$("#message").text(data).css("color", "#ed5565");
			}
//		    if ( data.success=="0") {
//		        // 通过return false来告诉组件，此文件上传有错。
//		        return false;
//		    }
		});

	
		/*    完成上传完了，成功或者失败，先删除进度条。 */
		uploader.on( 'uploadComplete', function( file ) {
		     $( '#'+file.id ).find('.progress').fadeOut();
		});
		setTimeout(function () {
			uploader.refresh();
		}, 50)
	}
/**********************************导入导出EXCEL结束**********************************************/
