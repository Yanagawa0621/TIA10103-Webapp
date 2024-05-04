package com.book_products.model;

import java.util.*;
import java.sql.*;



public class BookProductsJDBCDAO implements BookProductsDAO_interface{
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/G3?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO book_products (bookClassNumber,publishiingHouseCode,productStatus,bookTitle,isbn,price,publicationDate,stock,introductionContent) "
			+ "VALUES (?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM book_products order by bookNumber";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM book_products where bookNumber=?";
	private static final String DELETE = 
			"DELETE FROM book_products where bookNumber=?";
	private static final String UPDATE =
			"UPDATE book_products set bookClassNumber=?,publishiingHouseCode=?,productStatus=?,bookTitle=?,isbn=?,price=?,publicationDate=?,stock=?,introductionContent=? where bookNumber=?";
	
	//新增
	public void insert(BookProductsVO bookProductsVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, bookProductsVO.getBookClassNumber());
			pstmt.setInt(2, bookProductsVO.getPublishiingHouseCode());
			pstmt.setInt(3, bookProductsVO.getProductStatus());
			pstmt.setString(4, bookProductsVO.getBookTitle());
			pstmt.setString(5,bookProductsVO.getIsbn());
			pstmt.setDouble(6, bookProductsVO.getPrice());
			pstmt.setDate(7, bookProductsVO.getPublicationDate());
			pstmt.setInt(8, bookProductsVO.getStock());
			pstmt.setString(9, bookProductsVO.getIntroductionContent());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "+ se.getMessage());
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	//修改
	public void update(BookProductsVO bookProductsVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, bookProductsVO.getBookClassNumber());
			pstmt.setInt(2, bookProductsVO.getPublishiingHouseCode());
			pstmt.setInt(3, bookProductsVO.getProductStatus());
			pstmt.setString(4, bookProductsVO.getBookTitle());
			pstmt.setString(5,bookProductsVO.getIsbn());
			pstmt.setDouble(6, bookProductsVO.getPrice());
			pstmt.setDate(7, bookProductsVO.getPublicationDate());
			pstmt.setInt(8, bookProductsVO.getStock());
			pstmt.setString(9, bookProductsVO.getIntroductionContent());
			pstmt.setInt(10,bookProductsVO.getBookNumber());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "+ se.getMessage());
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	//刪除
	public void delete(Integer bookNumber) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt=con.prepareStatement(DELETE);
			
