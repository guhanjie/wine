/** 
 * Project Name:	wine
 * Package Name:	top.guhanjie.wine.model 
 * File Name:			UserTypeEnum.java 
 * Create Date:		2016年10月1日 下午10:10:42 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.model;

/**
 * Class Name:		UserTypeEnum<br/>
 * Description:		[会员类型（0：普通用户，1：会员）]
 * @time				2016年10月1日 下午10:10:42
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
public enum UserTypeEnum {

    NORMAL((short)0, "普通会员"),
    VIP((short)1, "会员");
    
    private short code;
    private String desc;
    
    private UserTypeEnum(short code, String desc) {
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
