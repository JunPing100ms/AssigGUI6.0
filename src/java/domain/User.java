package domain;

import Auth.AESEncryptor;
import Auth.AESEncryptor;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

public class User implements Serializable {

    AESEncryptor aes = new AESEncryptor();

    private String id = "";
    private String name = "";
    private String email = "";
    private String phone = "";
    private String hbd = "";
    private String pwd = "";

    private String permission = "";
    private int fail_count = 0;
    private boolean block = false;
    private String token = "";
    private String token_date = "";
    private String create_date = "";

    public User() {
    }

    // CREATE USER
    public User(String id, String name, String email, String phone, String hbd, String pwd) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.hbd = hbd;
        try {
            this.pwd = aes.encrypt(pwd);
        } catch (Exception ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        this.create_date = LocalDate.now().toString();
    }

    // load USER INFO
    public User(String id, String name, String email, String phone, String hbd, String pwd, String permission, int fail_count, boolean block, String token, String token_date, String create_date) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.hbd = hbd;
        try {
            this.pwd = aes.decrypt(pwd);
        } catch (Exception ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        this.permission = permission;
        this.fail_count = fail_count;
        this.block = block;
        this.token = token;
        this.token_date = token_date;
        this.create_date = create_date;
    }
    //Special Case
    public User(String id, String name, String email, String phone, String hbd, String pwd, String permission) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.hbd = hbd;
        this.pwd = pwd;
        this.permission = permission;
    }

    // GETTER & SETTER
    public String getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPhone() {
        return this.phone;
    }

    public String getHbd() {
        return this.hbd;
    }

    public String getPwd() {
        return this.pwd;
    }
    public String getEncryptedPwd(){
        try {
            return aes.encrypt(pwd);
        } catch (Exception ex) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, ex);
        }
        return this.pwd;
    }

    public int getFailCount() {
        return this.fail_count;
    }

    public boolean getBlock() {
        return this.block;
    }

    public String getCreateDate() {
        return this.create_date;
    }

    public String getPermission() {
        return permission;
    }

    public String getToken() {
        return token;
    }

    public String getTokenDate() {
        return token_date;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setHbd(String hbd) {
        this.hbd = hbd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setFailCount(int fail_count) {
        this.fail_count = fail_count;
    }

    public void setBlock(boolean block) {
        this.block = block;
    }

    public void setCreateDate(String create_date) {
        this.create_date = create_date;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setTokenDate(String token_date) {
        this.token_date = token_date;
    }
}
