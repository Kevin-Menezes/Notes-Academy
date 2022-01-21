
package com.notesacademy.DAO;

import com.notesacademy.entities.Category;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO
{
    private Connection con;
    
    public CategoryDAOImpl(Connection con)
    {
        super();
        this.con = con;
    }
    
//    -------------------------------------------------------------------- Categories with image --------------------------------------------------

    @Override
    public List<Category> getCategories() 
    {
        List<Category> list = new ArrayList<Category>();
        Category c = null;
        
        try 
        {
            
            String sql = "SELECT * FROM category";
            PreparedStatement ps_getcategories = con.prepareStatement(sql);
            
            ResultSet rs = ps_getcategories.executeQuery();

            while (rs.next()) 
            {
                c = new Category();
                c.setCategoryId(rs.getInt(1));
                c.setCategoryName(rs.getString(2));
                
//             Image retrieval (Converting a blob to string)
                Blob blob = rs.getBlob(3);
                InputStream inputStream = blob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;
                 
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);                  
                }
                 
                byte[] imageBytes = outputStream.toByteArray();
                String imgString = Base64.getEncoder().encodeToString(imageBytes);
                inputStream.close();
                outputStream.close();
//              Image retrieval end 
                
                c.setCategoryImgString(imgString);              
                list.add(c);           
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - getCategories : "+e);
        }
        
        System.out.println("Categories : "+list);
        return list;
     
    }
    
    // ------------------------------------------------ Categories without image ---------------------------------------

    @Override
    public List<Category> getCategoriesWithoutImg() 
    {
        List<Category> list = new ArrayList<Category>();
        Category c = null;
        
        try 
        {
            
            String sql = "SELECT * FROM category";
            PreparedStatement ps_getcategories = con.prepareStatement(sql);
            
            ResultSet rs = ps_getcategories.executeQuery();

            while (rs.next()) 
            {
                c = new Category();
                c.setCategoryId(rs.getInt(1));
                c.setCategoryName(rs.getString(2));
                list.add(c);           
            }

        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - getCategoriesWithoutImg : "+e);
        }
        
        System.out.println("Categories : "+list);
        return list;

    }

    
    // ------------------------------------------------ Count of Categories --------------------------------------
    
    @Override
    public int getCategoriesCount() 
    {
        int count = 0;
        
        try 
        {
            String sql = "SELECT COUNT(categoryName) FROM category";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            count = rs.getInt(1);
        } 
        
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - getCategoriesCount : "+e);
        }
        
        return count;
   
    }

    // ----------------------------------------- Return back a particular category's details based on id -----------------------------------------------------
    
    @Override
    public Category getCategoryById(int id) 
    {
        Category c = null;
        
        try 
        {
            String sql = "SELECT * FROM category WHERE categoryId = ? ";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                c = new Category();
                c.setCategoryId(rs.getInt(1));
                c.setCategoryName(rs.getString(2));
            }
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - getCategoryById : "+e);
        }
        
        return c;
    }

    // ----------------------------------------- Updates the category name based on the category id -----------------------------------------------------
    
    @Override
    public boolean updateEditCategory(Category c) 
    {
        boolean f = false;
        
        try 
        {
            String sql = "UPDATE category SET categoryName = ? WHERE categoryId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getCategoryName());
            ps.setInt(2, c.getCategoryId());
            
            int i = ps.executeUpdate();
            
            if(i>0)
           {
               f = true;
           }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - updateEditCategory : "+e);
        }
        
        return f;

    }
    
    // ----------------------------------------- Deletes the category based on the category id -----------------------------------------------------

    @Override
    public boolean deleteCategory(int id) 
    {
        boolean f = false;
        
        try
        {
            String sql = "DELETE FROM category WHERE categoryId = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,id);
            int i = ps.executeUpdate();
            
            if(i>0)
            {
                f=true;
            }
            
        }
        catch(Exception e)
        {
            System.out.println("There is error in CategoryDAOImpl - deleteCategory : "+e);
        }
        return f;
    }

    
     // ----------------------------------------- Inserts category details in the db -----------------------------------------------------
    
    @Override
    public boolean insertCategory(Category c) 
    {
        boolean f = false;
        try 
        {
            String sql = "INSERT INTO category(categoryName,categoryImg) VALUES (?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1,c.getCategoryName());       
            ps.setBytes(2,c.getCategoryImage());
            
            int i = ps.executeUpdate();
            if(i>0)
            {
                f=true;
            }
            
        } 
        catch (Exception e) 
        {
            System.out.println("There is error in CategoryDAOImpl - insertCategory : "+e);
        }
        
        
        return f;
    }
    
    
    

}
