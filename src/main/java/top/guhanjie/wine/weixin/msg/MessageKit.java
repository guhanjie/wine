/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.weixin.msg 
 * File Name:			MessageKit.java 
 * Create Date:		2016年8月28日 下午9:23:20 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.weixin.msg;

import java.io.IOException;
import java.io.StringWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.dom4j.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import top.guhanjie.wine.model.User;
import top.guhanjie.wine.service.UserService;
import top.guhanjie.wine.util.HttpUtil;
import top.guhanjie.wine.util.SpringContextUtil;
import top.guhanjie.wine.util.XmlUtil;
import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.WeixinHttpUtil;
import top.guhanjie.wine.weixin.WeixinHttpUtil.WeixinHttpCallback;
import top.guhanjie.wine.weixin.model.ErrorEntity;
import top.guhanjie.wine.weixin.model.UserInfo;
import top.guhanjie.wine.weixin.qrcode.QrcodeKit;
import top.guhanjie.wine.weixin.qrcode.QrcodeKit.QrcodeResponse;
import top.guhanjie.wine.weixin.user.UserKit;

/**
 * Class Name:		MessageKit<br/>
 * Description:		[description]
 * @time				2016年8月28日 下午9:23:20
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public class MessageKit {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(MessageKit.class);
    
    private static Map<String,String> replyMsgs = new HashMap<String,String>();
    static{
        replyMsgs.put("123", "你输入了123");
        replyMsgs.put("hello", "world");
        replyMsgs.put("run", "祝你一路平安!");
    }
    
    public static Map<String,String> reqMsg2Map(HttpServletRequest req) {
        try {
            Document xml = HttpUtil.getRequest2Xml(req);
            Map<String,String> maps = XmlUtil.xml2map(xml);
            return maps;
        } catch (Exception e) {
            LOGGER.error("error in parsing request to xml from weixin.", e); 
        }
        return null;
    }
    
    /**
	 * Method Name:	handlerMsg<br/>
	 * Description:			[处理微信消息]
	 * @author				GUHANJIE
	 * @time					2016年9月2日 上午10:58:25
	 * @param msgMap
	 * @return
	 * @throws IOException
	 */
	public static String handlerMsg(Map<String, String> msgMap) {
	    String msgType = msgMap.get("MsgType");
	    LOGGER.debug("weixin msg type = [{}]", msgType);
	    try {
    	    //处理事件消息
    	    if(msgType.equals(WeixinConstants.MSG_TYPE_EVENT)) {
    	    	String eventType = msgMap.get("Event");
    	    	LOGGER.debug("weixin msg event type = [{}]", eventType);
    	    	//关注公众号事件
    	        if(eventType.equals(WeixinConstants.EVENT_SUBSCRIBE)) {
    	        	return handleSubscribeEvent(msgMap);
    	        }
    	        //用户扫推广二维码事件
    	        else if(eventType.equals(WeixinConstants.EVENT_SCAN)) {
    	        	return handleScanEvent(msgMap);
    	        }
    	        //上报地址位置事件
//    	        else if(eventType.equals(WeixinConstants.EVENT_LOCATION)) {
//    	        	return handleLocationEvent(msgMap);
//    	        }
    	        //点击菜单拉取消息时的事件事件
    	        else if(eventType.equals(WeixinConstants.EVENT_CLICK)) {
    	        	return handleClickEvent(msgMap);
    	        }
    	    }
    	    //处理文本消息
    	    else if(msgType.equals(WeixinConstants.MSG_TYPE_TEXT)) {
    	        return handleTextMsg(msgMap);
    	    }
    	    //处理图片消息
//    	    else if(msgType.equals(WeixinConstants.MSG_TYPE_IMAGE)) {
//    	        return handleImageMsg(msgMap,"_I53ClKoGvcQC4z1mWLf-O_nDJ_rw2p-LtfJOslSONSzUEtv8eKEvlDbn8m71d9m");
//    	    }
	    } catch(IOException e) {
	        LOGGER.error("error to handle msg for weixin.", e);
	    }
	    return "";
	}

	private static String handleImageMsg(Map<String, String> msgMap,String mediaId) throws IOException {
	    LOGGER.info("starting to handle image message[{}]...", JSON.toJSONString(msgMap, true));
	    Map<String,String> map = new HashMap<String, String>();
        map.put("ToUserName", msgMap.get("FromUserName"));
        map.put("FromUserName", msgMap.get("ToUserName"));
        map.put("CreateTime", new Date().getTime()+"");
        map.put("MsgType", "image");
        map.put("Image", "<MediaId>"+mediaId+"</MediaId>");
        LOGGER.info("success to response msg:[{}]", map);
        return XmlUtil.map2xmlstr(map);
    }
    
    private static String handleTextMsg(Map<String, String> msgMap) throws IOException {
        LOGGER.info("starting to handle text message[{}]...", JSON.toJSONString(msgMap, true));
        Map<String,String> map = new HashMap<String, String>();
        map.put("ToUserName", msgMap.get("FromUserName"));
        map.put("FromUserName", msgMap.get("ToUserName"));
        map.put("CreateTime", new Date().getTime()+"");
        map.put("MsgType", "text");
        String replyContent = "你请求的消息的内容不正确!";
        String con = msgMap.get("Content");
        if(replyMsgs.containsKey(con)) {
            replyContent = replyMsgs.get(con);
        }
        map.put("Content", replyContent);
        LOGGER.info("success to response msg:[{}]", map);
        return XmlUtil.map2xmlstr(map);
    }
    
    private static String handleSubscribeEvent(Map<String, String> msgMap) throws IOException {
        LOGGER.info("starting to handle subscribe event[{}]...", JSON.toJSONString(msgMap, true));
        String openId = msgMap.get("FromUserName");
    	//自动添加关注用户
    	try {
    	    UserService userService = SpringContextUtil.getBean(UserService.class);
            User user = userService.getUserByOpenId(openId);
            if(user == null) {
                user = new User();
                user.setOpenId(openId);
                UserInfo userInfo = UserKit.getUserInfo(openId);
                user.setUnionid(userInfo.getUnionid());
                user.setName(userInfo.getNickname());
                user.setNickname(userInfo.getNickname());
                user.setSex(userInfo.getSex());
                user.setLanguage(userInfo.getLanguage());
                user.setCountry(userInfo.getCountry());
                user.setProvince(userInfo.getProvince());
                user.setCity(userInfo.getCity());
                if(StringUtils.isNumeric(userInfo.getSubscribe_time())) {
                    user.setSubscribeTime(new Date(Long.parseLong(userInfo.getSubscribe_time())));
                }
                //如果用户通过扫描二维码推广进入，会绑定推荐人信息
                String qrscene = msgMap.get("EventKey");
                if(StringUtils.isNotBlank(qrscene)) {
                	qrscene = qrscene.substring("qrscene_".length());	//去除前缀，截取推广用户id
                	user.setSourceId(Integer.parseInt(qrscene));
                }
                userService.addUser(user);
                LOGGER.info("success to add a new user[{}]", JSON.toJSONString(user, true));
            }
    	} catch(Exception e) {
    	    LOGGER.error("error happened in add user info, openId[{}].", openId, e);
    	}
        Map<String,String> map = new HashMap<String, String>();
        map.put("ToUserName", msgMap.get("FromUserName"));
        map.put("FromUserName", msgMap.get("ToUserName"));
        map.put("CreateTime", new Date().getTime()+"");
        map.put("MsgType", "text");
        map.put("Content", "您好，欢迎关注！");
        LOGGER.info("success to response msg:[{}]", map);
    	return XmlUtil.map2xmlstr(map);
    }
    
    private static String handleScanEvent(Map<String, String> msgMap) throws IOException {
        LOGGER.info("starting to handle scan event[{}]...", JSON.toJSONString(msgMap, true));
        String openId = msgMap.get("FromUserName");
    	try {
    	    UserService userService = SpringContextUtil.getBean(UserService.class);
            User user = userService.getUserByOpenId(openId);
            //如果用户之前已关注公众号，但是未绑定推广人信息，可以补绑推广人信息，但属于一次性行为，绑定后不可更改
            if(user != null && user.getSourceId() == null) {
        		String qrscene = msgMap.get("EventKey");//此时，事件KEY值，是一个32位无符号整数，即创建二维码时的二维码scene_id
                if(StringUtils.isNotBlank(qrscene)) {
                	int sourceid = Integer.parseInt(qrscene);
                	if(user.getId() != sourceid) {
                		user.setSourceId(sourceid);
                		userService.updateUser(user);
                		User promoter = userService.getUserById(Integer.parseInt(qrscene));
                		LOGGER.info("success to bind promoter[{}] to user:[{}]", promoter.getId(), user.getId());
                		Map<String,String> map = new HashMap<String, String>();
                		map.put("ToUserName", msgMap.get("FromUserName"));
                		map.put("FromUserName", msgMap.get("ToUserName"));
                		map.put("CreateTime", new Date().getTime()+"");
                		map.put("MsgType", "text");
                		map.put("Content", "您好，您已完成推荐人绑定！推荐人："+promoter.getName());
                		LOGGER.info("success to response msg:[{}]", map);
                		return XmlUtil.map2xmlstr(map);
                	}
                }
            }
    	} catch(Exception e) {
    	    LOGGER.error("error happened in add user info, openId[{}].", openId, e);
    	}
    	return "success";
    }
    
    private static String handleLocationEvent(Map<String, String> msgMap) throws IOException {
//        LOGGER.info("starting to handle location event[{}]...", JSON.toJSONString(msgMap, true));
//        String openId = msgMap.get("FromUserName");
//        String lat = msgMap.get("Latitude");
//    	String lng = msgMap.get("Longitude");
//    	//获取用户上报的地址微信，并绑定到内存中
//    	User user = new User();
//    	user.setOpenId(openId);
//    	Position p = new Position();
//    	p.setGeoLat(lat);
//    	p.setGeoLng(lng);
//    	user.setPosition(p);
//        UserService userService = SpringContextUtil.getBean(UserService.class);
//    	userService.updateToCache(user);
    	return "";
    }
    
    private static String handleClickEvent(Map<String, String> msgMap) throws IOException {
        LOGGER.info("starting to handle click event[{}]...", JSON.toJSONString(msgMap, true));

        PicTextMsg ptm = new PicTextMsg();
        ptm.ToUserName = msgMap.get("FromUserName");
        ptm.FromUserName = msgMap.get("ToUserName");
        ptm.CreateTime = new Date().getTime()+"";
        ptm.MsgType = "news";
        ptm.ArticleCount = 1;
        List<Article> as = new ArrayList<Article>();
		Article a = new Article();
		a.Title = "会员推广";
		a.Description = "下面是您的专属推广二维码，请长按此二维码，发送给好友，新会员注册成功，即送5代金券";
		a.PicUrl = "";
		a.Url = "http://www.guhanjie.top/wine/promote";
		as.add(a);
		ptm.Articles = as;
        
        String openid = msgMap.get("FromUserName");
        String eventkey = msgMap.get("EventKey");

        //用户获取推广二维码
	  	if(WeixinConstants.EVENTKEY_PROMOTE_QRCODE.equals(eventkey)) {
	  		LOGGER.info("starting to get promote qrcode for user open id[{}]...", openid);
	  		UserService userService = SpringContextUtil.getBean(UserService.class);
	  		User user = userService.getUserByOpenId(openid);
	  		if(user == null) {
	  			LOGGER.error("user is null, can not create qrcode.");
	  			a.Description = "对不起，您还未注册会员，请先关注该公众号，成为会员";
	  		}
	  		else if(user.getQrcodeTicket() != null) {
	  			String picUrl = WeixinConstants.API_QRCODE_SHOW;
	  			String encodedTikect = URLEncoder.encode(user.getQrcodeTicket(), "UTF-8");
	  			picUrl = picUrl.replaceAll("TICKET", encodedTikect);
	  			a.PicUrl = picUrl;
	  			a.Url = picUrl;
	  		}
	  		else {
	  			LOGGER.info("user[{}] does not have qrcode yet, create qrcode...", user.getId());
	  			QrcodeResponse r = QrcodeKit.createQrcode(user.getId());
	  			user.setQrcodeTicket(r.getTicket());
	  			user.setQrcodeUrl(r.getUrl());
	  			userService.updateUser(user);
	  			String picUrl = WeixinConstants.API_QRCODE_SHOW;
	  			String encodedTikect = URLEncoder.encode(r.getTicket(), "UTF-8");
	  			picUrl = picUrl.replaceAll("TICKET", encodedTikect);
	  			a.PicUrl = picUrl;
	  			a.Url = picUrl;
	  		}
	  	}
	  	StringWriter sw = new StringWriter();
	  	try {
			JAXBContext jaxbContext = JAXBContext.newInstance(PicTextMsg.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

			// output pretty printed
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			jaxbMarshaller.marshal(ptm, sw);
			
		} catch (JAXBException e) {
			e.printStackTrace();
		}
	  	String res = sw.toString();
        LOGGER.info("success to response msg:[{}]", res);
  	    return res;
    }
    
    public static void sendKFMsg(String openids, String content) {
        if(StringUtils.isBlank(openids)) {
            LOGGER.warn("send order msg to KF, but no kf openids.");
            return;
        }
        String [] ids = openids.split(",");
        for(final String openid : ids) {
            LOGGER.info("starting to send message to KF[{}]...", openid);
            try {
                String url = WeixinConstants.API_KF_SEND_MSG;
                String str = new String("{" + 
                                                    "    \"touser\":\"OPENID\"," + 
                                                    "    \"msgtype\":\"text\"," + 
                                                    "    \"text\":" + 
                                                    "    {" + 
                                                    "         \"content\":\"ContentText\"" + 
                                                    "    }" + 
                                                    "}");
                str = str.replaceAll("OPENID", openid);
                str = str.replaceAll("ContentText", content);
                LOGGER.debug("message content: [{}]", str);
                HttpEntity entity = new StringEntity(str, ContentType.APPLICATION_JSON);
                WeixinHttpUtil.sendPost(url, entity, new WeixinHttpCallback() {
                        @Override
                        public void process(String json) {
                            ErrorEntity t = JSONObject.parseObject(json, ErrorEntity.class);
                            if(t!=null && t.getErrcode()!=null && t.getErrmsg()!=null) {
                                if(t.getErrcode().equals("0") && t.getErrmsg().equals("ok"))
                                LOGGER.info("Success to post message to KF[{}].", openid);
                                return;
                            }
                            LOGGER.error("Failed to post message to KF, error:[{}].", json);
                        }
                    });
            } catch (Exception e) {
                LOGGER.error("error to post message[{}] to KF[{}].", content, openid);
            } 
        }
	}
}
