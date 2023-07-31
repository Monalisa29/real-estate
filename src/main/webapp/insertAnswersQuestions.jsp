<%@page import="bean.UserAccount"%>
<%@page import="bean.Answer"%>
<%@page import="DAO.QuestionnaireDBHelper"%>
<%
UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
QuestionnaireDBHelper questionnaireDBHelper = new QuestionnaireDBHelper();
int questionsNr = questionnaireDBHelper.getQuestionsNr();
Answer answer = null;

for(int i = 1; i <= questionsNr; i++){
	answer = new Answer();
	answer.setQuestionId(i);
	answer.setUserId(currentUser.getUserId());
	answer.setAnswer(request.getParameter("question"+i));
	if(i == 5 && answer.getAnswer().equals("Altele (va rugam sa specificati)")){
		answer.setAnswer(request.getParameter("question5Area"));
	}
	if(i == 10 && answer.getAnswer().equals("Nu (va rugam sa specificati motivul)")){
		answer.setAnswer(request.getParameter("question10Area"));
	}
	questionnaireDBHelper.insertAnswer(answer);
}

response.sendRedirect("index.jsp");
%>