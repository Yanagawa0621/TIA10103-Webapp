<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.book_products.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  BookProductsVO bpVO = (BookProductsVO) request.getAttribute("bpVO"); //bpServlet.java(Concroller), 存入req的bpVO物件
%>

<html>
<head>
<title>書籍資料 - listOneBookProducts.jsp</title>

<style>
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
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - listOneBookProducts.jsp</h3>
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
	<tr>
		<td><%=bpVO.getBookNumber()%></td>
		<td><%=bpVO.getBookTitle()%></td>
		<td><%=bpVO.getBookClassNumber()%></td>
		<td><%=bpVO.getPublishiingHouseCode()%></td>
		<td><%=bpVO.getProductStatus()%></td>
		<td><%=bpVO.getIsbn()%></td>
		<td><%=bpVO.getPrice()%></td>
		<td><%=bpVO.getPublicationDate()%></td>
		<td><%=bpVO.getStock()%></td>
		<td><%=bpVO.getIntroductionContent()%></td>
	</tr>
</table>

</body>
</html>