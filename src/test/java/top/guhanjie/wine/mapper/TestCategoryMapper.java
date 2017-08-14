package top.guhanjie.wine.mapper;

import static org.junit.Assert.*;

import java.math.BigDecimal;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.Category;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestCategoryMapper {

    private Logger logger = LoggerFactory.getLogger(TestCategoryMapper.class);
    
    @Autowired
    private CategoryMapper mapper;
	private String tableName;

    @Before
    public void setup() throws Exception {
		tableName = "category";
    }

	@Test
	public void testCreate() {
		//Create
		logger.debug("Create 4 records to table[{}]...", tableName);
		String[] mainCategory = {"酒水", "礼品", "茶叶", "集市"};
		int i = 1, insertCount = 0;
		for(String str : mainCategory) {
			Category model = new Category();
			model.setId(i++);
			model.setLevel(1);
			model.setParentId(0);
			model.setName(str);
			insertCount += mapper.insertSelective(model);
		}
		assertEquals(insertCount, 4L);
	}
	
	@Test
	public void testSelect() {
		//Retrieve
		logger.debug("Select one record from table[{}]...", tableName);
		Category model = mapper.selectByPrimaryKey(1);
		logger.debug(JSON.toJSONString(model, true));
		assertNotNull(model);
	}	
	
}
