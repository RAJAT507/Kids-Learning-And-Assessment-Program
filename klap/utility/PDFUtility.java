///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package com.jk.klap.utility;
//
///**
// *
// * @author Mahadev
// */
////package utility;
//
//import com.itextpdf.kernel.pdf.PdfWriter;
//import com.itextpdf.kernel.pdf.PdfDocument;
//import com.itextpdf.layout.Document;
//import com.itextpdf.layout.element.Paragraph;
//
//public class PDFUtility {
//
//    public static void createPdf(String dest, String content) {
//        try {
//            PdfWriter writer = new PdfWriter(dest);
//            PdfDocument pdf = new PdfDocument(writer);
//            Document document = new Document(pdf);
//            document.add(new Paragraph(content));
//            document.close();
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//    }
//}
