/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package gui;
import java.sql.*;
import database.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author lsuarez
 */
public class control_pane extends javax.swing.JFrame {

    /**
     * Creates new form control_pane
     */
    
    //crear el objeto de la tabla
    DefaultTableModel modeloHorario = new DefaultTableModel();
    
    //eatablecer el modelo de la tabla
    public void tbHorario(){
        modeloHorario.addColumn("Experiencia Educativa");
        modeloHorario.addColumn("Edificio");
        modeloHorario.addColumn("Aula");
        modeloHorario.addColumn("Día");
        modeloHorario.addColumn("Hora de Inicio");
        modeloHorario.addColumn("Hora de Fin");
        tbMiUV.setModel(modeloHorario);
        
        
    }
    //poner datos en la tabla
    public void horario(int matricula){
        String sql = "select ee.nombre,edificio.nombre,aula.nombre,imparte.dia,imparte.horaInicio,imparte.horaFin from ee,seccion,cursa,alumno,programaEducativo,facultad, edificio,aula,imparte where ee.idEE = seccion.ee_id and cursa.numNRC = seccion.nrc and cursa.matricula_alumno = alumno.matricula and programaEducativo.idProgramaEducativo = alumno.programaEduactivo_id and programaEducativo.facultad_id = facultad.idFacultad and edificio.facultad_id = facultad.idFacultad and aula.edificio_id = edificio.idEdicio and seccion.nrc = imparte.numNRC and imparte.aula_id=aula.idAula and alumno.matricula = ?;";
        //ejecutar la consulta
        PreparedStatement ps;
        ResultSet rs;
        conexionBD debug = new conexionBD();
        try{
            ps = debug.conectar().prepareStatement(sql);
            ps.setInt(1, matricula);
            rs = ps.executeQuery();
            System.out.println(rs);
            //poner la informacion en la tabla
            //meter datos a la table
            String [] celdas = new String [6];

            while(rs.next()){
                celdas[0] = rs.getString(1);
                celdas[1] = rs.getString(2);
                celdas[2] = rs.getString(3);
                celdas[3] = rs.getString(4);
                celdas[4] = rs.getString(5);
                celdas[5] = rs.getString(6);
                modeloHorario.addRow(celdas);
            }
            
            debug.desconectar();
        } catch(SQLException e){
            System.out.println("Error al hacer la consulta parametrizada");
        }
    } 
    private int matri;
    public control_pane(int matricula,String primerNom, String segundoNom, String apellidoPat, String apellidoMat) {
        initComponents();
        setLocationRelativeTo(this);
        String matriculaS = String.valueOf(matricula);
        txtMatricula.setText(matriculaS);
        txtPrimerNombre.setText(primerNom);
        txtSegundoNombre.setText(segundoNom);
        txtApellidoPat.setText(apellidoPat);
        txtApellidoMat.setText(apellidoMat);
        //aqui cargar los datos de la tabla
        tbHorario();
        javax.swing.table.TableColumn column = tbMiUV.getColumnModel().getColumn(0);
        column.setPreferredWidth(260);
        horario(matricula);
        this.matri = matricula;
        
    }
    
    public void buscar(int matricula){
        String dia = (String)cmbDias.getSelectedItem();
        String sql = "select ee.nombre,edificio.nombre,aula.nombre,imparte.dia,imparte.horaInicio,imparte.horaFin from ee,seccion,cursa,alumno,programaEducativo,facultad, edificio,aula,imparte where ee.idEE = seccion.ee_id and cursa.numNRC = seccion.nrc and cursa.matricula_alumno = alumno.matricula and programaEducativo.idProgramaEducativo = alumno.programaEduactivo_id and programaEducativo.facultad_id = facultad.idFacultad and edificio.facultad_id = facultad.idFacultad and aula.edificio_id = edificio.idEdicio and seccion.nrc = imparte.numNRC and imparte.aula_id=aula.idAula and alumno.matricula = ? and imparte.dia=?";
        PreparedStatement ps;
        ResultSet rs;
        conexionBD dg = new conexionBD();
        try{
            ps = dg.conectar().prepareStatement(sql);
            ps.setInt(1, matricula);
            ps.setString(2,dia);
            //ps.setString(2, dia);
            rs = ps.executeQuery();
            if(rs.next()){
                int registros = modeloHorario.getRowCount(); //borrar los registros existentes en la tabla
                for(int i=0; i<registros; i++){
                    modeloHorario.removeRow(0);
                } 
                //llenar la tabla con la nueva informacion
                //meter datos a la table
                String [] celdas = new String [6];
                try{
                    ps = dg.conectar().prepareStatement(sql);
                    ps.setInt(1, matricula);
                    ps.setString(2,dia);
                    //ps.setString(2, dia);
                    rs = ps.executeQuery();
                    while(rs.next()){
                        celdas[0] = rs.getString(1);
                        celdas[1] = rs.getString(2);
                        celdas[2] = rs.getString(3);
                        celdas[3] = rs.getString(4);
                        celdas[4] = rs.getString(5);
                        celdas[5] = rs.getString(6);
                        modeloHorario.addRow(celdas);
                    }
                    dg.desconectar();
                } catch(SQLException e){
                    System.out.println("No se puede llenar la tabla!");
                }
                
            } else{
                JOptionPane.showMessageDialog(null, "No hay clases en el dia "+dia);
            }
            dg.desconectar();
        } catch (SQLException ex) {
            System.out.println("No se pudo ejecutar la consulta");
            System.out.println(ex);
        }
    }
    
