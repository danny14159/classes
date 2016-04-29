package com.clz.core.module;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.clz.core.bean.TClasses;
import com.clz.core.bean.TCollege;
import com.clz.core.bean.TProf;
import com.clz.core.bean.TStu;
import com.clz.core.bean.TStuPics;
import com.clz.core.extend.AjaxReturn;
import com.clz.core.extend.ImageUtil;
import com.clz.core.extend.MD5;
import com.clz.core.extend.Mapper;
import com.clz.core.extend.file.FileTypeJudge;
import com.clz.core.service.ClassesService;
import com.clz.core.service.CollegeService;
import com.clz.core.service.ProfService;
import com.clz.core.service.StuPicsService;
import com.clz.core.service.StuService;

@Controller
@RequestMapping("/upd")
public class UploadModule {
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private StuPicsService stuPicsService;
	@Autowired
	private StuService stuService;

	/**
	 * @return 
	 */
	/**文件保存至服务器的私有函数
	 * @param file 文件
	 * @param typeFilter 文件类型
	 * @param moduleName 模块名称，命名时模块名称+时间戳
	 * @param StoreFolder 上传目录，under /WEB-INF/frontend/assets/upload/
	 * @param returnPath 返回的文件路径 returnPath+filename
	 * @param thumbnail 是否生成缩略图，同目录下源文件名+thumb[width]-[height]
	 * @return 返回文件名，false表示发生错误。
	 */
	private AjaxReturn processUploading(
			MultipartFile file,
			String typeFilter,
			String moduleName,
			String storeFolder,
			String returnPath,
			boolean thumbnail,
			int thumb_width,
			int thumb_height){
		if(null == file || file.isEmpty()){
			return new AjaxReturn(false, "文件未上传");
		}
		
		// 文件类型 过滤
		boolean isFileSpecified = false;
		try {
			isFileSpecified = FileTypeJudge.isFileSpecifiedType(file.getInputStream(), typeFilter);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		System.out.println("is file "+typeFilter+":"+isFileSpecified);
		if(!isFileSpecified){
			return new AjaxReturn(false, "文件类型错误，请检查。");
		}
		
		//获得存储路径
		String realPath = request.getSession().getServletContext().getRealPath("/WEB-INF/frontend/assets/upload/"+storeFolder );
		
		// 文件存储到服务器，加上时间戳
		String fileName = moduleName + new Date().getTime();
		try {
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(
					realPath, fileName));
			System.out.println("向服务器写入文件"+realPath+","+fileName);
		} catch (IOException e) {
			e.printStackTrace();
			return new AjaxReturn(false, "服务器文件存储异常");
		}
		
		//生成缩略图
		if(thumbnail)
			try {
				BufferedImage bufimg = ImageUtil.fillImage(ImageIO.read(file.getInputStream()), thumb_width, thumb_height);
				ImageIO.write(bufimg, "PNG", new File(
						realPath, fileName+"thumb"+thumb_width+"-"+thumb_height));
			} catch (IOException e) {
				e.printStackTrace();
				return new AjaxReturn(false, "缩略图生成异常！");
			}
		return new AjaxReturn(true,returnPath+fileName);
	}
	/**班级LOGO
	 * @param logo
	 * @return
	 */
	@RequestMapping("/clzlogo")
	@ResponseBody
	public Object clzlogo(@RequestParam MultipartFile logo){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		return processUploading(logo,"image","clzlogo",
				"clzlogo/"+s.getClassId(),
				"/f/assets/upload/clzlogo/"+s.getClassId()+"/",true,118,118);
	}
	
	@RequestMapping("/stuavatar")
	@ResponseBody
	public Object stuavatar(@RequestParam MultipartFile avatar){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		return processUploading(avatar,"image","avatar",
				"avatar/"+s.getNo()+"-"+s.getClassId(),
				"/f/assets/upload/avatar/"+s.getNo()+"-"+s.getClassId()+"/",true,102,102);
	}
	
	/**作业图片附件
	 * @param pics
	 * @return
	 */
	@RequestMapping("/hwpics")
	@ResponseBody
	public Object hwpics(@RequestParam MultipartFile[] pics){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		boolean succ = true;
		String strpics = "";
		for(MultipartFile mpf:pics){
			AjaxReturn ar = processUploading(mpf,"image","hwpics",
					"hwpics/"+s.getClassId(),
					"/f/assets/upload/hwpics/"+s.getClassId()+"/",true,110,110);
			if(!ar.getOk()) succ = false;
			else strpics += ";"+ar.getMsg();
		}
		return new AjaxReturn(succ, strpics.substring(1));
	}
	@RequestMapping("/stupics")
	@ResponseBody
	public Object stupics(@RequestParam MultipartFile[] stupics){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		boolean succ = true;
		for(MultipartFile mpf:stupics){
			AjaxReturn ar = processUploading(mpf,"image","stupics",
					"stupics/"+s.getNo()+"-"+s.getClassId(),
					"/f/assets/upload/stupics/"+s.getNo()+"-"+s.getClassId()+"/",true,110,110);
			if(!ar.getOk()) succ = false;
			else {
				//在stupics表中添加一条记录
				TStuPics tps = new TStuPics();
				tps.setStuClz(s.getClassId());
				tps.setStuNo(s.getNo());
				tps.setType('P');
				tps.setPicPath(ar.getMsg());
				stuPicsService.insert(tps);
			}
		}
		return new AjaxReturn(succ, null);
	}
	/**事件中的图片
	 * @param pics
	 * @return
	 */
	@RequestMapping("/evtpics")
	@ResponseBody
	public Object evtpics(@RequestParam MultipartFile pics){
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) return new AjaxReturn(false, "请先登录");
		
