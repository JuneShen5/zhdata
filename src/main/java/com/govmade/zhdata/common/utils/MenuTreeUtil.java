package com.govmade.zhdata.common.utils;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.govmade.zhdata.module.sys.pojo.Menu;

public class MenuTreeUtil {

    /**
     * @Title: buildMenuHtml
     * @Description: TODO(H+菜单构建)
     * @param @param menus
     * @param @return 设定文件
     * @return String 返回类型
     * @throws
     */
    public static String buildMenuHtml(String path, List<Menu> menus) {
        StringBuffer html = new StringBuffer();
        for (Menu p : menus) {
            if (p.getChildren() != null && p.getChildren().size() > 0) {
                html.append(" <li><a href=\"#\">");
                if (StringUtils.isNotEmpty(p.getImage())) {
                    html.append("<i class=\"fa fa-").append(p.getImage()).append("\"></i>");
                }
                html.append("<span class=\"nav-label nav-title\">").append(p.getName())
                        .append("</span><span class=\"fa arrow\"></span></a>");
                html.append(" <ul class=\"nav nav-second-level\">");
                html.append(buildChildMenuHtml(path, p.getChildren()));
                html.append("  </ul></li>");
            } else {
                html.append("<li ><a class=\"J_menuItem\" href=\"#\"").append("\" url=\"").append(path)
                        .append(p.getHref()).append("\" onclick=\"$('.").append(name(p.getHref())).append("').attr('src', $('.").append(name(p.getHref())).append("').attr('src'))")
                        .append("\" ><span class=\"nav-label nav-title\">")
                        .append(p.getName()).append("</span></a></li>");
            }
        }
        return html.toString();
    }

    public static String buildChildMenuHtml(String path, List<Menu> menus) {
        StringBuffer html = new StringBuffer();
        for (Menu p : menus) {
            if (p.getChildren() != null && p.getChildren().size() > 0) {
                html.append(" <li><a href=\"#\">");
                html.append("<i class=\"fa fa-").append(p.getImage()).append("\"></i>");
                html.append(" <span class=\"nav-label\">").append(p.getName())
                        .append("</span><span class=\"fa arrow\"></span></a>");
                html.append(" <ul class=\"nav nav-third-level\">");
                for (Menu c : p.getChildren()) {
                    html.append("<li><a class=\"J_menuItem\" href=\"#\"").append("\" url=\"").append(path)
                            .append(c.getHref()).append("\" onclick=\"$('.").append(name(c.getHref())).append("').attr('src', $('.").append(name(c.getHref())).append("').attr('src'))")
                            .append("\" >").append("<i class=\"fa fa-").append(c.getImage())
                            .append("\"></i>").append(c.getName()).append("</a></li>");
                }
                html.append("  </ul></li>");
            } else {
                html.append("<li><a class=\"J_menuItem\" href=\"#\"").append("\" url=\"").append(path)
                        .append(p.getHref()).append("\" onclick=\"$('.").append(name(p.getHref())).append("').attr('src', $('.").append(name(p.getHref())).append("').attr('src'))")
                        .append("\" ><i class=\"fa fa-").append(p.getImage())
                        .append("\"></i>").append(p.getName()).append("</a></li>");
            }
        }
        return html.toString();
    }

    private static String name(String href) {
        String name = href.replace("/", "");
        name = name.replace("?", "");
        name = name.replace("=", "");
        name = name.replace("&", "");
        return name;
    }
}
