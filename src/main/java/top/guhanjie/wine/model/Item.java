package top.guhanjie.wine.model;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.beanutils.PropertyUtils;

public class Item {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.name
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private String name;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.icon
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private String icon;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.detail
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private String detail;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.category_id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Integer categoryId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.normal_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private BigDecimal normalPrice;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.vip_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private BigDecimal vipPrice;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.back_points
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Integer backPoints;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.sales
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Integer sales;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.status
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Integer status;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.title_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private String titleImgs;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.detail_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private String detailImgs;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.create_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Date createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column item.update_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    private Date updateTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.id
     *
     * @return the value of item.id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.id
     *
     * @param id the value for item.id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.name
     *
     * @return the value of item.name
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.name
     *
     * @param name the value for item.name
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.icon
     *
     * @return the value of item.icon
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public String getIcon() {
        return icon;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.icon
     *
     * @param icon the value for item.icon
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.detail
     *
     * @return the value of item.detail
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public String getDetail() {
        return detail;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.detail
     *
     * @param detail the value for item.detail
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.category_id
     *
     * @return the value of item.category_id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Integer getCategoryId() {
        return categoryId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.category_id
     *
     * @param categoryId the value for item.category_id
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.normal_price
     *
     * @return the value of item.normal_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public BigDecimal getNormalPrice() {
        return normalPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.normal_price
     *
     * @param normalPrice the value for item.normal_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setNormalPrice(BigDecimal normalPrice) {
        this.normalPrice = normalPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.vip_price
     *
     * @return the value of item.vip_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public BigDecimal getVipPrice() {
        return vipPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.vip_price
     *
     * @param vipPrice the value for item.vip_price
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setVipPrice(BigDecimal vipPrice) {
        this.vipPrice = vipPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.back_points
     *
     * @return the value of item.back_points
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Integer getBackPoints() {
        return backPoints;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.back_points
     *
     * @param backPoints the value for item.back_points
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setBackPoints(Integer backPoints) {
        this.backPoints = backPoints;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.sales
     *
     * @return the value of item.sales
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Integer getSales() {
        return sales;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.sales
     *
     * @param sales the value for item.sales
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setSales(Integer sales) {
        this.sales = sales;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.status
     *
     * @return the value of item.status
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Integer getStatus() {
        return status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.status
     *
     * @param status the value for item.status
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setStatus(Integer status) {
        this.status = status;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.title_imgs
     *
     * @return the value of item.title_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public String getTitleImgs() {
        return titleImgs;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.title_imgs
     *
     * @param titleImgs the value for item.title_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setTitleImgs(String titleImgs) {
        this.titleImgs = titleImgs == null ? null : titleImgs.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.detail_imgs
     *
     * @return the value of item.detail_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public String getDetailImgs() {
        return detailImgs;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.detail_imgs
     *
     * @param detailImgs the value for item.detail_imgs
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setDetailImgs(String detailImgs) {
        this.detailImgs = detailImgs == null ? null : detailImgs.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.create_time
     *
     * @return the value of item.create_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.create_time
     *
     * @param createTime the value for item.create_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column item.update_time
     *
     * @return the value of item.update_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column item.update_time
     *
     * @param updateTime the value for item.update_time
     *
     * @mbggenerated Sun Aug 20 16:27:11 CST 2017
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    
    private Category category;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
    
    //------------------------- custom add -----------------------------
    private int count;	//used in order buy

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
    
	public Item deepCopy() {
		Item copy = new Item();
		try {
			PropertyUtils.copyProperties(copy, this);
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return copy;
	}
	//------------------------- custom add -----------------------------
}