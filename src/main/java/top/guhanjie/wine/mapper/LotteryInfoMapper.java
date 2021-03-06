package top.guhanjie.wine.mapper;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import top.guhanjie.wine.model.LotteryInfo;

public interface LotteryInfoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int insert(LotteryInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int insertSelective(LotteryInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    LotteryInfo selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int updateByPrimaryKeySelective(LotteryInfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lottery_info
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int updateByPrimaryKey(LotteryInfo record);
    
	//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LotteryInfo selectByTime(@Param("start")Date start, @Param("end")Date end);
    LotteryInfo selectByRound(@Param("round")String round);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}