package top.guhanjie.wine.msic;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import top.guhanjie.wine.weixin.msg.Article;
import top.guhanjie.wine.weixin.msg.PicTextMsg;

/**
 * Created by guhanjie on 2017-09-10.
 */
public class TestJAXB {

	public static void main(String[] args) {

		PicTextMsg ptm = new PicTextMsg();
		ptm.ArticleCount = 1;
		ptm.CreateTime = "1504988079412";
		ptm.FromUserName = "1504988079412";
		ptm.ToUserName = "1504988079412";
		ptm.MsgType = "news";
//		ptm.setArticleCount(1);
//		ptm.setCreateTime("1504988079412");
//		ptm.setFromUserName("1504988079412");
//		ptm.setToUserName("1504988079412");
//		ptm.setMsgType("news");
		Article a = new Article();
		a.Description = "下面是您的专属推广二维码，请长按此二维码，发送给好友，推荐成功后，将获得积分";
		a.Title = "会员推广";
		a.PicUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQEY8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyYXNsc0VBVW9mS2gxMDAwME0wMzEAAgTiOrRZAwQAAAAA";
		a.Url = "http://weixin.qq.com/q/02aslsEAUofKh10000M031";
		List<Article> as = new ArrayList<Article>();
		as.add(a);
		ptm.Articles = as;

		try {

			StringWriter sw = new StringWriter();
			JAXBContext jaxbContext = JAXBContext.newInstance(PicTextMsg.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

			// output pretty printed
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			jaxbMarshaller.marshal(ptm, sw);
			
			System.out.println(sw.toString());
		} catch (JAXBException e) {
			e.printStackTrace();
		}

	}
}
