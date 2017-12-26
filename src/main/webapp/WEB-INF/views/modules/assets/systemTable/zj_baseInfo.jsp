<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 基本信息 -->
<fieldset>
    <legend>基本信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class=" control-label">政务信息系统名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="xtmc" placeholder="请输入政务信息系统名称" required>
        </div>
    </div>
     <c:set var="user" value="${fns:getCurrentUser()}" />
    <div class="form-group">
        <label class="col-sm-3 control-label layerTips"
               data-tips-text="例：XX市XX局 / 单位人事管理 / 统计分析">所属部门：</label>
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
            <textarea name="ywgn" class="form-control" hasNoSpace="true" rows="3" placeholder="请描述系统功能、使用效益等"  required></textarea>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设单位名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jsdwmc" placeholder="负责此项目的科室名称" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">建设单位联系人</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content">
                <input type="text" class="form-control" hasNoSpace="true" name="jsdwlxr" placeholder="建设方项目负责人姓名" required>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">建设单位联系电话</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content form-border-left">
                <input type="text" class="form-control" isMobile="true" name="jsdwlxdh" placeholder="建设方项目负责人联系电话" required>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设预算/合同金额<br>（万元）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" isNonnegative="true" class="form-control" name="xtjsys" placeholder="具体数额（单位：万元，格式：数字填写）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">资金来源</label>
        </div>
        <div class="col-sm-7 form-contact column-content">
            <select name="zjly" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('capital_source')}">
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
            <select name="xtlb1" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('system_type1')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="xtlb1">
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
</fieldset>