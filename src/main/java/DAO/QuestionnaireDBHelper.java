package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Answer;
import bean.Questionnaire;

public class QuestionnaireDBHelper {

	public List<Questionnaire> getQuestions() throws SQLException
	{
		List<Questionnaire> questionnaires = new ArrayList<Questionnaire>();
		String answerOptions;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_intrebare, text_intrebare, variante_raspuns FROM chestionar ");
			
			while(rs.next())
			{				
				Questionnaire questionnaire = new Questionnaire();
				questionnaire.setQuestionId(rs.getInt(1));
				questionnaire.setQuestionText(rs.getString(2));
				answerOptions = rs.getString(3);
				questionnaire.setAnswerOptions(answerOptions.split(";"));
				
				questionnaires.add(questionnaire);
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
		
		return questionnaires;
	}
	
	public int getQuestionsNr() throws SQLException
	{
		int questionsNr = 0;
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(id_intrebare) FROM chestionar ");
			
			while(rs.next())
			{								
				questionsNr = rs.getInt(1);				
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
		
		return questionsNr;
	}
	
	public List<Integer> getUserForQuestionnaire() throws SQLException
	{
		List<Integer> usersId = new ArrayList<Integer>();
		
		Connection conn = null;		
		Statement stmt = null;
		ResultSet rs = null;
		
		try
		{			
			conn = new DBManager().getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT id_utilizator_fk FROM cont WHERE (id_utilizator_FK IN"
								+ "( "
								+ "SELECT distinct(id_utilizator_fk) "
								+ "FROM cont "
								+ "INNER JOIN vanzare ON vanzare.id_utilizator = cont.id_utilizator_FK "
								+ ") "
								+ "OR "
								+ "id_utilizator_FK IN "
								+ "( "
								+ "SELECT distinct(id_utilizator_fk) "
								+ "FROM cont "
								+ "INNER JOIN inchiriere ON inchiriere.id_utilizator = cont.id_utilizator_FK "
								+ ")) "
								+ "AND (id_utilizator_FK NOT IN (SELECT id_utilizator FROM ofera_raspunsuri) "
								+ "OR "
								+ "((id_utilizator_FK IN "
								+ "(SELECT DISTINCT ofera_raspunsuri.id_utilizator "
								+ "FROM ofera_raspunsuri "
								+ "INNER JOIN vanzare ON ofera_raspunsuri.id_utilizator = vanzare.id_utilizator "
								+ "WHERE DATEDIFF(CURRENT_DATE(), ofera_raspunsuri.data_pk) >= 180 "
								+ "  AND DATEDIFF(CURRENT_DATE(), vanzare.data_vanzare_pk) <= 180) "
								+ ") "
								+ "OR"
								+ "(id_utilizator_FK IN "
								+ "(SELECT DISTINCT ofera_raspunsuri.id_utilizator "
								+ "FROM ofera_raspunsuri "
								+ "INNER JOIN inchiriere ON ofera_raspunsuri.id_utilizator = inchiriere.id_utilizator "
								+ "WHERE DATEDIFF(CURRENT_DATE(), ofera_raspunsuri.data_pk) >= 180 "
								+ "  AND DATEDIFF(CURRENT_DATE(), inchiriere.data_inceput_inchiriere) <= 180) "
								+ ") "
								+ ")); ");
			
			while(rs.next())
			{				
				int userId;
				userId = rs.getInt(1);
				
				usersId.add(userId);
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
		
		return usersId;
	}
	
	public int insertAnswer(Answer answer) throws SQLException
	{
		int status = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try
		{
			conn = new DBManager().getConnection();
			stmt = conn.prepareStatement("INSERT INTO ofera_raspunsuri(data_PK, raspunsuri_oferite, id_utilizator, id_intrebare_chestionar) VALUES(sysdate(), ?, ?, ?)");	
			stmt.setString(1, answer.getAnswer());
			stmt.setInt(2, answer.getUserId());			
			stmt.setInt(3, answer.getQuestionId());
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
