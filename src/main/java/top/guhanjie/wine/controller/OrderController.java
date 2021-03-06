/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.controller 
 * File Name:			OrderController.java 
 * Create Date:		2016年9月1日 上午10:32:19 
 * Copyright (c) 2008-2016, 平安集团-平安万里通 All Rights Reserved.
 */  
package top.guhanjie.wine.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.exception.WebException;
import top.guhanjie.wine.exception.WebExceptionEnum;
import top.guhanjie.wine.exception.WebExceptionFactory;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.model.Order;
import top.guhanjie.wine.model.User;
import top.guhanjie.wine.service.ItemService;
import top.guhanjie.wine.service.OrderService;
import top.guhanjie.wine.service.UserService;
import top.guhanjie.wine.util.DateTimeUtil;
import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.pay.PayKit;

/**
 * Class Name:		OrderController<br/>
 * Description:		[description]
 * @time				2016年9月1日 上午10:32:19
 * @author			GUHANJIE
 * @version			1.0.0 
 * @since 			JDK 1.7 
 */
@Controller
@RequestMapping("/order")
public class OrderController extends BaseController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private WeixinConstants weixinContants;
    
	@Autowired
	private UserService userService;

    @Autowired
    private ItemService itemService;
    
	@Autowired
	private OrderService orderService;
	
	@Resource(name="wine-scheduler4weixin")
	private TaskScheduler taskScheduler;
	
	@RequestMapping(value={"/checkout"},method=RequestMethod.GET)
	public String checkout(Model model, HttpSession session, String type) {
		getSessionUser(); //refresh user info from DB
		List<Item> items = new ArrayList<Item>();
		Object obj = session.getAttribute("cart");
		Map<Integer, Integer> cart = null;
		if(obj != null) {
			cart = (Map<Integer, Integer>)obj;
		}
		if(cart != null) {
			for(Integer i : cart.keySet()) {
				Integer count = cart.get(i);
				Item item = itemService.getItem(i);
				items.add(item);
			}
		}
		model.addAttribute("items", items);
		model.addAttribute("cartType", type);
		return "checkout";
	}
	
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value="/cart/add",method=RequestMethod.POST)
//	@ResponseBody
//	public Map<String, Object> add(Integer itemId, Integer count, HttpSession session) {
//		User user = getSessionUser();
//		LOGGER.info("user[{}] added cart of item=[{}], count=[{}]", user.getId(), itemId, count);
//		Object obj = session.getAttribute("cart");
//		Map<Integer, Integer> cart = null;
//		if(obj != null) {
//			cart = (Map<Integer, Integer>)obj;
//		}
//		else {
//			cart = new HashMap<Integer, Integer>();
//			session.setAttribute("cart", cart);
//		}
//		Integer c = cart.get(itemId);
//		Integer newCount = (c == null) ? count : (c+count);
//		cart.put(itemId, newCount);
//		return success();
//	}
	
