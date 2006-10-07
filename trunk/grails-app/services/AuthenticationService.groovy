import java.security.MessageDigest
import sun.misc.BASE64Encoder

class AuthenticationService {
    
    def encryptPassword(clearPassword) {

        def md = MessageDigest.getInstance("SHA-1")
        def buf = clearPassword.getBytes()

        md.update(buf)     //so we avoid password recovery
        def hash = md.digest()     //hash of new password
        if (hash.length <= 0) {    //no password was entered
            println "encryptPassword() No password to hash"
            return ""
        }

        def encryptedPwd = "{SHA}" + new BASE64Encoder().encode(hash)
        //println "encryptPassword() generated password : " + encryptedPwd
        return encryptedPwd
    }
}