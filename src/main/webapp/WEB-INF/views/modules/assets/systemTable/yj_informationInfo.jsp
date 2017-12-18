<%@ page contentType="text/html;charset=UTF-8" %>
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
</fieldset>