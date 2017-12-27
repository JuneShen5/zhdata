<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统数据信息 -->
<fieldset>
    <legend>系统数据信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">信息录入方式</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="xxlrfs" class="form-control is-multiple-select" multiple="multiple" required>
                <c:forEach var="dict" items="${fns:getDictList('information_entry_mode')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据增长情况（单位：M）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" isNonnegative="true" name="xtsjzzqk" placeholder="按每月业务发生估算数据增长量（单位：M）" required>
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
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据存储方式</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sjccfs" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('storage_mode')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
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
            <select name="sjjmfs" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('encryption_method')}">
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
            <select name="sjgxms" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('update_mode')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">外部报送</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="wbbs" class="form-control is-multiple-select" multiple="multiple" required>
                <c:forEach var="dict" items="${fns:getDictList('external_delivery')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">报送时效</label>
        </div>
         <div class="col-sm-7 column-content">
            <select name="bssx" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('reporting_time')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
</fieldset>
