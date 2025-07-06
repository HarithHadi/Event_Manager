
package com.harith.model;


public class User {
    private int userId;
    private String email;
    private String password;
    private String role;
    
    public User(){
        userId= 0;
        email = "";
        password = "";
        role = "";        
    }
    public User(int userId, String email, String password, String role){
        this.userId= userId;
        this.email = email;
        this.password = password;
        this.role = role;        
    }
    
    public int getUserId(){
        return this.userId;
    }
    public String getEmail(){
        return email;
    }
    public String getPassword(){
        return password;
    }
    public String getRole(){
        return role;
    }
    
    public void setUserId(int id){
        this.userId = id;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public void setPassword(String password){
        this.password = password;
    }
    public void setRole(String role){
        this.role = role;
    }
}
