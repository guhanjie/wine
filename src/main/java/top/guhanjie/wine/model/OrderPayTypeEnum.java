/** 
 * Project Name:	wine
 * Package Name:	top.guhanjie.wine.model 
 * File Name:			OrderPayTypeEnum.java 
 * Create Date:		2016年10月1日 下午10:10:42 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.model;

/**
 * Class Name:		OrderPayTypeEnum<br/>
 * Description:		[支付类型（0：微信支付，1：现金）]
 * @time				2016年10月1日 下午10:10:42
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public enum OrderPayTypeEnum {

    WEIXIN((short)0, "微信支付"),
    CASH((short)1, "现金支付");
    
    private short code;
    private String desc;
    
    private OrderPayTypeEnum(short code, String desc) {
        this.code = code;
        this.desc = desc;
    }
    
    public short code() {
        return code;
    }
    
    public String desc() {
        return desc;
    }
}
