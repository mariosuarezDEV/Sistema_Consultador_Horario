/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author lsuarez
 */
public class conexionBD {
    
    //varaibles de acceso
    String db = "uv";
    String url = "jdbc:mysql://2.tcp.ngrok.io:17056/";
    String driver = "com.mysql.cj.jdbc.Driver";
    Connection cx;
        
    //desencriptar credenciales
    public static String desencriptar(String texto, int shift) {
        StringBuilder decryptedText = new StringBuilder();
        for (char c : texto.toCharArray()) {
            if (Character.isLetter(c)) {
                char base = Character.isUpperCase(c) ? 'A' : 'a';
                char decryptedChar = (char) ((c - base - shift + 26) % 26 + base);
                decryptedText.append(decryptedChar);
            } else {
                decryptedText.append(c); // Conservar caracteres que no sean letras
            }
        }
        return decryptedText.toString();
    }
    
    //obtener el contenido del archivo encriptado
    public static String[] decrypt() {
        
        try (BufferedReader archivo = new BufferedReader(new FileReader("C:\\config.txt"))) {
            String linea;
            String[] credenciales = new String[2];

            if ((linea = archivo.readLine()) != null) {
                String usuario = linea.trim();
                if ((linea = archivo.readLine()) != null) {
                    String clave = linea.trim();
                    String[] lista = {usuario, clave};

                    // Desencriptar la cuenta
                    String getUser = desencriptar(lista[0], 3);
                    String getPass = desencriptar(lista[1], 3);
                    credenciales[0] = getUser;
                    credenciales[1] = getPass;
                } else {
                    System.out.println("El archivo no tiene credenciales");
                    System.exit(0);
                }
            } else {
                System.out.println("El archivo no tiene credenciales");
                System.exit(0);
            }

            return credenciales;
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(0);
            return null;
        }
    }
    
    //contructor de la clase
    public conexionBD(){
        
    }
    //funcion para conectarse a la base de datos
    public Connection conectar(){
        
        String [] cuenta = decrypt();
        try {
            Class.forName(driver);
            cx = DriverManager.getConnection(url+db,cuenta[0],cuenta[1]);
            System.out.println("Se conecto a la db");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return cx;
    }
    
    //función para desconetar se la base de datos
    public Connection desconectar(){
        try{
            cx.close();
            System.out.print("Se cerro la conexion a la bd");
        } catch(SQLException e){
            System.out.print("No se pudo cerrar la conexion a la base de datos");
        }
        return cx;
    }
    
}
