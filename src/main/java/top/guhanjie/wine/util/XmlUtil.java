/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.weixin 
 * File Name:			WeixinXmlUtil.java 
 * Create Date:		2016年9月26日 下午10:55:09 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.XMLWriter;

/**
 * Class Name:		XmlUtil<br/>
 * Description:		[description]
 * @time				2016年9月26日 下午10:55:09
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public class XmlUtil {
    
    public static Document str2xml(String str) {
        if(str == null || str.isEmpty()) {
            return null;
        }
        Document xml = null;
        try {
            xml = DocumentHelper.parseText(str);
        }
        catch (DocumentException e) {
            e.printStackTrace();
        }
        return xml;
    }
    
    @SuppressWarnings("unchecked")
    public static Map<String, String> xml2map(Document xml) {
        if(xml == null) {
            return null;
        }
        Map<String,String> maps = new HashMap<String, String>();
        Element root = xml.getRootElement();
        List<Element> eles = root.elements();
        for(Element e:eles) {
            maps.put(e.getName(), e.getTextTrim());
        }
        return maps;
    }
    
    public static Map<String, String> xmlstr2map(String str) {
        Document xml  = str2xml(str);
        return xml2map(xml);
    }
    
    public static String map2xmlstr(Map<String, ?> map) {
        if(map == null) {
            return null;
        }
        Document d = DocumentHelper.createDocument();
        Element root = d.addElement("xml");
        Set<String> keys = map.keySet();
        for(String key:keys) {
        	Object value = map.get(key);
        	if(value instanceof Number){
        		root.addElement(key).addText(value.toString());
        	}
        	else if(value == null) {
                root.addElement(key).addText("");
        	}
        	else {
        		root.addElement(key).addCDATA(value.toString());
        	}
        }
        StringWriter sw = new StringWriter();
        try {
            XMLWriter xw = new XMLWriter(sw);
            xw.setEscapeText(true);
            xw.write(d);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        String str = sw.toString();
        return str.substring(str.indexOf("<xml>"));
    }
    
}
