package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.AdImmobile;

public class AdDBHelper {
	
	public List<AdImmobile> getActiveAds() throws SQLException
	{
		List<AdImmobile> ads = new ArrayList<AdImmobile>();
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, " +
									"imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, " +
									"tip_imobiliar, titlu, poza FROM anunt INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar " +
									"INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie WHERE stare_anunt = 'activ' ");
			
			while(rs.next())
			{				
				AdImmobile adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(1));
				adImmobile.setAdPostDate(rs.getDate(2));
				adImmobile.setAdStatus(rs.getString(3));
				adImmobile.setUsableArea(rs.getInt(4));
				adImmobile.setDescImmobile(rs.getString(5));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(7));
				adImmobile.setRoomsNrImmobile(rs.getInt(8));
				adImmobile.setImmobileId(rs.getInt(9));
				adImmobile.setUserId(rs.getInt(10));
				adImmobile.setAddressId(rs.getInt(11));
				adImmobile.setRealtorId(rs.getInt(12));
				adImmobile.setCategoryId(rs.getInt(13));
				adImmobile.setCategoryName(rs.getString(14));
				adImmobile.setImmobileType(rs.getString(15));
				adImmobile.setAdTitle(rs.getString(16));
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
	
	public List<AdImmobile> getAdsByFilters(String county, String city, String category, String type, int roomsNr, String partitioning, int minBuildYear, int maxBuildYear, int minUsableArea, int maxUsableArea, int minPrice, int maxPrice) throws SQLException
	{
		List<AdImmobile> ads = new ArrayList<AdImmobile>();
		StringBuilder query = new StringBuilder();
		query.append("SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, " +
						"imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, " +
						"tip_imobiliar, titlu, poza FROM anunt INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar " +
						"INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie " +
						"INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa ");
		
		if(partitioning != null){
			query.append("INNER JOIN apartament_garsoniera ON imobiliar.id_imobiliar = apartament_garsoniera.id_imobiliar_pk ");
		}
		
		query.append("WHERE stare_anunt = 'activ' ");
		
		if(county != null) {
			query.append("AND judet = ? ");
		}
		if(city != null) {
			query.append("AND oras = ? ");
		}
		if(category != null) {
			query.append("AND denumire_categorie = ? ");
		}
		if(type != null) {
			query.append("AND tip_imobiliar = ? ");
		}
		if(roomsNr != 0) {
			if(roomsNr != 4)
			{
				query.append("AND nr_camere = ? ");
			}
			else
			{
				query.append("AND nr_camere >= ? ");
			}
			
		}
		if(partitioning != null) {
			query.append("AND compartimentare = ? ");
		}
		if(minBuildYear != 0 && maxBuildYear != 0) {
			if(minBuildYear == 2000 && maxBuildYear == 2000) {
				query.append("AND an >= ? ");
			}
			if(minBuildYear == 1977 && maxBuildYear == 1977) {
				query.append("AND an <= ? ");
			}			
			else{
				query.append("AND an BETWEEN ? and ? ");
			}
		}
		if(minUsableArea != 0) {
			query.append("AND suprafata_utila >= ? ");
		}
		if(maxUsableArea != 0) {
			query.append("AND suprafata_utila <= ? ");
		}
		if(minPrice != 0) {
			query.append("AND pret >= ? ");
		}
		if(maxPrice != 0) {
			query.append("AND pret <= ? ");
		}
		String sqlString = query.toString();
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(sqlString);
			
			int index = 1;
			if(county != null) {
				stmt.setString(index, county);
				index++;
			}
			if(city != null) {
				stmt.setString(index, city);
				index++;
			}
			if(category != null) {
				stmt.setString(index, category);
				index++;
			}
			if(type != null) {
				stmt.setString(index, type);
				index++;
			}
			if(roomsNr != 0) {
				stmt.setInt(index, roomsNr);	
				index++;
			}
			if(partitioning != null) {
				stmt.setString(index, partitioning);
				index++;
			}
			if(minBuildYear != 0 && maxBuildYear != 0) {
				if(minBuildYear == 2000 && maxBuildYear == 2000) {
					stmt.setInt(index, minBuildYear);
					index++;
				}
				if(minBuildYear == 1977 && maxBuildYear == 1977) {
					stmt.setInt(index, minBuildYear);
					index++;
				}			
				else{
					stmt.setInt(index, minBuildYear);
					index++;
				    stmt.setInt(index, maxBuildYear);
				    index++;
				}			
			}
			if(minUsableArea != 0) {
				stmt.setInt(index, minUsableArea);		
				index++;
			}
			if(maxUsableArea != 0) {
				stmt.setInt(index, maxUsableArea);
				index++;
			}
			if(minPrice != 0) {
				stmt.setInt(index, minPrice);
				index++;
			}
			if(maxPrice != 0) {
			    stmt.setInt(index, maxPrice);
			    index++;
			}					   
		    
			rs = stmt.executeQuery();
			while(rs.next())
			{				
				AdImmobile adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(1));
				adImmobile.setAdPostDate(rs.getDate(2));
				adImmobile.setAdStatus(rs.getString(3));
				adImmobile.setUsableArea(rs.getInt(4));
				adImmobile.setDescImmobile(rs.getString(5));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(7));
				adImmobile.setRoomsNrImmobile(rs.getInt(8));
				adImmobile.setImmobileId(rs.getInt(9));
				adImmobile.setUserId(rs.getInt(10));
				adImmobile.setAddressId(rs.getInt(11));
				adImmobile.setRealtorId(rs.getInt(12));
				adImmobile.setCategoryId(rs.getInt(13));
				adImmobile.setCategoryName(rs.getString(14));
				adImmobile.setImmobileType(rs.getString(15));
				adImmobile.setAdTitle(rs.getString(16));
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
	
	public List<AdImmobile> getLastActiveAds() throws SQLException
	{
		List<AdImmobile> ads = new ArrayList<AdImmobile>();
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, " +
									"imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, " +
									"tip_imobiliar, titlu, poza FROM anunt INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar " +
									"INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie WHERE stare_anunt = 'activ' order by data_postare_anunt desc LIMIT 9 ");
			
			while(rs.next())
			{				
				AdImmobile adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(1));
				adImmobile.setAdPostDate(rs.getDate(2));
				adImmobile.setAdStatus(rs.getString(3));
				adImmobile.setUsableArea(rs.getInt(4));
				adImmobile.setDescImmobile(rs.getString(5));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(7));
				adImmobile.setRoomsNrImmobile(rs.getInt(8));
				adImmobile.setImmobileId(rs.getInt(9));
				adImmobile.setUserId(rs.getInt(10));
				adImmobile.setAddressId(rs.getInt(11));
				adImmobile.setRealtorId(rs.getInt(12));
				adImmobile.setCategoryId(rs.getInt(13));
				adImmobile.setCategoryName(rs.getString(14));
				adImmobile.setImmobileType(rs.getString(15));
				adImmobile.setAdTitle(rs.getString(16));
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
	
	public int getMaxPrice() throws SQLException
	{
		int maxPrice = 0;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT MAX(pret) FROM anunt");
			
			while(rs.next())
			{				
				maxPrice = rs.getInt(1);
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
		
		return maxPrice;
	}
	
	public AdImmobile getAdImmobileById(int id, int categoryId) throws SQLException
	{
		AdImmobile adImmobile = null;
		String query = null;
		if(categoryId == 1 || categoryId == 2) {
			query = "SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, "
					+ "imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, "
					+ "tip_imobiliar, titlu, judet, oras, strada, numar, nume, prenume, poza, compartimentare, etaj "
					+ "FROM anunt "
					+ "INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar "
					+ "INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie "
					+ "INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
					+ "INNER JOIN utilizator ON anunt.id_utilizator_FK = utilizator.id_utilizator "
					+ "INNER JOIN apartament_garsoniera ON anunt.id_imobiliar_FK = apartament_garsoniera.id_imobiliar_pk "
					+ "WHERE id_anunt = ? ";
		}
		else if(categoryId == 3 || categoryId == 4) {
			query = "SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, "
					+ "imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, "
					+ "tip_imobiliar, titlu, judet, oras, strada, numar, nume, prenume, poza, nr_etaje "
					+ "FROM anunt "
					+ "INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar "
					+ "INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie "
					+ "INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
					+ "INNER JOIN utilizator ON anunt.id_utilizator_FK = utilizator.id_utilizator "
					+ "INNER JOIN casa ON anunt.id_imobiliar_FK = casa.id_imobiliar_pk "
					+ "WHERE id_anunt = ? ";
		}
		else {
			query = "SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, "
					+ "imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, "
					+ "tip_imobiliar, titlu, judet, oras, strada, numar, nume, prenume, poza "
					+ "FROM anunt "
					+ "INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar "
					+ "INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie "
					+ "INNER JOIN adresa ON imobiliar.cod_adresa_FK = adresa.cod_adresa "
					+ "INNER JOIN utilizator ON anunt.id_utilizator_FK = utilizator.id_utilizator "
					+ "WHERE id_anunt = ? ";
		}
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement(query);	
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			
			while(rs.next())
			{				
				adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(1));
				adImmobile.setAdPostDate(rs.getDate(2));
				adImmobile.setAdStatus(rs.getString(3)); 
				adImmobile.setUsableArea(rs.getInt(4));
				adImmobile.setDescImmobile(rs.getString(5));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(7));
				adImmobile.setRoomsNrImmobile(rs.getInt(8));
				adImmobile.setImmobileId(rs.getInt(9));
				adImmobile.setUserId(rs.getInt(10));
				adImmobile.setAddressId(rs.getInt(11));
				adImmobile.setRealtorId(rs.getInt(12));
				adImmobile.setCategoryId(rs.getInt(13));
				adImmobile.setCategoryName(rs.getString(14));
				adImmobile.setImmobileType(rs.getString(15));
				adImmobile.setAdTitle(rs.getString(16));
				adImmobile.setCounty(rs.getString(17));
				adImmobile.setCity(rs.getString(18));
				adImmobile.setStreedName(rs.getString(19));
				adImmobile.setAddressNr(rs.getInt(20));
				adImmobile.setOwnerLName(rs.getString(21));
				adImmobile.setOwnerFName(rs.getString(22));
				adImmobile.setPicture(rs.getString(23));
				if(categoryId == 1 || categoryId == 2) {
					adImmobile.setPartitioningAp(rs.getString(24));
					adImmobile.setFloorAp(rs.getInt(25));
				}
				else if(categoryId == 3 || categoryId == 4) {
					adImmobile.setFloorsNrHouse(rs.getInt(24));
				}
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
		
		return adImmobile;
	}
	
	public int getCategoryId(String category, String type) throws SQLException
	{
		int categoryId = 0;
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT cod_categorie FROM categorie WHERE denumire_categorie = ? AND tip_imobiliar = ? ");	
			stmt.setString(1, category);
			stmt.setString(2, type);
			rs = stmt.executeQuery();			
					
			while(rs.next())
			{				
				categoryId = rs.getInt(1);
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
		
		return categoryId;
	}
	
	public List<AdImmobile> getAdsByUser(int userId) throws SQLException
	{
		List<AdImmobile> ads = new ArrayList<AdImmobile>();
		
		Connection conn = null;		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("SELECT id_anunt, data_postare_anunt, stare_anunt, suprafata_utila, descriere, pret, an, nr_camere, id_imobiliar, " +
										"imobiliar.id_utilizator_FK, imobiliar.cod_adresa_FK, anunt.id_agent_Fk, anunt.cod_categorie_Fk, denumire_categorie, " +
										"tip_imobiliar, titlu, poza FROM anunt INNER JOIN imobiliar ON anunt.id_imobiliar_FK = imobiliar.id_imobiliar " +
										"INNER JOIN categorie ON anunt.cod_categorie_Fk = categorie.cod_categorie WHERE stare_anunt in ('activ', 'in asteptare') AND imobiliar.id_utilizator_FK = ? ");	
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();
						
			while(rs.next())
			{				
				AdImmobile adImmobile = new AdImmobile();
				adImmobile.setAdId(rs.getInt(1));
				adImmobile.setAdPostDate(rs.getDate(2));
				adImmobile.setAdStatus(rs.getString(3));
				adImmobile.setUsableArea(rs.getInt(4));
				adImmobile.setDescImmobile(rs.getString(5));
				adImmobile.setPriceImmobile(rs.getInt(6));
				adImmobile.setYearImmobile(rs.getInt(7));
				adImmobile.setRoomsNrImmobile(rs.getInt(8));
				adImmobile.setImmobileId(rs.getInt(9));
				adImmobile.setUserId(rs.getInt(10));
				adImmobile.setAddressId(rs.getInt(11));
				adImmobile.setRealtorId(rs.getInt(12));
				adImmobile.setCategoryId(rs.getInt(13));
				adImmobile.setCategoryName(rs.getString(14));
				adImmobile.setImmobileType(rs.getString(15));
				adImmobile.setAdTitle(rs.getString(16));
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
	
	public int insertAd(AdImmobile adImmobile) throws SQLException
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO anunt(data_postare_anunt, stare_anunt, id_imobiliar_FK, id_utilizator_FK, id_agent_FK, cod_categorie_FK, titlu, pret, perioada_postare) values(sysdate(), ?, ?, ?, ?, ?, ?, ?, ?)");	
			stmt.setString(1, adImmobile.getAdStatus());
			stmt.setInt(2, adImmobile.getImmobileId());			
			stmt.setInt(3, adImmobile.getUserId());
			stmt.setInt(4, adImmobile.getRealtorId());
			stmt.setInt(5, adImmobile.getCategoryId());
			stmt.setString(6, adImmobile.getAdTitle());
			stmt.setInt(7, adImmobile.getPriceImmobile());
			stmt.setInt(8, adImmobile.getAdPostingPeriod());
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
	
	public int getRealtorAd() throws SQLException
	{
		int realtorId = 0;
				
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_agent_fk, count(id_anunt) "
								+ "FROM anunt INNER JOIN cont ON anunt.id_agent_Fk = cont.id_utilizator_FK "
								+ "WHERE stare_anunt = 'activ' OR stare_anunt = 'in asteptare' AND stare_cont = 'activ' "
								+ "GROUP BY id_agent_Fk ORDER BY count(id_anunt) ASC limit 1 ");
			
			while(rs.next())
			{				
				realtorId = rs.getInt(1);				
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
		
		return realtorId;
	}
	
	public int updateAd(AdImmobile adImmobile) throws SQLException
	{
			int status = 0;
			Connection conn = null;
			PreparedStatement ps = null;
			
			try
			{
				conn = new DBManager().getConnection();
				ps = conn.prepareStatement("UPDATE anunt SET titlu = ?, pret = ?, stare_anunt = ?  WHERE id_anunt = ?");												
				ps.setString(1, adImmobile.getAdTitle());
				ps.setInt(2, adImmobile.getPriceImmobile());
				ps.setString(3, adImmobile.getAdStatus());
				ps.setInt(4, adImmobile.getAdId());
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
