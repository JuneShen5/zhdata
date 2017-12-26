package com.govmade.zhdata.common.utils;


import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.govmade.zhdata.module.sys.pojo.Company;


public class TreeUtil {
    
    private  List <Company> companyTreeList = new ArrayList<Company>();
    

    public List<Company> getCompanyTreeList() {
        return companyTreeList;
    }

    @SuppressWarnings("unchecked")
    public List<Company> buildListToTree(List<Company> dirs) {
        List<Company> roots = findRoots(dirs);
        List<Company> notRoots = (List<Company>) CollectionUtils
                .subtract(dirs, roots);
        for (Company root : roots) {
            companyTreeList.add(root);
            root.setChildren(findChildren(root, notRoots));
        }
        return roots;
    }

    public List<Company> findRoots(List<Company> allInfoSorts) {
        List<Company> results = new ArrayList<Company>();
        for (Company InfoSort : allInfoSorts) {
            boolean isRoot = true;
            for (Company comparedOne : allInfoSorts) {
                if (InfoSort.getParentId() == comparedOne.getId()) {
                    isRoot = false;
                    break;
                }
            }
            if (isRoot) {
                InfoSort.setLevel(0);
                results.add(InfoSort);
                InfoSort.setRootId(InfoSort.getId());
            }
        }
        return results;
    }

    @SuppressWarnings("unchecked")
    private List<Company> findChildren(Company root, List<Company> allInfoSorts) {
        List<Company> children = new ArrayList<Company>();

        for (Company comparedOne : allInfoSorts) {
            if (comparedOne.getParentId() == root.getId()) {
                comparedOne.setParent(root);
                comparedOne.setLevel(root.getLevel() + 1);
                String treeLine = "";
                for(int i=0;i<comparedOne.getLevel();i++){
                    treeLine += "—";
                }
                comparedOne.setName(treeLine+comparedOne.getName()); //假装拼装出树形结构
                children.add(comparedOne);
                companyTreeList.add(comparedOne);
            }
        }
        List<Company> notChildren = (List<Company>) CollectionUtils.subtract(allInfoSorts, children);
        for (Company child : children) {
            List<Company> tmpChildren = findChildren(child, notChildren);
            if (tmpChildren == null || tmpChildren.size() < 1) {
                child.setLeaf(true);
                child.setChildSize(1);
            } else {
                child.setLeaf(false);
                child.setChildSize(tmpChildren.size());
            }
            child.setChildren(tmpChildren);
        }
        return children;
}
    
}