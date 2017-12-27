<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 基本信息 -->
<fieldset>
    <legend>系统基本信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class=" control-label">政务信息系统名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true"
                   name="zwxxxtmc" placeholder="请输入政务信息系统名称" required>
        </div>
    </div>
    <c:set var="user" value="${fns:getCurrentUser()}" />
    <div class="form-group">
        <label class="col-sm-3 control-label layerTips"
               data-tips-text="例：XX市XX局 / 单位人事管理 / 统计分析">所属部门</label>
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
            <label class="control-label">建设依据</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jsyj" placeholder="根据权责清单、政策文件等填写（事项名称全写）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">审批部门</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="spbm" placeholder="负责审批此系统的相关单位" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">审批时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="spsj" readonly="readonly" placeholder="审批的具体日期" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title column-title-multiple">
            <label class="control-label">业务功能</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="ywgn" class="form-control" hasNoSpace="true" rows="3" placeholder="本系统所办理的具体业务" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">归口科室名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="gkksmc" placeholder="负责此项目的科室名称" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">联系人</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content">
                <input type="text" class="form-control" hasNoSpace="true" name="jsdwlxr" placeholder="建设方项目负责人姓名" required>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">联系电话</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content form-border-left">
                <input type="text" class="form-control" isMobile="true" name="jsdwlxdh" placeholder="建设方项目负责人联系电话" required>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">单位名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="cjdwmc" placeholder="负责此项目的承建商名称" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">联系人</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content">
                <input type="text" class="form-control" hasNoSpace="true" name="cjdwlxr" placeholder="承建方负责人姓名" required>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">联系电话</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content form-border-left">
                <input type="text" class="form-control" isMobile="true" name="cjdwlxdh" placeholder="承建方联系电话" required>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">建设类型</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="jslx" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('build_type')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
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
            <label class="control-label">建设起始时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="jsqssj" readonly="readonly" placeholder="项目建设具体起始时间,格式：CCYY-MM" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">投入使用时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="trsysj" readonly="readonly" placeholder="系统投入使用具体时间,格式：CCYY-MM" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">系统类别</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="xtlb" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('system_type1')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="xtlb">
        <div class="col-sm-3 column-title">
            <label class="control-label"></label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="xtlb2" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('system_type2')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">部署位置</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="bswz" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('deploy_location_yj')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
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
            <label class="control-label">安全级别</label>
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
            <label class="control-label">已接入</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="yjr" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('network_type')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">网络类型使用范围</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="wllxsyfw" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('usable_range')}">
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
            <label class="control-label">应用服务器操作系统</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="yyfwqczxt" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('operate_system')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据库服务器操作系统</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sjkfwqczxt" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('operate_system')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">中间件版本</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="zjjbb" placeholder="请输入中间件类型和数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据库版本</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sjkbb" placeholder="请输入中间件类型和数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">是否与其他系统对接</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfyqtxtdj" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('system_integrating')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfyqtxtdj">
        <div class="col-sm-3 column-title">
            <label class="control-label">对接其它系统名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="djqtxtmc" placeholder="请输入对接其它系统名称">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">是否虚拟化部署</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfxnhbs" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfxnhbs">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">虚拟化软件及厂商名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="xnhrjjcsmc" placeholder="虚拟化软件厂商名称">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">是否申请暂缓整合</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfsqzhzh" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfsqzhzh">
        <div class="col-sm-3 column-title column-title-multiple">
            <label class="control-label">暂缓整合原因说明</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="zhzhyysm" hasNoSpace="true" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">是否有升级需求</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfysjxq" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfysjxq">
        <div class="col-sm-3 column-title column-title-multiple">
            <label class="control-label">升级需求详细说明</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="sjxqxxsm" class="form-control" hasNoSpace="true" rows="3" placeholder="请说明升级后功能、覆盖面、性能、对接等要求"></textarea>
        </div>
    </div>
</fieldset>
