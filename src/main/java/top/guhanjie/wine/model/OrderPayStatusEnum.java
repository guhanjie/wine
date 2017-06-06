/** 
 * Project Name:	wine
 * Package Name:	top.guhanjie.wine.model 
 * File Name:			OrderPayStatusEnum.java 
 * Create Date:		2016年10月1日 下午10:02:15 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.model;

/**
 * Class Name:		OrderPayStatusEnum<br/>
 * Description:		[支付状态（0：未支付，1：支付成功，2：支付失败，3：转入退款，4：已关闭，5：已撤销（刷卡支付），6： 用户支付中）]
 * @time				2016年10月1日 下午10:02:15
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public enum OrderPayStatusEnum {

    NOTPAY((short)0, "未支付"),
    SUCCESS((short)1, "支付成功"),
    PAYERROR((short)2, "支付失败"),
    REFUND((short)3, "转入退款"),
    CLOSED((short)4, "已关闭"),
    REVOKED((short)5, "已撤销（刷卡支付）"),
    USERPAYING((short)6, "用户支付中");
    
    private short code;
    private String desc;
    
    private OrderPayStatusEnum(short code, String desc) {
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
