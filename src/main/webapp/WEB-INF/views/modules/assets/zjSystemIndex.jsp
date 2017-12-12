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
                                   <!--  <button type="button" id="searchMoreFor"
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
                            部门在建政务信息系统调查表
                        </h1>
                        <form role="form" id="mainForm" class="form-horizontal main-form">
                            <input type="text" name="id" class="hide">
                            <!-- 系统名称 -->
                            <fieldset>
                                <legend>系统名称</legend>
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
                                        <textarea name="ywgn" class="form-control" rows="3" placeholder="请描述系统功能、使用效益等"  required></textarea>
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
                                            <input type="text" isMobile="true" class="form-control" name="jsdwlxdh" placeholder="请输入手机号" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">建设预算/合同金额</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" digits="true" class="form-control" name="xtjsys" placeholder="系统建设预算/合同金额（万元）" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">资金来源</label>
                                    </div>
                                    <div class="col-sm-10 form-contact column-content">
                                        <select name="zjly" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('capital_source')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
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
                            <!-- 项目建设状态 -->
                            <fieldset>
                                <legend>项目建设状态</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">系统当前建设阶段</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="dqjsjd" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('construction_stage')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>

                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">建设方式</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="jsfs" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('construction_mode')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
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
                                            <input type="text" isMobile="true" class="form-control" name="cjdwlxdh" placeholder="请输入手机号" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">合同签署时间</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="htqssj" readonly="readonly" placeholder="请选择合同签署时间" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">合同约定完成时间</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="htydwcsj" readonly="readonly" placeholder="请选择合同约定完成时间" required>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">签署的维保到期日期</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control datepicker" name="htqsdwbdqsj" readonly="readonly" placeholder="请选择维保到期日期" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">已付合同金额或比例</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="yfhtje" placeholder="请输入已付合同金额或比例" required>
                                    </div>
                                </div>
                            </fieldset>
                            <!-- 项目建设必要性说明 -->
                            <fieldset>
                                <legend>项目建设必要性说明</legend>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">项目建设立项依据</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="xtjsyj" placeholder="请输入项目建设立项依据，如国家政策、需求" required>
                                    </div>
                                </div>

                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title">
                                        <label class="control-label">建设预期目标</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="jsyqmb" placeholder="建设预期目标，如经济效益、民生效益等" required>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">建设项目的紧迫程度</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <select name="jsxmjpcd" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('project_urgency')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">紧迫程度简要说明</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="jpcdsm" placeholder="紧迫程度简要说明" required>
                                    </div>
                                </div>

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title">
                                        <label class="control-label">预估使用对象</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="ygsydx" placeholder="请输入预估使用对象" required>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-2 column-title form-border-left">
                                        <label class="control-label">预估使用规模</label>
                                    </div>
                                    <div class="col-sm-10 column-content">
                                        <input type="text" class="form-control" name="ygsygm" placeholder="请输入预估使用规模（注册用户数/个）" required>
                                    </div>
                                </div>

                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title form-border-left">
                                        <label class="control-label">原计划投入使用时间</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control datepicker" name="yjhtrsysj" readonly="readonly" placeholder="原计划投入使用时间" required>
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
                                        <select name="bswz" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('deploy_location')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
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
                                        <label class="control-label">信息安全等保级别</label>
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
                                        <label class="control-label">计划接入网络类型</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <input type="text" class="form-control" name="jhjrwllx" placeholder="计划接入网络类型" required>
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
                                    <div class="col-sm-2 column-title form-border-left">
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
                                            <label class="control-label">数据备份量（GB）</label>
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
                                        <label class="control-label">系统后续计划</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <select name="xthxjh" class="form-control" required>
							                    <option value="">== 请选择 ==</option>
							                     <c:forEach var="dict" items="${fns:getDictList('follow-up')}">
								                 <option value="${dict.value}">${dict.label}</option>
							               </c:forEach>
						                   </select>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 column-title column-title-multiple">
                                        <label class="control-label">系统继续建设原因</label>
                                    </div>
                                    <div class="col-sm-11 column-content">
                                        <textarea name="xtjxjsyy" class="form-control" rows="3" placeholder="说明继续建设的必要性、对接要求等" required></textarea>
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
            url: '${ctx}/assets/zjSystem/list',
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
            container: '#layer_form',
            button: 'default',
            dataTable: '#yjSystemTable',
            dataTableId: '',
            submitUrl: '${ctx}/assets/zjSystem/save'
        };
        // 新增
        function openAdd() {
            $().layerSetting('openAdd', options);
        }

        function datailRow(id) {
            options.title = '详情';
            options['button'] = [];
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $().layerSetting('openDetail', options);
        }
        function editRow(id) {
            options.title = '修改';
            options['button'] = 'default';
            options.dataTableId = id;
//            var row = $(options.dataTable).bootstrapTable('getRowByUniqueId', id);
            $().layerSetting('openEdit', options);
        }
        var deleteOptions = {
            onlyConfirm: true,
            submitUrl: '${ctx}/assets/zjSystem/delete',
            dataTable: '#yjSystemTable'
        };
        function deleteRow(id) {
            deleteOptions.dataTableId = id;
            $().layerSetting('deleteRow', deleteOptions);
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
            $().layerSetting('deleteRow', deleteOptions);
        }
    </script>

    </body>
</html>
