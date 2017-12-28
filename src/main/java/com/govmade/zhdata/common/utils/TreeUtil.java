package com.govmade.zhdata.common.utils;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;

import com.govmade.zhdata.module.drs.pojo.InfoSort;



public class TreeUtil {
    
    private Integer levalNum = 0; //列数
    private Integer rankNum = 0;  //行数
    
    public Integer getLevalNum() {
        return levalNum;
    }

    private String[][] numfour;
    

    @SuppressWarnings("unchecked")
    public List<InfoSort> buildListToTree(List<InfoSort> dirs) {
        List<InfoSort> roots = findRoots(dirs);
        List<InfoSort> notRoots = (List<InfoSort>) CollectionUtils
                .subtract(dirs, roots);
        for (InfoSort root : roots) {
            root.setChildren(findChildren(root, notRoots));
        }
        System.out.println("levalNum:"+levalNum);
        System.out.println("rankNum:"+rankNum);
//        numfour = new String[rankNum+2][levalNum+2];
//        return   listToArray(roots);
//        return new String[30][30];
        return roots;
    }

    public List<InfoSort> findRoots(List<InfoSort> allInfoSorts) {
        List<InfoSort> results = new ArrayList<InfoSort>();
        for (InfoSort InfoSort : allInfoSorts) {
            boolean isRoot = true;
            for (InfoSort comparedOne : allInfoSorts) {
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
    private List<InfoSort> findChildren(InfoSort root, List<InfoSort> allInfoSorts) {
        List<InfoSort> children = new ArrayList<InfoSort>();

        for (InfoSort comparedOne : allInfoSorts) {
            if (comparedOne.getParentId() == root.getId()) {
                comparedOne.setParent(root);
                comparedOne.setLevel(root.getLevel() + 1);
                children.add(comparedOne);
                /*增加列数目     */  
                if(root.getLevel() + 1>levalNum){
                    levalNum = root.getLevel() + 1;
                }
//                setLevalNum(root.getLevel() + 1);
                
            }
        }
        List<InfoSort> notChildren = (List<InfoSort>) CollectionUtils.subtract(allInfoSorts, children);
        for (InfoSort child : children) {
            List<InfoSort> tmpChildren = findChildren(child, notChildren);
            if (tmpChildren == null || tmpChildren.size() < 1) {
                child.setLeaf(true);
                rankNum++;
            } else {
                child.setLeaf(false);
            }
            child.setChildren(tmpChildren);
        }
        return children;
}
    
    
/*   这边开始集合转数组*/
//    private  String[][] numfour=new String[1000][1000];
    public  String[][] listToArray(List<InfoSort> roots){
//        int  num = 0;
        
        for (InfoSort n : roots) {
//            System.out.println(n);
            int leval = n.getLevel(); //列
            int  num = getnumFromLevel(numfour,leval);
            int pRank = n.getChildren().size(); //行
            if(pRank>=0){
                numfour[num+1][leval] = n.getId()+"_"+n.getName();
                if(!n.isLeaf()){
                    numfour[num][leval+1] = "1_kong";
                }
               
                num += pRank;
            }
            if(n.isLeaf()){
                ++num;
            }
            System.out.println("num："+num);
            System.out.println("level："+leval);
            System.out.println(n.getId()+"_"+n.getName());
//            int _num = getnumFromLevel(numfour,leval)+num;
//            System.out.println("_num："+_num);
            numfour[num][leval] = n.getId()+"_"+n.getName();
         
            if(!n.isLeaf()){
                listToArray(n.getChildren());
            }
          
        }
        
//        for(int a=0;a<30;a++){
            for(int b=0;b<30;b++){
//                System.out.println(numfour[b][1]);
            }
//        }
        
        
        return numfour;
    }
    
    public Integer getnumFromLevel(String[][] strarray,int column){
        int rowlength = strarray.length;
        int num = 0;
        for(int i=rowlength-1;i>=0;i--){
//            System.out.println("column:"+strarray[i][column]);
            if( strarray[i][column] !=null){
//                System.out.println("column:"+strarray[i][column]);
//                System.out.println("i:"+i);
                num = i;
//                System.out.println("numnum:"+num);
                break;
            }
        }
         
        return num;
    } 
    
}