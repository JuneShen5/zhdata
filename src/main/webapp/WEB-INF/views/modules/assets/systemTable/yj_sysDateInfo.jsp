<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统数据信息 -->
<fieldset>
    <legend>系统数据信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">信息录入方式</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="xxlrfs" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('is_secret')}">
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
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">数据存储方式</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sjccfs" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('file_size')}">
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
            <input type="text" class="form-control" hasNoSpace="true" name="sjjmfs" placeholder="对称算法\非对称算法\杂凑算法\其他" required>
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
</fieldset>
