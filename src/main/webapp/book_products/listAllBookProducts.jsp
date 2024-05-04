<%@page import="com.book_products.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    BookProductsService bpSvc= new BookProductsService();
    List<BookProductsVO> list = bpSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有書籍資料 - listAllBookProducts.jsp</title>

<style>
	*{
		box-sizing: border-box;
	}
	table#table-1 {
		background-color: #CCCCFF;
		border: 2px solid black;
		text-align: center;
	}
	table#table-1 h4 {
		color: red;
		display: block;
		margin-bottom: 1px;
	}
	h4 {
		color: blue;
		display: inline;
	}
</style>

<style>
	table {
		width: 100%;
		background-color: white;
		margin-top: 5px;
		margin-bottom: 5px;
		overflow-x: hidden;
	}
	table, th, td {
		border: 1px solid #CCCCFF;
	}
	th, td {
		padding: 5px;
		text-align: center;
	}
	td{
		height: 100px;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	div.text{
		width: 100%;
/* 		border: 1px solid black; */
		display: -webkit-box; 
		-webkit-box-orient: vertical; 
		-webkit-line-clamp: 3; 
		overflow: hidden; 
		/*   text-overflow: ellipsis;  */
	}
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		<h3>所有書籍資料 - listAllBookProducts.jsp</h3>
		<h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>書籍編號</th>
		<th>書籍名稱</th>
		<th>書籍類別編號</th>
		<th>出版社編碼</th>
		<th>商品狀態</th>
		<th>ISBN</th>
		<th>價格</th>
		<th>出版日期</th>
		<th>庫存量</th>
		<th>介紹內容</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="bpVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td width=30px >${bpVO.getBookNumber()}</td>
			<td width=100px>${bpVO.getBookTitle()}</td>
			<td width=30px>${bpVO.getBookClassNumber()}</td>
			<td width=30px>${bpVO.getPublishiingHouseCode()}</td>
			<td width=30px>${bpVO.getProductStatus()}</td>
			<td width=100px>${bpVO.getIsbn()}</td>
			<td width=50px>${bpVO.getPrice()}</td>
			<td width=100px>${bpVO.getPublicationDate()}</td>
			<td width=50px>${bpVO.getStock()}</td>
			<td ><div class="text">${bpVO.getIntroductionContent()}</div></td>
			<td>
			  <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/book_products/book_products.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="bookNumber"  value="${bpVO.bookNumber}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/book_products/book_products.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="bookNumber"  value="${bpVO.bookNumber}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>