package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;

public class ImmobileDBHelper {
	
	public int getMaxUsableArea() throws SQLException
	{
		int maxUsableArea = 0;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT MAX(suprafata_utila) FROM imobiliar");
			
			while(rs.next())
			{				
				maxUsableArea = rs.getInt(1);
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
		
		return maxUsableArea;
	}
	
	public List<AdImmobile> getImmobileListByUserId(int userId) throws SQLException
	{
		List<AdImmobile> immobileList = new ArrayList<AdImmobile>();
		AdImmobile adImmobile = null;
		String query = null;		
		query = "SELECT id_imobiliar, suprafata_utila, descriere, poza, an, nr_camere, cod_adresa_FK, id_utilizator_FK, judet, oras, strada, numar "				
				+ "FROM imobiliar "
				+ "INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
				+ "WHERE id_utilizator_FK = ? ";		
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(query);	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				adImmobile = new AdImmobile();
				adImmobile.setImmobileId(rs.getInt(1)); 
				adImmobile.setUsableArea(rs.getInt(2));
				adImmobile.setDescImmobile(rs.getString(3));
				adImmobile.setYearImmobile(rs.getInt(5));
				adImmobile.setRoomsNrImmobile(rs.getInt(6));
				adImmobile.setAddressId(rs.getInt(7));
				adImmobile.setUserId(rs.getInt(8));
				adImmobile.setCounty(rs.getString(9));
				adImmobile.setCity(rs.getString(10));
				adImmobile.setStreedName(rs.getString(11));
				adImmobile.setAddressNr(rs.getInt(12));		
				immobileList.add(adImmobile);
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
		
		return immobileList;
	}
	
	public int checkIfAddressExist(AdImmobile address) throws SQLException
	{		
		int addressId = -1;
		String query = null;		
		query = "SELECT cod_adresa FROM adresa "				
				+ "WHERE judet = ? AND oras = ? "
				+ "AND strada = ? AND numar = ? ";		
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(query);	
			stmt.setString(1, address.getCounty());
			stmt.setString(2, address.getCity());
			stmt.setString(3, address.getStreedName());
			stmt.setInt(4, address.getAddressNr());
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				addressId = -1;
				addressId = rs.getInt(1);				
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
		
		return addressId;
	}
	
	public AdImmobile getImmobileById(int immobileId) throws SQLException
	{
		AdImmobile immobile = null;
		String query = null;		
		query = "SELECT id_imobiliar, suprafata_utila, descriere, an, nr_camere, cod_adresa_FK, id_utilizator_FK, judet, oras, strada, numar, poza "				
				+ "FROM imobiliar "
				+ "INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
				+ "WHERE id_imobiliar = ? ";		
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(query);	
			stmt.setInt(1, immobileId);
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				immobile = new AdImmobile();
				immobile.setImmobileId(rs.getInt(1)); 
				immobile.setUsableArea(rs.getInt(2));
				immobile.setDescImmobile(rs.getString(3));
				immobile.setYearImmobile(rs.getInt(4));
				immobile.setRoomsNrImmobile(rs.getInt(5));
				immobile.setAddressId(rs.getInt(6));
				immobile.setUserId(rs.getInt(7));
				immobile.setCounty(rs.getString(8));
				immobile.setCity(rs.getString(9));
				immobile.setStreedName(rs.getString(10));
				immobile.setAddressNr(rs.getInt(11));
				immobile.setPicture(rs.getString(12));
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
		
		return immobile;
	}
	
	public int getNextIdImmobile() throws SQLException
	{
		int nextIdImmobile = 0;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT MAX(id_imobiliar) FROM imobiliar ");
			
			while(rs.next())
			{				
				nextIdImmobile = rs.getInt(1);
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
		
		return nextIdImmobile + 1;
	}
	
	public int insertImmobile(AdImmobile immobile)
	{
		int status = 0;
		String query = "INSERT INTO imobiliar(suprafata_utila, descriere, an, nr_camere, cod_adresa_FK, id_utilizator_FK, poza) values(?, ?, ?, ?, ?, ?, ?)";
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);	
			stmt.setInt(1, immobile.getUsableArea());
			stmt.setString(2, immobile.getDescImmobile());	
			
			stmt.setInt(3, immobile.getYearImmobile());
			stmt.setInt(4, immobile.getRoomsNrImmobile());
			stmt.setInt(5, immobile.getAddressId());
			stmt.setInt(6, immobile.getUserId());
			stmt.setString(7, immobile.getPicture());
			status = stmt.executeUpdate();	
			rs = stmt.getGeneratedKeys();        
			
			while (rs.next()) {
			   immobile.setImmobileId(rs.getInt(1));
			}

			if(immobile.getCategoryName().equals("ApartamentGarsoniera"))
			{
				insertApartment(immobile);
			}
			else if(immobile.getCategoryName().equals("Casa"))
			{
				insertHouse(immobile);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		finally
		{
			new DBManager().closeStatement(stmt);
			new DBManager().closeConnection(conn);
		}
		return status;
	}
	
	public int insertApartment(AdImmobile immobile)
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO apartament_garsoniera(compartimentare, etaj, id_imobiliar_Pk, suprafata_utila_imobiliar, descriere_imobiliar, an_imobiliar, nr_camere_imobiliar, cod_adresa_FK, id_utilizator_FK, poza_imobiliar) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");	
			stmt.setString(1, immobile.getPartitioningAp());
			stmt.setInt(2, immobile.getFloorAp());
			stmt.setInt(3, immobile.getImmobileId());			
			stmt.setInt(4, immobile.getUsableArea());
			stmt.setString(5, immobile.getDescImmobile());
			stmt.setInt(6, immobile.getYearImmobile());
			stmt.setInt(7, immobile.getRoomsNrImmobile());
			stmt.setInt(8, immobile.getAddressId());
			stmt.setInt(9, immobile.getUserId());
			stmt.setString(10, immobile.getPicture());
			status = stmt.executeUpdate();				
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			new DBManager().closeStatement(stmt);
			new DBManager().closeConnection(conn);
		}
		return status;
	}
	
	public int insertHouse(AdImmobile immobile)
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO casa(nr_etaje, id_imobiliar_Pk, suprafata_utila_imobiliar, descriere_imobiliar, an_imobiliar, nr_camere_imobiliar, cod_adresa_FK, id_utilizator_FK, poza_imobiliar) values(?, ?, ?, ?, ?, ?, ?, ?, ?)");	
			stmt.setInt(1, immobile.getFloorsNrHouse());
			stmt.setInt(2, immobile.getImmobileId());			
			stmt.setInt(3, immobile.getUsableArea());
			stmt.setString(4, immobile.getDescImmobile());
			stmt.setInt(5, immobile.getYearImmobile());
			stmt.setInt(6, immobile.getRoomsNrImmobile());
			stmt.setInt(7, immobile.getAddressId());
			stmt.setInt(8, immobile.getUserId());
			stmt.setString(9, immobile.getPicture());
			status = stmt.executeUpdate();				
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			new DBManager().closeStatement(stmt);
			new DBManager().closeConnection(conn);
		}
		return status;
	}
	
	public int updateDesciptionImmobile(AdImmobile adImmobile)
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("UPDATE imobiliar SET descriere = ? WHERE id_imobiliar = ?");												
				ps.setString(1, adImmobile.getDescImmobile());
				ps.setInt(2, adImmobile.getImmobileId());
				status = ps.executeUpdate();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				System.out.println(e.getMessage());
			}
			finally
			{
				new DBManager().closeStatement(ps);
				new DBManager().closeConnection(conn);
			}			
			
			return status;
	}

}
