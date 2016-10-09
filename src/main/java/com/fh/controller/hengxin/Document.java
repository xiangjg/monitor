package com.fh.controller.hengxin;

import com.alibaba.fastjson.JSON;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.util.Const;
import com.fh.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
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

    @RequestMapping(value = "/assessment")
    public ModelAndView assessment(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
//        PageData pd = new PageData();
//        pd = this.getPageData();
//
//        String USERNAME = pd.getString("USERNAME");
//
//        if (null != USERNAME && !"".equals(USERNAME)) {
//            USERNAME = USERNAME.trim();
//            pd.put("USERNAME", USERNAME);
//        }
//
//        String lastLoginStart = pd.getString("lastLoginStart");
//        String lastLoginEnd = pd.getString("lastLoginEnd");
//
//        if (lastLoginStart != null && !"".equals(lastLoginStart)) {
//            lastLoginStart = lastLoginStart + " 00:00:00";
//            pd.put("lastLoginStart", lastLoginStart);
//        }
//        if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
//            lastLoginEnd = lastLoginEnd + " 00:00:00";
//            pd.put("lastLoginEnd", lastLoginEnd);
//        }
//
//        page.setPd(pd);
//        List<PageData> userList = userService.listPdPageUser(page); // 列出用户列表
//        List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色

        mv.setViewName("hengxin/document/assessment");
//        mv.addObject("userList", userList);
//        mv.addObject("roleList", roleList);
//        mv.addObject("pd", pd);
//        mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        return mv;
    }

    @RequestMapping(value = "/estimate")
    public ModelAndView estimate(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();

        mv.setViewName("hengxin/document/estimate");
        return mv;
    }

    @SuppressWarnings({ "unused" })
    @RequestMapping(value = "/webUpload/assessment", method = RequestMethod.POST, produces = { "application/json;charset=UTF-8" })
    public void regulationsAjaxUpload(HttpServletRequest request,
                                      HttpServletResponse response) {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("status", "fail");
        DataReturnVo dv = new DataReturnVo();
        Integer docType = Integer.valueOf(request.getParameter("docType"));// 文档类型
        try {
            List<MultipartFile> files = ((MultipartHttpServletRequest) request)
                    .getFiles("file");
            if (files.size() < 1 || files.get(0).getSize() <= 0) {
                result.put("message", "上传文件不能为空!");
            }
            MultipartFile file = files.get(0);
            byte[] bytes = file.getBytes();
            if (bytes.length <= 0) {
                result.put("message", "上传文件内容不能为空!");
            }
            String orgName = request.getParameter("orgName");
            DisasterStatInfo model = new DisasterStatInfo();
            String reportDt = "";

            Date date = new Date();
            if (docType == 5002) {
                reportDt = request.getParameter("reportDt");
            } else if (docType == 5004) {
                reportDt = DateUtil.dateToString(date, "yyyy-MM-dd HH:mm:ss");
            } else {
                result.put("message", "文档类型错误!");
            }

            ContentObjectVo co = new ContentObjectVo();
            co.setContentName(file.getOriginalFilename());
            co.setContentType(file.getContentType());
            co.setDocType(docType);
            co.setContentData(bytes);
            co.setAdcd(getAdcd());
            co.setDocRef1(reportDt);
            co.setDocRef2(getUserId());
            co.setDocRef3(DateUtil.dateToString(date, "yyyy-MM-dd HH:mm:ss"));
            co.setSize(NumUtil.divideNumber(file.getSize(), 1024));
            dv.setRetcode(0);
            String contentId = contentManager.uploadContent3(co);
            result.put("status", "success");
            result.put("message", "上传成功!");
            // logger.debug("contentId:{}",contentId);
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