			pstmt.setInt(1, bookNumber);
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "+ se.getMessage());
		}
	}
	
	
	//主鍵查詢(書籍編號 bookNumber)
	public BookProductsVO findByPrimaryKey(Integer bookNumber) {
		BookProductsVO bookProductsVO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url, userid, passwd);
			pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, bookNumber);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				bookProductsVO=new BookProductsVO();
				
				bookProductsVO.setBookNumber(rs.getInt("bookNumber"));
				bookProductsVO.setBookClassNumber(rs.getInt("bookClassNumber"));
				bookProductsVO.setPublishiingHouseCode(rs.getInt("publishiingHouseCode"));
				bookProductsVO.setProductStatus(rs.getInt("productStatus"));
				bookProductsVO.setBookTitle(rs.getString("bookTitle"));
				bookProductsVO.setIsbn(rs.getString("isbn"));
				bookProductsVO.setPrice(rs.getDouble("price"));
				bookProductsVO.setPublicationDate(rs.getDate("publicationDate"));
				bookProductsVO.setStock(rs.getInt("stock"));
				bookProductsVO.setIntroductionContent(rs.getString("introductionContent"));
				
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return bookProductsVO;
	}
	
	//表格全部資料
	public List<BookProductsVO> getAll(){
		List<BookProductsVO> list=new ArrayList<BookProductsVO>();
		
		BookProductsVO bookProductsVO=null;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			Class.forName(driver);
			con=DriverManager.getConnection(url, userid, passwd);
			pstmt=con.prepareStatement(GET_ALL_STMT);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				bookProductsVO=new BookProductsVO();
				
				bookProductsVO.setBookNumber(rs.getInt("bookNumber"));
				bookProductsVO.setBookClassNumber(rs.getInt("bookClassNumber"));
				bookProductsVO.setPublishiingHouseCode(rs.getInt("publishiingHouseCode"));
				bookProductsVO.setProductStatus(rs.getInt("productStatus"));
				bookProductsVO.setBookTitle(rs.getString("bookTitle"));
				bookProductsVO.setIsbn(rs.getString("isbn"));
				bookProductsVO.setPrice(rs.getDouble("price"));
				bookProductsVO.setPublicationDate(rs.getDate("publicationDate"));
				bookProductsVO.setStock(rs.getInt("stock"));
				bookProductsVO.setIntroductionContent(rs.getString("introductionContent"));
				list.add(bookProductsVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
//	public static void main(String[] args) {
//		BookProductsJDBCDAO dao=new BookProductsJDBCDAO();
////		
////		// 新增
////		BookProductsVO bookProductsVO1=new BookProductsVO();
////		bookProductsVO1.setBookClassNumber(1);
////		bookProductsVO1.setPublishiingHouseCode(1);
////		bookProductsVO1.setProductStatus(1);
////		bookProductsVO1.setBookTitle("dsjf");
////		bookProductsVO1.setIsbn("87483749143");
////		bookProductsVO1.setPrice(500.00);
////		bookProductsVO1.setPublicationDate(java.sql.Date.valueOf("1999-01-10"));
////		bookProductsVO1.setStock(15);
////		bookProductsVO1.setIntroductionContent("臺灣首部巡山員小說，第一手田野調查寫成，\r\n"
////				+ "　　親身走入山林，揭露巡山員不為人知的護國任務\r\n"
////				+ "\r\n"
////				+ "　　菜鳥巡山員報到！除了日常勤務超吃重，還有難解的愛情與親情課題連番上場……\r\n"
////				+ "\r\n"
////				+ "　　她不顧一切當上巡山員，\r\n"
////				+ "　　一個人要管理五十個大安森林公園的山林面積，挑戰接二連三；\r\n"
////				+ "　　即使吃盡苦頭，她卻始終想知道，\r\n"
////				+ "　　那些當年父親來不及告訴她的事……\r\n"
////				+ "\r\n"
////				+ "　　大學畢業生葉綠儀放棄與醫師男友的感情，不管母親的強烈反對，正式成為林務局水里工作站的一分子。既是菜鳥又是女生，老是遭受組員的言語諷刺，她卻一心想證明自己也能成為優秀的巡山員。\r\n"
////				+ "\r\n"
////				+ "　　深山中被竊的七里香、考驗心智的深山特遣、喝下水鹿洗澡坑裡的水、埋伏抓山老鼠……，挑戰接連而來，總是組員楊向陽有力的臂膀支撐著她；一段正在萌芽的感情卻因一場大學生登山意外陷入危機，父親當年因公殉職的實情也漸漸浮現；緊接而來一場森林大火，鋪天蓋地要將她吞噬，身邊最親近的人卻在烈焰竄天中不見蹤影……\r\n"
////				+ "\r\n"
////				+ "　　在山林面前，山神沒有留時間給人們猶豫，巡山員只能勇敢踏入森林山野的深處，領會「山神」的存在與意義。");
////		dao.insert(bookProductsVO1);
//		
//		//修改
////		BookProductsVO bookProductsVO2=new BookProductsVO();
////		bookProductsVO2.setBookNumber(6);
////		bookProductsVO2.setBookClassNumber(2);
////		bookProductsVO2.setPublishiingHouseCode(3);
////		bookProductsVO2.setProductStatus(0);
////		bookProductsVO2.setBookTitle("oorr");
////		bookProductsVO2.setIsbn("3857493105");
////		bookProductsVO2.setPrice(300.00);
////		bookProductsVO2.setPublicationDate(java.sql.Date.valueOf("1980-09-12"));
////		bookProductsVO2.setStock(4);
////		bookProductsVO2.setIntroductionContent("joiwqejqlemdlwe");
////		dao.update(bookProductsVO2);
//		
//		//刪除
////		dao.delete(6);
//		
//		//查詢
//		List<BookProductsVO> list=dao.getAll();
//		for(BookProductsVO bp:list) {
//			System.out.println(bp.getBookNumber()+",");
//			System.out.println(bp.getBookClassNumber()+",");
//			System.out.println(bp.getPublishiingHouseCode()+",");
//			System.out.println(bp.getProductStatus()+",");
//			System.out.println(bp.getBookTitle()+",");
//			System.out.println(bp.getIsbn()+",");
//			System.out.println(bp.getPrice()+",");
//			System.out.println(bp.getPublicationDate()+",");
//			System.out.println(bp.getStock()+",");
//			System.out.println(bp.getIntroductionContent());
//			System.out.println();
//		}
//	}
}
