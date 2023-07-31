package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;
import bean.Address;

public class AddressDBHelper {
	
	public List<Address> getAllAddresses() throws SQLException
	{
		List<Address> addresses = new ArrayList<Address>();
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select cod_adresa, judet, oras, strada, numar from adresa");
			
			while(rs.next())
			{
				addresses.add(new Address(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5)));
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
		
		return addresses;
	}
	
	public List<Address> getAllCounty() throws SQLException
	{
		List<Address> addresses = new ArrayList<Address>();
		Address address = null;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT DISTINCT judet FROM adresa");
			
			while(rs.next())
			{
				address = new Address();
				address.setCounty(rs.getString(1));
				addresses.add(address);
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
		return addresses;
	}
	
	public List<Address> getAllActivesCounties() throws SQLException
	{
		List<Address> addresses = new ArrayList<Address>();
		Address address = null;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT DISTINCT judet FROM adresa "
								 + "INNER JOIN imobiliar ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
								 + "INNER JOIN anunt ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar "
								 + "WHERE anunt.stare_anunt = 'activ' ");
			
			while(rs.next())
			{
				address = new Address();
				address.setCounty(rs.getString(1));
				addresses.add(address);
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
		return addresses;
	}
	
	public List<Address> getAllCities() throws SQLException
	{
		List<Address> addresses = new ArrayList<Address>();
		Address address = null;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT DISTINCT oras FROM adresa");
			
			while(rs.next())
			{
				address = new Address();
				address.setCity(rs.getString(1));
				addresses.add(address);
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
		return addresses;
	}
	
	public List<Address> getAllCitiesByCounty(String county) throws SQLException
	{
		List<Address> addresses = new ArrayList<Address>();
		Address address = null;
		
		Connection conn = null;		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			preparedStatement = conn.prepareStatement("SELECT DISTINCT oras FROM adresa WHERE judet = ? ");
			preparedStatement.setString(1, county);
			resultSet = preparedStatement.executeQuery();
			 
			while(resultSet.next())
			{
				address = new Address();
				address.setCity(resultSet.getString(1));
				addresses.add(address);
			}
		}
		catch(SQLException e)
		{
			throw new SQLException();
		}
		finally
		{
			new DBManager().closeResultSet(resultSet);
			new DBManager().closeStatement(preparedStatement);
			new DBManager().closeConnection(conn);
		}
		return addresses;
	}
	
	public int insertAddress(AdImmobile address) throws SQLException
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO adresa(judet, oras, strada, numar) VALUES(?, ?, ?, ?)");	
			
			stmt.setString(1, address.getCounty());
			stmt.setString(2, address.getCity());
			stmt.setString(3, address.getStreedName());
			stmt.setInt(4, address.getAddressNr());
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
