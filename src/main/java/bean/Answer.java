package bean;

public class Answer {
	
	String answer;
	int userId;
	int questionId;
	
	public Answer() {
		super();
	}

	public Answer(String answer, int userId, int questionId) {
		super();
		this.answer = answer;
		this.userId = userId;
		this.questionId = questionId;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	@Override
	public String toString() {
		return "Answer [answer=" + answer + ", userId=" + userId + ", questionId=" + questionId + "]";
	}

}
