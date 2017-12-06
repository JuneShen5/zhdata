<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>表格</title>
        <%@ include file="/WEB-INF/views/include/head.jsp"%>
        <style>
            .verticle-mode-l {
                width: 16px;
                font-size: 16px;
                word-wrap: break-word;
                line-height: 1.2em;
                margin: 0 auto;
            }
            .column-head-position{
                position: relative!important;
            }
            .form-horizontal .form-group{
                margin: 0;
            }
            .main-form{
                border: solid 1px #e4eaec;
            }
            .main-form .control-label{
                padding: 0;
                text-align: center;
                line-height: 1.2em;
                display: table-cell;
                vertical-align: middle;
            }
            .main-form .form-group {
                display: flex;
                align-items: stretch;
                flex-wrap: wrap;
                border-bottom: solid 1px #e4eaec;
            }
            .main-form fieldset{
                text-align: center;
            }
            .main-form fieldset>legend{
                margin-bottom: 0;
                border-bottom: solid 1px #e4eaec;
                background-color: #e4eaec;
            }
            .column-title{
                padding: 0;
                height: 40px;
                display: table;
            }
            .column-content{
                padding-top: 3px;
                padding-bottom: 3px;
            }
            .form-contact{
                font-size: 0;
            }
            .form-input-inline{
                display: inline-block;
                width: 50%;
                font-size: 14px;
            }
            .border{
                border: 1px solid #ddd;
            }
        </style>
    </head>

    <body>
        <header>123</header>
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
                                    <div class="col-sm-1 column-title">
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
                                        <label for="fieldsetInput2_5_1" class="control-label">联系人<br>（姓名/手机）</label>
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
                                        <label for="fieldsetInput2_7_1" class="control-label">联系人<br>（姓名/手机）</label>
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
                                        <label for="fieldsetInput2_9_1" class="control-label">联系人<br>（姓名/手机）</label>
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
                                        <label for="fieldsetInput2_11" class="control-label">运维合同签署的到期时间</label>
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
                                        <label for="fieldsetInput4_8" class="control-label">虚拟化部署</label>
                                    </div>
                                    <div class="col-sm-5 column-content">
                                        <input type="text" class="form-control" id="fieldsetInput4_8" placeholder="虚拟化软件厂商名称">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-1 column-title">
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
                                    <div class="col-sm-1 col-sm-offset-1 column-title">
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
        <footer>321</footer>

        <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script>
        $(function () {
            var itemType = ['<div class="verticle-mode-l">基本信息</div>','<div class="verticle-mode-l">僵尸系统信息</div>','<div class="verticle-mode-l">系统整合信息</div>'];
            var itemData = [{
                itemType: '政务信息系统名称',
                itemName: '政务信息系统名称',
                itemContent: inputFormatter('input1')
            },{
                itemType: itemType[0],
                itemName: '审批部门',
                itemContent: inputFormatter('input2')
            },{
                itemType: itemType[0],
                itemName: '审批时间',
                itemContent: dateFormatter('input3')
            },{
                itemType: itemType[0],
                itemName: '业务功能',
                itemContent: inputFormatter('input4')
            },{
                itemType: itemType[0],
                itemName: '建设单位',
                itemContent: inputFormatter('input5')
            },{
                itemType: itemType[0],
                itemName: '承建单位',
                itemContent: inputFormatter('input6')
            },{
                itemType: itemType[0],
                itemName: '运维单位',
                itemContent: inputFormatter('input7')
            },{
                itemType: itemType[0],
                itemName: '建成时间',
                itemContent: dateFormatter('input8')
            },{
                itemType: itemType[0],
                itemName: '资金与运维',
                itemContent: '-'
            },{
                itemType: itemType[0],
                itemName: '系统类别',
                itemContent: selectFormatter('input10', ['应用层系统','应用支撑层系统','基础设施层系统'])
            },{
                itemType: itemType[1],
                itemName: '是否为僵尸信息系统',
                itemContent: '-'
            },{
                itemType: itemType[1],
                itemName: '使用对象',
                itemContent: '-'
            },{
                itemType: itemType[1],
                itemName: '使用频度',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '系统部署位置',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '涉密分类',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '信息安全等保级别',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '系统已接入的网络类型',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '是否与其他系统对接',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '虚拟化部署',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '数据备份',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '应用容灾',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '是否申请暂缓整合',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '暂缓整合说明原因',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '升级需求',
                itemContent: '-'
            },{
                itemType: itemType[2],
                itemName: '升级需求详细说明',
                itemContent: '-'
            },{
                itemType: '备注',
                itemName: '备注',
                itemContent: '-'
            },{
                itemType: '说明',
                itemName: '说明',
                itemContent: '说明'
            }];
            $('#mainTable').bootstrapTable({
                data: itemData,
                classes: 'table',
                showHeader: false,
                onLoadSuccess: function(){  //加载成功时执行
                    // 时间插件
                    $('.datepicker').datepicker({
                        todayBtn: "linked",
                        keyboardNavigation: false,
                        forceParse: false,
                        calendarWeeks: true,
                        autoclose: true,
                        todayHighlight:true
                    });
                }
            });
            mergeCells(itemData, "itemType", 1, $('#mainTable'));
        });

        /**
         * 操作区域表单输入框设置
         * @param data  原始数据（在服务端完成排序）
         * @param fieldName 合并属性名称
         * @param colspan   合并列
         * @param target    目标表格对象
         */
        function inputFormatter(idName, frontLabel, backLabel) {
            idName = arguments[0]?arguments[0]:'';
            frontLabel = arguments[1]?arguments[1]:'';
            backLabel = arguments[2]?arguments[2]:'';
            var html = '';
            html += '<div class="form-group">';
            if (frontLabel === '' && backLabel === ''){
                html += '<div class="col-sm-12">';
                html += '<input type="text" class="form-control" id="firstname" placeholder="请输入名字">';
                html += '</div>';
            }else if (frontLabel !== '' && backLabel === ''){
                html += '<label for="'+idName+'" class="col-sm-2 control-label">'+frontLabel+'</label>';
                html += '<div class="col-sm-10">';
                html += '<input type="text" class="form-control" id="'+idName+'" placeholder="请输入'+frontLabel+'">';
                html += '</div>';
            }else if(frontLabel === '' && backLabel !== ''){
                html += '<div class="col-sm-10">';
                html += '<input type="text" class="form-control" id="'+idName+'" placeholder="请输入'+backLabel+'">';
                html += '</div>';
                html += '<label for="'+idName+'" class="col-sm-2 control-label">'+backLabel+'</label>';
            }else if(frontLabel !== '' && backLabel !== ''){
                html += '<label for="'+idName+'" class="col-sm-2 control-label">'+frontLabel+'</label>';
                html += '<div class="col-sm-8">';
                html += '<input type="text" class="form-control" id="'+idName+'" placeholder="请输入'+frontLabel+'">';
                html += '</div>';
                html += '<label for="'+idName+'" class="col-sm-2 control-label">'+backLabel+'</label>';
            }
            html += '</div>';
            return html;
        }
        function dateFormatter(idName) {
            var html = '';
            html += '<div class="form-group">'
            html += '<div class="col-sm-12">'
            html += '<input type="text" id="'+idName+'" class="form-control datepicker" readonly="readonly" placeholder="请选择日期">'
            html += '</div></div>';
            return html;
        }
        function selectFormatter(idName, selectData) {
            var html = '';
            html += '<div class="form-group">';
            html += '<select id="'+idName+'" class="form-control">';
            html += '<option value=0>请选择</option>';
            $.each(selectData, function (index, optionData) {
                html += '<option value="'+(index+1)+'">'+optionData+'</option>';
            });
            html += '</select>';
            html += '</div>';
            return html;
        }

        /**
         * 合并单元格
         * @param data  原始数据（在服务端完成排序）
         * @param fieldName 合并属性名称
         * @param colspan   合并列
         * @param target    目标表格对象
         */
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
//                console.log(prop,sortMap[prop])
            }
            var index = 0;
            for(var prop in sortMap){
                var count = sortMap[prop] * 1;
                $(target).bootstrapTable('mergeCells',{index:index, field:fieldName, colspan: colspan, rowspan: count}); // 合并相同行
                index += count;
            }
            $(target).bootstrapTable('mergeCells',{index:0, field:'itemType', colspan: 2, rowspan: 1}); // 合并相同列
            $(target).bootstrapTable('mergeCells',{index:data.length-2, field:'itemType', colspan: 2, rowspan: 1}); // 合并说明列
            $(target).bootstrapTable('mergeCells',{index:data.length-1, field:'itemType', colspan: 3, rowspan: 1}); // 合并说明列
        }
        // 时间插件
        $('.datepicker').datepicker({
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: true,
            autoclose: true,
            todayHighlight:true
        });
    </script>
    </body>
</html>