package DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Category;

public class CategoryDBHelper {
	
	public List<Category> getAllCategories() throws SQLException
	{
		List<Category> categories = new ArrayList<Category>();
		Category category = null;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT DISTINCT tip_imobiliar FROM categorie");
			
			while(rs.next())
			{
				category = new Category();
				category.setCategoryType(rs.getString(1));
				categories.add(category);
			}
		}
		catch(SQLException e)
		{
			throw new SQLException();
		}
		finally
		{
			new DBManager().closeResultSet(rs);
			new DBManager().closeStatement(stmt);
			new DBManager().closeConnection(conn);
		}
		return categories;
	}

}
