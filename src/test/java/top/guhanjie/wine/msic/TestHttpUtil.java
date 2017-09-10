package top.guhanjie.wine.msic;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.http.HttpEntity;

import top.guhanjie.wine.util.HttpUtil;

/**
 * Created by guhanjie on 2017-09-09.
 */
public class TestHttpUtil {

	public static void main(String[] args) {
		HttpUtil.sendGet("https://www.baidu.com", new HttpUtil.HttpCallback() {

			@Override
			public void processEntity(HttpEntity e) {
				try {
					InputStream is = e.getContent();
					long length = e.getContentLength();
					System.out.println("content length:"+length);
					BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(is));
					StringBuilder sb = new StringBuilder();
	                char[] charBuffer = new char[128];
	                int bytesRead = -1;
	                while ((bytesRead = bufferedReader.read(charBuffer)) != -1) {
	                    sb.append(charBuffer, 0, bytesRead);
	                }
					System.out.println(sb.toString());
				} catch (UnsupportedOperationException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			
		});
	}

}
