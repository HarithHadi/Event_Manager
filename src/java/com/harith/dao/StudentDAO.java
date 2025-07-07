
package com.harith.dao;

import com.harith.model.Student;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class StudentDAO {
    private Connection conn;
    
    public StudentDAO(Connection conn){
        this.conn=conn;
    }
    
    public Student getStudentByUserId(int userId) throws SQLException {
        Student student = null;
        String query = "SELECT * FROM STUDENTS WHERE USER_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            student = new Student();
            student.setStudentID(rs.getInt("STUDENT_ID"));
            student.setUserID(userId);
            student.setClubID(rs.getInt("CLUB_ID"));
            student.setStudentName(rs.getString("STUDENT_NAME"));
            student.setStudentCourse(rs.getString("STUDENT_COURSE"));
            student.setStudentPart(rs.getInt("STUDENT_PART"));
            student.setStudentGroup(rs.getString("STUDENT_GROUP"));
            student.setStudentPhone(rs.getInt("STUDENT_PHONE"));
        }
        rs.close();
        stmt.close();
        return student;
                
    }
}
