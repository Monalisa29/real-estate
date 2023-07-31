package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;

public class FavoriteAdsDBHelper {
	
	public boolean hasAddedToFavorites(int userId, int adId) throws SQLException
	{
		boolean hasAddedToFavorites= false;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_utilizator, id_anunt FROM salveaza_favorite WHERE id_utilizator = ? AND id_anunt = ? ");	
			stmt.setInt(1, userId);
			stmt.setInt(2, adId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				hasAddedToFavorites = true;
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
		
		return hasAddedToFavorites;
	}
	
	public int nrUserWhoAddFavorite(int adId) throws SQLException
	{
		int personNr = 0;		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT COUNT(ID_UTILIZATOR) FROM salveaza_favorite WHERE id_anunt = ? ");	
			stmt.setInt(1, adId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				personNr = rs.getInt(1);
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
		
		return personNr;
	}
	
	public List<AdImmobile> getFavoriteAdsByUser(int userId) throws SQLException
	{
		List<AdImmobile> ads = new ArrayList<AdImmobile>();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT salveaza_favorite.id_utilizator, salveaza_favorite.id_anunt, data_postare_anunt, stare_anunt, titlu, pret, id_imobiliar, "
										+ "suprafata_utila, descriere, an, nr_camere, cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, "
										+ "tip_imobiliar, imobiliar.poza "
										+ "FROM salveaza_favorite "
										+ "INNER JOIN anunt ON salveaza_favorite.id_anunt = anunt.id_anunt "
										+ "INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar "
										+ "INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie "
										+ "WHERE id_utilizator = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				AdImmobile adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(2));
				adImmobile.setAdPostDate(rs.getDate(3));
				adImmobile.setAdStatus(rs.getString(4));
				adImmobile.setUsableArea(rs.getInt(8));
				adImmobile.setDescImmobile(rs.getString(9));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(10));
				adImmobile.setRoomsNrImmobile(rs.getInt(11));
				adImmobile.setImmobileId(rs.getInt(7));
				adImmobile.setUserId(rs.getInt(1));
				adImmobile.setAddressId(rs.getInt(12));
				adImmobile.setRealtorId(rs.getInt(13));
				adImmobile.setCategoryId(rs.getInt(14));
				adImmobile.setCategoryName(rs.getString(15));
				adImmobile.setImmobileType(rs.getString(16));
				adImmobile.setAdTitle(rs.getString(5));
				adImmobile.setPicture(rs.getString(17));
				
				ads.add(adImmobile);
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
		
		return ads;
	}
	
	public int insertAdToFavorites(int userId, int adId) throws SQLException
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO salveaza_favorite(id_utilizator, id_anunt) values(?, ?)");	
			stmt.setInt(1, userId);
			stmt.setInt(2, adId);						
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
	
	public int deleteAdFromFavorites(int userId, int adId) throws SQLException
	{
		System.out.println(adId+"=adid");
		System.out.println(userId+"-userid");
		int status = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		
		try
		{
			conn = new DBManager().getConnection();
			ps = conn.prepareStatement("DELETE FROM salveaza_favorite WHERE id_utilizator = ? AND id_anunt = ? ");															
			ps.setInt(1, userId);
			ps.setInt(2, adId);
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
