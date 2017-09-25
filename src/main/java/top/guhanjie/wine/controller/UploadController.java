package top.guhanjie.wine.controller;

import java.io.File;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import top.guhanjie.wine.util.IdGenerator;

/**
 * Created by guhanjie on 2017-09-18.
 */
@Controller 
public class UploadController extends BaseController{

	private static final Logger LOGGER = LoggerFactory.getLogger(UploadController.class);
	
	@ResponseBody
	@RequestMapping(value="/upload")
	public Map<String, Object> upload(@RequestParam("imgType") String type, 
			@RequestParam("name") String name, @RequestParam("file") MultipartFile file) throws Exception{
		if(!file.isEmpty()) {
			int suffixIdx = name.lastIndexOf('.');
			String suffix = (suffixIdx != -1) ? name.substring(suffixIdx) : ".jpg";
			String destFileName = type+"-"+IdGenerator.getShortUuid()+suffix;
			File destFile = new File(servletContext.getRealPath("/")+"/WEB-INF/assets/images/"+destFileName);
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
}
