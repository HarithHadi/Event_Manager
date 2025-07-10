
package com.harith.dao;


import java.sql.Connection;
import com.harith.model.Club;
import com.harith.model.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class ClubDAO {
    private Connection conn;
    
    public ClubDAO(Connection conn){
        this.conn = conn;
    }
    
    public Club getClub(int clubId)throws SQLException{
        Club club = new Club();
        String sql = "SELECT * FROM CLUBS WHERE CLUB_ID=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, clubId);
        ResultSet rs = stmt.executeQuery();
        
        while(rs.next()){
            club.setClubID(clubId);
            club.setClubName(rs.getString("CLUB_NAME"));
            club.setOrganizerID(rs.getInt("ORGANIZER_ID"));
        }
        return club;
    }
    
    public List<Student> isClub(Student student, int clubId)throws SQLException{
        List<Student> students = new ArrayList<Student>();
        String sql = "SELECT * FROM STUDENTS WHERE CLUB_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, clubId);
        ResultSet  rs = stmt.executeQuery();
        
        while(rs.next()){
            Student curr = new Student();
            curr.setStudentID(rs.getInt("STUDENT_ID"));
            curr.setUserID(rs.getInt("USER_ID"));
            curr.setStudentName(rs.getString("STUDENT_NAME"));
            curr.setStudentCourse(rs.getString("STUDENT_COURSE"));
            curr.setStudentPart(rs.getInt("STUDENT_PART"));
            curr.setStudentGroup(rs.getString("STUDENT_GROUP"));
            curr.setStudentPhone(rs.getString("STUDENT_PHONE"));
            curr.setClubID(rs.getInt("CLUB_ID"));
            
            students.add(curr);
        }
        rs.close();
        stmt.close();
        return students;
    }
    
    
}
