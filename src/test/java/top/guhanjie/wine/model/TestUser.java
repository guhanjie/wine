package top.guhanjie.wine.model;

import com.alibaba.fastjson.JSON;

/**
 * Created by guhanjie on 2017-10-01.
 */
public class TestUser {

    public static void main(String[] args) {
        User u = new User();
        u.setId(2);
        //u.setName("印霞");
        //u.setPhone("13122876562");
        //u.setType(1);
        //u.setAddress("如东县环镇乡");
        u.setPoints(2000);
        System.out.println(JSON.toJSONString(u, true));
        
        String str = JSON.toJSONString(u);
        User user = JSON.parseObject(str, User.class);
        System.out.println(JSON.toJSONString(u, true));
    }
}
