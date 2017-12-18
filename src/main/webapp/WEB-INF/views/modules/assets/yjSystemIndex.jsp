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
                <fieldset>
                    <legend>基本信息</legend>
                    <!-- <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class=" control-label">单位名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="dwmc" placeholder="请输入单位名称" required>
                        </div>
                    </div> -->
				<c:set var="user" value="${fns:getCurrentUser()}" />
				<div class="form-group">
					<label class="col-sm-3 control-label layerTips"
						data-tips-text="例：XX市XX局 / 单位人事管理 / 统计分析">单位名称：</label>
					<c:choose>
						<c:when test="${user.roleId==1}">
							<div class="col-sm-7">
								<input id="" name="companyId"
									class="form-control citySelId hide" type="text"> <input
									id="" name="companyName" class="form-control citySel"
									type="text" placeholder="请选择单位名称" ReadOnly required />
								<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
							</div>
						</c:when>
						<c:otherwise>
							<div class="col-sm-7">
								<input type="text" name="companyName" class="form-control"
									value="${fns:queryCompanyName()}" required> <input
									type="text" name="companyId" class="form-control hide"
									value="${user.companyId}">
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<div class="col-sm-3 column-title">
						<label class=" control-label">政务信息系统名称</label>
					</div>
					<div class="col-sm-7 column-content">
						<input type="text" class="form-control" hasNoSpace="true"
							name="xtmc" placeholder="请输入政务信息系统名称" required>
					</div>
				</div>
				<div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">审批部门</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="spbm" placeholder="请输入审批部门" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">审批时间</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control datepicker" name="spsj" readonly="readonly" placeholder="请选择审批时间" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title column-title-multiple">
                            <label class="control-label">业务功能</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <textarea name="ywgn" class="form-control" hasNoSpace="true" rows="3" placeholder="请量化描述系统功能、使用效果等" required></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">建设单位</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="jsdwmc" placeholder="请输入建设单位" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人姓名</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="jsdwlxr" placeholder="请输入姓名" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人手机号</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content form-border-left">
                                <input type="text" class="form-control" isMobile="true" name="jsdwlxdh" placeholder="请输入手机号" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">承建单位</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="cjdwmc" placeholder="请输入承建单位" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人姓名</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="cjdwlxr" placeholder="请输入姓名" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人手机号</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content form-border-left">
                                <input type="text" class="form-control" isMobile="true" name="cjdwlxdh" placeholder="请输入手机号" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">运维单位</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ywdwmc" placeholder="请输入运维单位" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人姓名</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="ywdwlxr" placeholder="请输入姓名" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">联系人手机号</label>
                        </div>
                        <div class="col-sm-7 form-border-nobottom">
                            <div class="form-contact column-content form-border-left">
                                <input type="text" class="form-control" isMobile="true" name="ywdwlxdh" placeholder="请输入手机号" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">建成时间</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control datepicker" name="jcsj" readonly="readonly" placeholder="请选择建成时间" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">运维合同签署到期时间</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control datepicker" name="ywhtqsdqsj" readonly="readonly" placeholder="请选择运维合同签署到期时间" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">建设金额（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" isNonnegative="true" class="form-control" name="jsje" placeholder="单位:万元" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">资金来源</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zjly" placeholder="请输入资金来源" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">建设方式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="jsfs" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                 <c:forEach var="dict" items="${fns:getDictList('construction_mode')}">
                                 <option value="${dict.value}">${dict.label}</option>
                           </c:forEach>
                           </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">年度运维金额（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" isNonnegative="true" class="form-control" name="ndywje" placeholder="单位:万元" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">资金来源</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ywzjly" placeholder="请输入资金来源" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">运维方式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="ywfs" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                 <c:forEach var="dict" items="${fns:getDictList('operational_way')}">
                                 <option value="${dict.value}">${dict.label}</option>
                           </c:forEach>
                           </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">系统类别</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="xtlb" placeholder="请输入系统类别" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据增长情况（单位：M）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="sjzzqk" placeholder="按每月业务发生估算数据增长量（单位：M）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">存量数据年限</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="clsjnx" placeholder="数据积累年数，填写数字（X年）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">存量数据有效期</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="clsjyxq" placeholder="五年/十年/永久等" required>
                        </div>
                    </div>
                </fieldset>
                <!-- 僵尸系统信息 -->
                <fieldset>
                    <legend>僵尸系统信息</legend>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">是否为僵尸信息系统</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sfjsxt" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">使用对象</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sydx" placeholder="请输入使用对象，如政府单位内部，注册用户数_个" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">使用频度</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sypd" placeholder="请输入使用频度，如每月系统使用用户量" required>
                        </div>
                    </div>
                </fieldset>
                <!-- 系统整合信息 -->
                <fieldset>
                    <legend>系统整合信息</legend>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">系统部署位置</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="bswz" placeholder="请输入系统部署位置" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">涉密分类</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="smfl" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                 <c:forEach var="dict" items="${fns:getDictList('is_secret')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                 </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">信息安全登保级别</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="aqjb" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('security_level')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">已接入的网络类型</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="yjrwllx" placeholder="请输入系统已接入的网络类型" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">使用范围</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="syfw" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('usable_range')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">是否与其他系统对接</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sfyqtxtdj" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('system_integrating')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">对接其它系统名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="djqtxtmc" placeholder="请输入对接其它系统名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">虚拟化部署</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sfxnhbs" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">虚拟化软件厂商名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="xnhrjmc" placeholder="虚拟化软件厂商名称" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-bottom">
                            <label class="control-label">数据是否有备份</label>
                        </div>
                        <div class="col-sm-7 column-content form-border-bottom">
                            <select name="sfybf" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                 <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                                 <option value="${dict.value}">${dict.label}</option>
                           </c:forEach>
                           </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left form-border-bottom">
                            <label class="control-label">数据备份方式</label>
                        </div>
                        <div class="col-sm-7 column-content form-border-bottom">
                            <select name="bffs" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                 <c:forEach var="dict" items="${fns:getDictList('backup_mode')}">
                                 <option value="${dict.value}">${dict.label}</option>
                           </c:forEach>
                           </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据备份点位置</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="bfdwz" placeholder="备份点位置" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title form-border-left">
                            <label class="control-label">数据备份量（GB）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" isNonnegative="true" class="form-control" name="sjbfl" placeholder="数据备份量（GB）" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">应用容灾</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="yyrz" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">是否申请暂缓整合</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sfsqzhzh" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title column-title-multiple">
                            <label class="control-label">暂缓整合原因说明</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <textarea name="zhzhyy" hasNoSpace="true" class="form-control" rows="3" required></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">升级需求</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sjxq" class="form-control" required>
                                    <option value="">== 请选择 ==</option>
                                     <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                                     <option value="${dict.value}">${dict.label}</option>
                               </c:forEach>
                               </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title column-title-multiple">
                            <label class="control-label">升级需求详细说明</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <textarea name="sjxqsm" class="form-control" hasNoSpace="true" rows="3" placeholder="请说明升级后功能、覆盖面、性能、对接等要求" required></textarea>
                        </div>
                    </div>
                </fieldset>
                <!-- 财政要素信息 -->
                <fieldset>
                    <legend>财政要素信息</legend>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">年度</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="nd" placeholder="请输入年度" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">区划名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="qhmc" placeholder="请输入区划名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">业务处室名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ywcsmc" placeholder="请输入业务处室名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">预算单位名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ysdwmc" placeholder="请输入预算单位名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">资金性质名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zjxzmc" placeholder="请输入资金性质名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">功能分类名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="gnflmc" placeholder="请输入功能分类名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">项目分类名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="xmflmc" placeholder="请输入项目分类名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">经济分类名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="jjflmc" placeholder="请输入经济分类名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">支付方式名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zffsmc" placeholder="请输入支付方式名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">指标类型名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zblxmc" placeholder="请输入指标类型名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">指标来源名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zblymc" placeholder="请输入指标来源名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">指标分配年度名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="zbfpndmc" placeholder="请输入指标分配年度名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">预算项目编码</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ysxmbm" placeholder="请输入预算项目编码" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">预算项目名称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="ysxmmc" placeholder="请输入预算项目名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">总指标金额（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="zzbje" placeholder="请输入总指标金额（万元）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">可用金额（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="kyje" placeholder="请输入可用金额（万元）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">已用金额（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="yyje" placeholder="请输入已用金额（万元）" required>
                        </div>
                    </div>
                </fieldset>

                <!-- 信息化管理要素 -->
                <fieldset>
                    <legend>信息化管理要素</legend>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">信息化机构人员编制情况</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="xxhjgrybzqk" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('prepare_condition')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">信息化人员技术职称</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="xxhryjszc" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('technical_titles ')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">承担信息化工作的事业单位</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="cdxxhgzdsydw" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('public_institution')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">承担信息化工作的内设机构</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="cdxxhgzdnsjg" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('inner_organ')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">系统情况</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="xtqk" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('system_explorer')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">系统架构</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="xtjg" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('system_architecture')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">信息录入方式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="xxlrfs" placeholder="请输入使用对象，如政府单位内部，注册用户数_个" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">系统信息查看</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="xtxxck" placeholder="系统IP___,账号___,密码___" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">软件架构描述</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="rjjgms" placeholder="前端/中间件/数据库" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据库品牌、版本、运行平台</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sjkppbbyxpt" placeholder="请输入数据库品牌、版本、运行平台" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据存储方式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sjccfs" placeholder="本地本机存储\本地集中存储\异地自行存储\异地集中存储\其他" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据文件大小</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="sjwjdx" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('file_size')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据加密方式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sjjmfs" placeholder="对称算法\非对称算法\杂凑算法\其他" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">技术资料</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="jszl" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('technical_data')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">数据更新模式</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="sjgxms" placeholder="追加且保留历史数据\追加不保留历史数据\覆盖历史数据\其他" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">外部报送</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="wbbs" placeholder="向上级报送数据\向上级报送报表\向社会公开数据\向社会公开报表\依申请公开数据\其他" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">报送时效</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="bssx" placeholder="实时报送\每日报送\每周报送\每月报送\年末报送\其他" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">机房场地面积（平方米）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="jfcdmj" placeholder="请输入机房场地面积（单位：平方米）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">机柜数量（个）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="jgsl" placeholder="请输入机柜数量（单位：个）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">不间断电源容量</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="bjddyrl" placeholder="请输入不间断电源容量" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">租用和托管机柜数量（个）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="zyhtgjgsl" placeholder="请输入租用和托管机柜数量（单位：个）" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">托管在哪个运营商机房，租用面积多大</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="tgzngyysjf" placeholder="运营商机房___,租用面积___" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">机房精密空调</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="jfjmkt" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">机房综合监控系统</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="jfzhjkxt" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">内部局域网终端数</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="nbjywzds" placeholder="请输入内部局域网终端数" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">承载业务系统数量</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="czywxtsl" placeholder="请输入承载业务系统数量" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">电子政务外网终端数</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="dzzwwwzds" placeholder="请输入电子政务外网终端数" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">专网终端数</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="zwzds" placeholder="请输入专网终端数" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">专网承载业务系统数量</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control digits" name="zwczywxtsl" placeholder="请输入承载业务系统数量" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">专网连接范围</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="zwljfw" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('joint_scope')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">与其他网络连接情况</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <select name="yqtwlljqk" class="form-control" required>
                                <option value="">== 请选择 ==</option>
                                <c:forEach var="dict" items="${fns:getDictList('connectivity')}">
                                    <option value="${dict.value}">${dict.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">存储</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" hasNoSpace="true" name="cc" placeholder="集中式存储,容量：____\分布式存储,容量：____" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 column-title">
                            <label class="control-label">年宽带使用费（万元）</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <input type="text" class="form-control" isNonnegative="true" name="nkdsyf" placeholder="请输入年宽带使用费" required>
                        </div>
                    </div>

                    <!-- 关键设备信息 -->
                    <fieldset>
                        <legend>关键设备信息</legend>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">PC服务器品牌数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control digits" name="pcfwqppsl" placeholder="请输入PC服务器品牌数量" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">操作系统类型数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control digits" name="czxtlxsl" placeholder="请输入操作系统类型数量" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">小型机品牌数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control digits" name="xxjppsl" placeholder="请输入小型机品牌数量" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">备份设备数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control digits" name="bfsbsl" placeholder="请输入备份设备数量" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">网络设备（路由器、交换机）数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control digits" name="wlsbsl" placeholder="请输入网络设备（路由器、交换机）数量" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">中间件类型和数量</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="zjjlxhsl" placeholder="请输入中间件类型和数量" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">存储容量（TB）</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" isNonnegative="true" name="ccrl" placeholder="请输入存储容量（单位：TB）" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">实际用量（TB）</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" isNonnegative="true" name="sjyl" placeholder="请输入实际用量（单位：TB）" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">服务器</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="fwq" placeholder="X86,CPU总核数：_____,内存总容量：____,其他（小型机）：____" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">数据备份频率</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="sjbfpl" placeholder="实时备份\每天备份\每周备份\每月更新\其他" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-3 column-title">
                                <label class="control-label">应用双活</label>
                            </div>
                            <div class="col-sm-7 column-content">
                                <input type="text" class="form-control" hasNoSpace="true" name="yysh" placeholder="无\有,同城双活选址：____" required>
                            </div>
                        </div>
                    </fieldset>

                </fieldset>
                <!-- 备注与说明 -->
                <fieldset>
                    <legend>备注</legend>
                    <div class="form-group">
                        <div class="col-sm-3 column-title column-title-multiple">
                            <label class="control-label">备注</label>
                        </div>
                        <div class="col-sm-7 column-content">
                            <textarea name="remarks" class="form-control" hasNoSpace="true" rows="3" required></textarea>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
		<!-- excel导入导出-->
        <c:set var="type" value="6" />
		<%@ include file="/WEB-INF/views/include/exp_importData.jsp"%>
        <%@ include file="/WEB-INF/views/include/footer.jsp"%>
    <script src="${ctxStatic}/js/common/common-h.js"></script>
    <script>
    
	    /*导入导出定义的全部变量 */
		var uploaderServer = "yjSystem";

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
            containerSize: ['100%','100%'],
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
    </script>

    </body>
</html>
