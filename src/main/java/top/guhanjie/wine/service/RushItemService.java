/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.service 
 * File Name:				ItemService.java 
 * Create Date:			2017年8月13日 下午4:53:02 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.RushItemMapper;
import top.guhanjie.wine.mapper.RushLotteryMapper;
import top.guhanjie.wine.model.Order;
import top.guhanjie.wine.model.RushItem;
import top.guhanjie.wine.model.RushLottery;

@Service
public class RushItemService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RushItemService.class);
        
    @Autowired
    private RushItemMapper rushItemMapper;
    @Autowired
    private RushLotteryMapper rushLotteryMapper;

	//获取所有秒杀商品列表
    public List<RushItem> listAllItems() {
    	List<RushItem> items = rushItemMapper.selectAll();
        return items;
    }
    
    public void addItem(RushItem item) {
		LOGGER.info("Add a new rush item[{}]...", JSON.toJSONString(item, true));
		item.setStartTiem(new Date());
		rushItemMapper.insertSelective(item);
	}

    public void updateItem(RushItem item) {
		LOGGER.info("Update rush item[{}]...", JSON.toJSONString(item, true));
		rushItemMapper.updateByPrimaryKeySelective(item);
	}
    
    public void deleteItem(RushItem item) {
    	LOGGER.warn("Delete rush item[{}]...", JSON.toJSONString(item, true));
    	item.setStatus(4);
    	rushItemMapper.updateByPrimaryKeySelective(item);
    }
    
    //获取当前正在进行的活动商品列表
    public List<RushItem> listActiveItems() {
    	List<RushItem> items = rushItemMapper.selectByStatus(RushItem.StatusEnum.PROCESSING.code());
        return items;
    }
    
    //获取某个活动商品
    public RushItem getItem(Integer itemId) {
    	RushItem item = rushItemMapper.selectByPrimaryKey(itemId);
    	//item.setCounts(rushLotteryMapper.countByItem(itemId));
        return item;
    }
    
    //获取某个活动商品
    public RushItem getItemByOrder(Integer orderId, Integer itemId) {
    	LOGGER.debug("Get item by order[{}], item[{}]", orderId, itemId);
    	RushItem item = rushItemMapper.selectByPrimaryKey(itemId);
    	List<RushLottery> rls = rushLotteryMapper.selectByOrderItem(orderId, itemId);
    	item.setRushLotterys(rls);
    	//若已开奖
    	if(StringUtils.isNotBlank(item.getLotteryCode())) {
        	for(RushLottery rl : rls) {
        		if(item.getLotteryCode().equals(rl.getLotteryCode())) {
        			item.setWon(true);
        			break;
        		}
        	}
    	}
        return item;
    }
    
    //生产活动的随机码
	@Transactional
    public void putItem(Order order) {
    	LOGGER.info("Put rush item:[{}]", JSON.toJSONString(order, true));
    	Integer orderId = order.getId();
    	Integer userId = order.getUserId();
    	String items = order.getItems();
		String[] it = items.split(",");
		for(String str : it) {
			String[] iteminfo = str.split(":");
			Integer itemId = Integer.parseInt(iteminfo[0]);
			Integer count = Integer.parseInt(iteminfo[1]);
			int used = rushLotteryMapper.countByItem(itemId);
			if(1000-used < count) {
				throw new RuntimeException("购买份额超限");
			}
			for(int i=0; i<count; i++) {
				generateLotteryCode(orderId, userId, itemId);
			}
			if(0 == rushItemMapper.addSales(itemId, count)) {
				throw new RuntimeException("add sales for items["+items+"] failed, transaction rollback....");
			}
			RushItem ri = new RushItem();
			ri.setId(itemId);
			ri.setBuyers(rushLotteryMapper.countUsersByItem(itemId));
			//检查是否活动达成
			if(rushLotteryMapper.countByItem(itemId) >= 1000) {
				Date now = new Date();
				Date kjdate = new Date(now.getTime()+24*3600); //后一天
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            String round = sdf.format(kjdate);
				ri.setRound(round);
				ri.setEndTime(now);
			}
			rushItemMapper.updateByPrimaryKeySelective(ri);
		}
    }
    
    /**
     * 生成随机彩票码
     * @return
     */
    private String generateLotteryCode(Integer orderId, Integer userId, Integer itemId) {
    	int rcode = new Random().nextInt(1000);
    	int cnt = 0;
    	String randcode = null;
    	RushLottery found = null;
    	do {
    		randcode = String.format("%03d", (rcode++)%1000);
    		found = rushLotteryMapper.selectByItemCode(itemId, randcode);
    		cnt++;
    	} while(found != null && cnt <= 1000);	//直至该彩票未被占用
    	if(cnt > 1000) {
    		throw new RuntimeException("彩票号码已全部占用");
    	}
    	else {
    		RushLottery rl = new RushLottery();
    		rl.setLotteryCode(randcode);
    		rl.setOrderId(orderId);
    		rl.setUserId(userId);
    		rl.setRushItemId(itemId);
    		rushLotteryMapper.insertSelective(rl);
    		return randcode;
    	}
    }
}
