package com;

import com.notesacademy.DAO.NoteDAOImpl;
import com.notesacademy.DB.DBConnection;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

public class TestNoteMethods {
    
    NoteDAOImpl ndao; 
    
    @Before
    public void setup(){
        
        ndao = new NoteDAOImpl(DBConnection.getConnection());
    }

}
