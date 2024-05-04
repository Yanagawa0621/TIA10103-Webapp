<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM BookProducts: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM BookProducts: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM BookProducts: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllBookProducts.jsp'>List</a> all BookProducts.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/book_products/book_products.do" >
        <b>輸入書籍編號 (例如:1):</b>
        <input type="text" name="bookNumber">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="bpSvc" scope="page" class="com.book_products.model.BookProductsService" />
   
  <li>
     <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/book_products/book_products.do" >
       <b>選擇書籍編號:</b>
       <select size="1" name="bookNumber">
         <c:forEach var="bpVO" items="${bpSvc.all}" > 
          <option value="${bpVO.bookNumber}">${bpVO.bookNumber}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/book_products/book_products.do" >
       <b>選擇書籍名稱:</b>
       <select size="1" name="bookNumber">
         <c:forEach var="bpVO" items="${bpSvc.all}" > 
          <option value="${bpVO.bookNumber}">${bpVO.bookTitle}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>書籍管理</h3>

<ul>
  <li><a href='add_bp.jsp'>Add</a> a new BookProducts.</li>
</ul>

</body>
</html>