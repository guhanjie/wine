package top.guhanjie.wine.msic;

import java.nio.charset.Charset;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.WeixinHttpUtil;
import top.guhanjie.wine.weixin.WeixinHttpUtil.WeixinHttpCallback;
import top.guhanjie.wine.weixin.qrcode.QrcodeKit.QrcodeResponse;
import top.guhanjie.wine.weixin.token.AccessTokenKit;

/**
 * Created by guhanjie on 2017-09-10.
 */
public class TestQrcode {
	
    private static final Logger LOGGER = LoggerFactory.getLogger(TestQrcode.class);

	public static void main(String[] args) {

	    Integer userid = 6;
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

            HttpPost post = null;
            CloseableHttpClient client = null;
            CloseableHttpResponse resp = null;        
            try {
                client = HttpClients.createDefault();
                url = url.replace("ACCESS_TOKEN", "-RkGWTr7hNXm5XI0LgGYurZQ5cLNp_bphv5tQGxqBBirhFKIlK2-SjTNj-WTgKGMLXyMlGJSEgPUiu7FqTxDyvGiEGD9KH1778EoIrHkynFKYESFKeQSaE4iZLOEZ7U7XZOeAHASUJ");
                LOGGER.debug("sending http post to url:[{}]...", url);
                post = new HttpPost(url);
                post.setEntity(entity);
                resp = client.execute(post);
                int sc = resp.getStatusLine().getStatusCode();
                if(sc>=200&&sc<300) {
                    String respEntity = EntityUtils.toString(resp.getEntity(), Charset.forName("UTF-8"));
                    LOGGER.debug("success to get response:[{}]", respEntity);
                	QrcodeResponse t = JSONObject.parseObject(respEntity, QrcodeResponse.class);
                	qrcode.setTicket(t.ticket);
                	qrcode.setUrl(t.url);
                    LOGGER.debug("success to finish http post request.");
                }
            } catch (Exception e) {
                LOGGER.error("failed to send http post request", e);
            } finally {
                HttpClientUtils.closeQuietly(resp);
                HttpClientUtils.closeQuietly(client);
            }
        } catch (Exception e) {
            LOGGER.error("Failed to create qrcode for user[{}].", userid);
        }
        LOGGER.info(JSON.toJSONString(qrcode, true));

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
