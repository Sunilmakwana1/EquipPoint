package com.equip.point.util;

import jakarta.servlet.http.Part;

import java.io.FileOutputStream;
import java.io.InputStream;

public class EquipPointUtil {

    public static void uploadFile(String uploadPath, Part filePart) {
        try {
            FileOutputStream fos = new FileOutputStream(uploadPath);
            InputStream is = filePart.getInputStream();
            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();
        } catch (Exception e) {
            System.out.println("Unable to Upload File: "+ e.getMessage());
        }
    }


}
