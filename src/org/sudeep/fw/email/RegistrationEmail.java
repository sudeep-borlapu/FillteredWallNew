package org.sudeep.fw.email;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class RegistrationEmail {
	
	public void sendEmail(String to) {
		final String username = "noreply.filteredwall@gmail.com";
		final String password = "filter1211";

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
			message.setText("Test");

			Transport.send(message);

			System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

	}
	public static void main(String args[]){
		RegistrationEmail reg = new RegistrationEmail();
		for(int i=0;i<100;i++)
		{
			System.out.println("Initiate time: "+new Date());
			reg.sendEmail("borlamsudeep@gmail.com,sudeep.borlapu@gmail.com,thrigunreddy@gmail.com");
			System.out.println("Terminated time: "+new Date());
		}
		System.out.println("intereations completed");
	}

}