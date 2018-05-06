package top.guhanjie.wine.msic;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

public class TestLotteryScrap {

	@Test
	public void test() throws IOException {
//		Document doc = Jsoup.connect("http://www.zhcw.com/3d/").userAgent("Mozilla").get();
//		String title = doc.title();
//		Elements e = doc.select("dl.kj_lt2");
//		System.out.println(doc.html());
		HttpGet get = null;
        CloseableHttpClient client = null;        
        CloseableHttpResponse resp = null;
        try {
            client = HttpClients.createDefault();
            get = new HttpGet("http://www.zhcw.com/kaijiang/kjData/2012/zhcw_3d_index_last30.js");
            resp = client.execute(get);
            String txt = EntityUtils.toString(resp.getEntity());
            System.out.println("txt==="+txt);
            Date now = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String date = sdf.format(now);
//            Pattern p = Pattern.compile("\"kjDate\":\"2018-05-05\",.*\"kjZNum\":\"([\\d,\\s]*)\".??,", Pattern.DOTALL);
            //Pattern: 2018-05-05.*?kjZNum":"(.*?)"
            Pattern p = Pattern.compile(date+".*?kjZNum\":\"(.*?)\"", Pattern.DOTALL);
            //get matched str: 2018-05-05","kjIssue":"2018118","kjNum":"","kjOutnum":"","kjTNum":"-1","kjZNum":"9 3 0"
            System.out.println(p.pattern());
            Matcher m = p.matcher(txt);
            if (m.find( )) {
            	System.out.println(m.group());
            	String znum = m.group(1);
            	znum = znum.replaceAll("\\s", "");
            	System.out.println("group1="+znum);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        } finally {
            HttpClientUtils.closeQuietly(resp);
            HttpClientUtils.closeQuietly(client);
        }
	}

}
