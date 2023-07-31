package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;
import bean.UserAccount;

public class AccountDBHelper {
	
	public UserAccount getUserByEmailPassword(String email, String password) throws SQLException
	{
		UserAccount account = null;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT email, parola, tip_cont, stare_cont, id_utilizator, nume, prenume, sex, CNP, nr_telefon "
										+ "FROM cont "
										+ "INNER JOIN utilizator ON cont.id_utilizator_FK = utilizator.id_utilizator "
										+ "WHERE email = ? AND parola = ? ");	
			stmt.setString(1, email);
			stmt.setString(2, password);
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				account = new UserAccount();
				account.setEmail(rs.getString(1));
				account.setPassword(rs.getString(2));
				account.setUserType(rs.getString(3));
				account.setAccountStatus(rs.getString(4));
				account.setUserId(rs.getInt(5));
				account.setUserLName(rs.getString(6));
				account.setUserFName(rs.getString(7));
				account.setUserSex(rs.getString(8).charAt(0));
				account.setUserCNP(rs.getString(9));
				account.setUserPhoneNr(rs.getString(10));
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
		
		return account;
	}
	
	public boolean checkIfEmailExist(String email) throws SQLException
	{
		boolean checkIfEmailExist = false;
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT email FROM cont "
										+ "WHERE email = ? ");	
			stmt.setString(1, email);
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				checkIfEmailExist = true;
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
		
		return checkIfEmailExist;
	}
	
	public List<UserAccount> getRealtors() throws SQLException
	{
		List<UserAccount> realtors = new ArrayList<UserAccount>();
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT email, parola, tip_cont, stare_cont, id_utilizator, nume, prenume, sex, cnp, nr_telefon "
								+ "FROM cont "
								+ "INNER JOIN utilizator ON cont.id_utilizator_fk = utilizator.id_utilizator "
								+ "WHERE stare_cont = 'activ' AND tip_cont = 'agent' ");
			
			while(rs.next())
			{				
				UserAccount realtor = new UserAccount();
				realtor.setEmail(rs.getString(1));
				realtor.setPassword(rs.getString(2));;
				realtor.setUserType(rs.getString(3));
				realtor.setAccountStatus(rs.getString(4));
				realtor.setUserId(rs.getInt(5));
				realtor.setUserLName(rs.getString(6));
				realtor.setUserFName(rs.getString(7));
				realtor.setUserSex(rs.getString(8).charAt(0));
				realtor.setUserCNP(rs.getString(9));
				realtor.setUserPhoneNr(rs.getString(10));

				realtors.add(realtor);
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
		
		return realtors;
	}
	
	public int updateUserPhoneNr(int userId, String phoneNr) throws SQLException
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("UPDATE utilizator SET nr_telefon = ? WHERE id_utilizator = ? ");												
				ps.setString(1, phoneNr);
				ps.setInt(2, userId);
				status = ps.executeUpdate();
			}
			catch(SQLException e)
			{
				throw new SQLException();
			}
			finally
			{
				new DBManager().closeStatement(ps);
				new DBManager().closeConnection(conn);
			}			
			
			return status;
	}
	
	public int updateUserPassword(int userId, String password) throws SQLException
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("UPDATE cont SET parola = ? WHERE id_utilizator_FK = ? ");												
				ps.setString(1, password);
				ps.setInt(2, userId);
				status = ps.executeUpdate();
			}
			catch(SQLException e)
			{
				throw new SQLException();
			}
			finally
			{
				new DBManager().closeStatement(ps);
				new DBManager().closeConnection(conn);
			}			
			
			return status;
	}
		
	public int insertUser(UserAccount userAccount) throws SQLException
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			System.out.println(userAccount.getUserFName());
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("INSERT INTO utilizator(nume, prenume, sex, cnp, nr_telefon, tip_utilizator) VALUES(?, ?, ?, ?, ?, ?) ", Statement.RETURN_GENERATED_KEYS);												
				ps.setString(1, userAccount.getUserFName());
				ps.setString(2, userAccount.getUserLName());
				ps.setString(3, String.valueOf(userAccount.getUserSex()));
				ps.setString(4, userAccount.getUserCNP());
				ps.setString(5, userAccount.getUserPhoneNr());
				ps.setString(6, userAccount.getUserType());
				status = ps.executeUpdate();
				rs = ps.getGeneratedKeys();
				
				while (rs.next()) {
				   userAccount.setUserId(rs.getInt(1));
				}
				System.out.println(userAccount.getUserId());
				insertAccount(userAccount);
			}
			catch(SQLException e)
			{
				throw new SQLException();
			}
			finally
			{
				new DBManager().closeStatement(ps);
				new DBManager().closeConnection(conn);
			}			
			
			return status;
	}
	
	public int insertAccount(UserAccount userAccount) throws SQLException
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("INSERT INTO cont(email, parola, tip_cont, stare_cont, id_utilizator_fk) VALUES(?, ?, ?, ?, ?) ");												
				ps.setString(1, userAccount.getEmail());
				ps.setString(2, userAccount.getPassword());
				ps.setString(3, userAccount.getUserType());
				ps.setString(4, userAccount.getAccountStatus());
				ps.setInt(5, userAccount.getUserId());
				status = ps.executeUpdate();
			}
			catch(SQLException e)
			{
				throw new SQLException();
			}
			finally
			{
				new DBManager().closeStatement(ps);
				new DBManager().closeConnection(conn);
			}			
			
			return status;
	}

}
