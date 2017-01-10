package com.fh.controller.hengxin;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.henxin.Content;
import com.fh.service.hengxin.ContentService;
import com.fh.util.PageData;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by jone on 2016/10/15.
 */
@Controller
@RequestMapping(value = "/download")
public class DownLoadController extends BaseController{

    @Resource(name = "contentService")
    private ContentService contentService;

    @RequestMapping("/file")
    public void postRequest(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contentId = request.getParameter("cid");
        Content content = new Content();
        content.setContentId(Integer.parseInt(contentId));
        //OutputStream os = null;
        ServletOutputStream out = null;
        try {
            content = contentService.getContentInfo(content);
            if(content!=null){
                File file = new File(content.getPath());
                byte[] data = FileUtils.readFileToByteArray(file);
                response.setContentType(content.getContentType());
                if(data!=null)
                    response.setContentLength(data.length);
                response.setHeader("Content-disposition", "attachment;filename="
                        + getFileName(request,response,content.getContentName()));
                out = response.getOutputStream();
                out.write(data);
                out.flush();
            }
        }catch (Exception e){
            logBefore(logger, e.getMessage());
            //e.printStackTrace();
        }finally {
            if(out!=null)
                out.close();
        }

    }
    @SuppressWarnings({ "unused" })
    @RequestMapping(value = "/file/del", method = RequestMethod.POST, produces = { "application/json;charset=UTF-8" })
    public void deleteFile(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("status", false);
        try {
            String contentId = request.getParameter("cid");
            PageData param = new PageData();
            param.put("contentId",contentId);
            contentService.delete(param);
            result.put("status", true);
        }catch (Exception e){
            logger.error(e.getMessage());
            result.put("msg", e.getMessage());
        }
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter pw = null;
        try {
            pw = response.getWriter();
            pw.write(JSON.toJSONString(result));
            pw.flush();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            if (pw != null)
                pw.close();
        }
    }

    public String getFileName(HttpServletRequest request,
                                             HttpServletResponse response, String fileName) {
        String agent = request.getHeader("USER-AGENT");
        try {
            if ((agent != null) && (-1 != agent.indexOf("MSIE"))) {
                String newFileName = URLEncoder.encode(fileName, "UTF-8");
                newFileName = StringUtils.replace(newFileName, "+", "%20");
                if (newFileName.length() > 150) {
                    newFileName = new String(fileName.getBytes("GB2312"),
                            "ISO8859-1");
                    newFileName = StringUtils.replace(newFileName, " ", "%20");
                }
                return newFileName;
            }
            if ((agent != null) && (-1 != agent.indexOf("Mozilla")))
                return new String(fileName.getBytes(), "ISO8859-1");

            return fileName;
        } catch (Exception ex) {
            return fileName;
        }

    }
}
