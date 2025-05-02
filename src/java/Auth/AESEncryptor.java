package Auth;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import javax.crypto.spec.IvParameterSpec;

public class AESEncryptor {
    private static final byte[] KEY = "UafL8Bvn2ngjUoB0".getBytes();
    private static final byte[] IV = new byte[16];
    
    public String encrypt(String password) throws Exception {
        SecretKeySpec key = new SecretKeySpec(KEY, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(IV));
        byte[] encrypted = cipher.doFinal(password.getBytes());
        return Base64.getEncoder().encodeToString(encrypted);
    }
    
    public String decrypt(String encryptedBase64) throws Exception {
        SecretKeySpec key = new SecretKeySpec(KEY, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(IV));
        byte[] decrypted = cipher.doFinal(Base64.getDecoder().decode(encryptedBase64));
        return new String(decrypted);
    }
    public static void main(String[] args) {
        try {
            AESEncryptor encryptor = new AESEncryptor();
            String encrypted = encryptor.encrypt("");
            System.out.println("Encrypted: " + encrypted);
            
            String decrypted = encryptor.decrypt("0GB2KUpM7hw8bpYJaAoK9A==");
            System.out.println("Decrypted: " + decrypted);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
