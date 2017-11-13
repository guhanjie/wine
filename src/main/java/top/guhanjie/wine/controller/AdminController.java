package top.guhanjie.wine.controller;

import java.io.File;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.User;
import top.guhanjie.wine.service.CategoryService;
import top.guhanjie.wine.service.UserService;
import top.guhanjie.wine.util.IdGenerator;

/**
 * Created by guhanjie on 2017-09-17.
 */
@Controller 
@RequestMapping("/admin")
public class AdminController extends BaseController{
    private static final Logger LOGGER = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;
    
	@RequestMapping(value="", method=RequestMethod.GET)
	public String admin(Model model) {
		return "admin";
	}
	
	/*
	 *  upload img for admin
	 */
    @ResponseBody
    @RequestMapping(value="/upload")
    public Map<String, Object> upload(@RequestParam("imgType") String type, 
            @RequestParam("name") String name, @RequestParam("file") MultipartFile file) throws Exception{
        if(!file.isEmpty()) {
            int suffixIdx = name.lastIndexOf('.');
            String suffix = (suffixIdx != -1) ? name.substring(suffixIdx) : ".jpg";
            String destFileName = type+"-"+IdGenerator.getShortUuid()+suffix;
            //File destFile = new File(servletContext.getRealPath("/")+"/WEB-INF/assets/images/"+destFileName);
            File destFile = new File("/data/wwwroot/www.guhanjie.top/wine/resources/images/"+destFileName);
            LOGGER.info("uploading image file[{}]", destFile.getAbsolutePath());
            if(!destFile.exists()) {
                destFile.createNewFile();
            }
            file.transferTo(destFile);
            return success("images/"+destFileName);
        }
        else {
            LOGGER.warn("upload image file, but file is empty.");
            return fail("文件不存在");
        }
    }
	//-------------------------------------------------------------------------
	
	/*
	 *  user management for admin
	 */
    @ResponseBody
    @RequestMapping(value="/user", method=RequestMethod.GET)
    public Map<String, Object> findUser(@RequestParam("search") String str) {
        return success(userService.findUser(str));
    }
    
    @ResponseBody
    @RequestMapping(value="/user/points", method=RequestMethod.PUT)
    public Map<String, Object> updateUserPoints(@RequestParam("id") Integer userid, @RequestParam("points")Integer points) {
        LOGGER.info("update user[{}] points[{}]", userid, points);
        User user = new User();
        user.setId(userid);
        user.setPoints(points);
        userService.updateUserPoint(user);
        LOGGER.debug("refresh session for user[{}]", JSON.toJSONString(user));
        user = userService.getUserById(userid);
        setSessionUser(user);
        return success();
    }
    
    @ResponseBody
    @RequestMapping(value="/user/type", method=RequestMethod.PUT)
    public Map<String, Object> updateUserType(@RequestParam("id") Integer userid, @RequestParam("type")Integer type) {
        LOGGER.info("update user[{}] type[{}]", userid, type);
        User user = new User();
        user.setId(userid);
        user.setType(type);
        userService.updateUser(user);
        LOGGER.debug("refresh session for user[{}]", JSON.toJSONString(user));
        user = userService.getUserById(userid);
        setSessionUser(user);
        return success();
    }
    //-------------------------------------------------------------------------
	
}
