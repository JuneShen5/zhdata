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
                                            onclick="$('#yjSystemTable').bootstrapTable('refresh');"
                                            class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
                             <!--        <button type="button" id="searchMoreFor"
                                            onclick="$('.search-list').slideToggle();"
                                            class="btn btn-primary btn-drop"><span class="caret"></span></button> -->
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="text-center">
                                    <a data-toggle="modal" class="btn btn-green"
                                       onclick="openAdd();"><i class="fa fa-plus-square-o"></i> 新增</a>
                                    <button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
                                    <button class="btn btn-purple" type="button" onclick="importData();"><i class='fa fa-sign-in'></i> Excel导入</button>
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
                                <th data-field="spbm">审批部门</th>
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
        <div class="main">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 column">
                        <h1 class="form-main-title">
                            部门已建政务信息系统调查表
                        </h1>
                        <form role="form" id="mainForm" class="form-horizontal main-form">
                            <input type="text" name="id" class="hide">
                            <!-- 系统信息 -->
                            <fieldset>
                                <legend>系统信息</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-2 column-title">
                                        <label class=" control-label">单位名称</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="dwmc" placeholder="请输入单位名称" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-2 column-title">
                                        <label class=" control-label">政务信息系统名称</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="xtmc" placeholder="请输入政务信息系统名称" required>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 基本信息 -->
                            <fieldset>
                                <legend>基本信息</legend>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">审批部门</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="spbm" placeholder="请输入审批部门" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">审批时间</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="spsj" readonly="readonly" placeholder="请选择审批时间" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">业务功能</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea name="ywgn" class="form-control" rows="3" placeholder="请量化描述系统功能、使用效果等" required></textarea>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">建设单位</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="jsdwmc" placeholder="请输入建设单位" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content">
                                            <input type="text" class="form-control" name="jsdwlxr" placeholder="请输入姓名" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content form-border-left">
                                            <input type="text" class="form-control" isMobile="true" name="jsdwlxdh" placeholder="请输入手机号" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">承建单位</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="cjdwmc" placeholder="请输入承建单位" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content">
                                            <input type="text" class="form-control" name="cjdwlxr" placeholder="请输入姓名" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content form-border-left">
                                            <input type="text" class="form-control" isMobile="true" name="cjdwlxdh" placeholder="请输入手机号" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">运维单位</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="ywdwmc" placeholder="请输入运维单位" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">联系人<br>(姓名/手机)</label>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content">
                                            <input type="text" class="form-control" name="ywdwlxr" placeholder="请输入姓名" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="form-contact column-content form-border-left">
                                            <input type="text" class="form-control" isMobile="true" name="ywdwlxdh" placeholder="请输入手机号" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">建成时间</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="jcsj" readonly="readonly" placeholder="请选择建成时间" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">合同签署到期时间</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="ywhtqsdqsj" readonly="readonly" placeholder="请选择到期时间" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">资金</label>
                                    </div>
                                    <div class="form-group col-sm-3 form-border-nobottom">
                                        <div class="col-sm-4 column-title">
                                            <label class="control-label">建设金额</label>
                                        </div>
                                        <div class="col-sm-8 column-content">
                                            <input type="text" digits="true" class="form-control" name="jsje" placeholder="单位:万元" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-4 form-border-nobottom">
                                        <div class="col-sm-3 column-title form-border-left">
                                            <label class="control-label">资金来源</label>
                                        </div>
                                        <div class="col-sm-9 column-content">
                                            <input type="text" class="form-control" name="zjly" placeholder="请输入资金来源" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-4 form-border-nobottom">
                                        <div class="col-sm-3 column-title form-border-left">
                                            <label class="control-label">建设方式</label>
                                        </div>
                                        <div class="col-sm-9 column-content">
                                            <select name="jsfs" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('construction_mode')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">运维</label>
                                    </div>
                                    <div class="form-group col-sm-3 form-border-nobottom">
                                        <div class="col-sm-4 column-title">
                                            <label class="control-label">年度运维金额</label>
                                        </div>
                                        <div class="col-sm-8 column-content">
                                            <input type="text" digits="true" class="form-control" name="ndywje" placeholder="单位:万元" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-4 form-border-nobottom">
                                        <div class="col-sm-3 column-title form-border-left">
                                            <label class="control-label">资金来源</label>
                                        </div>
                                        <div class="col-sm-9 column-content">
                                            <input type="text" class="form-control" name="ywzjly" placeholder="请输入资金来源" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-4 form-border-nobottom">
                                        <div class="col-sm-3 column-title form-border-left">
                                            <label class="control-label">运维方式</label>
                                        </div>
                                        <div class="col-sm-9 column-content">
                                            <select name="ywfs" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('operational_way')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">系统类别</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="xtlb" placeholder="请输入系统类别" required>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 僵尸系统信息 -->
                            <fieldset>
                                <legend>僵尸系统信息</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">是否为僵尸信息系统</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="sfjsxt" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">使用对象</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="sydx" placeholder="请输入使用对象，如政府单位内部，注册用户数_个" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">使用频度</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="sypd" placeholder="请输入使用频度，如每月系统使用用户量" required>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 系统整合信息 -->
                            <fieldset>
                                <legend>系统整合信息</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">系统部署位置</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="bswz" placeholder="请输入系统部署位置" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">涉密分类</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="smfl" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('secret-related ')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">信息安全登保级别</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="aqjb" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('security_level')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">已接入的网络类型</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="yjrwllx" placeholder="请输入系统已接入的网络类型" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">使用范围</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="syfw" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('usable_range')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">是否与其他系统对接</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <select name="sfyqtxtdj" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('system_integrating')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">对接其它系统名称</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="djqtxtmc" placeholder="请输入对接其它系统名称" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">虚拟化部署</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <select name="sfxnhbs" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">虚拟化软件厂商名</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="xnhrjmc" placeholder="虚拟化软件厂商名" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">数据备份</label>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="col-sm-2 column-title form-border-bottom">
                                            <label class="control-label">是否有备份</label>
                                        </div>
                                        <div class="col-sm-10 column-content form-border-bottom">
                                            <select name="sfybf" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('is_have')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-6 form-border-nobottom">
                                        <div class="col-sm-2 column-title form-border-left form-border-bottom">
                                            <label class="control-label">备份方式</label>
                                        </div>
                                        <div class="col-sm-10 column-content form-border-bottom">
                                            <select name="bffs" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('backup_mode')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-5 form-border-nobottom">
                                        <div class="col-sm-2 column-title">
                                            <label class="control-label">备份点位置</label>
                                        </div>
                                        <div class="col-sm-10 column-content">
                                            <input type="text" class="form-control" name="bfdwz" placeholder="备份点位置" required>
                                        </div>
                                    </div>
                                    <div class="form-group col-sm-6 form-border-nobottom">
                                        <div class="col-sm-2 column-title form-border-left">
                                            <label class="control-label">数据备份量</label>
                                        </div>
                                        <div class="col-sm-10 column-content">
                                            <input type="text" digits="true" class="form-control" name="sjbfl" placeholder="数据备份量（GB）" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">应用容灾</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="yyrz" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('is_have')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">是否申请暂缓整合</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="sfsqzhzh" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">暂缓整合原因说明</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea name="zhzhyy" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">升级需求</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="sjxq" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('is_have')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">升级需求详细说明</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea name="sjxqsm" class="form-control" rows="3" placeholder="请说明升级后功能、覆盖面、性能、对接等要求"></textarea>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 备注与说明 -->
                            <fieldset>
                                <legend>备注与说明</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">备注</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea name="remarks" class="form-control" rows="3"></textarea>
                                    </div>
                                </div>
                                <!--<div class="form-group">
                                    <div class="col-sm-1 column-title">
                                        <label for="fieldsetInput5_2" class="control-label">使用对象</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="fieldsetInput5_2" placeholder="请输入使用对象">
                                    </div>
                                </div>-->
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
            containerSize: ['90%','96%'],
            button: 'default',
            dataTable: '#yjSystemTable',
            dataTableId: '',
            submitUrl: '${ctx}/assets/yjSystem/save'
        };
        // 新增
        function openAdd() {
            options.title = '新增';
            options['button'] = 'default';
            options.dataTableId = '';
            $('#layer_form').layerSetting('openAdd', options);
        }
        // 详情
        function datailRow(id) {
            options.title = '详情';
            options['button'] = [];
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $('#layer_form').layerSetting('openDetail', options);
        }
        // 修改
        function editRow(id) {
            options.title = '修改';
            options['button'] = 'default';
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $('#layer_form').layerSetting('openEdit', options);
        }
        // 删除
        var deleteOptions = {
            onlyConfirm: true,
            submitUrl: '${ctx}/assets/yjSystem/delete',
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
            });
            ids = JSON.stringify(ids);
            deleteOptions.dataTableId = ids.slice(1, ids.length - 1);
            $('#layer_form').layerSetting('deleteRow', deleteOptions);
        }
        $(function () {
            // 是否为僵尸系统相关表设置
            $('select[name="sfjsxt"]').on('change', function () {
                if ($(this).val() === '0'){
                    $('input[name="sydx"],input[name="sypd"]').prop('required',false).closest('.form-group').removeClass('has-error has-success');
                }else {
                    $('input[name="sydx"],input[name="sypd"]').prop('required',true);
                }
                $(options.container).validate().form()
            });
        });
    </script>

    </body>
</html>
