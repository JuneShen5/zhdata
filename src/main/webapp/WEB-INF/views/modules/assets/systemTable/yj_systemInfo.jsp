<%@ page contentType="text/html;charset=UTF-8" %>
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
