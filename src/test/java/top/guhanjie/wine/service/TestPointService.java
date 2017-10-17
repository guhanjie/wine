package top.guhanjie.wine.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by guhanjie on 2017-09-02.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestPointService {
	@Autowired
	PointService pointService;
		
	@Test
    public void testAddPoints() {
		pointService.addPointsForAgent(1, 1000, 1, 1);
	}
	
	@Test
    public void testConsumePoints() {
		pointService.consumePoints(1, 2000, 1);
	}
}
