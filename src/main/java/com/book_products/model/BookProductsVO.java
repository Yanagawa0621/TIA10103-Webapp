package com.book_products.model;

import java.sql.Date;

public class BookProductsVO implements java.io.Serializable{
	private Integer bookNumber;
	private Integer bookClassNumber;
	private Integer publishiingHouseCode;
	private Integer productStatus;
	private String bookTitle;
	private String isbn;
	private Double price;
	private Date publicationDate;
	private Integer stock;
	private String introductionContent;
	
	public Integer getBookNumber() {
		return bookNumber;
	}
	public void setBookNumber(Integer bookNumber) {
		this.bookNumber = bookNumber;
	}
	public Integer getBookClassNumber() {
		return bookClassNumber;
	}
	public void setBookClassNumber(Integer bookClassNumber) {
		this.bookClassNumber = bookClassNumber;
	}
	public Integer getPublishiingHouseCode() {
		return publishiingHouseCode;
	}
	public void setPublishiingHouseCode(Integer publishiingHouseCode) {
		this.publishiingHouseCode = publishiingHouseCode;
	}
	public Integer getProductStatus() {
		return productStatus;
	}
	public void setProductStatus(Integer productStatus) {
		this.productStatus = productStatus;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Date getPublicationDate() {
		return publicationDate;
	}
	public void setPublicationDate(Date publicationDate) {
		this.publicationDate = publicationDate;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public String getIntroductionContent() {
		return introductionContent;
	}
	public void setIntroductionContent(String introductionContent) {
		this.introductionContent = introductionContent;
	}
	
	
}
