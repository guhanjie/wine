package top.guhanjie.wine.mapper;

import top.guhanjie.wine.model.RushItem;

public interface RushItemMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    int insert(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    int insertSelective(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    RushItem selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    int updateByPrimaryKeySelective(RushItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rush_item
     *
     * @mbggenerated Sun Aug 13 17:30:49 CST 2017
     */
    int updateByPrimaryKey(RushItem record);
}