//	@RequestMapping(value={"", "pre"},method=RequestMethod.GET)
//	public String order(HttpServletRequest req, HttpServletResponse resp, 
//	                                        Model model, 
//	                                        @RequestParam(required=false) String phone, 
//	                                        @RequestParam(required=false) String source) {
//	    resp.setHeader("Cache-Control", "no-cache");
//	    if(getSessionUser()==null && StringUtils.isNotBlank(phone)) {
//    	    User user = userService.getUserByPhone(phone);
//    	    if(user != null) {
//    	        setSessionUser(user);
//    	        req.getSession().setAttribute(AppConstants.SESSION_KEY_OPEN_ID, user.getOpenId());
//    	    }
//	    }
//	    if(StringUtils.isNotBlank(source)) {
//	        model.addAttribute("source", source);
//	    }
//		return "order";
//	}
	
	@RequestMapping(value="put",method=RequestMethod.POST, consumes="application/json")
	@ResponseBody
	public Map<String, Object> putOrder(HttpServletRequest req, HttpServletResponse resp, 
    	                                                    @RequestBody Order order, 
    	        	                                        @RequestParam(required=false) String source) {
	    resp.setHeader("Cache-Control", "no-cache");
		//获取用户信息
		User user = getSessionUser();
		LOGGER.info("putting new order for user [{}]...", JSON.toJSONString(user, true));
		LOGGER.info("=====order:[{}]...", JSON.toJSONString(order, true));
		if(user == null) {
		    user = new User();
		    user.setPhone(order.getPhone());
		    setSessionUser(user);
		}
		//封装信息
		order.setUserId(user.getId());
		//order.setSource(source);
		//下单
		order = orderService.putOrder(order);
		user = userService.getUserById(order.getUserId());
		setSessionUser(user);  //更新会话中用户信息，可能用户积分、会员身份变动了
		return success(order);
	}

	@ResponseBody
    @RequestMapping(value="list_admin",method=RequestMethod.GET)
    public Map<String, Object> listOrdersAdmin(HttpServletRequest req, HttpServletResponse resp, Model model, 
                    @RequestParam(required=false) String beginDate, //yyyy-mm-dd
                    @RequestParam(required=false) String endDate,    //yyyy-mm-dd
                    @PageableDefault(page=0, size=5) Pageable pageable) {        
	    resp.setHeader("Cache-Control", "no-cache");
        Date beginTime = null;
        Date endTime = null;
        if(StringUtils.isNotBlank(beginDate)){
            beginTime = DateTimeUtil.getDate(beginDate + " 00:00:00", "yyyy-MM-dd HH:mm:ss");
        }       
        if(StringUtils.isNotBlank(endDate)){
            endTime = DateTimeUtil.getDate(endDate + " 23:59:59", "yyyy-MM-dd HH:mm:ss");
        }
        PageImpl<Order> page = orderService.listOrders(beginTime, endTime, pageable);
        
        Map<String, Object> rt = success();
        rt.put("orders", page.getContent());
        rt.put("current", page.getNumber());
        rt.put("pages", page.getTotalPages());
        rt.put("now", new Date());
        return rt;
    }
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	public String listOrder(HttpServletRequest req, HttpServletResponse resp, Model model) {
	    resp.setHeader("Cache-Control", "no-cache");
		User user = getSessionUser();
		List<Order> orders = orderService.getOrdersByUser(user);
		model.addAttribute("orders", orders);
		model.addAttribute("now", new Date());
		return "order_list_user";
	}
	
	@RequestMapping(value="cancel",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cancelOrder(Integer orderid) {
		Order order = orderService.getOrderById(orderid);
		if(order == null) {
			return fail("无效的订单号");
		}
		try {
			orderService.cancelOrder(order);
			return success();
		} catch(WebException e) {
			return fail(e.getScreenMessage());
		}
	}
	
	@RequestMapping(value="payed",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> finishOrderPay(Integer orderid) {
	    Order order = orderService.getOrderById(orderid);
	    if(order == null) {
	        return fail("无效的订单号");
	    }
	    try {
	        orderService.finishOrderPay(order);
	        return success();
	    } catch(WebException e) {
	        return fail(e.getScreenMessage());
	    }
	}
	
	@RequestMapping(value="pay",method=RequestMethod.GET)
    @ResponseBody
	public Map<String, Object> payOrder(HttpServletRequest req, HttpServletResponse resp, final Integer orderid) {
	    resp.setHeader("Cache-Control", "no-cache");
	    final String APPID = weixinContants.APPID;
	    final String MCH_ID = weixinContants.MCH_ID;
	    final String MCH_KEY = weixinContants.MCH_KEY;
	    //查询订单
        final Order order = orderService.getOrderById(orderid);
        if(order == null) {
            return fail("无效的订单号");
        }
        //1元抢购活动
        if(Order.SourceTypeEnum.RUSH.code().equalsIgnoreCase(order.getSourceType())) {
        	orderService.finishOrderPay(order);
        	Map<String, Object> res = success();
        	res.put("rush", "true");
        	return res;
        }
        //获取订单的微信预支付id
        String prepayid = order.getPayId();
        try {
            if(prepayid != null) {  //若先前发起过支付，需要验证prepayid是否已关闭
                Map<String, String>map = PayKit.search(order, APPID, MCH_ID, MCH_KEY);
                String result = map.get("result");
                //若该prepayid对应的支付请求已失效或者异常则重新下单
                if("FAIL".equals(result)) {
                    String payStatus = map.get("trade_state");
                    if(!"USERPAYING".equals(payStatus)) {  //只要不是用户正在支付的状态，其他都属于异常，重新生成prepayid
                        prepayid = null;
                    }
                }
            }
            if(prepayid == null) {  //第一次发起支付，或支付已关闭，或支付价格变更，或者其他异常
                prepayid = PayKit.unifiedorder(req, order, APPID, MCH_ID, MCH_KEY);
                order.setPayId(prepayid);
                orderService.updatePayInfo(order);
            }
            //定时（10分钟）查询订单支付情况
        	long now = new Date().getTime();
        	taskScheduler.schedule(new Runnable() {
                @Override
                public void run() {
                    LOGGER.info("search order[{}] in timed schedule...", order.getId());
                    Map<String, String> map;
                    try {
                        map = PayKit.search(order, APPID, MCH_ID, MCH_KEY);
                        String result = map.get("result");
                        Integer orderid = Integer.valueOf(map.get("out_trade_no"));
                        String total_fee = map.get("total_fee");
                        String time_end = map.get("time_end");
                        boolean success = "SUCCESS".equals(result);                    
                        orderService.updateOrderByPay(success, orderid, total_fee, time_end);
                    }
                    catch (Exception e) {
                        LOGGER.error("error in search pay result for order[{}].", orderid, e);
                    }
                }
        	}, new Date(now+10*60*1000));       //产生支付预付单后的10分钟查询，以防微信支付回调没有接收到。
        }
        catch (IOException e) {
            LOGGER.error("error in unified weixin pay for order[{}].", order.getId());
        }
        
        if(StringUtils.isBlank(prepayid)) {
        	throw WebExceptionFactory.exception(WebExceptionEnum.PAY_ERROR, "支付系统有误，目前无法支付");
        }
        Map<String, String> payParams = new HashMap<String, String>();
        final String nonceStr = String.valueOf(new Random().nextInt(10000));
        payParams.put("appId", APPID);                                  //公众号id
        payParams.put("timeStamp", String.valueOf(System.currentTimeMillis()/1000));         //时间戳
        payParams.put("nonceStr", nonceStr);                                                   //随机字符串
        payParams.put("package", "prepay_id="+prepayid);                              //订单详情扩展字符串
        payParams.put("signType", "MD5");                                                       //签名方式
        payParams.put("paySign", PayKit.sign(payParams, MCH_KEY)); //签名        
		return success(payParams);
	}
	
	/**
	 * 用户支付完成后的回调地址
	 */
	@RequestMapping(value="paycallback")
	public void paycallback(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		LOGGER.info("getting callback from weixin pay...");
		
		Map<String, String> map = PayKit.callback(req, weixinContants.MCH_KEY);
		String result = map.get("result");
		Integer orderid = Integer.valueOf(map.get("out_trade_no"));
		String total_fee = map.get("total_fee");
		String time_end = map.get("time_end");
		boolean success = "SUCCESS".equals(result);
		
		orderService.updateOrderByPay(success, orderid, total_fee, time_end);
		
        resp.setContentType("application/xml;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String respCon = "<xml>"
        						+ "	<return_code><![CDATA[SUCCESS]]></return_code>"
        						+ "	<return_msg><![CDATA[OK]]></return_msg>"
        						+ "</xml>";
        LOGGER.debug("Weixin msg response= "+respCon);
        resp.getWriter().write(respCon);
		resp.getWriter().flush();
	}
}
