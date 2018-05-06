package top.guhanjie.wine.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import top.guhanjie.wine.model.RushLottery;

public interface RushLotteryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int insert(RushLottery record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int insertSelective(RushLottery record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    RushLottery selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int updateByPrimaryKeySelective(RushLottery record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_lottery
     *
     * @mbggenerated Sun Apr 15 17:33:13 CST 2018
     */
    int updateByPrimaryKey(RushLottery record);

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    List<RushLottery> selectByOrderItem(@Param("order_id")Integer orderid, @Param("rush_item_id")Integer itemid);
    RushLottery selectByItemCode(@Param("rush_item_id")Integer itemid, @Param("lottery_code")String rcode);
    int countByItem(@Param("rush_item_id")Integer itemid);
    int countUsersByItem(@Param("rush_item_id")Integer itemid);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}