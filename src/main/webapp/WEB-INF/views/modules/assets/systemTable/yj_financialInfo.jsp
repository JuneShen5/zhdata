<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统资金信息 -->
<fieldset>
    <legend>系统资金信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">资金来源</label>
        </div>
        <!-- <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="zjly" placeholder="请输入资金来源" required>
        </div> -->
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="zjly" placeholder="资金来源" required>
            <!--<select name="zjly" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('capital_source_yj')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>-->
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设金额（万元）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" isNonnegative="true" class="form-control" name="jsje" placeholder="系统建设金额" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">运维金额（万元）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" isNonnegative="true" class="form-control" name="ywje" placeholder="运维所需金额" required>
        </div>
    </div>
    <!--
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
    </div>-->
</fieldset>