/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.service 
 * File Name:			OrderService.java 
 * Create Date:		2016年9月1日 下午1:46:59 
 * Copyright (c) 2008-2016, 平安集团-平安万里通 All Rights Reserved.
 */  
package top.guhanjie.wine.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.exception.WebExceptionEnum;
import top.guhanjie.wine.exception.WebExceptionFactory;
import top.guhanjie.wine.mapper.OrderMapper;
import top.guhanjie.wine.model.Category;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.model.Order;
import top.guhanjie.wine.model.Order.PayStatusEnum;
import top.guhanjie.wine.model.Order.PayTypeEnum;
import top.guhanjie.wine.model.Order.ShipTypeEnum;
import top.guhanjie.wine.model.PointDetail;
import top.guhanjie.wine.model.RushItem;
import top.guhanjie.wine.model.User;
import top.guhanjie.wine.util.DateTimeUtil;
import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.msg.MessageKit;

/**
 * Class Name:		OrderService<br/>
 * Description:		[description]
 * @time			2016年9月1日 下午1:46:59
 * @author			GUHANJIE
 * @version			1.0.0 
 * @since 			JDK 1.7 
 */

@Service
public class OrderService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OrderService.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PointService pointService;
	
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private RushItemService rushItemService;
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private WeixinConstants weixinConstants;
	
	/*
	 * 返回值的order对象中包含user的id
	 * 为什么一定要包含userid这个值？
	 * 因为订单请求有可能用户之前根本就没注册，在OrderController中我们还会依据user进行后续操作，比如刷新session等动作
	 */
	public Order putOrder(Order order) {
		if(order == null) {
			LOGGER.error("put order error, order is null");
			throw WebExceptionFactory.exception(WebExceptionEnum.PARAMETER_NULL);
		}
		// 1. 检查用户信息 
		Integer userid = order.getUserId();
		User user = null;
		if(userid == null) {	//若用户不存在，首次进入添加user记录
			if(StringUtils.isBlank(order.getPhone())) {
				LOGGER.error("put order error, user not exist, order:[{}]", order.getId());
				throw WebExceptionFactory.exception(WebExceptionEnum.USER_NOT_EXIST);
			}
			//新建用户
			user = userService.getUserByPhone(order.getPhone());
			if(user == null) {
	            user = new User();
	            user.setName(order.getContactor());
	            user.setPhone(order.getPhone());
	            user.setAddress(order.getAddress());
	            user.setCreateTime(new Date());
	            LOGGER.info("user first in while putting order, add an new user:[{}]", JSON.toJSONString(user));
	            userService.addUser(user);
			}
			order.setUserId(user.getId());
		}
		else {
			user = userService.getUserById(userid);
		}
		if(StringUtils.isBlank(user.getPhone())) {    //用户信息默认不含手机号码，第一次用户填写信息时记录手机号码
		    String phone = order.getPhone();
		    if(StringUtils.isBlank(phone)) {
		        throw WebExceptionFactory.exception(WebExceptionEnum.DATA_NOT_WELL, "缺失联系方式");
		    }
		    user.setPhone(phone);
		    userService.updateUser(user);
		}
        if(StringUtils.isBlank(user.getAddress())) {    //用户信息默认不含地址，第一次用户填写信息时记录地址
            String address = order.getAddress();
            if(StringUtils.isBlank(address)) {
                throw WebExceptionFactory.exception(WebExceptionEnum.DATA_NOT_WELL, "缺失收货地址");
            }
            user.setAddress(address);
            userService.updateUser(user);
        }
		if(StringUtils.isBlank(order.getContactor())) {
			String username = StringUtils.isBlank(user.getName()) ? user.getNickname() : user.getName();
			order.setContactor(username);
		}
		if(StringUtils.isBlank(order.getPhone())) {
			order.setPhone(user.getPhone());
		}
		if(StringUtils.isBlank(order.getAddress())) {
			order.setAddress(user.getAddress());
		}
		// 2. 检查订单来源
		String sourceType = order.getSourceType();
		StringBuilder purchases = new StringBuilder("");
		// 普通商品下单流程
		if(Order.SourceTypeEnum.NORMAL.code().equalsIgnoreCase(sourceType)) {
			// 2-1. 检查订单总额
			double total = 0.0;
			String items = order.getItems();
			String[] it = items.split(",");
			for(String str : it) {
				String[] iteminfo = str.split(":");
				Integer itemId = Integer.parseInt(iteminfo[0]);
				Integer count = Integer.parseInt(iteminfo[1]);
				Item item = itemService.getItem(itemId);
				purchases.append(item.getName()+"\t"+count+"件\n");
				double price = user.isAgent()? item.getVipPrice().doubleValue() : item.getNormalPrice().doubleValue();
				total += count * price;
			}
			double totalAmount = order.getTotalAmount().doubleValue();
			double pay = total + order.getShips().doubleValue() - order.getCoupons();
			double payAmount = order.getPayAmount().doubleValue();
			//校验订单金额（计算金额与前端展示金额误差在1.0以内）
			if(Math.abs(total-totalAmount) > 0.1 || Math.abs(pay-payAmount) > 0.1) {
			    LOGGER.error("order payment error: total[{}]-totalAmount[{}], pay[{}]-payAmount[{}]", 
			            total, totalAmount, pay, payAmount);
			    throw WebExceptionFactory.exception(WebExceptionEnum.VALIDATE_ERROR, "订单金额有误");
			}
	        itemService.addSales(items);	//插入商品销售记录
		}
		// 1元抢购下单流程
		else if(Order.SourceTypeEnum.RUSH.code().equalsIgnoreCase(sourceType)) {
			// 2-1. 检查订单总额
			double total = 0.0;
			String items = order.getItems();
			String[] it = items.split(",");
			for(String str : it) {
				String[] iteminfo = str.split(":");
				Integer itemId = Integer.parseInt(iteminfo[0]);
				Integer count = Integer.parseInt(iteminfo[1]);
				RushItem item = rushItemService.getItem(itemId);
				purchases.append(item.getName()+"\t"+count+"件\n");
				double price = user.isAgent()? item.getVipPrice().doubleValue() : item.getNormalPrice().doubleValue();
				total += count * price;
			}
			double totalAmount = order.getTotalAmount().doubleValue();
			double pay = total + order.getShips().doubleValue() - order.getCoupons();
			double payAmount = order.getPayAmount().doubleValue();
			//校验订单金额（计算金额与前端展示金额误差在1.0以内）
			if(Math.abs(total-totalAmount) > 0.1 || Math.abs(pay-payAmount) > 0.1) {
			    LOGGER.error("order payment error: total[{}]-totalAmount[{}], pay[{}]-payAmount[{}]", 
			            total, totalAmount, pay, payAmount);
			    throw WebExceptionFactory.exception(WebExceptionEnum.VALIDATE_ERROR, "订单金额有误");
			}
		}
		
		// 3. 生成订单
		order.setCreateTime(new Date());
		order.setStatus(Order.StatusEnum.NEW.code());
		orderMapper.insertSelective(order);	//插入订单记录
        pointService.consumePoints(user.getId(), order.getCoupons(), order.getId());	//更新用户积分
		
		// 4. 发送微信消息通知客服
		StringBuilder sb = new StringBuilder("主人，您有新的订单：\n");
		sb.append("订单ID：").append(order.getId()).append("\n");
		sb.append("支付金额：").append(order.getTotalAmount()).append("元\n");
		sb.append("联系人：").append(order.getContactor()).append("\n");
		sb.append("联系电话：").append(order.getPhone()).append("\n");
		sb.append("购买商品：").append(purchases).append("\n");
		sb.append("配送地址：").append(order.getAddress()).append("\n");
		if(order.getShipType() != null) {
			sb.append("配送方式：").append(ShipTypeEnum.valueOf(order.getShipType()).desc()).append("\n");
		}
		sb.append("创建时间：").append(DateTimeUtil.formatDate(order.getCreateTime(), "yyyy-MM-dd HH:mm")).append("\n");
		sb.append("备注：").append(order.getRemark()==null?"无":order.getRemark()).append("\n");
		MessageKit.sendKFMsg(weixinConstants.KF_OPENIDS, sb.toString());
		
		return order;
	}
	
	public PageImpl<Order> listOrders(Date beginTime, Date endTime, Pageable pageable) {
		//查询条件
        Map<String, Object> param = new HashMap<String, Object>();
        if(beginTime != null) {
            param.put("beginTime", beginTime);
        }
        if(endTime != null) {
            param.put("endTime", endTime);
        }
        param.put("offset", pageable.getOffset());
        param.put("pagesize", pageable.getPageSize());
        
        int total = orderMapper.countSelective(param);
        List<Order> list = orderMapper.selectByQualifiedPage(param);
        if(list != null) {
            for(Order order : list) {
            	parseItems(order);
            }
        }
        PageImpl<Order> page = new PageImpl<Order>(list, pageable, total);
        return page;
	}
	
	public List<Order> getOrdersByUser(User user) {
		List<Order> result = null;
		if(user!=null) {
		    if(user.getId() != null) {
		        result = orderMapper.selectByUserId(user.getId());
		    }
		    if(user.getOpenId() != null) {
		        result = orderMapper.selectByUserOpenId(user.getOpenId());
		    }
		    if(user.getPhone() != null) {
		        result = orderMapper.selectByUserPhone(user.getPhone());
		    }
		}
		if(result != null) {
		    for(Order order : result) {
		    	parseItems(order);
		    }
		}
		return result;
	}
	
	public Order getOrderById(Integer orderId) {
		return orderMapper.selectByPrimaryKey(orderId);
	}
	
	/**
	 * Method Name:	updatePayInfo<br/>
	 * Description:			[更新订单的预支付信息]
	 * @author				GUHANJIE
	 * @time					2016年10月17日 上午10:30:28
	 * @param order
	 */
	public void updatePayInfo(Order order) {
	    if(order != null && order.getId() != null) {
	    	//just update pay related info, disable status and other fields update for security
	    	if(order.getPayId()!=null) {
		        Order o = new Order();
		        o.setId(order.getId());
		        o.setPayId(order.getPayId());
		        orderMapper.updateByPrimaryKeySelective(o);
	    	}
	    }
	}

	/**
	 * Method Name:	updateOrderByPay<br/>
	 * Description:			[更新订单的支付状态]
	 * @author				GUHANJIE
	 * @time					2016年10月17日 上午10:30:55
	 * @param success
	 * @param orderid
	 * @param total_fee
	 * @param time_end
	 */
	public void updateOrderByPay(boolean success, Integer orderid, String total_fee, String time_end) {
	    LOGGER.info("Updating order[{}] pay info: sucess=[{}], total_fee=[{}], time_end=[{}]...", orderid, success, total_fee, time_end);
	    if(orderid==null || total_fee==null || time_end==null) {
	    	LOGGER.warn("error in updating order pay, as pay info not complete: order_id=[{}], total_fee=[{}], time_end=[{}].", orderid, total_fee, time_end);
	    	return;
	    }
	    Order order = getOrderById(orderid);
	    if(order==null) {
	        LOGGER.warn("order[{}] not exists", orderid);
	        return;
	    }
	    //一旦订单状态到达“支付成功”，就不再进行后续处理
	    int oldOrderStatus = order.getStatus();
	    int oldPayStatus = order.getPayStatus();
	    if(oldPayStatus == PayStatusEnum.SUCCESS.code()) {
	        LOGGER.info("order[{}] pay has succeed, no more to handler.", orderid);
	        return;
	    }
        if(success) {
        	LOGGER.info("Order[{}] pay complete successfully!!!", orderid);
            order.setStatus(Order.StatusEnum.PAYED.code());
            order.setPayStatus(PayStatusEnum.SUCCESS.code());
            order.setPayType(PayTypeEnum.WEIXIN.code());
            order.setPayTime(DateTimeUtil.getDate(time_end, "yyyyMMddHHmmss"));
            int payAmount = order.getPayAmount().multiply(new BigDecimal(100)).setScale(0, BigDecimal.ROUND_HALF_DOWN).intValue();
            if(payAmount != Integer.valueOf(total_fee).intValue()) {
            	LOGGER.error("Pay amount not matched: topay=[{}], actual payed=[{}]", payAmount, total_fee);
            	//这个地方有点小问题：订单待支付的和实际支付的金额不吻合，订单状态置为错误，但是用户实际支付的钱怎么办呢？（需要确保支付订单的金额和商城下订单时保持一致！！！）
            	order.setPayStatus(PayStatusEnum.PAYERROR.code());
            }
        }
        //更新订单支付状态
        LOGGER.info("===updating order[{}] status:[{}]-->[{}], pay status:[{}]-->[{}].", orderid, oldOrderStatus, order.getStatus(), oldPayStatus, order.getPayStatus());
        if(1 == orderMapper.updateByPayStatus(order, oldOrderStatus, oldPayStatus)) {
            LOGGER.info("Success to update order[{}] pay! status:[{}]-->[{}], pay status:[{}]-->[{}].", orderid, oldOrderStatus, order.getStatus(), oldPayStatus, order.getPayStatus());
        }
        else {
            LOGGER.warn("Failed to update order[{}] pay, maybe already been updated before", orderid);
            return;
        }
        
        // 当订单支付成功时，计算推广积分、发送客服通知短信
        LOGGER.info("order pay_status=[{}]", order.getPayStatus());
        if(order.getPayStatus() == PayStatusEnum.SUCCESS.code()) {
            // 推荐人的积分提成
            processAgent(order);
            
            // 支付成功，发送微信消息通知客服
            StringBuffer sb = new StringBuffer("主人，您有一笔订单已完成支付：\n");
            sb.append("订单ID：").append(orderid).append("\n");
            sb.append("支付金额：").append(Double.valueOf(total_fee)/100).append("元\n");
            sb.append("支付时间：").append(DateTimeUtil.formatDate(order.getPayTime())).append("\n");
            sb.append("联系人：").append(order.getContactor()).append("\n");
            sb.append("联系电话：").append(order.getPhone()).append("\n");
            sb.append("创建时间：").append(DateTimeUtil.formatDate(order.getCreateTime())).append("\n");
            MessageKit.sendKFMsg(weixinConstants.KF_OPENIDS, sb.toString());
        }
	}
	
	public boolean cancelOrder(Order order) {
        if(order == null) {
            LOGGER.warn("order can not be null.");
            return false;
        }
        LOGGER.info("cancelling order[{}]...", order.getId());
		long startTime = order.getCreateTime().getTime();
		long now = System.currentTimeMillis();
		//只有订单状态为新建，才可取消订单
		if(order.getStatus()==Order.StatusEnum.NEW.code()) {
			order.setStatus(Order.StatusEnum.CANCEL.code());
			order.setUpdateTime(new Date());
			if(1 == orderMapper.updateByStatus(order, Order.StatusEnum.NEW.code())) {
				//撤销用户因此单扣减的积分
				pointService.refundPoints(order.getUserId(), order.getCoupons(), order.getId());
			    LOGGER.info("success to cancel order[{}]", order.getId());
			    // 订单被取消，发送微信消息通知客服
	            StringBuffer sb = new StringBuffer("主人，您有一笔订单已取消：\n");
	    		sb.append("订单ID：").append(order.getId()).append("\n");
	    		sb.append("订单金额：").append(order.getTotalAmount()).append("元\n");
	    		sb.append("联系人：").append(order.getContactor()).append("\n");
	    		sb.append("联系电话：").append(order.getPhone()).append("\n");
	    		sb.append("创建时间：").append(DateTimeUtil.formatDate(order.getCreateTime())).append("\n");
	            MessageKit.sendKFMsg(weixinConstants.KF_OPENIDS, sb.toString());
				return true;
			}
		}
		throw WebExceptionFactory.exception(WebExceptionEnum.ORDER_CANCEL_ERROR, "当前订单状态无法取消");
	}
	
	/**
	 * Method Name:	finishOrderPay<br/>
	 * Description:			[管理员手动完成订单支付，支持当面付现支付场景]
	 * @author				GUHANJIE
	 * @time					2016年10月17日 上午10:03:24
	 * @param order
	 * @return
	 */
	public boolean finishOrderPay(Order order) {
	    if(order == null) {
	        LOGGER.warn("order can not be null.");
	        return false;
	    }
	    LOGGER.info("finishing pay order[{}]...", order.getId());    
        int oldOrderStatus = order.getStatus();
        int oldPayStatus = order.getPayStatus();
        order.setStatus(Order.StatusEnum.PAYED.code());
        order.setPayStatus(PayStatusEnum.SUCCESS.code());
        order.setPayType(PayTypeEnum.CASH.code());
        order.setPayTime(new Date());
        if(1 == orderMapper.updateByPayStatus(order, oldOrderStatus, oldPayStatus)) {
        	// 推荐人的积分提成
            processAgent(order);
            // 一元抢购活动
            if(Order.SourceTypeEnum.RUSH.code().equalsIgnoreCase(order.getSourceType())) {
            	rushItemService.putItem(order);
            }
            return true;
        }
        throw WebExceptionFactory.exception(WebExceptionEnum.PAY_ERROR, "当前订单支付出错");
    }

    private void parseItems(Order order) {
		if(Order.SourceTypeEnum.NORMAL.code().equalsIgnoreCase(order.getSourceType())) {
	    	List<Item> itemList = new ArrayList<Item>();
	    	String items = order.getItems();
			String[] it = items.split(",");
			for(String str : it) {
				String[] iteminfo = str.split(":");
				Integer itemId = Integer.parseInt(iteminfo[0]);
				Integer count = Integer.parseInt(iteminfo[1]);
				Item item = itemService.getItem(itemId).deepCopy();
				item.setCount(count);
				itemList.add(item);
			}
	    	order.setItemList(itemList);
		}
		else if(Order.SourceTypeEnum.RUSH.code().equalsIgnoreCase(order.getSourceType())) {
			List<RushItem> itemList = new ArrayList<RushItem>();
	    	String items = order.getItems();
			String[] it = items.split(",");
			for(String str : it) {
				String[] iteminfo = str.split(":");
				Integer itemId = Integer.parseInt(iteminfo[0]);
				Integer count = Integer.parseInt(iteminfo[1]);
				RushItem item = rushItemService.getItemByOrder(order.getId(), itemId).deepCopy();
				item.setCount(count);
				itemList.add(item);
			}
	    	order.setRushItemList(itemList);
		}
		else {
			throw new RuntimeException("订单商品信息解析出错");
		}
    }
    
    /**
     * 代理商的相关处理逻辑（升级代理商，返送积分）
     */
    private void processAgent(Order order) {
        LOGGER.debug("Starting to process agent for order[{}]...", order.getId());
    	// parse order owner
        int userid =  order.getUserId();
        User user = userService.getUserById(userid);
        if(user == null) {
            LOGGER.error("order[{}] malformed, user[{}] does not exist", order.getId(), userid);
            return;
        }
        order.setUser(user);
        // parse items for order
        List<Item> itemList = new ArrayList<Item> ();
        String items = order.getItems();
        String[] itemPairs = items.split(",");
        for(String itemPair : itemPairs) {
            String[] itemInfo = itemPair.split(":");
            Integer itemId = Integer.valueOf(itemInfo[0]);
            Integer count = Integer.valueOf(itemInfo[1]);
            Item item = itemService.getItem(itemId);
            itemList.add(item);
        }
        order.setItemList(itemList);
        //升级为代理商
        boolean upgrade = upgradeAgent(order);
        //分配提成积分给代理商
        assignReturnPoints(order);
        LOGGER.debug("End to process agent for order[{}].", order.getId());
    }
    
    /**
     * 升级代理商（通过校验该用户下单中是否购买了“代理专区”的商品，若有，且之前不是代理商，则升级为代理商）
     */
    private boolean upgradeAgent(Order order) {
        boolean canAgent = false;
        User user = order.getUser();
        if(user.isAgent()) {
            LOGGER.info("skip to upgrade agent, because user[{}] has been agent already.", order.getUserId());
        }
        else {
            for(Item item : order.getItemList()) {
                //WARNING!!! Hard coding for 代理专区 category id 15
                if(15 == item.getCategoryId()) {
                    canAgent = true;
                    break;
                }
            }
            if(canAgent) {
                LOGGER.info("starting to upgrade agent for user[{}] in order[{}]...", order.getUserId(), order.getId());
                user.setType(User.TypeEnum.AGENT.code());
                userService.updateUser(user);
                if(user.getSourceId() != null) {
                    User promoter = userService.getUserById(user.getSourceId());
                    if(promoter != null && promoter.isAgent()) {
                        LOGGER.info("===[Upgrade Agent Points Assignment]===");
                        LOGGER.info("starting to assign promote points for order[{}]...", order.getId());
                        int promoterid = promoter.getId();
                        int points = order.getTotalAmount().intValue() / 2;
                        LOGGER.info("order[{}] amount=[{}], promote points=[{}] to user[{}].", order.getId(), order.getTotalAmount(), points, promoterid);
                        pointService.addPointsForAgent(promoterid, points, order.getUserId(), order.getId(), PointDetail.RemarkEnum.AGENT_PROMOTE.remark());
                        LOGGER.info("success to assign promote points[{}] to user[{}] for order[{}].", points, promoterid, order.getId());
                    }
                }
                LOGGER.info("success to upgrade agent for user[{}] in order[{}].", order.getUserId(), order.getId());
            }
        }
        return canAgent;
    }
    
    /**
     * 分配推广积分<br/>
     * 推广有两种模式：1：代理商推广用户购买，2：代理商平推代理商
     * 模式1：推广用户完成订单支付后，给推广人相应订单的积分（提成按“正常价-代理商价”的差价计算），每单都算
     * 模式2：代理商平推某个用户成为代理商，给推广人购买成为代理商订单总额的一半积分，仅一次有效
     */
    private void assignReturnPoints(Order order) {
        int orderid = order.getId();
        int amount = order.getTotalAmount()==null ? 0 : order.getTotalAmount().intValue();
        User user = order.getUser();
        if(user.getSourceId() == null) {
            LOGGER.info("skip to assign promote points, because order owner[{}] has no promoter.", order.getUserId());
            return;
        }
        User promoter = userService.getUserById(user.getSourceId());
        //发分条件：1.用户为普通会员，2.有推广人，3.推广人是代理商
        if(!user.isAgent() && promoter != null && promoter.isAgent()) {
            LOGGER.info("===[Agent Points Assignment]===");
            LOGGER.info("starting to assign return points for order[{}]...", orderid);
            //统计该订单下差价提成
            int points = 0;
            String items = order.getItems();
            String[] itemPairs = items.split(",");
            for(String itemPair : itemPairs) {
                String[] itemInfo = itemPair.split(":");
                Integer itemId = Integer.valueOf(itemInfo[0]);
                Integer count = Integer.valueOf(itemInfo[1]);
                Item item = itemService.getItem(itemId);
                points += (item.getNormalPrice().intValue()-item.getVipPrice().intValue())*count;
            }
            int promoterid = promoter.getId();
            LOGGER.info("order[{}] amount=[{}], promote points=[{}] to user[{}].", orderid, amount, points, promoterid);
            pointService.addPointsForAgent(promoterid, points, order.getUserId(), orderid, PointDetail.RemarkEnum.AGENT_RETURN.remark());
            LOGGER.info("success to assign return points[{}] to user[{}] for order[{}].", points, promoterid, orderid);
        }
    }
}
