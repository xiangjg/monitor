package com.fh.controller.hengxin;

import com.fh.entity.henxin.Content;
import com.fh.service.hengxin.ContentService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by jone on 2016/10/15.
 */
@Controller
@RequestMapping(value = "/download")
public class DownLoadController {

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
            e.printStackTrace();
        }finally {
            if(out!=null)
                out.close();
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
