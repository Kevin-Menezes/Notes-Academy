/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.notesacademy.servlets;

import com.notesacademy.DAO.DownloadDAOImpl;
import com.notesacademy.DB.DBConnection;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownloadServlet extends HttpServlet 
{
    public static int BUFFER_SIZE = 1024 * 100;
    public static final String UPLOAD_DIR = "";
    public static String fileName = null;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        /**
         * *** Get The Absolute Path Of The File To Be Downloaded ****
         */
        fileName = request.getParameter("fileName");
        int noteId = Integer.parseInt(request.getParameter("noteId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int nuserId = Integer.parseInt(request.getParameter("nuserId"));
        
        if (fileName == null || fileName.equals("")) {
            /**
             * *** Set Response Content Type ****
             */
            response.setContentType("text/html");

            /**
             * *** Print The Response ****
             */
            response.getWriter().println("<h3>File " + fileName + " Is Not Present .....!</h3>");
        } else {
            String applicationPath = getServletContext().getRealPath("");
            String downloadPath = applicationPath + File.separator + UPLOAD_DIR;
            String filePath = downloadPath + File.separator + fileName;
            System.out.println("Application Path : "+applicationPath);
            System.out.println("Download Path : " +downloadPath);
            System.out.println("fileName in DownloadServlet:" + fileName);
            System.out.println("filePath in DownloadServlet :" + filePath);
            File file = new File(filePath);
            OutputStream outStream = null;
            FileInputStream inputStream = null;

            if (file.exists()) {

                /**
                 * ** Setting The Content Attributes For The Response Object
                 * ***
                 */
                String mimeType = "application/octet-stream";
                response.setContentType(mimeType);

                /**
                 * ** Setting The Headers For The Response Object ***
                 */
                String headerKey = "Content-Disposition";
                String headerValue = String.format("attachment; filename=\"%s\"", file.getName());
                response.setHeader(headerKey, headerValue);

                try {

                    /**
                     * ** Get The Output Stream Of The Response ***
                     */
                    outStream = response.getOutputStream();
                    inputStream = new FileInputStream(file);
                    byte[] buffer = new byte[BUFFER_SIZE];
                    int bytesRead = -1;
                              
                    // For incrementing the download counts of a note and user
                    DownloadDAOImpl ddao = new DownloadDAOImpl(DBConnection.getConnection());
                    
                    if(ddao.alreadyDownloadedByUser(noteId, userId))
                    {
                        
                    }
                    else
                    {
                        boolean f = ddao.insertDownload(noteId, userId, nuserId);
                        System.out.println(f);                    
                    }
                    

                    /**
                     * ** Write Each Byte Of Data Read From The Input Stream
                     * Write Each Byte Of Data Read From The Input Stream Into
                     * The Output Stream ***
                     */
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outStream.write(buffer, 0, bytesRead);
                    }
                } catch (IOException ioExObj) {
                    System.out.println("Exception While Performing The I/O Operation?= " + ioExObj.getMessage());
                } finally {
                    if (inputStream != null) {
                        inputStream.close();
                    }

                    outStream.flush();
                    if (outStream != null) {
                        outStream.close();
                    }
                }
            } else {

                /**
                 * *** Set Response Content Type ****
                 */
                response.setContentType("text/html");

                /**
                 * *** Print The Response ****
                 */
                response.getWriter().println("<h3>File " + fileName + " Is Not Present .....!</h3>");
            }

        }
    }

}
