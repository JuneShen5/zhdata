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
                                            onclick="$('#systemTable').bootstrapTable('refresh');"
                                            class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
                                    <button type="button" id="searchMoreFor"
                                            onclick="$('.search-list').slideToggle();"
                                            class="btn btn-primary btn-drop"><span class="caret"></span></button>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="text-center">
                                    <a data-toggle="modal" class="btn btn-green"
                                       onclick="openAdd();"><i class="fa fa-plus-square-o"></i> 新增</a>
                                    <button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
                                    <button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
                                    <button class="btn btn-yellow" type="button" onclick="deleteAll();"><i class='fa fa-trash-o'></i> 批量删除</button>
                                    <button class="btn btn-blue other-url" type="button" id="272" url="${ctx}/settings/attribute?type=1" name="信息系统配置"><i class='fa fa-cog'></i> 配置</button>
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
                                <th data-field="dwmc">责任部门</th>
                                <th data-field="Score" data-formatter="initTableButton">操作</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <div id="layer_form" style="display: none" class="ibox-content" >
        <div class="main">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 column">
                        <h1>
                            部门已建政务信息系统调查表
                        </h1>
                        <!--<form>
                            <table class="table" id="mainTable">
                                <thead>
                                    <tr>
                                        <th data-field="itemType" data-valign="middle" data-class="col-sm-1 column-head-position">类别</th>
                                        <th data-field="itemName" data-valign="middle" data-class="col-sm-2">项目名称</th>
                                        <th data-field="itemContent">项目详情</th>
                                    </tr>
                                </thead>
                            </table>
                        </form>-->
                        <form role="form" id="mainForm" class="form-horizontal main-form">
                            <!-- 系统名称 -->
                            <fieldset>
                                <legend>系统名称</legend>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="sysName" class=" control-label">政务信息系统名称</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="sysName" placeholder="请输入政务信息系统名称">
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 基本信息 -->
                            <fieldset>
                                <legend>基本信息</legend>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_1" class="control-label">审批部门</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_1" placeholder="请输入审批部门">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_2" class="control-label">审批时间</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control datepicker" id="fieldsetInput2_2" readonly="readonly" placeholder="请选择审批时间">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label for="fieldsetInput2_3" class="control-label">业务功能</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea id="fieldsetInput2_3" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_4" class="control-label">建设单位</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_4" placeholder="请输入建设单位">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_5_1" class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="col-sm-5 form-contact column-content">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_5_1" placeholder="请输入姓名">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_5_2" placeholder="请输入手机号">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_6" class="control-label">承建单位</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_6" placeholder="请输入承建单位">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_7_1" class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="col-sm-5 form-contact column-content">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_7_1" placeholder="请输入姓名">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_7_2" placeholder="请输入手机号">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_8" class="control-label">运维单位</label>
                                    </div>
                                    <div class="col-sm-5">
                                        <input type="text" class="form-control" id="fieldsetInput2_8" placeholder="请输入运维单位">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_9_1" class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="col-sm-5 form-contact column-content">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_9_1" placeholder="请输入姓名">
                                        <input type="text" class="form-control form-input-inline" id="fieldsetInput2_9_2" placeholder="请输入手机号">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_10" class="control-label">建成时间</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control datepicker" id="fieldsetInput2_10" readonly="readonly" placeholder="请选择建成时间">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_11" class="control-label">运维合同签署到期时间</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control datepicker" id="fieldsetInput2_11" readonly="readonly" placeholder="请选择到期时间">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">资金</label>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_12" class="control-label">建设金额：</label>
                                    </div>
                                    <div class="col-sm-3 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_12" placeholder="请输入建设金额（单位：万元）">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_13" class="control-label">资金来源</label>
                                    </div>
                                    <div class="col-sm-3 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_13" placeholder="请输入资金来源">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_14" class="control-label">建设方式</label>
                                    </div>
                                    <div class="col-sm-2 column-content">
                                        <select class="form-control" id="fieldsetInput2_14">
                                            <option value="">请选择</option>
                                            <option value="1">自建（自有产权）</option>
                                            <option value="2">购买服务（无产权）</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">运维</label>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_15" class="control-label">年度运维金额：</label>
                                    </div>
                                    <div class="col-sm-3 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_15" placeholder="请输入年度运维金额（单位：万元）">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_16" class="control-label">资金来源</label>
                                    </div>
                                    <div class="col-sm-3 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput2_16" placeholder="请输入资金来源">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_17" class="control-label">运维方式</label>
                                    </div>
                                    <div class="col-sm-2 column-content">
                                        <select class="form-control" id="fieldsetInput2_17">
                                            <option value="">请选择</option>
                                            <option value="1">自主运维</option>
                                            <option value="2">外包服务</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput2_18" class="control-label">系统类别</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput2_18">
                                            <option value="">请选择</option>
                                            <option value="1">应用层系统</option>
                                            <option value="2">应用支撑层系统</option>
                                            <option value="3">基础设施层系统</option>
                                        </select>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 僵尸系统信息 -->
                            <fieldset>
                                <legend>僵尸系统信息</legend>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput3_1" class="control-label">是否为僵尸信息系统</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput3_1">
                                            <option value="">请选择</option>
                                            <option value="1">否</option>
                                            <option value="2">是（如是僵尸系统下表内容无需填写）</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput3_2" class="control-label">使用对象</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput3_2" placeholder="请输入使用对象">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput3_3" class="control-label">业务功能</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput3_3" placeholder="请输入业务功能">
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 系统整合信息 -->
                            <fieldset>
                                <legend>系统整合信息</legend>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_1" class="control-label">部署位置</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_1" placeholder="请输入部署位置">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_2" class="control-label">涉密分类</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput4_2">
                                            <option value="">请选择</option>
                                            <option value="1">涉密</option>
                                            <option value="2">非涉密</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_3" class="control-label">业务功能</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput4_3">
                                            <option value="">请选择</option>
                                            <option value="1">三级</option>
                                            <option value="2">二级</option>
                                            <option value="3">未定级</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_4" class="control-label">系统已接入的网络类型</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_4" placeholder="请输入系统已接入的网络类型">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_5" class="control-label">使用范围</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput4_5">
                                            <option value="">请选择</option>
                                            <option value="1">单位内部</option>
                                            <option value="2">国家垂直</option>
                                            <option value="3">覆盖省级</option>
                                            <option value="4">覆盖省市</option>
                                            <option value="5">覆盖省县</option>
                                            <option value="6">覆盖省县以下</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_6" class="control-label">是否与其他系统对接</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput4_6">
                                            <option value="">请选择</option>
                                            <option value="1">是，对接省政务信息信息共享平台</option>
                                            <option value="2">是，对接其他系统</option>
                                            <option value="3">否，无对接</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_7" class="control-label">虚拟化部署</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <select class="form-control" id="fieldsetInput4_7">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_8" class="control-label">软件厂商名称</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_8" placeholder="虚拟化软件厂商名">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label for="fieldsetInput4_9" class="control-label">数据备份</label>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_10" class="control-label">是否备份</label>
                                    </div>
                                    <div class="col-sm-4 column-content">
                                        <select class="form-control" id="fieldsetInput4_9">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_10" class="control-label">数据备份方式</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <select class="form-control" id="fieldsetInput4_10">
                                            <option value="">请选择</option>
                                            <option value="1">本地</option>
                                            <option value="2">异地</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_11" class="control-label">备份点位置</label>
                                    </div>
                                    <div class="col-sm-4 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_11" placeholder="备份点位置">
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_12" class="control-label">数据备份量</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_12" placeholder="数据备份量（GB）">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_13" class="control-label">应用容灾</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select class="form-control" id="fieldsetInput4_13">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_14" class="control-label">是否申请暂缓整合</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <select class="form-control" id="fieldsetInput4_14">
                                            <option value="">请选择</option>
                                            <option value="1">是</option>
                                            <option value="2">否</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_15" class="control-label">暂缓整合原因说明</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_15" placeholder="备份点位置">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_16" class="control-label">升级需求</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <select class="form-control" id="fieldsetInput4_16">
                                            <option value="">请选择</option>
                                            <option value="1">无</option>
                                            <option value="2">有</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput4_17" class="control-label">升级需求详细说明</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_17" placeholder="升级需求详细说明">
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 备注与说明 -->
                            <fieldset>
                                <legend>备注与说明</legend>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput5_1" class="control-label">备注</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea id="fieldsetInput5_1" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput5_2" class="control-label">使用对象</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput5_2" placeholder="请输入使用对象">
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script src="${ctxStatic}/js/common/common-h.js"></script>
    <script>
        <%--var tableId = '#yjSystemTable';--%>
        <%--var layerId = '#layer_form';--%>
        <%--var formId = '#mainForm'; //form id--%>
        <%--var toolbar = '#toolbar';--%>
        <%--var url = '${ctx}/assets/yjSystem/';--%>
        <%--var obj = {--%>
        <%--};--%>
        <%--var editTitle = "已建系统修改";--%>
        <%--var detailTitle = "已建系统详情";--%>
        <%--// 时间插件--%>
        <%--$('.datepicker').datepicker({--%>
            <%--todayBtn: "linked",--%>
            <%--keyboardNavigation: false,--%>
            <%--forceParse: false,--%>
            <%--calendarWeeks: true,--%>
            <%--autoclose: true,--%>
            <%--todayHighlight:true--%>
        <%--});--%>


        // 1.设置Table参数和表格按钮
        var mainTableOption = {
            tableId: 'yjSystemTable',
            url: '${ctx}/assets/yjSystem/list',
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
            containerSize: ['90%','90%'],
            container: '#layer_form',
            button: 'default',
            dataTable: '#yjSystemTable',
            dataTableId: '',
            submitUrl: '${ctx}/assets/yjSystem/save'
        };
        function openAdd() {
            $().layerSetting('openAdd', options);
        }
    </script>

    </body>
</html>