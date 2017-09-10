package org.sudeep.fw.dto;

public class ChangePwd1Dto {
	
	private String curentPassword;
	private String newPassword;
	private String confirmPassword;
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCurentPassword() {
		return curentPassword;
	}
	public void setCurentPassword(String curentPassword) {
		this.curentPassword = curentPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getConfirmPassword() {
		return confirmPassword;
	}
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
}
