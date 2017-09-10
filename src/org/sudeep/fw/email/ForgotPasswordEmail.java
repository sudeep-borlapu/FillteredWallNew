package org.sudeep.fw.email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class ForgotPasswordEmail {

	/*
	 * public boolean sendMail(String to) throws SendGridException, SQLException
	 * {
	 * 
	 * ForgotPasswordDao dao = new ForgotPasswordDao(); RegisterDto dto =
	 * dao.getDetails(to);
	 * 
	 * SendGrid sendgrid = new SendGrid("sudeep.borlapu", "sumalatha1208");
	 * 
	 * SendGrid.Email email = new SendGrid.Email();
	 * 
	 * 
	 * email.addTo(to); email.setFrom("noreply.filteredwall@gmail.com");
	 * email.setFromName("Filtered Wall");
	 * email.setSubject("Filtered Wall Login Password"); email.
	 * setHtml("<font color='green' font='20px'>Your password for the account with email : "
	 * +to+" is : "+dto.getPassword()+"<br></font><br>");
	 * 
	 * SendGrid.Response response = sendgrid.send(email); boolean emailStatus =
	 * response.getStatus();
	 * 
	 * return emailStatus; }
	 */

	public void sendMail(String to) {
		final String username = "noreply.filteredwall@gmail.com";
		final String password = "filter1208";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(to));
			message.setSubject("Testing Subject");
			message.setText("Dear Mail Crawler,"
				+ "\n\n No spam to my email, please!");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}

}
