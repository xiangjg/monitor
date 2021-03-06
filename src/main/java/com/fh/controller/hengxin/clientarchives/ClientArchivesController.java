package com.fh.controller.hengxin.clientarchives;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.fh.entity.henxin.Content;
import com.fh.service.hengxin.ContentService;
import com.fh.service.system.user.UserService;
import com.fh.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.hengxin.clientarchives.ClientArchivesService;

/** 
 * 类名称：ClientArchivesController
 * 创建人：FH 
 * 创建时间：2016-10-15
 */
@Controller
@RequestMapping(value="/clientarchives")
public class ClientArchivesController extends BaseController {
	
	String menuUrl = "clientarchives/list.do"; //菜单地址(权限用)
	@Resource(name="clientarchivesService")
	private ClientArchivesService clientarchivesService;
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "contentService")
	private ContentService contentService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增ClientArchives");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		String userName = (String)currentUser.getPrincipal();
		PageData pd1 = new PageData();
		pd1.put("USERNAME",userName);
		pd1 = userService.findByUId(pd1);
		String userId = pd1.getString("USER_ID");

		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CLIENTARCHIVES_ID", this.get32UUID());	//主键
		pd.put("USER_ID", userId);	//用户ID
		pd.put("CREATE_DATE", Tools.date2Str(new Date()));	//创建时间
		clientarchivesService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除ClientArchives");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			clientarchivesService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改ClientArchives");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		clientarchivesService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表ClientArchives");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData>	varList = clientarchivesService.list(page);	//列出ClientArchives列表
			for (PageData pp:varList
					) {
				String reportId = pp.get("CLIENTARCHIVES_ID").toString();
				Content param = new Content();
				param.setRefTable("HX_CLIENTARCHIVES");
				param.setRefFiled("CLIENTARCHIVES_ID");
				param.setRefValue(reportId);
				List<Content> files = contentService.getContent(param);
				pp.put("files",files);
			}
			mv.setViewName("hengxin/clientarchives/clientarchives_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增ClientArchives页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("hengxin/clientarchives/clientarchives_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改ClientArchives页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = clientarchivesService.findById(pd);	//根据ID读取
			mv.setViewName("hengxin/clientarchives/clientarchives_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除ClientArchives");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				clientarchivesService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出ClientArchives到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("客户名称");	//1
			titles.add("联系电话");	//2
			titles.add("估价对象地址");	//3
			titles.add("委托方");	//4
			titles.add("创建时间");
			titles.add("客户信息介绍");
			titles.add("备注");
			dataMap.put("titles", titles);
			List<PageData> varOList = clientarchivesService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("CLIENTNAME"));	//1
				vpd.put("var2", varOList.get(i).getString("PHONE"));	//2
				vpd.put("var3", varOList.get(i).getString("ADDRESS"));	//3
				vpd.put("var4", varOList.get(i).getString("CLIENT"));	//4
				vpd.put("var5", varOList.get(i).getString("CREATE_DATE"));
				vpd.put("var6", varOList.get(i).getString("MESSAGE"));
				vpd.put("var7", varOList.get(i).getString("REMARK"));
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
	 * 去新增页面
	 */
	@RequestMapping(value = "/goImgAdd")
	public ModelAndView goImgAdd() {
		logBefore(logger, "去新增DataBasePictures页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("hengxin/clientarchives/pictures_add");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	@SuppressWarnings({ "unused" })
	@RequestMapping(value = "/saveImg", method = RequestMethod.POST, produces = { "application/json;charset=UTF-8" })
	public void AjaxUpload(HttpServletRequest request,
						   HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("status", "fail");
		String dbid = request.getParameter("dbid");
		String docType = request.getParameter("docType");
		List<MultipartFile> files = ((MultipartHttpServletRequest) request)
				.getFiles("file");
		if (files.size() < 1 || files.get(0).getSize() <= 0) {
			result.put("message", "上传文件不能为空!");
		}
		SimpleDateFormat mysdf = new SimpleDateFormat("yyyyMMddHHmmss");
		try {
			MultipartFile file = files.get(0);
			Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
			String userName =  (String)currentUser.getPrincipal();
			PageData param = new PageData();
			param.put("USERNAME",userName);
			param = userService.findByUId(param);
			String userId = param.getString("USER_ID");

			Content content  = new Content();
			content.setContentName(file.getOriginalFilename());
			content.setContentType(file.getContentType());
			content.setDocType(docType);
			content.setFileSize(String.valueOf(file.getSize()));
			content.setPath("d:\\content\\"+docType+ File.separator+ mysdf.format(new Date()));
			content.setRefTable("HX_CLIENTARCHIVES");
			content.setRefFiled("CLIENTARCHIVES_ID");
			content.setRefValue(dbid);
			content.setCreateDate(Tools.date2Str(new Date()));
			content.setUserId(userId);
			contentService.saveFile(content,file.getBytes());
			result.put("status", "success");
			result.put("message", "上传成功!");
		}catch (Exception e){
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
/*	@RequestMapping(value = "/saveImg")
	@ResponseBody
	public Object saveImg(@RequestParam(required = false) MultipartFile file) throws Exception {
		logBefore(logger, "新增DataBasePictures");
		Map<String, String> map = new HashMap<String, String>();
		String ffile = DateUtil.getDays(), fileName = "";
		PageData pd = new PageData();
		pd = this.getPageData();
		SimpleDateFormat mysdf = new SimpleDateFormat("yyyyMMddHHmmss");
		if (Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			if (null != file && !file.isEmpty()) {
//				if(file.getBytes().length>500*1024){
//					map.put("result", "ok");
//					return AppUtil.returnObject(pd, map);
//				}
				Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
				String userName =  (String)currentUser.getPrincipal();
				PageData param = new PageData();
				param.put("USERNAME",userName);
				param = userService.findByUId(param);
				String userId = param.getString("USER_ID");

				String docType = pd.getString("docType");
				Content content  = new Content();
				content.setContentName(file.getOriginalFilename());
				content.setContentType(file.getContentType());
				content.setDocType(docType);
				content.setFileSize(String.valueOf(file.getSize()));
				content.setPath("d:\\content\\"+docType+ File.separator+ mysdf.format(new Date()));
				content.setRefTable("HX_CLIENTARCHIVES");
				content.setRefFiled("CLIENTARCHIVES_ID");
				content.setRefValue(pd.getString("dbid"));
				content.setCreateDate(Tools.date2Str(new Date()));
				content.setUserId(userId);
				contentService.saveFile(content,file.getBytes());
			} else {
				System.out.println("上传失败");
			}
		}
		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
	}*/
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
