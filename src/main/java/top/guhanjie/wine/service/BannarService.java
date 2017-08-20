package top.guhanjie.wine.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.BannarMapper;
import top.guhanjie.wine.model.Bannar;
import top.guhanjie.wine.util.TTLCache;

@Service
public class BannarService {	

	private static final Logger LOGGER = LoggerFactory.getLogger(BannarService.class);
	
	private static final TTLCache<Integer, Bannar> CACHE = new TTLCache<Integer, Bannar>(-1); //失效时间为20分钟，按进入时间超时逐出
	
	@Autowired
	private BannarMapper bannarMapper;
	
	public void addBannar(Bannar bannar) {
	    try {
	        bannarMapper.insertSelective(bannar);
	    } catch(DuplicateKeyException e) {
	        LOGGER.error("当前位置的bannar已存在，无法添加", e);
	    }
        CACHE.put(bannar.getIdx(), bannar);
	    LOGGER.debug("Added a new bannar[{}]...", JSON.toJSONString(bannar));
	}
	
	public void updateBannar(Bannar bannar) {
	    bannarMapper.updateByPrimaryKeySelective(bannar);
	    bannar = bannarMapper.selectByPrimaryKey(bannar.getId());
	    CACHE.put(bannar.getIdx(), bannar);
	    LOGGER.debug("Updated bannar[{}]...", JSON.toJSONString(bannar));
	}
	
	public void deleteBannar(Bannar bannar) {
        bannarMapper.deleteByPrimaryKey(bannar.getId());
        CACHE.remove(bannar.getIdx());
        LOGGER.debug("Deleted bannar[{}]...", JSON.toJSONString(bannar));
	}
	
	public List<Bannar> listBannar() {
	    if(CACHE.size() == 0) {
	        LOGGER.info("Bannar cache set up...");
	        List<Bannar> list = bannarMapper.selectAll();
	        for(Bannar b : list) {
	            CACHE.put(b.getIdx(), b);
	        }
	    }
	    Set<Integer> keys = new TreeSet<Integer>(CACHE.keySet());
	    List<Bannar> bannars = new ArrayList<Bannar>();
	    for(Integer key : keys) {
	        bannars.add(CACHE.get(key));
	    }
	    return bannars;
	}
	
}
