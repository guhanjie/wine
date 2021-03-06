package top.guhanjie.wine.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import top.guhanjie.wine.model.RushItem;

public interface RushItemMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    int insert(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    int insertSelective(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    RushItem selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    int updateByPrimaryKeySelective(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 20 16:15:40 CST 2017
     */
    int updateByPrimaryKey(RushItem record);
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    List<RushItem> selectAll();
    List<RushItem> selectByStatus(int status);
    List<RushItem> selectByRound(String round);
    int addSales(@Param("itemid")Integer itemid, @Param("counts")Integer counts);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}