
package com.harith.dao;
import com.harith.model.Organizer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrganizerDAO {
    private Connection conn;
    
    public OrganizerDAO(Connection conn){
        this.conn= conn;
    }
    
    public boolean CheckIfStudentIsOrganizer(int StudentId) throws SQLException{
        boolean isOrganizer = false;
        String query = "SELECT * FROM ORGANIZERS WHERE STUDENT_ID=?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, StudentId);
        ResultSet rs = stmt.executeQuery();     
        if(rs.next()){
            isOrganizer = true;
            return isOrganizer;
        }else{
            return isOrganizer;
        }   
    }
}
