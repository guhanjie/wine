package top.guhanjie.wine.weixin.qrcode;

import org.apache.http.HttpEntity;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;

import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.WeixinHttpUtil;
import top.guhanjie.wine.weixin.WeixinHttpUtil.WeixinHttpCallback;

/**
 * Created by guhanjie on 2017-09-09.
 */
public class QrcodeKit {

    private static final Logger LOGGER = LoggerFactory.getLogger(QrcodeKit.class);
    
    public static QrcodeResponse createQrcode(Integer userid) {
        LOGGER.info("Starting to create qrcode for user[{}]...", userid);
        final QrcodeResponse qrcode = new QrcodeResponse();
        try {
            String url = WeixinConstants.API_QRCODE_CREATE;
            String data = new String("{" + 
                                    "\"action_name\":\"QR_LIMIT_SCENE\"," + 
                                    "\"action_info\":"+
                                    "    {\"scene\":" + 
                                    "    	{\"scene_id\":USER_ID}" + 
                                    "    }" + 
                                    "}");
            data = data.replaceAll("USER_ID", userid.toString());
            LOGGER.debug("message content: [{}]", data);
            HttpEntity entity = new StringEntity(data, ContentType.APPLICATION_JSON);
            WeixinHttpUtil.sendPost(url, entity, new WeixinHttpCallback() {
                @Override
                public void process(String json) {
                	QrcodeResponse t = JSONObject.parseObject(json, QrcodeResponse.class);
                	qrcode.setTicket(t.ticket);
                	qrcode.setUrl(t.url);
                }
            });
        } catch (Exception e) {
            LOGGER.error("Failed to create qrcode for user[{}].", userid);
        }
        return qrcode;
    }
 
    public static class QrcodeResponse {
    	private String ticket;
		private String expire_seconds;
    	private String url;
    	
    	public String getTicket() {
			return ticket;
		}
		public void setTicket(String ticket) {
			this.ticket = ticket;
		}
		public String getExpire_seconds() {
			return expire_seconds;
		}
		public void setExpire_seconds(String expire_seconds) {
			this.expire_seconds = expire_seconds;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
    }
    
}