    public void horarioTime( int matricula){
        String sql = "select ee.nombre,edificio.nombre, aula.nombre,imparte.dia, imparte.horaInicio, imparte.horaFin from facultad, edificio, aula, imparte, seccion, ee, alumno, programaEducativo, cursa where programaEducativo.facultad_id = facultad.idFacultad and facultad.idFacultad = edificio.facultad_id and aula.edificio_id = edificio.idEdicio and imparte.aula_id = aula.idAula and imparte.numNRC = seccion.NRC and seccion.ee_id = ee.idEE and ee.programaEduactivo_id = programaEducativo.idProgramaEducativo and alumno.matricula = cursa.matricula_alumno and cursa.numNRC = seccion.NRC and alumno.matricula = ? and imparte.horaFin < curdate();";
        PreparedStatement ps;
        ResultSet rs;
        
        conexionBD dg = new conexionBD();
        try{
            ps = dg.conectar().prepareStatement(sql);
            ps.setInt(1, matricula);
            rs = ps.executeQuery();
            if(rs.next()){
                int registros = modeloHorario.getRowCount(); //borrar los registros existentes en la tabla
                for(int i=0; i<registros; i++){
                    modeloHorario.removeRow(0);
                } 
                //llenar la tabla con la nueva informacion
                //meter datos a la table
                String [] celdas = new String [6];
                try{
                    ps = dg.conectar().prepareStatement(sql);
                    ps.setInt(1, matricula);
                    rs = ps.executeQuery();
                    while(rs.next()){
                        celdas[0] = rs.getString(1);
                        celdas[1] = rs.getString(2);
                        celdas[2] = rs.getString(3);
                        celdas[3] = rs.getString(4);
                        celdas[4] = rs.getString(5);
                        celdas[5] = rs.getString(6);
                        modeloHorario.addRow(celdas);
                    }
                    dg.desconectar();
                } catch(SQLException e){
                    System.out.println("No se puede llenar la tabla!");
                }
                
            } else{
                JOptionPane.showMessageDialog(null, "No hay clases pendientes!");
            }
            dg.desconectar();
        } catch (SQLException ex) {
            System.out.println("No se pudo ejecutar la consulta");
            System.out.println(ex);
        }
        
    }
    
    

    private control_pane() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    
  
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        txtSegundoNombre = new javax.swing.JLabel();
        txtPrimerNombre = new javax.swing.JLabel();
        btnCerrarSesion = new javax.swing.JLabel();
        txtApellidoPat = new javax.swing.JLabel();
        txtApellidoMat = new javax.swing.JLabel();
        txtMatricula = new javax.swing.JLabel();
        btnActualizar = new javax.swing.JLabel();
        txtMatricula1 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        tbMiUV = new javax.swing.JTable();
        cmbDias = new javax.swing.JComboBox<>();
        btnSearch = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
        setResizable(false);

        jPanel1.setBackground(new java.awt.Color(255, 255, 255));

        jLabel2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/logocp.png"))); // NOI18N

        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/Forma 1.png"))); // NOI18N

        txtSegundoNombre.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        txtSegundoNombre.setForeground(new java.awt.Color(0, 81, 158));
        txtSegundoNombre.setText("NombreUsuario");

        txtPrimerNombre.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        txtPrimerNombre.setForeground(new java.awt.Color(0, 81, 158));
        txtPrimerNombre.setText("NombreUsuario");

