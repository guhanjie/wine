package top.guhanjie.wine.weixin.msg;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * Created by guhanjie on 2017-09-10.
 */
@XmlRootElement(name="xml")
public class PicTextMsg {
	public String ToUserName;
	public String FromUserName;
	public String CreateTime;
	public String MsgType;
	public int ArticleCount;
	@XmlElementWrapper(name = "Articles")
	@XmlElement(name = "item")
	public List<Article> Articles;
}