<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<!DOCTYPE html>
<c:set var="isCore" value="2" />
<%-- <c:set var="type" value="2" /> --%>
<c:forEach var="att" items="${fns:getAttList(type,isCore)}">
	<div
		class="form-group">
		<label class="col-sm-3 control-label layerTips" data-tips-text="${att.remarks}">${att.nameCn} :</label>
		<div class="col-sm-7 <c:if test="${att.inputLength=='2'}"> col-sm-3</c:if>">
            <c:choose>
                <c:when test="${att.inputType=='input'}">
                    <input type="text" name="${att.nameEn}" class="form-control hasNoSpace" placeholder="${att.remarks}"
                        <c:if test="${att.isRequire==1}" >required</c:if>>
                </c:when>
                <c:when test="${att.inputType=='textarea'}">
                    <textarea type="text" name="${att.nameEn}" class="form-control" placeholder="${att.remarks}"
                        <c:if test="${att.isRequire==1}" >required</c:if> 
                        style="min-height: 115px;"></textarea>
                </c:when>
                <c:when test="${att.inputType=='select'}">
                    <select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if>>
                        <option value=""></option>
                        <c:forEach var="obj" items="${fns:getList(att.inputValue)}">
                            <option value="${obj.id}">${obj.name}</option>
                        </c:forEach>
                    </select>
                </c:when>
                <c:when test="${att.inputType=='dictselect'}">
                    <select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if>>
                        <option value=""></option>
                        <c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
                            <option value="${obj.value}">${obj.label}</option>
                        </c:forEach>
                    </select>
                </c:when>
                <c:when test="${att.inputType=='companyselect'}">
                    <select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if>>
                        <option value=""></option>
                        <c:forEach var="company" items="${fns:getList('company')}">
                            <option value="${company.id}">${company.name}</option>
                        </c:forEach>
                    </select>
                </c:when>
                
                <c:when test="${att.inputType=='dateselect'}">
                    <input type="text" name="${att.nameEn}" class="form-control datepicker"
                        <c:if test="${att.isRequire==1}" >required</c:if> value="" readonly="readonly">
                </c:when>
                <c:when test="${att.inputType=='radiobox'}">
                    <c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
                        <label class="radio-inline i-checks">
                            <input type="radio" value="${obj.value}" name="${att.nameEn}-radio">  ${obj.label}</label>
                    </c:forEach>
                    <input type="text" stype="checkbox" name="${att.nameEn}" class="checkboxInput hide"
                    <c:if test="${att.isRequire==1}" >required</c:if>>
                </c:when>
                <c:when test="${att.inputType=='checkbox'}">
                    <c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
                        <label class="checkbox-inline i-checks">
                            <input type="checkbox" value="${obj.value}">  ${obj.label}</label>
                    </c:forEach>
                    <input type="text" stype="checkbox" name="${att.nameEn}" class="checkboxInput hide"
                    <c:if test="${att.isRequire==1}" >required</c:if>>
                </c:when>
                
                <c:when test="${att.inputType=='upload'}">
                    <div class="col-sm-5 detail-hide edit-show" style="width: calc(100% - 190px); padding-left: 0;">
                        <input type="text" name="${att.nameEn}" class="form-control detail-hide"
                            <c:if test="${att.isRequire==1}" >required</c:if> readonly>
                    </div>
                    <div class="col-sm-3" style="width: 190px;">
                        <a style="float: left; margin-right: 10px;" class="btn btn-primary"
                            onclick="downloadFile(this);">下载</a> <a
                            style="float: left; margin-right: 10px;" class="btn btn-primary"
                            onclick="uploadFile(this);">上传文件</a> <input type="file"
                            class="uploadFile hide" multiple="multiple">
                    </div>
                </c:when>
                
            </c:choose>
        </div>
	</div>
</c:forEach>

</html>