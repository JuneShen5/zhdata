<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统运维信息 -->
<fieldset>
    <legend>系统运维信息</legend>
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
            <label class="control-label">运维单位联系人姓名</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content">
                <input type="text" class="form-control" hasNoSpace="true" name="ywdwlxr" placeholder="请输入姓名" required>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">运维单位联系人手机号</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content form-border-left">
                <input type="text" class="form-control" isMobile="true" name="ywdwlxdh" placeholder="请输入手机号" required>
            </div>
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
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">运维合同签署到期时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="ywhtqsdqsj" readonly="readonly" placeholder="与运维单位签署的相关合同到期日期（格式：CCYY-MM）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-bottom">
            <label class="control-label">数据是否有备份</label>
        </div>
        <div class="col-sm-7 column-content form-border-bottom">
            <select name="sfybf" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('is_have')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfybf">
        <div class="col-sm-3 column-title form-border-left form-border-bottom">
            <label class="control-label">数据备份方式</label>
        </div>
        <div class="col-sm-7 column-content form-border-bottom">
            <select name="bffs" class="form-control">
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('backup_mode')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfybf">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据备份点位置</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="bfdwz" placeholder="备份点位置">
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfybf">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">数据备份量（GB）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" isNonnegative="true" class="form-control" name="sjbfl" placeholder="数据备份量（GB）">
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
</fieldset>