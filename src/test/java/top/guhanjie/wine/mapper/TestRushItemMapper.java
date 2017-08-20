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

import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.model.RushItem;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestRushItemMapper {

    private Logger logger = LoggerFactory.getLogger(TestRushItemMapper.class);
    
    @Autowired
    private RushItemMapper mapper;
	private String tableName;

    @Before
    public void setup() throws Exception {
		tableName = "item";
    }

	@Test
	public void testCRUD() {
		//Create
		logger.debug("Create one record to table[{}]...", tableName);
		RushItem model = new RushItem();
		model.setName("百年老窖");
		model.setNormalPrice(new BigDecimal(888));
		long insertCount = mapper.insertSelective(model);
		assertEquals(insertCount, 1L);
		//Retrieve
		logger.debug("Select one record from table[{}]...", tableName);
		model = mapper.selectByPrimaryKey(model.getId());
		logger.debug(JSON.toJSONString(model, true));
		//Update
		logger.debug("Update one record in table[{}]...", tableName);
		model.setImages("http://www.guhanjie.top");
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
    public void testSelectByStatus() {
	    List<RushItem> items = mapper.selectByStatus(1);
	    for(RushItem item : items) {
	        logger.debug(JSON.toJSONString(item));
	    }
	}
}
