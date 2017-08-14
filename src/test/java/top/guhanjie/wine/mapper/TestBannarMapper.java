package top.guhanjie.wine.mapper;

import static org.junit.Assert.assertEquals;

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

import top.guhanjie.wine.model.Bannar;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestBannarMapper {

    private Logger logger = LoggerFactory.getLogger(TestBannarMapper.class);
    
    @Autowired
    private BannarMapper mapper;
	private String tableName;

    @Before
    public void setup() throws Exception {
		tableName = "bannar";
    }

	@Test
	public void testCRUD() {
		//Create
		logger.debug("Create one record to table[{}]...", tableName);
		Bannar model = new Bannar();
		model.setItemId(123);
		long insertCount = mapper.insertSelective(model);
		assertEquals(insertCount, 1L);
		//Retrieve
		logger.debug("Select one record from table[{}]...", tableName);
		model = mapper.selectByPrimaryKey(model.getId());
		logger.debug(JSON.toJSONString(model, true));
		//Update
		logger.debug("Update one record in table[{}]...", tableName);
		model.setIdx(1);
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
    public void testSelect() {
        logger.debug("Select one record from table[{}]...", tableName);
        Bannar model = mapper.selectByPrimaryKey(1);
        logger.debug(JSON.toJSONString(model, true));
	}

    @Test
    public void testSelectAll() {
        logger.debug("Select all records from table[{}]...", tableName);
        List<Bannar> models = mapper.selectAll();
        for(Bannar obj : models) {
            logger.debug(JSON.toJSONString(obj, true));
        }
    }
}
