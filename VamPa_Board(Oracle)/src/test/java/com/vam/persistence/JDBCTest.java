package com.vam.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {

	

    static { 
        try { 
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
        } catch(Exception e) { 
            e.printStackTrace(); 
        } 
    } 
    
    @Test 
    public void testConnection() { 
    	// given, when, then
    	
    	//given (필요한 데이터 준비)
    	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    	String id = "kona";
    	String password = "0700";
    	
    	// when 실행
        try(Connection con = DriverManager.getConnection( 
        		// 계정정보
        		url, 
                id, 
                password)){ 
        	
        	
        	// then
            System.out.println(con); 
        } catch (Exception e) { 
            fail(e.getMessage()); 
        } 
    
    }    
        
}
