package com.fh.controller.hengxin;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.henxin.Content;
import com.fh.entity.henxin.Report;
import com.fh.entity.system.Role;
import com.fh.service.henxin.ContentService;
import com.fh.service.henxin.ReportService;
import com.fh.service.system.user.UserService;
import com.fh.util.Const;
import com.fh.util.PageData;
import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 向敬光 on 2016/8/25.
 */
@Controller
@RequestMapping(value = "/document")
public class Document extends BaseController {

    @Resource(name = "reportService")
    private ReportService reportService;
    @Resource(name = "contentService")
    private ContentService contentService;
    @Resource(name = "userService")
    private UserService userService;

    @RequestMapping(value = "/assessment")
    public ModelAndView assessment(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("hengxin/document/assessment");
        return mv;
    }

    @RequestMapping(value = "/estimate")
    public ModelAndView estimate(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();

        mv.setViewName("hengxin/document/estimate");
        return mv;
    }

    @SuppressWarnings({ "unused" })
    @RequestMapping(value = "/webUpload", method = RequestMethod.POST, produces = { "application/json;charset=UTF-8" })
    public void AjaxUpload(HttpServletRequest request,
                                      HttpServletResponse response) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("status", "fail");
        String docType = request.getParameter("type");// 文档类型
        String address = request.getParameter("address");
        String bank = request.getParameter("bank");
        String client = request.getParameter("client");

        SimpleDateFormat mysdf = new SimpleDateFormat("yyyyMMddHHmmss");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
            String userName = (String)currentUser.getPrincipal();
            PageData pd = new PageData();
            pd.put("USERNAME",userName);
            pd = userService.findByUId(pd);
            String userId = pd.getString("USER_ID");

            List<MultipartFile> files = ((MultipartHttpServletRequest) request)
                    .getFiles("file");
            if (files.size() < 1 || files.get(0).getSize() <= 0) {
                result.put("message", "上传文件不能为空!");
            }
            MultipartFile file = files.get(0);
            String contentType = file.getContentType();
            String size = String.valueOf(file.getSize());
            String name = file.getOriginalFilename();
            byte[] bytes = file.getBytes();
            if (bytes.length <= 0) {
                result.put("message", "上传文件内容不能为空!");
            }
            String filePath = "d:\\content\\"+docType+ File.separator+ mysdf.format(new Date());
            FileUtils.writeByteArrayToFile(new File(filePath),bytes);



            Report report = new Report();
            report.setType(1);
            report.setAddress(address);
            report.setBank(bank);
            report.setClient(client);
            report.setCreateDate(sdf.format(new Date()));
            report.setUserId(userId);
            reportService.save(report);
            report = reportService.getReportInfo(report);

            Content content = new Content();
            content.setContentName(name);
            content.setContentType(contentType);
            content.setDocType(docType);
            content.setFileSize(size);
            content.setPath(filePath);
            content.setRefTable("hx_report");
            content.setRefFiled("id");
            content.setRefValue(report.getId().toString());
            content.setCreateDate(sdf.format(new Date()));
            content.setUserId(userId);
            contentService.save(content);
            result.put("status", "success");
            result.put("message", "上传成功!");
        } catch (Exception e) {
            logger.error("");
            result.put("status", "fail");
            if (result.get("message") == null)
                result.put("message", e.getMessage());
        }
        response.setContentType("application/json" + ";charset=UTF-8");
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
}
