package com.sistema.contabil;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {

    // Configurações do Mailtrap - Substitua com suas credenciais reais do Mailtrap
    private static final String HOST = "sandbox.smtp.mailtrap.io";
    private static final String PORT = "2525"; // Ou 465, 587, 2525
    private static final String USERNAME = "008c1414aea296"; // Substitua
    private static final String PASSWORD = "635a39c883b38c"; // Substitua
    private static final String FROM_EMAIL = "noreply@sistemacontabil.com";

    public static boolean send2FACode(String recipientEmail, String code) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Código de Autenticação de 2 Fatores");
            message.setText("Seu código de autenticação de 2 fatores é: " + code + "\n\nEste código expira em 5 minutos.");

            Transport.send(message);
            System.out.println("E-mail 2FA enviado com sucesso para: " + recipientEmail);
            return true;

        } catch (MessagingException e) {
            System.err.println("Erro ao enviar e-mail 2FA: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
