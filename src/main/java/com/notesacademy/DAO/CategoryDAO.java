
package com.notesacademy.DAO;

import com.notesacademy.entities.Category;
import java.util.List;

public interface CategoryDAO 
{
    public List<Category> getCategories();
    
    public List<Category> getCategoriesWithoutImg();
    
    public int getCategoriesCount();
    
    public Category getCategoryById(int id); // This is after clicking on edit category
    
    public boolean updateEditCategory(Category c); // This is after editing the name of the category
    
    public boolean deleteCategory(int id); // Delete category based on id
    
    public boolean insertCategory(Category c); // Adds category
}
