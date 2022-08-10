package com;

import com.notesacademy.DAO.CategoryDAOImpl;
import com.notesacademy.DB.DBConnection;
import com.notesacademy.entities.Category;
import static org.hamcrest.CoreMatchers.is;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import org.junit.Ignore;

public class TestCategoryMethods {
    
    CategoryDAOImpl cdao; 
    
    @Before
    public void setup(){
        
        cdao = new CategoryDAOImpl(DBConnection.getConnection());
    }
    
    // Fetch categories from db to display them
    @Test
    public void testFetchCategories()
    {
        assertNotNull(cdao.getCategoriesWithoutImg());
    }
    
    // Get count of total categories
    @Test
    public void testCategoriesCount()
    {
        assertThat(cdao.getCategoriesCount(),is(3));
    }
    
    // Fetch a single category from db 
    @Test
    public void testFetchSingleCategory()
    {
        assertNotNull(cdao.getCategoryById(2));
    }
    
    // Edit a category
    @Test
    @Ignore
    public void testEditCategory(){

        Category c = new Category();
        c.setCategoryName("Sciences");
        c.setCategoryId(1);
        
        assertTrue(cdao.updateEditCategory(c));
    }
    
    // Delete a category
    @Test
    @Ignore
    public void testDeleteCategory()
    {
        assertTrue(cdao.deleteCategory(5));    
    }
    
    // Add a new category
    @Test
    @Ignore
    public void testInsertCategory(){

        Category c = new Category();
        c.setCategoryName("Sports");
        assertTrue(cdao.insertCategory(c));    
    }
    
}
