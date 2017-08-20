package top.guhanjie.wine.mapper;

import static org.junit.Assert.*;

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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestItemMapper {

    private Logger logger = LoggerFactory.getLogger(TestItemMapper.class);
    
    @Autowired
    private ItemMapper mapper;
	private String tableName;

    @Before
    public void setup() throws Exception {
		tableName = "item";
    }

	@Test
	public void testCRUD() {
		//Create
		logger.debug("Create one record to table[{}]...", tableName);
		Item model = new Item();
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
		model.setDetailImgs("http://www.guhanjie.top");
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
    public void testSelectByCategory() {
	    List<Item> items = mapper.selectByCategory(6);
	    for(Item item : items) {
	        logger.debug(JSON.toJSONString(item));
	    }
	}

    @Test
    public void testSelectById() {
        Item item = mapper.selectById(1);
        assertNotNull(item);
        logger.debug(JSON.toJSONString(item));
    }
}
