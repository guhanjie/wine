/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.weixin.pay 
 * File Name:			PayKit.java 
 * Create Date:		2016年9月26日 下午10:49:11 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.weixin.pay;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import top.guhanjie.wine.controller.AppConstants;
import top.guhanjie.wine.model.Order;
import top.guhanjie.wine.util.HttpUtil;
import top.guhanjie.wine.util.MD5Util;
import top.guhanjie.wine.util.XmlUtil;
import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.WeixinHttpUtil;
import top.guhanjie.wine.weixin.WeixinHttpUtil.WeixinHttpCallback;
import top.guhanjie.wine.weixin.msg.MessageKit;

/**
 * Class Name:		PayKit<br/>
 * Description:		[description]
 * @time				2016年9月26日 下午10:49:11
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public class PayKit {

    private static final Logger LOGGER = LoggerFactory.getLogger(PayKit.class);
    
    /**
     * Method Name:	unifiedorder<br/>
     * Description:			[除被扫支付场景以外，商户系统先调用该接口在微信支付服务后台生成预支付交易单，
     *                              返回正确的预支付交易回话标识后再按扫码、JSAPI、APP等不同场景生成交易串调起支付。]
     * @author				guhanjie
     * @time					2016年9月30日 上午1:39:12
     * @param request
     * @param order
     * @param appid
     * @param mchid
     * @throws IOException
     */
    public static String unifiedorder(HttpServletRequest request, final Order order, final String appid, final String mchid, final String mchkey) throws IOException {
        if(order == null) {
            LOGGER.warn("order can not be nulll in unified order.");
            return null;
        }
        LOGGER.info("starting to unified order to weixin for order:[{}]...", order.getId());

        final StringBuilder prepayId = new StringBuilder();        
        
    	final String nonceStr = String.valueOf(new Random().nextInt(10000));
        Map<String, String> map = new HashMap<String, String>();
        map.put("appid", appid);                                                                         //公众账号ID
        map.put("mch_id", mchid);                                                                   //商户号
        map.put("device_info", "WEB");                                                              //设备号(PC网页或公众号内支付请传"WEB")
        map.put("nonce_str", nonceStr);                                                         //随机字符串
        map.put("body", "如果酒业-酒类");                                         //商品描述
        //map.put("detail", "商品详细列表，使用Json格式，传输签名前请务必使用CDATA标签将JSON文本串保护起来。");          //商品详情
        //map.put("attach", "附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据");
        map.put("out_trade_no", order.getId().toString());                                  //商户订单号
        map.put("fee_type", "CNY");                                                                 //货币类型
        int money = order.getPayAmount().intValue()*100;                   
//        if(order.getTip() != null) {
//            money += order.getTip().intValue()*100;
//        }
        map.put("total_fee", String.valueOf(money));                           //总金额，订单总金额，单位为分
        map.put("spbill_create_ip", HttpUtil.getIpAddress(request));                    //用户端IP
        map.put("time_start", new SimpleDateFormat("yyyyMMddHHmmss", Locale.CHINA).format(new Date()));                 //交易起始时间，格式为yyyyMMddHHmmss
        //map.put("time_expire", "订单失效时间，格式为yyyyMMddHHmmss,最短失效时间间隔必须大于5分钟");                       //交易结束时间
        //map.put("goods_tag", "WXG");                                                          //商品标记
        map.put("notify_url", WeixinConstants.API_PAY_CALLBACK);                //通知地址，接收微信支付异步通知回调地址
        map.put("trade_type", "JSAPI");                                                         //交易类型
        //map.put("product_id", "此id为二维码中包含的商品ID，商户自行定义");//商品ID
        //map.put("limit_pay", "no_credit--指定不能使用信用卡支付");               //支付方式
        map.put("openid", (String)request.getSession().getAttribute(AppConstants.SESSION_KEY_OPEN_ID));                         //用户标识        
        map.put("sign", sign(map, mchkey));                                                             //签名
        String reqOrderStr = XmlUtil.map2xmlstr(map);
        LOGGER.debug("=====set request for weixin unified order:[{}].", reqOrderStr);
        
        HttpEntity entity = new StringEntity(reqOrderStr, ContentType.create("application/xml", Consts.UTF_8));
        WeixinHttpUtil.sendPost(WeixinConstants.API_PAY_UNIFIEDORDER, entity, new WeixinHttpCallback() {
            @Override
            public void process(String respBody) {
                Map<String, String> map = XmlUtil.xmlstr2map(respBody);
                LOGGER.debug("=====got response from weixin unified order:[{}].", map);
                String return_code = map.get("return_code");                                        //返回状态码SUCCESS/FAIL，此字段是通信标识，非交易标识，交易是否成功需要查看result_code来判断
                String return_msg = map.get("return_msg");                                          //返回信息
                String appid = map.get("appid");                                                        //公众账号ID
                String mch_id = map.get("mch_id");                                                  //商户号
                String device_info = map.get("device_info");                                        //设备号
                String nonce_str = map.get("nonce_str");                                            //随机字符串
                String sign = map.get("sign");                                                          //签名
                String result_code = map.get("result_code");                                    //业务结果
                String err_code = map.get("err_code");                                              //错误代码
                String err_code_des = map.get("err_code_des");                              //错误代码描述
                String trade_type = map.get("trade_type");                                  //交易类型JSAPI
                String prepay_id = map.get("prepay_id");                                     //预支付交易会话ID
                String code_url = map.get("code_url");                                            //二维码链接
                if(!"SUCCESS".equals(return_code)) {
                	LOGGER.error("fail to get response for weixin unified order api, cause:[{}]", return_msg);
                	return;
                }
            	//验签
                String signature = sign(map, mchkey);
                if(sign==null || !sign.equals(signature)) {
                	LOGGER.warn("signature validation failed, this response maybe fake!");
                	return;
                }
                //验证随机字符串nonce，防CSRF攻击
//                    if(!nonceStr.equals(nonce_str)) {
//                        LOGGER.warn("nonce not matched(CSRF warning), this response maybe fake!");
//                        return;
//                    }
                //根据业务结果，执行后续业务操作
                if(!"SUCCESS".equals(result_code)) {
                    LOGGER.error("error in weixin unified order, cause: err_code=[{}], err_code_des=[{}]", err_code, err_code_des);
                    return;
                }
                //成功，则返回JSAPI需要的预支付ID
                prepayId.append(prepay_id);
                LOGGER.info("success to get weixin prepay id:[{}] for order:[{}]", prepay_id, order.getId());
            }
        });
        return prepayId.toString();
    }
    
    /**
     * Method Name:	search<br/>
     * Description:			[该接口提供所有微信支付订单的查询，商户可以通过查询订单接口主动查询订单状态，完成下一步的业务逻辑。]<br/>
     * 								需要调用查询接口的情况：<br/>
	 * 								◆ 当商户后台、网络、服务器等出现异常，商户系统最终未接收到支付通知；<br/>
	 * 								◆ 调用支付接口后，返回系统错误或未知交易状态情况；<br/>
	 *								◆ 调用被扫支付API，返回USERPAYING的状态；<br/>
	 * 								◆ 调用关单或撤销接口API之前，需确认支付状态；
     * @author				GUHANJIE
     * @time					2016年9月30日 下午2:25:42
     * @param orderid
     * @param appid
     * @param mchid
     * @param mchkey
     * @return Map<K,V>: {<br/>result: SUCCESS/FAIL, <br/>out_trade_no: orderid, <br/>total_fee: 100, time_end: ***, <br/>openid:***<br/>}
     * @throws IOException
     */
    public static Map<String,String> search(final Order order, final String appid, final String mchid, final String mchkey) throws IOException {
        if(order == null) {
            LOGGER.warn("order can not be nulll in search order.");
            return null;
        }
        LOGGER.info("starting to search payment for order:[{}]...", order.getId());

        final Map<String, String> result = new HashMap<String, String>();
        result.put("out_trade_no", String.valueOf(order.getId()));

    	final String nonceStr = String.valueOf(new Random().nextInt(10000));
        Map<String, String> map = new HashMap<String, String>();
        map.put("appid", appid);                                                                      //公众账号ID
        map.put("mch_id", mchid);                                                                  //商户号
        map.put("out_trade_no", String.valueOf(order.getId()));                       //商户订单号
        map.put("nonce_str", nonceStr);                                                         //随机字符串
        map.put("sign", sign(map, mchkey));                                         			//签名

        String reqStr = XmlUtil.map2xmlstr(map);
        LOGGER.debug("=====set request for weixin search payment:[{}].", reqStr);
        
        HttpEntity entity = new StringEntity(reqStr, ContentType.create("application/xml", Consts.UTF_8));
        WeixinHttpUtil.sendPost(WeixinConstants.API_PAY_ORDERQUERY, entity, new WeixinHttpCallback() {
            @Override
            public void process(String respBody) {
                Map<String, String> map = XmlUtil.xmlstr2map(respBody);
                LOGGER.debug("=====got response from weixin search payment:[{}].", map);
                String return_code = map.get("return_code");                                        //返回状态码SUCCESS/FAIL，此字段是通信标识，非交易标识，交易是否成功需要查看result_code来判断
                String return_msg = map.get("return_msg");                                          //返回信息
                if(!"SUCCESS".equals(return_code)) {
                	LOGGER.error("fail to get response for weixin search payment api, cause:[{}]", return_msg);
                    result.put("result", return_code);
                    result.put("err_msg", "订单查询失败: " + return_msg);
                	return;
                }
            	//验签
                String signature = sign(map, mchkey);
                String sign = map.get("sign");                                                          //签名
                if(sign==null || !sign.equals(signature)) {
                	LOGGER.warn("signature validation failed, this response maybe fake!");
                    result.put("result", "FAIL");
                    result.put("err_msg", "验签失败");
                	return;
                }
                //验证随机字符串nonce，防CSRF攻击
//                    String nonce_str = map.get("nonce_str");                                            //随机字符串
//                    if(!nonceStr.equals(nonce_str)) {
//                        LOGGER.warn("nonce not matched(CSRF warning), this response maybe fake!");
//                        result.put("result", "FAIL");
//                        result.put("err_msg", "随机字符串不匹配");
//                        return;
//                    }
                //根据业务结果，执行后续业务操作
                String result_code = map.get("result_code");                                    //业务结果
                if(!"SUCCESS".equals(result_code)) {
                    String err_code = map.get("err_code");                                              //错误代码
                    String err_code_des = map.get("err_code_des");                              //错误代码描述
                    LOGGER.error("error in weixin search payment, cause: err_code=[{}], err_code_des=[{}]", err_code, err_code_des);
                    result.put("result", result_code);
                    result.put("err_msg", "pay search fail: "+err_code + ", " + err_code_des);
                    return;
                }
                String openid = map.get("openid");                                        			//用户OpenId
                String trade_state = map.get("trade_state");                                  //交易状态(SUCCESS—支付成功、REFUND—转入退款、NOTPAY—未支付、CLOSED—已关闭、REVOKED—已撤销（刷卡支付）、USERPAYING--用户支付中、PAYERROR--支付失败(其他原因，如银行返回失败)、)
                String out_trade_no = map.get("out_trade_no");							//商户订单号
                String total_fee = map.get("total_fee");											//订单总金额，单位为分
                String time_end = map.get("time_end");										//支付完成时间，格式为yyyyMMddHHmmss，如2009年12月25日9点10分10秒表示为20091225091010。
                String trade_state_desc = map.get("trade_state_desc");				//对当前查询订单状态的描述和下一步操作的指引
//                    String settlement_total_fee = map.get("settlement_total_fee");		//应结订单金额=订单金额-非充值代金券金额，应结订单金额<=订单金额
//                    String transaction_id = map.get("transaction_id");						//微信支付订单号
//                    String appid = map.get("appid");                                                        //公众账号ID
//                    String mch_id = map.get("mch_id");                                                  //商户号
//                    String device_info = map.get("device_info");                                        //设备号
//                    String is_subscribe = map.get("is_subscribe");                                //用户是否关注公众账号，Y-关注，N-未关注，仅在公众账号类型支付有效
//                    String trade_type = map.get("trade_type");                                  //交易类型JSAPI
//                    String bank_type = map.get("bank_type");                                     //付款银行(银行类型，采用字符串类型的银行标识)
//                    String fee_type = map.get("fee_type");											//货币种类
//                    String cash_fee = map.get("cash_fee");											//货币种类
                LOGGER.info("success to search weixin payment for order:[{}]: "
                				+ "openid=[{}], trade_state=[{}], total_fee=[{}], out_trade_no=[{}], time_end=[{}], trade_state_desc=[{}]", 
                				order.getId(), openid, trade_state, total_fee, out_trade_no, time_end, trade_state_desc);
                if(!"SUCCESS".equals(trade_state)) {    //支付不成功
                    LOGGER.warn("trade failed, trade_state:[{}], trade_state_desc:[{}]", trade_state, trade_state_desc);
                    result.put("result", trade_state);
                    result.put("err_msg", "订单支付不成功："+trade_state_desc);
                    return;
                }
                if(order.getTotalAmount().intValue() != Integer.valueOf(total_fee)/100) {    //支付金额与订单金额不一致
                    LOGGER.warn("trade exception, amount not matched: topay=[{}], payed=[{}]", order.getTotalAmount(), total_fee);
//                    result.put("result", "FAIL");
//                    result.put("err_msg", "订单支付金额有误：topay="+order.getAmount()+", payed="+ total_fee);
//                    return;
                }
                result.put("total_fee", total_fee);
                result.put("time_end", time_end);
                result.put("openid", openid);
                result.put("result", "SUCCESS");
            }
        });
        return result;
    }
    
    /**
     * Method Name:	closeorder<br/>
     * Description:			[关单接口，以下情况需要调用]：<br/>
     *                            ◆ 商户订单支付失败需要生成新单号重新发起支付，要对原订单号调用关单，避免重复支付；<br/>
     *                            ◆ 系统下单后，用户支付超时，系统退出不再受理，避免用户继续，请调用关单接口。<br/>
     *                        <b>注意：订单生成后不能马上调用关单接口，最短调用时间间隔为5分钟。</b>
     * @author				guhanjie
     * @time					2016年10月16日 下午7:00:56
     */
    public static boolean closeorder(final Order order, final String appid, final String mchid, final String mchkey) throws IOException {
        if(order == null) {
            LOGGER.warn("order can not be nulll in close order.");
            return false;
        }
        LOGGER.info("starting to close payment for order:[{}]...", order.getId());

        final StringBuilder result = new StringBuilder("");

        final String nonceStr = String.valueOf(new Random().nextInt(10000));
        Map<String, String> map = new HashMap<String, String>();
        map.put("appid", appid);                                                                      //公众账号ID
        map.put("mch_id", mchid);                                                                  //商户号
        map.put("out_trade_no", String.valueOf(order.getId()));                       //商户订单号
        map.put("nonce_str", nonceStr);                                                         //随机字符串
        map.put("sign", sign(map, mchkey));                                                     //签名

        String reqStr = XmlUtil.map2xmlstr(map);
        LOGGER.debug("=====set request for weixin search payment:[{}].", reqStr);
        
        HttpEntity entity = new StringEntity(reqStr, ContentType.create("application/xml", Consts.UTF_8));
        WeixinHttpUtil.sendPost(WeixinConstants.API_PAY_CLOSEORDER, entity, new WeixinHttpCallback() {
            @Override
            public void process(String respBody) {
                Map<String, String> map = XmlUtil.xmlstr2map(respBody);
                LOGGER.debug("=====got response from weixin close payment:[{}].", map);
                String return_code = map.get("return_code");                                        //返回状态码SUCCESS/FAIL，此字段是通信标识，非交易标识，交易是否成功需要查看result_code来判断
                String return_msg = map.get("return_msg");                                          //返回信息
                if(!"SUCCESS".equals(return_code)) {
                    LOGGER.error("fail to get response for weixin close payment api, cause:[{}]", return_msg);
                    return;
                }
                //验签
                String signature = sign(map, mchkey);
                String sign = map.get("sign");                                                          //签名
                if(sign==null || !sign.equals(signature)) {
                    LOGGER.warn("signature validation failed, this response maybe fake!");
                    return;
                }
                //验证随机字符串nonce，防CSRF攻击
//                    String nonce_str = map.get("nonce_str");                                            //随机字符串
//                    if(!nonceStr.equals(nonce_str)) {
//                        LOGGER.warn("nonce not matched(CSRF warning), this response maybe fake!");
//                        result.put("result", "FAIL");
//                        result.put("err_msg", "随机字符串不匹配");
//                        return;
//                    }
                //根据业务结果，执行后续业务操作
                String result_code = map.get("result_code");                                    //业务结果
                if(!"SUCCESS".equals(result_code)) {
                    String err_code = map.get("err_code");                                              //错误代码
                    String err_code_des = map.get("err_code_des");                              //错误代码描述
                    LOGGER.error("error in weixin close payment, cause: err_code=[{}], err_code_des=[{}]", err_code, err_code_des);
                    return;
                }
                LOGGER.info("success to close weixin payment for order[{}].", order.getId());
                result.append("success");
            }
        });
        return "success".equals(result.toString());
    }
    
    /**
     * Method Name:	callback<br/>
     * Description:			[支付完成后，微信会把相关支付结果和用户信息发送给商户，商户需要接收处理，并返回应答]
     * @author				guhanjie
     * @time					2016年10月1日 下午6:49:46
     * @param request
     * @param mchkey
     * @return Map<K,V>: {<br/>result: SUCCESS/FAIL, <br/>out_trade_no: orderid, <br/>total_fee: 100, time_end: ***, <br/>openid:***<br/>}
     */
    public static Map<String,String> callback(HttpServletRequest request, final String mchkey) {
        final Map<String, String> result = new HashMap<String, String>();
        
        Map<String, String> map = MessageKit.reqMsg2Map(request);
        LOGGER.debug("=====got response from weixin pay callback:[{}].", map);

        String return_code = map.get("return_code");                                        //返回状态码SUCCESS/FAIL，此字段是通信标识，非交易标识，交易是否成功需要查看result_code来判断
        String return_msg = map.get("return_msg");                                          //返回信息
        if(!"SUCCESS".equals(return_code)) {
            LOGGER.warn("error in callback from weixin pay, cause:[{}]", return_msg);
            result.put("result", return_code);
            result.put("err_msg", return_msg);
            return result; 
        }
        //验签
        String signature = sign(map, mchkey);
        String sign = map.get("sign");                                                          //签名
        if(sign==null || !sign.equals(signature)) {
            LOGGER.warn("signature validation failed, this request of weixin pay callback maybe fake!");
            result.put("result", "FAIL");
            result.put("err_msg", "签名失败");
            return result;
        }
        String result_code = map.get("result_code");                                    //业务结果
        if(!"SUCCESS".equals(result_code)) {
            String err_code = map.get("err_code");                                              //错误代码
            String err_code_des = map.get("err_code_des");                              //错误代码描述
            LOGGER.error("error in callback from weixin pay, cause: err_code=[{}], err_code_des=[{}]", err_code, err_code_des);
            result.put("result", result_code);
            result.put("err_msg", err_code + ", " + err_code_des);
            return result;
        }
        String out_trade_no = map.get("out_trade_no");          //商户订单号
        String total_fee = map.get("total_fee");                            //订单金额  
        String time_end = map.get("time_end");                      //支付完成时间
        String openid = map.get("openid");                              //用户OpenIds
        result.put("result", "SUCCESS");
        result.put("out_trade_no", out_trade_no);
        result.put("total_fee", total_fee);
        result.put("time_end", time_end);
        result.put("openid", openid);
        
        return result;
    }
        
    public static String sign(Map<String, String> params, String secretKey) {
    	if(params == null || params.isEmpty()) {
    		LOGGER.error("signaute params can not be null or empty.");
    	}
    	List<String> keys = new ArrayList<String>(params.keySet().size());
    	for(String key : params.keySet()) {
    		keys.add(key);
    	}
    	Collections.sort(keys);
    	StringBuilder stringA = new StringBuilder();
    	for(String key : keys) {
    		if(!key.equals("sign") && !StringUtils.isEmpty(params.get(key))) {		//sign参数不参与签名，参数的值为空不参与签名
    			stringA.append(key).append("=").append(params.get(key)).append("&");
    		}
    	}
    	String stringSignTemp = stringA.append("key=").append(secretKey).toString();
    	String sign = MD5Util.md5(stringSignTemp).toUpperCase();
    	return sign;
    }
}
