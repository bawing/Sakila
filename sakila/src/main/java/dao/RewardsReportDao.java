package dao;

import java.sql.*;
import java.util.*;
import vo.*;
import util.DBUtil;


public class RewardsReportDao {
	public Map<String, Object> rewardsReportCall(int minMonthlyPurchases,double minDollarAmountPurchased) {
		Map<String, Object> map = new HashMap<String, Object>();
		Connection conn = null;
		// PreparedStatement : 쿼리를 실행
		// CallableStatement : 프로시저를 실행 
		CallableStatement stmt = null;
		ResultSet rs = null;
		// select customer_id .... 
		List<Customer> list = new ArrayList<>();
		// select count(customer_id) ....
		Integer count = 0;
		conn = DBUtil.getConnection();
		try {
			stmt = conn.prepareCall("{call rewards_report(?, ?, ?)}");
			stmt.setInt(1, minMonthlyPurchases);
			stmt.setDouble(2, minDollarAmountPurchased);
			stmt.registerOutParameter(3, Types.INTEGER);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Customer c = new Customer();
				c.setCustomerId(rs.getInt(1));
				c.setStoreId(rs.getInt(2));
				c.setFirstName(rs.getString(3));
				c.setLastName(rs.getString(4));
				c.setEmail(rs.getString(5));
				c.setAddressId(rs.getInt(6));
				c.setActive(rs.getInt(7));
				c.setCreateDate(rs.getString(8));
				c.setLastUpdate(rs.getString(9));
				list.add(c);	// cutomer 목록넣기
			}
			count = stmt.getInt(3); // 프로시저 3번째 out변수 값
		} catch (SQLException e) {
			e.printStackTrace();
		}
		map.put("customer", list);
		map.put("count", count);
		return map;
	}
	// test
	public static void main(String[] args) {
		RewardsReportDao rR = new RewardsReportDao();
		int minMonthlyPurchases = 5;
		double minDollarAmountPurchased = 10.0;
		Map<String, Object> map = rR.rewardsReportCall(minMonthlyPurchases, minDollarAmountPurchased);
		List<Integer> list = (List<Integer>)map.get("list");
		int count = (Integer)map.get("count");
		System.out.println(minMonthlyPurchases + "번 사신 손님들의 "+ minDollarAmountPurchased +"금액보다 산게"+count+"번 정도 있음");
	}
}
