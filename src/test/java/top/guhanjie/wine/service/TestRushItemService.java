package top.guhanjie.wine.service;

import static org.junit.Assert.fail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import top.guhanjie.wine.model.Order;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestRushItemService {
	
	@Autowired
	RushItemService service;

	@Test
	public void testGenerateLotteryCode() {
		Order order = new Order();
		order.setId(69);
		order.setUserId(7);
		order.setItems("1:5");
		service.putItem(order);
	}

}