		AjaxReturn ar = processUploading(pics,"image","evtpics",
					"evtpics/"+s.getClassId(),
					"/f/assets/upload/evtpics/"+s.getClassId()+"/",true,284,250);
		return AjaxReturn.ok(ar.getOk()?1:0, ar.getMsg(),null);
	}
	
	/**UEditor所有的图片上传接口
	 * @param img
	 * @return
	 */
	@RequestMapping(value="/ueimage")
	public String ueimage(@RequestParam MultipartFile img,Model model){
		System.out.println(img==null);
		TStu s = SystemModule.getLoginStu(request);
		if(null == s) {
			model.addAttribute("data","{\"state\":\"请先登录\"}");
		}
		else{
			
			AjaxReturn ar = (AjaxReturn)
			processUploading(img,"image","ueimage",
				"ueimage/"+s.getClassId(),
				"/f/assets/upload/ueimage/"+s.getClassId()+"/",false,0,0);
			
			model.addAttribute("data","{\"url\":\""+ar.getMsg()+"\",\"state\":\"SUCCESS\"}");
		}
		
		return "frontend/assets/ueditor/jsp/ueresolver.jsp";
		//TODO
	}
	
	@RequestMapping(value="/ueditor/controller")
	public String ueditorController(@RequestParam String action){
		if("config".equals(action))
			return "frontend/assets/ueditor/jsp/controller.jsp";
		else if("ueimg".equals(action)){
			return "forward:/upd/ueimage";
		}
		return "";
	}
	
	/**上传学生excel表
	 * @return
	 */
	@RequestMapping("/upstuxls")
	@ResponseBody
	public Object uploadStusExcel(@RequestParam MultipartFile stusxls){
		
		HSSFWorkbook workbook ;
		try {
			workbook = new HSSFWorkbook(stusxls.getInputStream());
			// 获得指定的sheet
			HSSFSheet sheet0 = workbook.getSheetAt(0);
			//行，列数
			int crow = sheet0.getLastRowNum();
			//int ccol = sheet0.getRow(0).getLastCellNum();
			
			//HSSFRow headRow = sheet0.getRow(0);//第一行
			int iNo=0,iName=1,icollege = 3,iprof=4,iclass=5;
			/*for(int i = 0;i<ccol;i++){
				HSSFCell cell = headRow.getCell(i);
				
				String thead = String.valueOf(ExcelUtils.getCellString(cell));
				if("学号".equals(thead)) ioNo = i;
				else if("姓名".equals(thead)) ioName = i;
			}
			if(ioNo<0 || ioName<0) return new AjaxReturn(false,"上传的Excel文件中不存在“学号”或“姓名”列！");*/
			
			for(int i=1;i<=crow;i++){
				HSSFRow row = sheet0.getRow(i);
					if(null!=row){
					String no =row.getCell(iNo).getStringCellValue();
					String name = row.getCell(iName).getStringCellValue();
					String college = row.getCell(icollege).getStringCellValue();
					String prof = row.getCell(iprof).getStringCellValue();
					String clz = row.getCell(iclass).getStringCellValue();
					int clzId = insertObj(3,clz,insertObj(2,prof,insertObj(1,college,1)));
					
					TStu stu = new TStu();
					stu.setClassId(clzId);
					stu.setDeleted('N');
					stu.setName(name);
					stu.setNo(no);
					
					int lno = no.length();
					stu.setPassword(MD5.encrypt(no.substring(lno-6, lno)));//密码默认为学号后6位
					try{
						stuService.insert(stu);
					}
					catch(Exception e){}
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
			return new AjaxReturn(false,"系统异常");
		}
		
		return new AjaxReturn(true, null);
	}
	
	@Autowired
	private CollegeService collegeService;
	@Autowired
	private ProfService profService;
	@Autowired
	private ClassesService classesService;
	/**插入某个值，返回插入值的ID
	 * @return
	 */
	public int insertObj(int type,String value,int parentId){
		Map<String,Object> param = Mapper.make("name", value).toHashMap();
		if(1==type){
			TCollege t = collegeService.load(param);
			if(null == t){
				t = new TCollege();
				t.setName(value);
				t.setUnivId(parentId);
				collegeService.insert(t);
				return collegeService.load(param).getId();
			}
			else return t.getId();
		}
		else if(2==type){
			TProf t = profService.load(param);
			if(null == t){
				t = new TProf();
				t.setName(value);
				t.setCollegeId(parentId);
				profService.insert(t);
				return profService.load(param).getId();
			}
			else return t.getId();
		}
		else if(3==type){
			TClasses t = classesService.load(param);
			if(null == t){
				t = new TClasses();
				t.setName(value);
				t.setProfId(parentId);
				t.setBalance(0d);
				classesService.insert(t);
				return classesService.load(param).getId();
			}
			else
				return t.getId();
		}
		return -1;
	}
}

