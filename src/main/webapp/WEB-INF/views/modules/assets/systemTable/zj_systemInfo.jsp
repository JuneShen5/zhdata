<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统整合信息 -->
<fieldset>
    <legend>系统整合信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">系统部署位置</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="bswz" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('deploy_location')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
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
            <label class="control-label">信息安全等保级别</label>
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
            <label class="control-label">计划接入网络类型</label>
        </div>
        <div class="col-sm-7 column-content">
            <%--<input type="text" class="form-control" hasNoSpace="true" name="jhjrwllx" placeholder="计划接入网络类型" required>--%>
            <select name="jhjrwllx" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('security_level')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
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
            <select name="sfyqtxtdj" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('system_integrating')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfyqtxtdj">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">对接其它系统名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="djqtxtmc" placeholder="若无对接其他系统，此项不填" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">虚拟化部署</label>
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
            <label class="control-label">虚拟化软件厂商名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="xnhrjmc" placeholder="若无虚拟化部署，此项不填">
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
            <input type="text" class="form-control" hasNoSpace="true" name="bfdwz" placeholder="备份点位置（若无备份，此项不填）">
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfybf">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">数据备份量（GB）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" isNonnegative="true" class="form-control" name="sjbfl" placeholder="数据备份量（GB）（若无备份，此项不填）">
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
            <label class="control-label">系统后续计划</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="xthxjh" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('follow-up')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="xthxjh">
        <div class="col-sm-3 column-title column-title-multiple">
            <label class="control-label">系统继续建设原因</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="xtjxjsyy" class="form-control" hasNoSpace="true" rows="3" placeholder="说明继续建设的必要性、对接要求等（若无系统后续计划，此项不填）"></textarea>
        </div>
    </div>
</fieldset>