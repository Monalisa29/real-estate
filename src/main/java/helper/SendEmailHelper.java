package helper;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmailHelper {
	
	public void sendEmailContact(String emailFrom, String passwordFrom, String subject, String comment) throws MessagingException {
		final String emailTo = "draganmonalisamihaela@gmail.com";
		
		Properties props = System.getProperties(); 
		props.setProperty("mail.smtp.host", "smtp.gmail.com"); 
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
		props.setProperty("mail.smtp.socketFactory.fallback", "false"); 
		props.setProperty("mail.smtp.port", "465"); 
		props.setProperty("mail.smtp.socketFactory.port", "465"); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.debug", "true"); 
		props.put("mail.store.protocol", "pop3");
		props.put("mail.transport.protocol", "smtp");
		
		try {
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailFrom, passwordFrom);
				}
			});
			
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(emailFrom));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo, false));
			msg.setSubject(subject);
			msg.setText(comment);
			
			msg.setSentDate(new Date());
			Transport.send(msg);
		}
		catch(MessagingException e) {
			throw new MessagingException();
		}
				
	}

}
