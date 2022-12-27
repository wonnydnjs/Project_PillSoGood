package com.kh.pill.product.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.member.model.vo.Member;
import com.kh.pill.product.model.service.ProductService;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.product.model.vo.ProductLike;

@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	/**
	 * 상품 전체 리스트 조회
	 * @return
	 */
	@RequestMapping("list.pr")
	public String selectList(@RequestParam(value="order", defaultValue="all")String order, String keyword, Model model) {
		
		ArrayList<Product> list = new ArrayList<>();
		
		if(keyword == null) {
			list = productService.selectList(order);
		} else {
			list = productService.selectList(keyword);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("order", order);
		model.addAttribute("keyword", keyword);
		
		return "product/productListView";
	}
	
	/**
	 * 상품 등록 폼 띄우기
	 * @return
	 */
	@RequestMapping("enrollForm.pr")
	public String enrollForm() {
		
		return "product/productEnrollForm";
	}
	
	/**
	 * @param 상품 등록
	 * @return
	 */
	@RequestMapping("insert.pr")
	public ModelAndView insertProduct(Product p, MultipartHttpServletRequest request, HttpSession session, ModelAndView mv) throws Exception{
		
		List<MultipartFile> upfiles = request.getFiles("upfile"); // 파일 name 담기
		 
		String path = session.getServletContext().getRealPath("/resources/productUploadFiles/"); // 실제 경로 알아내기
		    
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int c = 0; // 파일 레벨을 구분하기 위한 변수선언
		
		for (MultipartFile f : upfiles) {
			
			if(!f.getOriginalFilename().equals("")) {
				
				String originFileName = f.getOriginalFilename(); // 원본파일명
		 
				String ext = originFileName.substring(originFileName.lastIndexOf("."));
				
				String saveFileName = currentTime + ext; // 수정파일명 만들기
				
				if(c == 0) {
					saveFileName = "d" + saveFileName;
					p.setProductImgPath("resources/productUploadFiles/" + saveFileName);
				}
				
				// 파일생성 하기
			    f.transferTo(new File(path, saveFileName));
			    p.setProductDescription("resources/productUploadFiles/" + saveFileName); // Product에 담아주기
			    
			    c++;
			}
		}
		
		int result = productService.insertProduct(p); // Service단으로 보내기
		 
		if(result > 0) {
			
			session.setAttribute("alertMsg", "제품이 성공적으로 등록되었습니다.");
			mv.setViewName("redirect:/list.pr");
		}
		else {
			mv.addObject("alertMsg", "제품 등록에 실패했습니다.");
		}
		 
		return mv;
	}
	
	/**
	 * @param 상품 상세 조회
	 * @return
	 */
	@RequestMapping("detail.pr")
	public ModelAndView selectProduct(int pno, ModelAndView mv, HttpSession session) {
	      
		// 게시글 조회수 증가용 서비스 호출 결과 받기 (update 하고 오기)
		int result = productService.increaseCount(pno);
		
		int count = 0;
		
		if(session.getAttribute("loginUser") != null) {
			
			int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo(); 
			
			ProductLike pl = new ProductLike(memberNo, pno);
			count = productService.selectProductLike(pl);
		}
		
		
		if(result > 0) { // 성공적으로 조회수 증가가 일어났다면
		 
			// 상세조회 요청
			// DetailView.jsp 상에 필요한 데이터 조회
			Product p = productService.selectProduct(pno);
			 
			// 조회된 데이터를 담아서 포워딩 
			mv.addObject("count", count);
			mv.addObject("p", p).setViewName("product/productDetailView");
		
		}
		else { // 실패 
			
			mv.addObject("alertMsg", "게시글 조회 실패").setViewName("common/errorPage");
			
		}
		
		return mv;
	}
	
	/**
	 * @param 상품 삭제
	 * @return
	 */
	@RequestMapping("delete.pr")
	public String deleteProduct(int pno, String[] upfile, HttpSession session, Model model) {
		
		int result = productService.deleteProduct(pno);
		
		if(result > 0) { // 게시글 삭제 성공
			
			// 첨부파일이 있을 경우 => 파일 삭제
			// filePath 에는 해당 게시글의 수정파일명이 들어있음
			// filePath 값이 빈 문자열이 아니라면 첨부파일이 있었던 경우임
			for(String s : upfile) {
				
				if(!s.equals("")) {
					String realPath = session.getServletContext().getRealPath(s);
					new File(realPath).delete();
				}
			}
			
			// 게시판 리스트 페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/list.pr";
		}
		else { // 게시글 삭제 실패
			
			model.addAttribute("alertMsg", "게시글 삭제 실패");
			return "redirect:/list.pr";
		}
	}
	
	/**
	 * @param 상품 수정 폼 띄우기
	 * @return
	 */
	@RequestMapping("updateForm.pr")
	public String updateForm(int pno, Model model) {
		
		// 게시글 수정 페이지를 포워딩 하기 전에 우선적으로 해당 게시글 정보 조회
		Product p = productService.selectProduct(pno); // 기존의 상세보기 서비스 재활용
		
		model.addAttribute("p", p);
		
		return "product/productUpdateForm";
	}
	
	/**
	 * @param 상품 수정
	 */
	@RequestMapping("update.pr")
	public String updateProduct(Product p, MultipartFile upfile1, MultipartFile upfile2, HttpSession session, Model model) throws Exception {
		
		// upfile1 새로 올린 썸네일
		// upfile2 새로 올린 상세사진
		String path = session.getServletContext().getRealPath("/resources/productUploadFiles/"); // 실제 경로 알아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		// 새로운 썸네일이 있을 경우
		if(!upfile1.getOriginalFilename().equals("")) {
			
			String originFileName = upfile1.getOriginalFilename(); // 원본파일명
			String ext = originFileName.substring(originFileName.lastIndexOf("."));
			String saveFileName = currentTime + ext; // 수정파일명 만들기
			
			// 기존 썸네일이 있을 경우
			if(p.getProductImgPath() != null) {
				String realPath = session.getServletContext().getRealPath(p.getProductImgPath());
				new File(realPath).delete();
			}
			saveFileName = "d" + saveFileName;
			upfile1.transferTo(new File(path, saveFileName));
			p.setProductImgPath("resources/productUploadFiles/" + saveFileName);
		}
		
		// 새로운 상세사진이 있을 경우
		if(!upfile2.getOriginalFilename().equals("")) {
			
			String originFileName = upfile2.getOriginalFilename(); // 원본파일명
			String ext = originFileName.substring(originFileName.lastIndexOf("."));
			String saveFileName = currentTime + ext; // 수정파일명 만들기
			
			// 기존 상세사진이 있을 경우
			if(p.getProductDescription() != null) {
				String realPath = session.getServletContext().getRealPath(p.getProductDescription());
				new File(realPath).delete();
			}
			upfile2.transferTo(new File(path, saveFileName));
			p.setProductDescription("resources/productUploadFiles/" + saveFileName);
		}
		
		int result = productService.updateProduct(p);
		
		if(result > 0) { // 게시글 수정 성공
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			// 게시글 상세보기 페이지로 url 재요청
			return "redirect:/detail.pr?pno=" + p.getProductNo();
		}
		else { // 게시글 수정 실패
			
			model.addAttribute("alertMsg", "게시글 수정 실패");
			
			return "redirect:/detail.pr?pno=" + p.getProductNo();
		}
	}
	
	/**
	 * @param 상품 찜하기
	 * @param session
	 */
	@ResponseBody
	@RequestMapping("like.pr")
	public int productLike (ProductLike pl) {
		
		int	result = productService.insertProductLike(pl);
		
		return result;
	}
	
	/**
	 * @param 상품 찜 취소
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deletelike.pr")
	public int productUnLike (ProductLike pl) {
		
		int	result = productService.deleteProductLike(pl);
			
		return result;
	}
	
	
	//------------------------------------------------- 관리자 페이지 --------------------------------------------------------//
	
	
	/**
	 * 관리자 제품 관리 조회
	 */
	@RequestMapping("ProductList.ad")
	public String adminSelectProductList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
		
		int listCount = productService.adSelectListCount();
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Product> list = productService.adSelectProductList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "product/adminProductListView";
		
		
		
	}
	
	
	
	
	

	
	
}
