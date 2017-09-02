package top.guhanjie.wine.mapper;

import java.util.List;
import java.util.Map;

import top.guhanjie.wine.model.Order;

public interface OrderMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    int insert(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    int insertSelective(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    Order selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    int updateByPrimaryKeySelective(Order record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table order
     *
     * @mbggenerated Sat Aug 19 18:06:45 CST 2017
     */
    int updateByPrimaryKey(Order record);
    
    //------------------------- custom add -----------------------------
    List<Order> selectByUserId(Integer userid);
    
    List<Order> selectByUserOpenId(String openid);
    
    List<Order> selectByUserPhone(String phone);
    
    List<Order> selectByQualifiedPage(Map<String, Object> param);
    
    int countSelective(Map<String, Object> param);
    
    int updateByStatus(Order record, int oldstaus);
    
    int updateByPayStatus(Order record, int oldstatus, int oldPayStatus);
    //--------------------------------------------------------------------
}