package com.book_products.model;

import java.util.List;

public interface BookProductsDAO_interface {
	public void insert(BookProductsVO bookProductsVO);
	public void update(BookProductsVO bookProductsVO);
	public void delete(Integer bookNumber);
	public BookProductsVO findByPrimaryKey(Integer bookNumber);
	public List<BookProductsVO> getAll();
}
