package bean;

import java.util.Arrays;

public class Questionnaire {
	
	int questionId;
	String questionText;
	String[] answerOptions;	
	
	public Questionnaire() {
		super();
	}

	public Questionnaire(int questionId, String questionText, String[] answerOptions) {
		super();
		this.questionId = questionId;
		this.questionText = questionText;
		this.answerOptions = answerOptions;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getQuestionText() {
		return questionText;
	}

	public void setQuestionText(String questionText) {
		this.questionText = questionText;
	}

	public String[] getAnswerOptions() {
		return answerOptions;
	}

	public void setAnswerOptions(String[] answerOptions) {
		this.answerOptions = answerOptions;
	}

	@Override
	public String toString() {
		return "Questionnaire [questionId=" + questionId + ", questionText=" + questionText + ", answerOptions="
				+ Arrays.toString(answerOptions) + "]";
	}
	
}
