package helper;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;

public class UserAccountHelper {
	
	public String encryptionPassword(String password) 
	{
		 try {
		        MessageDigest md5 = MessageDigest.getInstance("MD5");
		        byte[] keyBytes = md5.digest("A!9HHhi%XjjYY4YP2@Nob009X".getBytes(StandardCharsets.UTF_8));

		        byte[] textBytes = password.getBytes(StandardCharsets.UTF_8);

		        byte[] encryptedBytes = xor(textBytes, keyBytes);
		        String encodedPassword = Base64.getEncoder().encodeToString(encryptedBytes);
		        return encodedPassword;
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return null;
	}
	
	private byte[] xor(byte[] a, byte[] b) {
	    byte[] result = new byte[a.length];
	    for (int i = 0; i < a.length; i++) {
	        result[i] = (byte) (a[i] ^ b[i % b.length]);
	    }
	    return result;
	}
	
	public String decryptionPassword(String encryptedPassword) {
	    try {
	        MessageDigest md5 = MessageDigest.getInstance("MD5");
	        byte[] keyBytes = md5.digest("A!9HHhi%XjjYY4YP2@Nob009X".getBytes(StandardCharsets.UTF_8));

	        byte[] encryptedBytes = Base64.getDecoder().decode(encryptedPassword);

	        byte[] decryptedBytes = xor(encryptedBytes, keyBytes);
	        String decryptedPassword = new String(decryptedBytes, StandardCharsets.UTF_8);
	        return decryptedPassword;
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return null;
	}

}
