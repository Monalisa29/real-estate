package bean;

public class UserAccount {
	
	int userId;
	String userFName;
	String userLName;
	char userSex;
	String userCNP;
	String userPhoneNr;
	String userType;
	
	String email;
	String password;
	String accountStatus;
		
	public UserAccount() {
		super();
	}

	public UserAccount(int userId, String userFName, String userLName, char userSex, String userCNP, String userPhoneNr,
			String userType, String email, String password, String accountStatus) {
		super();
		this.userId = userId;
		this.userFName = userFName;
		this.userLName = userLName;
		this.userSex = userSex;
		this.userCNP = userCNP;
		this.userPhoneNr = userPhoneNr;
		this.userType = userType;
		this.email = email;
		this.password = password;
		this.accountStatus = accountStatus;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserFName() {
		return userFName;
	}

	public void setUserFName(String userFName) {
		this.userFName = userFName;
	}

	public String getUserLName() {
		return userLName;
	}

	public void setUserLName(String userLName) {
		this.userLName = userLName;
	}

	public char getUserSex() {
		return userSex;
	}

	public void setUserSex(char userSex) {
		this.userSex = userSex;
	}

	public String getUserCNP() {
		return userCNP;
	}

	public void setUserCNP(String userCNP) {
		this.userCNP = userCNP;
	}

	public String getUserPhoneNr() {
		return userPhoneNr;
	}

	public void setUserPhoneNr(String userPhoneNr) {
		this.userPhoneNr = userPhoneNr;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	@Override
	public String toString() {
		return "UserAccount [userId=" + userId + ", userFName=" + userFName + ", userLName=" + userLName + ", userSex="
				+ userSex + ", userCNP=" + userCNP + ", userPhoneNr=" + userPhoneNr + ", userType=" + userType
				+ ", email=" + email + ", password=" + password + ", accountStatus=" + accountStatus + "]";
	}

}
