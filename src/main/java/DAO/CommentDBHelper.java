package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;
import bean.Comment;
import bean.UserAccount;

public class CommentDBHelper {
	
	public List<Comment> getAllComments() throws SQLException
	{
		List<Comment> comments = new ArrayList<Comment>();
		Comment comment = null;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_comentariu, text_comentariu, id_utilizator_FK, data_comentariului, nume, prenume "
								+ "FROM comentarii "
								+ "INNER JOIN utilizator ON comentarii.id_utilizator_FK = utilizator.id_utilizator");
			
			while(rs.next())
			{				
				comment = new Comment();
				comment.setCommentId(rs.getInt(1));	
				comment.setCommentText(rs.getString(2));
				comment.setUserId(rs.getInt(3));
				comment.setDateComment(rs.getDate(4));
				comment.setUserFName(rs.getString(6));
				comment.setUserLName(rs.getString(5));
				
				comments.add(comment);
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
		
		return comments;
	}
	
	public boolean isUserAbleToComment(int userId) throws SQLException
	{
		try {
			if(hasUserRented(userId)) {
				System.out.println("hasUserRented(userId): " + hasUserRented(userId));
				return true;
			}
			else if(didUserBuy(userId)) {
				System.out.println("didUserBuy(userId): " + didUserBuy(userId));
				return true;
			}
			else if(didUserGaveForRent(userId)) {
				System.out.println("didUserGaveForRent(userId): " + didUserGaveForRent(userId));
				return true;
			}
			else if(didUserGaveForSale(userId)) {
				System.out.println("didUserGaveForSale(userId): " + didUserGaveForSale(userId));
				return true;
			}
			
			return false;
		}
		catch(SQLException e) {
			throw new SQLException();
		}				
	}	
	
	public boolean hasUserRented(int userId) throws SQLException
	{
		boolean hasUserRented= false;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_utilizator FROM inchiriere WHERE id_utilizator = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				hasUserRented = true;
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
		
		return hasUserRented;
	}
	
	public boolean didUserBuy(int userId) throws SQLException
	{
		boolean didUserBuy= false;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_utilizator FROM vanzare WHERE id_utilizator = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				didUserBuy = true;
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
		
		return didUserBuy;
	}
	
	public boolean didUserGaveForRent(int userId) throws SQLException
	{
		boolean didUserGaveForRent= false;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_utilizator_FK FROM anunt WHERE id_anunt IN (SELECT anunt.id_anunt FROM anunt INNER JOIN inchiriere ON anunt.id_anunt = inchiriere.id_anunt) "
										+ "AND id_utilizator_FK = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				didUserGaveForRent = true;
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
		
		return didUserGaveForRent;
	}
	
	public boolean didUserGaveForSale(int userId) throws SQLException
	{
		boolean didUserGaveForSale= false;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_utilizator_FK FROM anunt WHERE id_anunt IN "
										+ "(SELECT anunt.id_anunt FROM anunt INNER JOIN vanzare ON anunt.id_anunt = vanzare.id_anunt)  AND id_utilizator_FK = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				didUserGaveForSale = true;
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
		
		return didUserGaveForSale;
	}
	
	public int insertComment(Comment comment) throws SQLException
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO comentarii(text_comentariu, id_utilizator_FK, data_comentariului) values( ?, ?, sysdate() )");	
			stmt.setString(1, comment.getCommentText());			
			stmt.setInt(2, comment.getUserId());		
			status = stmt.executeUpdate();				
			
		}
		catch(SQLException e)
		{
			throw new SQLException();
		}
		finally
		{
			new DBManager().closeStatement(stmt);
			new DBManager().closeConnection(conn);
		}
		return status;
	}

}
