package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager {
	
	public Connection getConnection() {
		Connection conn = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String url = "jdbc:mysql://localhost:3306/agentie_imobiliara_l?characterEncoding=latin1&useConfigs=maxPerformance";
			String user = "root";
			String password = "root";
			
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		return conn;
	}

	public void closeConnection(Connection conn) {
		try {
			if(conn != null)
			{
				conn.close();				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeResultSet(ResultSet rs) {
		try {
			if(rs != null)
			{
				rs.close();				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void closeStatement(Statement stmt) {
		try {
			if(stmt != null)
			{
				stmt.close();				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


}
