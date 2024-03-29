import org.springframework.mail.MailException
import org.springframework.mail.MailSender
import org.springframework.mail.SimpleMailMessage

/**
* Simple service for sending emails.
*
* Work is planned in the Grails roadmap to implement first-class email
* support, so there's no point in making this code any more sophisticated
*/
class EmailerService {
   boolean transactional = false
   MailSender mailSender
   SimpleMailMessage mailMessage // a "prototype" email instance

   /**
    * Send a list of emails.
    *
    * @param mails a list of mails
    */
   def sendEmails(mails) {
       // Build the mail messages
       def messages = []
       for (mail in mails) {
           // Create a thread safe "sandbox" of the message
           SimpleMailMessage message = new SimpleMailMessage(mailMessage)
           if (mail.replyTo)
               message.replyTo = mail.replyTo
           message.to = mail.to
           message.cc = [ message.from ].toArray()
           message.text = mail.text
           message.subject = mail.subject
           messages << message
       }
       // Send them all together
       try {
           println "about to send ${messages.size()} messages to:\n${messages.to.join('\n')}"
           mailSender.send(messages as SimpleMailMessage[])
       } catch (MailException ex) {
           println "Failed to send emails"
           ex.printStackTrace()
       }
   }
}
