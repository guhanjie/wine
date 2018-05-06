package top.guhanjie.wine.mapper;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.RushItem;
import top.guhanjie.wine.model.RushLottery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestRushLotteryMapper {

    private Logger logger = LoggerFactory.getLogger(TestRushLotteryMapper.class);
    
    @Autowired
    private RushLotteryMapper mapper;
	private String tableName;

    @Before
    public void setup() throws Exception {
		tableName = "rush_lottery";
    }

	@Test
	public void testCRUD() {
		//Create
		logger.debug("Create one record to table[{}]...", tableName);
		RushLottery model = new RushLottery();
		model.setUserId(1);
		model.setLotteryCode("888");
		model.setRushItemId(3);
		long insertCount = mapper.insertSelective(model);
		assertEquals(insertCount, 1L);
		//Retrieve
		logger.debug("Select one record from table[{}]...", tableName);
		model = mapper.selectByPrimaryKey(model.getId());
		logger.debug(JSON.toJSONString(model, true));
		//Update
		logger.debug("Update one record in table[{}]...", tableName);
		model.setLotteryCode("666");
		long updateCount = mapper.updateByPrimaryKeySelective(model);
		logger.debug("Update [{}] record(s) in table[{}]...", updateCount, tableName);
		model = mapper.selectByPrimaryKey(model.getId());
		logger.debug(JSON.toJSONString(model, true));
		//Delete
		logger.debug("Delete one record from table[{}]...", tableName);
		long deleteCount = mapper.deleteByPrimaryKey(model.getId());
		assertEquals(deleteCount, 1L);
	}
	
	@Test
    public void testSelectByUserItem() {
	    List<RushLottery> items = mapper.selectByOrderItem(1, 1);
	    for(RushLottery item : items) {
	        logger.debug(JSON.toJSONString(item));
	    }
	}
	
	@Test
    public void testSelectByCodeItem() {
		// exist case:
	    RushLottery item1 = mapper.selectByItemCode(1, "505");
	    System.out.println(JSON.toJSONString(item1, true));

		// not exist case:
	    RushLottery item2 = mapper.selectByItemCode(1, "222");
	    System.out.println(JSON.toJSONString(item2, true));
	}
}
