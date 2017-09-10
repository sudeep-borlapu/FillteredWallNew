package org.sudeep.fw.servlet;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AjaxProfilePicUploadServlet extends HttpServlet{
	
	private boolean isMultipart;
	private String filePath;
	//private int maxFileSize = 50 * 1024;//50KB
	private int maxMemSize = 4 * 1024;
	private File file ;

	public void init( ){
	// Get the file location where it would be stored.
		filePath = getServletContext().getInitParameter("profile-pic");
		System.out.println("The files that are going to store at :"+filePath);
	   }
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, java.io.IOException {
	      // Check that we have a file upload request
		PrintWriter out = response.getWriter();
	    isMultipart = ServletFileUpload.isMultipartContent(request);
	    if( !isMultipart ){
	    	//form is not of multipart
	    	return;
	    }
	    DiskFileItemFactory factory = new DiskFileItemFactory();
	    // maximum size that will be stored in memory
	    factory.setSizeThreshold(maxMemSize);
	    // Location to save data that is larger than maxMemSize.
	    factory.setRepository(new File("/home/sudeep/Desktop/temp/"));
	    
	    // Create a new file upload handler
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    // maximum file size to be uploaded.
	    //upload.setSizeMax( maxFileSize );

	    try{
	    // Parse the request to get file items.
	    List fileItems = upload.parseRequest(request);
	    // Process the uploaded file items
	    Iterator i = fileItems.iterator();
	    
	    String fileExtension = "";

	    while ( i.hasNext () ) 
	    {
	    	FileItem fi = (FileItem)i.next();
	    	if ( !fi.isFormField () )	
	    	{
	    		// Get the uploaded file parameters
	    		String fieldName = fi.getFieldName();
	    		String fileName = fi.getName();
	    		String contentType = fi.getContentType();
	    		//boolean isInMemory = fi.isInMemory();
	    		long sizeInBytes = fi.getSize();
	    		double sizeInMB = sizeInBytes/1000000.0;
	    		
	    		System.out.println("The file name is :"+fileName);
	    		System.out.println("The fieldName is :"+fieldName);
	    		System.out.println("The file size is :"+sizeInBytes+" Bytes");
	    		System.out.println("The file size is :"+sizeInMB+" MB");
	    		if(contentType.equalsIgnoreCase("image/jpeg")) {
	    		//rename the file to USERID
	    		HttpSession session = request.getSession();
	    		if(session.getAttribute("loggedInUser") != null) {
	    			fileName = session.getAttribute("loggedInUser").toString();
	    			if(sizeInMB >= 1.0) {
	    				out.write("<font color='red'>File size limit exceeded. File size should be less than 1 MB only</font>");
	    			}else {
	    				//write the file to disk
			    		file = new File(filePath+fileName);
			    		System.out.println("The filePath is : "+file);
			    		fi.write( file );
			    		  
			    		out.write("<font color='red'>File uploaded!</font>");
	    			}
	    		}
	    		else if(session.getAttribute("loggedInUser") == null){
	    			out.write("Session timeout! Please <a href='/index'>login</a> again!");
	    		}
	    			
	    		
	    		}
	    		else {
	    			out.write("Only JPEG or JPG images are accepted!");
	    		}
	    		System.out.println("loop ended");
	    	  }System.out.println("loop ended ff");
	      }
	      }catch(Exception ex) {
	       System.out.println(ex);
	      }
	}
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, java.io.IOException {
	        throw new ServletException("GET method used with " + getClass( ).getName( )+": POST method required.");
	} 
}