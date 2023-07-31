package bean;

import java.util.Date;

public class Comment {

	int commentId;
	int userId;
	String commentText;
	Date dateComment;
	String userLName;
	String userFName;
	
	public Comment() {
		super();
	}
	
	public Comment(int commentId, int userId, String commentText, Date dateComment, String userLName,
			String userFName) {
		super();
		this.commentId = commentId;
		this.userId = userId;
		this.commentText = commentText;
		this.dateComment = dateComment;
		this.userLName = userLName;
		this.userFName = userFName;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public Date getDateComment() {
		return dateComment;
	}

	public void setDateComment(Date dateComment) {
		this.dateComment = dateComment;
	}

	public String getUserLName() {
		return userLName;
	}

	public void setUserLName(String userLName) {
		this.userLName = userLName;
	}

	public String getUserFName() {
		return userFName;
	}

	public void setUserFName(String userFName) {
		this.userFName = userFName;
	}

	@Override
	public String toString() {
		return "Comment [commentId=" + commentId + ", userId=" + userId + ", commentText=" + commentText
				+ ", dateComment=" + dateComment + ", userLName=" + userLName + ", userFName=" + userFName + "]";
	}

}
