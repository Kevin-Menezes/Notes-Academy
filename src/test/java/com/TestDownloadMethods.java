package com;

import com.notesacademy.DAO.DownloadDAOImpl;
import com.notesacademy.DB.DBConnection;
import static org.hamcrest.CoreMatchers.is;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;


public class TestDownloadMethods {
    
    DownloadDAOImpl ddao; 
    
    @Before
    public void setup(){
        
        ddao = new DownloadDAOImpl(DBConnection.getConnection());
    }
    
    // Increment download in a note
    @Test
    @Ignore
    public void testInsertDownload()
    {
        assertTrue(ddao.insertDownload(25, 1, 18));
    }
    
    // To count the number of downloads of a particular note
    @Test
    public void testCountDownloads()
    {
        assertThat(ddao.countDownload(23),is(4));
    }
    
    // To check if the user has already downloaded the note and then not to increment the number of downloads
    @Test
    public void testCheckAlreadyDownloaded(){
        assertTrue(ddao.alreadyDownloadedByUser(13, 19));
    }
    
    // To get the most downloaded note number in a particular subject
    @Test
    public void testGetMostDownloadedNote()
    {
        assertThat(ddao.getMostDownloadedNote(7),is(6));
    }
    
    // To get the most downloaded paid note number in a particular subject
    @Test
    public void testGetMostDownloadedPaidNote()
    {
        assertThat(ddao.getMostDownloadedPaidNote(4),is(4));
    }
    
    // To get the most downloaded note number from searched criteria
    @Test
    public void testGetMostDownloadedNoteSearch()
    {
        assertThat(ddao.getMostDownloadedNoteSearch("python"),is(6));
    }
    
    // To get the most downloaded paid note number from searched criteria
    @Test
    public void testGetMostPaidDownloadedNoteSearch()
    {
        assertThat(ddao.getMostDownloadedPaidNoteSearch("chem"),is(4));
    }
    
}
