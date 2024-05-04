package com.book_products.model;

import java.util.List;

public class BookProductsService {
	private BookProductsDAO_interface dao;

	public BookProductsService() {
		dao=new BookProductsJDBCDAO();
	}
	
	public BookProductsVO addbookProductsVO(Integer bookClassNumber,Integer publishiingHouseCode,Integer productStatus,String bookTitle,String isbn,Double price,java.sql.Date publicationDate,Integer stock,String introductionContent) {
		BookProductsVO bookProductsVO=new BookProductsVO();
		bookProductsVO.setBookClassNumber(bookClassNumber);
		bookProductsVO.setPublishiingHouseCode(publishiingHouseCode);
		bookProductsVO.setProductStatus(productStatus);
		bookProductsVO.setBookTitle(bookTitle);
		bookProductsVO.setIsbn(isbn);
		bookProductsVO.setPrice(price);
		bookProductsVO.setPublicationDate(publicationDate);
		bookProductsVO.setStock(stock);
		bookProductsVO.setIntroductionContent(introductionContent);
		dao.insert(bookProductsVO);
		
		return bookProductsVO;
	}
	
	public BookProductsVO updatebookProductsVO(Integer bookNumber,Integer bookClassNumber,Integer publishiingHouseCode,Integer productStatus,String bookTitle,String isbn,Double price,java.sql.Date publicationDate,Integer stock,String introductionContent) {
		BookProductsVO bookProductsVO=new BookProductsVO();
		bookProductsVO.setBookNumber(bookNumber);
		bookProductsVO.setBookClassNumber(bookClassNumber);
		bookProductsVO.setPublishiingHouseCode(publishiingHouseCode);
		bookProductsVO.setProductStatus(productStatus);
		bookProductsVO.setBookTitle(bookTitle);
		bookProductsVO.setIsbn(isbn);
		bookProductsVO.setPrice(price);
		bookProductsVO.setPublicationDate(publicationDate);
		bookProductsVO.setStock(stock);
		bookProductsVO.setIntroductionContent(introductionContent);
		dao.update(bookProductsVO);
		
		return bookProductsVO;
	}
	
	public void deletebookProductsVO(Integer bookNumber) {
		dao.delete(bookNumber);
	}
	
	public BookProductsVO getOnebookProductsVO(Integer bookNumber) {
		return dao.findByPrimaryKey(bookNumber);
	}
	
	public List<BookProductsVO> getAll(){
		return dao.getAll();
	}
}
