
package com.harith.dao;
import com.harith.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author User
 */
public class UserDAO {
    private Connection conn;
    
    public UserDAO(Connection conn){
        this.conn = conn;
    }
    
    public User getUserByUserId(int userId ) throws SQLException{
        User user = null;
        
        String query = "SELECT * FROM USERS WHERE USER_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            user = new User();
            user.setUserId(rs.getInt("USER_ID"));
            user.setEmail(rs.getString("EMAIL"));
            user.setPassword(rs.getString("PASSWORD"));
            user.setRole(rs.getString("ROLE"));
        }
        rs.close();
        stmt.close();
        
        return user;
    }
    
     public User getUserByEmailAndPassword(String email, String password) throws SQLException {
        User user = null;
        String query = "SELECT * FROM USERS WHERE EMAIL = ? AND PASSWORD = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            user = new User();
            user.setUserId(rs.getInt("USER_ID"));
            user.setEmail(rs.getString("EMAIL"));
            user.setPassword(rs.getString("PASSWORD"));
            user.setRole(rs.getString("ROLE"));
        }

        rs.close();
        stmt.close();

        return user;
    }
    
}
