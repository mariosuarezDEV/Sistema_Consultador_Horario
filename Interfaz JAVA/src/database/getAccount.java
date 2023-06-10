/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;
import database.conexionBD;
import java.sql.*;

/**
 *
 * @author lsuarez
 */
public class getAccount {
    //contructor
    public getAccount(){
        
    }
    //variable
    int matricula;
    
    //objetos de la conexion
    conexionBD debug = new conexionBD();
    //funcion para login
    public int enter(String user, String password){
        PreparedStatement ps;
        ResultSet rs;
        String sql = "select matricula from alumno where email = ? and clave = ?";
        
        try{
            ps = debug.conectar().prepareStatement(sql);
            ps.setString(1,user);
            ps.setString(2,password);
            rs = ps.executeQuery(); //aqui se obtienen los datos para poder manipularlos después
            
            //comprobar si se obtuvierons datos
            if(rs.next()){
                //si se obtuvieron los datos
                matricula = rs.getInt(1);
                debug.desconectar();
                return matricula;
            } else{
                //no se obtuieron los datos
                debug.desconectar();
                //buscar la cuenta en academico
                sql = "select matricula from autoridad where correoElectronico = ? and clave = ?";
                try{
                    ps = debug.conectar().prepareStatement(sql);
                    ps.setString(1,user);
                    ps.setString(2, password);
                    rs = ps.executeQuery();
                    if(rs.next()){
                        matricula = rs.getInt(1);
                        debug.desconectar();
                        return matricula;
                    }
                } catch(SQLException e){
                    System.out.println("No se puede hacer la consulta parametrizada con autoridad");
                }
                return 0;
            }
            
        } catch(SQLException e){
            System.out.println("No se puede hacer la consulta parametrizada");
        }
        
        return 0;
    }
}
