package top.guhanjie.wine.model;

import java.util.Date;

public class RushLottery {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private Integer id;
    
    private Integer orderId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.user_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private Integer userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.rush_item_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private Integer rushItemId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.lottery_code
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private String lotteryCode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.create_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private Date createTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rush_lottery.update_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    private Date updateTime;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.id
     *
     * @return the value of rush_lottery.id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.id
     *
     * @param id the value for rush_lottery.id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.user_id
     *
     * @return the value of rush_lottery.user_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.user_id
     *
     * @param userId the value for rush_lottery.user_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.rush_item_id
     *
     * @return the value of rush_lottery.rush_item_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public Integer getRushItemId() {
        return rushItemId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.rush_item_id
     *
     * @param rushItemId the value for rush_lottery.rush_item_id
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setRushItemId(Integer rushItemId) {
        this.rushItemId = rushItemId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.lottery_code
     *
     * @return the value of rush_lottery.lottery_code
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public String getLotteryCode() {
        return lotteryCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.lottery_code
     *
     * @param lotteryCode the value for rush_lottery.lottery_code
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setLotteryCode(String lotteryCode) {
        this.lotteryCode = lotteryCode == null ? null : lotteryCode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.create_time
     *
     * @return the value of rush_lottery.create_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public Date getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.create_time
     *
     * @param createTime the value for rush_lottery.create_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rush_lottery.update_time
     *
     * @return the value of rush_lottery.update_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rush_lottery.update_time
     *
     * @param updateTime the value for rush_lottery.update_time
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    
    public void setOrderId(Integer orderId) {
    	this.orderId = orderId;
    }
    
    public Integer getOrderId() {
    	return this.orderId;
    }
}