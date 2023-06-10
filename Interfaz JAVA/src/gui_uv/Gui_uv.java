/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package gui_uv;
import gui.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
/**
 *
 * @author lsuarez
 */
public class Gui_uv {

    /**
     * @param args the command line arguments
     */
    public void crear_doc(){
        String rutaArchivo = "C:\\config.txt";

        try (BufferedWriter archivo = new BufferedWriter(new FileWriter(rutaArchivo))) {
            archivo.write("xvhu");
            archivo.newLine(); // Cambiar de línea
            archivo.write("LJkQHvWULvKL");
            
            System.out.println("Archivo creado exitosamente.");
        } catch (IOException e) {
            System.out.println("Fallo al crear el archivo.");
            e.printStackTrace();
        }
    }
    
    
    public static void main(String[] args) {
        // TODO code application logic here
        Gui_uv cred = new Gui_uv();
        cred.crear_doc();
        login lg = new login();
        lg.setVisible(true);
    }
    
}