        btnCerrarSesion.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/logout copy (1).png"))); // NOI18N
        btnCerrarSesion.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnCerrarSesion.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnCerrarSesionMouseClicked(evt);
            }
        });

        txtApellidoPat.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        txtApellidoPat.setForeground(new java.awt.Color(0, 81, 158));
        txtApellidoPat.setText("NombreUsuario");

        txtApellidoMat.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        txtApellidoMat.setForeground(new java.awt.Color(0, 81, 158));
        txtApellidoMat.setText("NombreUsuario");

        txtMatricula.setFont(new java.awt.Font("Arial", 0, 16)); // NOI18N
        txtMatricula.setForeground(new java.awt.Color(0, 81, 158));
        txtMatricula.setText("MATRICULA");

        btnActualizar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/clock.png"))); // NOI18N
        btnActualizar.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnActualizar.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnActualizarMouseClicked(evt);
            }
        });

        txtMatricula1.setFont(new java.awt.Font("Arial", 1, 16)); // NOI18N
        txtMatricula1.setForeground(new java.awt.Color(0, 81, 158));
        txtMatricula1.setText("MATRICULA:");

        tbMiUV.setBorder(javax.swing.BorderFactory.createEmptyBorder(0, 0, 0, 0));
        tbMiUV.setFont(new java.awt.Font("Arial", 0, 12)); // NOI18N
        tbMiUV.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {

            }
        ));
        tbMiUV.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        tbMiUV.setGridColor(new java.awt.Color(0, 81, 158));
        tbMiUV.setRowSelectionAllowed(false);
        tbMiUV.setSelectionBackground(new java.awt.Color(3, 153, 51));
        tbMiUV.setSelectionForeground(new java.awt.Color(255, 255, 255));
        jScrollPane1.setViewportView(tbMiUV);

        cmbDias.setFont(new java.awt.Font("Arial", 0, 13)); // NOI18N
        cmbDias.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Lunes", "Martes", "Miercoles", "Jueves", "Viernes" }));
        cmbDias.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        btnSearch.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/search.png"))); // NOI18N
        btnSearch.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        btnSearch.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnSearchMouseClicked(evt);
            }
        });

        jLabel3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/img/Forma 1.png"))); // NOI18N

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGap(12, 12, 12)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel1Layout.createSequentialGroup()
                                        .addComponent(txtPrimerNombre)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                        .addComponent(txtSegundoNombre))
                                    .addGroup(jPanel1Layout.createSequentialGroup()
                                        .addComponent(txtApellidoPat)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                        .addComponent(txtApellidoMat)))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(btnCerrarSesion))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel1)
                                    .addComponent(jLabel3))
                                .addGap(0, 0, Short.MAX_VALUE))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 766, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(btnActualizar)
                        .addGap(6, 6, 6))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(cmbDias, javax.swing.GroupLayout.PREFERRED_SIZE, 185, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnSearch)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtMatricula1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(txtMatricula)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(9, 9, 9)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(txtSegundoNombre)
                                    .addComponent(txtPrimerNombre))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(txtApellidoPat)
                                    .addComponent(txtApellidoMat))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGap(18, 18, 18)
                                .addComponent(btnCerrarSesion)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                        .addComponent(jLabel1))
                    .addComponent(jLabel2))
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addComponent(btnSearch))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(cmbDias, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtMatricula1)
                            .addComponent(txtMatricula))))
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(16, 16, 16)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 298, Short.MAX_VALUE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnActualizar)))
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnCerrarSesionMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnCerrarSesionMouseClicked
        System.exit(0);
    }//GEN-LAST:event_btnCerrarSesionMouseClicked

    private void btnSearchMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnSearchMouseClicked
        int key = matri;
        buscar(key);
    }//GEN-LAST:event_btnSearchMouseClicked

    private void btnActualizarMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnActualizarMouseClicked
        // Actualizar el horario
        horarioTime(matri);
    }//GEN-LAST:event_btnActualizarMouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(control_pane.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(control_pane.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(control_pane.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(control_pane.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new control_pane().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel btnActualizar;
    private javax.swing.JLabel btnCerrarSesion;
    private javax.swing.JLabel btnSearch;
    private javax.swing.JComboBox<String> cmbDias;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable tbMiUV;
    private javax.swing.JLabel txtApellidoMat;
    private javax.swing.JLabel txtApellidoPat;
    private javax.swing.JLabel txtMatricula;
    private javax.swing.JLabel txtMatricula1;
    private javax.swing.JLabel txtPrimerNombre;
    private javax.swing.JLabel txtSegundoNombre;
    // End of variables declaration//GEN-END:variables
}
