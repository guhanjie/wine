package top.guhanjie.wine.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.User;

/**
 * Created by guhanjie on 2017-09-02.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestUserService {
	@Autowired
	UserService userService;
	
	@Test
    public void testGetUser() {
		Integer userid = null;
		User user = userService.getUserById(10);
		System.out.println(JSON.toJSONString(user));
	}
}
