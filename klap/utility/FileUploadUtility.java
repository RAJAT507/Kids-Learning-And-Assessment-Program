/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.utility;

/**
 *
 * @author Mahadev
 */
//package utility;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.io.FileOutputStream;

public class FileUploadUtility {

    public static String uploadFile(Part filePart, String uploadDir) {
        String fileName = filePart.getSubmittedFileName();
        try {
            File file = new File(uploadDir + File.separator + fileName);
            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fileName;
    }
}
