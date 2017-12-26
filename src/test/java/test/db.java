package test;

import org.junit.Test;

public class db {
 
    
    
    @Test
    public void dou() {
        String name ="啊,";
        String[] nameArr = name.split(",");
        for(int i=0;i<nameArr.length;i++){
            System.out.println(nameArr[i]);
        }
        System.out.println(nameArr.length);
    }
}

    
   
        