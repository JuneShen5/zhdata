package com.govmade.zhdata.common.config;

import java.util.HashMap;
import java.util.Map;

/**
 * EXCEL配置类
 * 
 * @author cyz
 */
public class ExcelConstant {
	
	public static final String SEQUENCE_NUMBER = "序号";
	
	public static final String REMARKS_TITEL = "备注信息";
	public static final String REMARKS_AT = "remarks";
	/**
	 * 机构标题-属性
	 */

	public static final String COMP_FILENAME_TEM = "机构数据导入模板";
	public static final String COMP_TITLE = "机构数据";
	
	public static final String COMP_SITENAME_TITEL = "所属班子";
	public static final String COMP_SITENAME_AT = "siteName";

	public static final String COMP_NUMBER_TITEL = "机构编号";
	public static final String COMP_NUMBER_AT = "number";

	public static final String COMP_NAME_TITEL = "机构名称";
	public static final String COMP_NAME_AT = "name";

	public static final String COMP_CODE_TITEL = "机构代码";
	public static final String COMP_CODE_AT = "code";

	public static final String COMP_ADDRESS_TITEL = "地址";
	public static final String COMP_ADDRESS_AT = "address";

	public static Map<String, String> getCoTA() {
		Map<String, String> ta = new HashMap<String, String>();
		ta.put(COMP_SITENAME_TITEL, COMP_SITENAME_AT);
		ta.put(COMP_NUMBER_TITEL, COMP_NUMBER_AT);
		ta.put(COMP_NAME_TITEL, COMP_NAME_AT);
		ta.put(COMP_CODE_TITEL, COMP_CODE_AT);
		ta.put(COMP_ADDRESS_TITEL, COMP_ADDRESS_AT);
		ta.put(REMARKS_TITEL, REMARKS_AT);
		return ta;
	}
	
	public static final String[] COMP_ROWNAME = { SEQUENCE_NUMBER, COMP_SITENAME_TITEL, COMP_NUMBER_TITEL, COMP_NAME_TITEL, COMP_CODE_TITEL,COMP_ADDRESS_TITEL,REMARKS_TITEL};

	
	/**
	 * 班子标题-属性
	 */
	public static final String SITE_FILENAME_TEM = "班子数据导入模板";
	public static final String SITE_TITLE = "班子数据";
	
	public static final String SITE_PARENT_TITEL = "上级班子";
	public static final String SITE_PARENT_AT = "parentName";
	
	public static final String SITE_CODE_TITEL = "班子代码";
	public static final String SITE_CODE_AT = "code";
	
	public static final String SITE_NAME_TITEL = "班子名称";
	public static final String SITE_NAME_AT = "name";
	
	public static final String SITE_TYPEID_TITEL = "班子级别";
	public static final String SITE_TYPEID_AT = "typeId";
	
	
	public static Map<String, String> getSiteTA() {
		Map<String, String> ta = new HashMap<String, String>();
		ta.put(SITE_PARENT_TITEL, SITE_PARENT_AT);
		ta.put(SITE_CODE_TITEL, SITE_CODE_AT);
		ta.put(SITE_NAME_TITEL, SITE_NAME_AT);
		ta.put(SITE_TYPEID_TITEL, SITE_TYPEID_AT);
		ta.put(REMARKS_TITEL, REMARKS_AT);
		return ta;
	}
	
	public static final String[] SITE_ROWNAME = {SEQUENCE_NUMBER, SITE_PARENT_TITEL, SITE_CODE_TITEL, SITE_NAME_TITEL, SITE_TYPEID_TITEL, REMARKS_TITEL};

	
	/**
	 * 字典标题-属性
	 */
	
	public static final String DICT_FILENAME_TEM = "字典数据导入模板";
	public static final String DICT_TITLE = "字典数据";
	
	public static final String DICT_VALUE_TITEL = "字典值";
	public static final String DICT_VALUE_AT = "value";
	
	public static final String DICT_LABEL_TITEL = "标签名";
	public static final String DICT_LABEL_AT = "label";
	
	public static final String DICT_TYPE_TITEL = "字典类型";
	public static final String DICT_TYPE_AT = "type";
	
	public static final String DICT_SORT_TITEL = "排序";
	public static final String DICT_SORT_AT = "sort";
	
	
	public static Map<String, String> getDictTA() {
		Map<String, String> ta = new HashMap<String, String>();
		ta.put(DICT_VALUE_TITEL, DICT_VALUE_AT);
		ta.put(DICT_LABEL_TITEL, DICT_LABEL_AT);
		ta.put(DICT_TYPE_TITEL, DICT_TYPE_AT);
		ta.put(DICT_SORT_TITEL, DICT_SORT_AT);
		ta.put(REMARKS_TITEL, REMARKS_AT);
		return ta;
	}
	
	public static final String[] DICT_ROWNAME = { SEQUENCE_NUMBER,DICT_VALUE_TITEL, DICT_LABEL_TITEL, DICT_TYPE_TITEL, DICT_SORT_TITEL, REMARKS_TITEL};
	
	
	/**
	 * 角色标题-属性
	 */
	
	public static final String ROLE_FILENAME_TEM = "角色数据导入模板";
	public static final String ROLE_TITLE = "角色数据";
	
	public static final String ROLE_COMPANYNAME_TITEL = "归属机构";
	public static final String ROLE_COMPANYNAME_AT = "companyName";
	
	public static final String ROLE_NAME_TITEL = "角色名称";
	public static final String ROLE_NAME_AT = "name";
	
	public static final String ROLE_ENNAME_TITEL = "英文名称";
	public static final String ROLE_ENNAME_AT = "enname";
	
	public static final String ROLE_USEABLE_TITEL = "是否可用";
	public static final String ROLE_USEABLE_AT = "useable";
	
	public static final String ROLE_MENUIDS_TITEL = "拥有菜单列表";
	public static final String ROLE_MENUIDS_AT = "menuIds";
	
	
	
	public static Map<String, String> getRoleTA() {
		Map<String, String> ta = new HashMap<String, String>();
		ta.put(ROLE_COMPANYNAME_TITEL, ROLE_COMPANYNAME_AT);
		ta.put(ROLE_NAME_TITEL, ROLE_NAME_AT);
		ta.put(ROLE_ENNAME_TITEL, ROLE_ENNAME_AT);
		ta.put(ROLE_USEABLE_TITEL, ROLE_USEABLE_AT);
		ta.put(ROLE_MENUIDS_TITEL, ROLE_MENUIDS_AT);
		ta.put(REMARKS_TITEL, REMARKS_AT);
		return ta;
	}
	
	public static final String[] ROLE_ROWNAME = { SEQUENCE_NUMBER,ROLE_COMPANYNAME_TITEL, ROLE_NAME_TITEL, ROLE_ENNAME_TITEL, ROLE_USEABLE_TITEL,ROLE_MENUIDS_TITEL, REMARKS_TITEL};

}
