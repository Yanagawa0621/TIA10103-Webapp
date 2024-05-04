package com.book_products.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book_products.model.BookProductsService;
import com.book_products.model.BookProductsVO;

@WebServlet("/book_products/book_products.do")
public class BookProductsServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		if ("getOne_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			// ----------以書籍編號搜尋----------
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

			// 輸入空字串處裡
			String str = req.getParameter("bookNumber");
			if (str == null || (str.trim()).length() == 0) {
				errorMsgs.add("請輸入書籍編號");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/book_products/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			// 輸入格式處理
			Integer bookNumber = null;
			try {
				bookNumber = Integer.valueOf(str);
			} catch (Exception e) {
				errorMsgs.add("請輸入正確的書籍編號格式");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/book_products/select_page.jsp");
				failureView.forward(req, res);
				return;
			}

			/*************************** 2.開始查詢資料 *****************************************/
			BookProductsService bpSvc = new BookProductsService();
			BookProductsVO bpVO = bpSvc.getOnebookProductsVO(bookNumber);
			if (bpVO == null) {
				errorMsgs.add("查無資料");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/book_products/select_page.jsp");
				failureView.forward(req, res);
				return;
			}
			/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
			req.setAttribute("bpVO", bpVO);
			String url = "/book_products/listOneBookProducts.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		// ----------單筆查詢資料----------
		if ("getOne_For_Update".equals(action) || "delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute(action, errorMsgs);
			/*************************** 1.接收請求參數 ****************************************/
			Integer bookNumber = Integer.valueOf(req.getParameter("bookNumber"));
			/*************************** 2.開始查詢資料 ****************************************/
			BookProductsService bpSvc = new BookProductsService();
			if ("getOne_For_Update".equals(action)) {
				BookProductsVO bpVO = bpSvc.getOnebookProductsVO(bookNumber);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("bpVO", bpVO);
				String url = "/book_products/update_bp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}else if("delete".equals(action)) {
				bpSvc.deletebookProductsVO(bookNumber);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				String url = "/book_products/listAllBookProducts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
		}

		// 修改資料
		if ("update".equals(action) || "insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			/*************************** 1.接收請求參數 ****************************************/

			String title = req.getParameter("bookTitle");
			String reg1 = "^[(\u4e00-\u9fff),(a-zA-Z0-9),[^\n]]{1,30}$";
			if (title.trim().length() == 0 || title == null) {
				errorMsgs.add("請輸入書名");
			} else if (!title.trim().matches(reg1)) {
				errorMsgs.add("請輸入正確格式");
			}

			// 之後更換成跟類別表格驗證
			Integer classNumber = null;
			try {
				classNumber = Integer.valueOf(req.getParameter("bookClassNumber"));
			} catch (NumberFormatException e) {
				errorMsgs.add("請填入正確的類別編號格式");
			}

			// 之後更換成跟出版社表格驗證
			Integer publishiingHouseCode = null;
			try {
				publishiingHouseCode = Integer.valueOf(req.getParameter("publishiingHouseCode"));
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入正確的出版社編號格式");
			}

			String isbn = req.getParameter("isbn");
			String reg2 = "^[0-9]{10,13}$";
			if (isbn.trim().length() == 0 || isbn == null) {
				errorMsgs.add("國際書碼不可空白");
			} else if (!isbn.trim().matches(reg2)) {
				errorMsgs.add("國際書碼格式錯誤");
			}

			java.sql.Date publicationDate = null;
			try {
				publicationDate = java.sql.Date.valueOf(req.getParameter("publicationDate").trim());
			} catch (IllegalArgumentException e) {
				errorMsgs.add("輸入的日期格式錯誤");
			}

			Double price = null;
			try {
				price = Double.valueOf(req.getParameter("price"));
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入正確的價格格式");
			}

			Integer stock = null;
			try {
				stock = Integer.valueOf(req.getParameter("stock"));
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入正確的數量格式");
			}

			// 之後由前端做選擇限制
			Integer productStatus = null;
			try {
				productStatus = Integer.valueOf(req.getParameter("productStatus"));
			} catch (Exception e) {
				errorMsgs.add("請輸入正確的狀態編號格式");
			}

			String introductionContent = req.getParameter("introductionContent");
			if (introductionContent.trim().length() == 0 || introductionContent == null) {
				errorMsgs.add("請輸入內容");
			}

			if ("update".equals(action)) {
				Integer bookNumber = Integer.valueOf(req.getParameter("bookNumber").trim());
				BookProductsVO bpVO = new BookProductsVO();
				bpVO.setBookNumber(bookNumber);
				bpVO.setBookTitle(title);
				bpVO.setBookClassNumber(classNumber);
				bpVO.setPublishiingHouseCode(publishiingHouseCode);
				bpVO.setIsbn(isbn);
				bpVO.setPublicationDate(publicationDate);
				bpVO.setPrice(price);
				bpVO.setStock(stock);
				bpVO.setProductStatus(productStatus);
				bpVO.setIntroductionContent(introductionContent);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bpVO", bpVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/book_products/update_bp_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 ****************************************/
				BookProductsService bpSvc = new BookProductsService();
				bpVO = bpSvc.updatebookProductsVO(bookNumber, classNumber, publishiingHouseCode, productStatus, title,
						isbn, price, publicationDate, stock, introductionContent);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("bpVO", bpVO);
				String url = "/book_products/listOneBookProducts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			if ("insert".equals(action)) {
				BookProductsVO bpVO = new BookProductsVO();
				bpVO.setBookTitle(title);
				bpVO.setBookClassNumber(classNumber);
				bpVO.setPublishiingHouseCode(publishiingHouseCode);
				bpVO.setIsbn(isbn);
				bpVO.setPublicationDate(publicationDate);
				bpVO.setPrice(price);
				bpVO.setStock(stock);
				bpVO.setProductStatus(productStatus);
				bpVO.setIntroductionContent(introductionContent);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bpVO", bpVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/book_products/add_bp.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ****************************************/
				BookProductsService bpSvc = new BookProductsService();
				bpVO = bpSvc.addbookProductsVO(classNumber, publishiingHouseCode, productStatus, title, isbn, price,
						publicationDate, stock, introductionContent);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = "/book_products/listAllBookProducts.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
		}
	}
}
