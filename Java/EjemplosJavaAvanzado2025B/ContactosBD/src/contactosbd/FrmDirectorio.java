/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package contactosbd;

import java.awt.FlowLayout;
import java.awt.Graphics;
import java.awt.Image;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.swing.ImageIcon;
import javax.swing.JTable;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;

/**
 *
 * @author cymaniatico
 */
public class FrmDirectorio extends javax.swing.JFrame {

    /**
     * Creates new form FrmDirectorio
     */
     InfoConexion conexion;
     ArrayList<TipoContacto> listaTipoContacto;
     ArrayList<Directorio> listaContactos;
     boolean bandera = false;
     int contactoSeleccionado;
    public FrmDirectorio() {
        initComponents();
        conexion = new InfoConexion();
        listaTipoContacto = new ArrayList();
        listaContactos= new ArrayList();
        AjustesObjetos.ajustarImagen(lbIcon, "src/img/smm2.png");
        txtNombre.setText("");
        txtTelefono.setText("");       
        btnGuardar.setEnabled(!bandera);
        btnActualizar.setEnabled(bandera);
        
        llenarCombo();
        mostrarInfo();
    }
    
    public void llenarCombo(){
        try(Connection con = DriverManager.getConnection(conexion.getUrl(),
                conexion.getUsername(), conexion.getPassword())){
            comboTipoContacto.removeAllItems();
            comboTipoContacto.addItem("Seleccione");
            listaTipoContacto.clear();
            Statement stm = con.createStatement();
            String query ="call comboContacto()";
            ResultSet rs = stm.executeQuery(query);
            
            while(rs.next()){
                String descripcion = rs.getString("descripcion");
                int id = rs.getInt("id");
                listaTipoContacto.add(new TipoContacto(id, descripcion));
                comboTipoContacto.addItem(descripcion);
            }
            
        }catch(SQLException e){
            
        }
    }
    
    public void guardar(){
        try(Connection con = DriverManager.getConnection(conexion.getUrl(),
                conexion.getUsername(), conexion.getPassword())){
            int posCombo = comboTipoContacto.getSelectedIndex()-1;
            PreparedStatement pstm = con.prepareCall("call guardaRegistro(?,?,?)");
            pstm.setInt(1, listaTipoContacto.get(posCombo).getId());
            pstm.setString(2, txtNombre.getText());
            pstm.setString(3, txtTelefono.getText());
            
            pstm.executeQuery();
            
            JOptionPane.showMessageDialog(rootPane, "Dato Guardado");
            mostrarInfo();
            
        }catch(SQLException e){
            JOptionPane.showMessageDialog(rootPane, e.toString());
        }
    }
    
    public void actualizar(){
        try(Connection con = DriverManager.getConnection(conexion.getUrl(),
                conexion.getUsername(), conexion.getPassword())){
            int posCombo = comboTipoContacto.getSelectedIndex()-1;
            PreparedStatement pstm = con.prepareCall("call actualizarContacto(?,?,?,?)");
            pstm.setInt(1,contactoSeleccionado);
            pstm.setInt(2, listaTipoContacto.get(posCombo).getId());
            pstm.setString(3,txtNombre.getText());
            pstm.setString(4,txtTelefono.getText());
            
            
            int rowAffected= pstm.executeUpdate();
            
            if(rowAffected>0){
                JOptionPane.showMessageDialog(rootPane, "Dato Actualizado");
                bandera = false;
            }else{
                JOptionPane.showMessageDialog(rootPane, "No se pudo realizar la actualizacion");
            }
            
            
            
            
            mostrarInfo();
            
        }catch(SQLException e){
            JOptionPane.showMessageDialog(rootPane, e.toString());
        }
    }
    
    
    public void filtar(){
        try(Connection con = DriverManager.getConnection(conexion.getUrl(),
                conexion.getUsername(), conexion.getPassword())){
            
            DefaultTableModel modelo = new DefaultTableModel();
            
            PreparedStatement pstmn = con.prepareCall("call mostrarRegistroTipo(?)");
            pstmn.setInt(1, listaTipoContacto.get(comboTipoContacto.getSelectedIndex()-1).getId());
            
            ResultSet rs = pstmn.executeQuery();
            ResultSetMetaData rsmt = rs.getMetaData();
            
            for(int i = 1; i<=rsmt.getColumnCount(); i++){
                modelo.addColumn(rsmt.getColumnLabel(i));
            }
            
            while(rs.next()){
                Object[] filas = new Object[rsmt.getColumnCount()];
                for(int i = 1; i<=rsmt.getColumnCount(); i++){
                    filas[i-1] = rs.getObject(i);
                }
                modelo.addRow(filas);
            }
            tableContactos.setModel(modelo);
            
            
    }catch(SQLException e){
            JOptionPane.showMessageDialog(rootPane, e.toString());
        }
    }
    
    public void mostrarInfo(){
        try(Connection con = DriverManager.getConnection(conexion.getUrl(),
                conexion.getUsername(), conexion.getPassword())){
            
            DefaultTableModel modelo = new DefaultTableModel();
            listaContactos.clear();
            
            Statement stm = con.createStatement();
            
            String query = "call mostrarRegistro()";
            ResultSet rs = stm.executeQuery(query);
            ResultSetMetaData rsmt = rs.getMetaData();
            
            for(int i = 1; i<=rsmt.getColumnCount(); i++){
                modelo.addColumn(rsmt.getColumnLabel(i));
            }
            
            while(rs.next()){
                //Para llenar ArrayList
                int id = rs.getInt("id");
                String nombre = rs.getString("Nombre");
                String telefono = rs.getString("Telefono");
                String tipoContacto = rs.getString("Tipo");
                listaContactos.add(new Directorio(id, nombre, telefono, tipoContacto));                
                //Para colocar en table
                Object[] filas = new Object[rsmt.getColumnCount()];
                for(int i = 1; i<=rsmt.getColumnCount(); i++){
                    filas[i-1] = rs.getObject(i);
                }
                modelo.addRow(filas);
            }
            
            tableContactos.setModel(modelo);
            tableContactos.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
            TableColumn column = tableContactos.getColumnModel().getColumn(0);
            tableContactos.removeColumn(column);
            AjustesObjetos.ajustarTabla(tableContactos);
            
            
    }catch(SQLException e){
            JOptionPane.showMessageDialog(rootPane, e.toString());
        }
    }
    
    

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        fondo = new javax.swing.JPanel();
        btnFiltrar = new javax.swing.JButton();
        btnActualizar = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        txtNombre = new javax.swing.JTextField();
        jLabel2 = new javax.swing.JLabel();
        lbIcon = new javax.swing.JLabel();
        txtTelefono = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        comboTipoContacto = new javax.swing.JComboBox<>();
        btnGuardar = new javax.swing.JButton();
        jScrollPane2 = new javax.swing.JScrollPane();
        tableContactos = new javax.swing.JTable();

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPane1.setViewportView(jTable1);

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Contactos");

        fondo.setBackground(new java.awt.Color(255, 51, 102));

        btnFiltrar.setText("Filtrar");
        btnFiltrar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnFiltrarActionPerformed(evt);
            }
        });

        btnActualizar.setText("Actualizar");
        btnActualizar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnActualizarActionPerformed(evt);
            }
        });

        jLabel1.setText("Nombre");

        txtNombre.setText("jTextField1");

        jLabel2.setText("Telefono");

        lbIcon.setText("jLabel4");

        txtTelefono.setText("jTextField2");

        jLabel3.setText("Tipo de contacto");

        comboTipoContacto.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));

        btnGuardar.setText("Guardar");
        btnGuardar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGuardarActionPerformed(evt);
            }
        });

        tableContactos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        tableContactos.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                tableContactosMouseClicked(evt);
            }
        });
        jScrollPane2.setViewportView(tableContactos);

        javax.swing.GroupLayout fondoLayout = new javax.swing.GroupLayout(fondo);
        fondo.setLayout(fondoLayout);
        fondoLayout.setHorizontalGroup(
            fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(fondoLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addComponent(txtNombre, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2)
                    .addComponent(txtTelefono, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel3)
                    .addGroup(fondoLayout.createSequentialGroup()
                        .addComponent(comboTipoContacto, javax.swing.GroupLayout.PREFERRED_SIZE, 112, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(btnGuardar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnFiltrar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(btnActualizar)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 60, Short.MAX_VALUE)
                .addComponent(lbIcon, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(54, 54, 54))
            .addComponent(jScrollPane2)
        );
        fondoLayout.setVerticalGroup(
            fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(fondoLayout.createSequentialGroup()
                .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(fondoLayout.createSequentialGroup()
                        .addGap(22, 22, 22)
                        .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(fondoLayout.createSequentialGroup()
                                .addGap(22, 22, 22)
                                .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                    .addComponent(txtNombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(txtTelefono, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(comboTipoContacto, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(btnGuardar)
                                    .addComponent(btnFiltrar)
                                    .addComponent(btnActualizar)))
                            .addGroup(fondoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                                .addComponent(jLabel1)
                                .addComponent(jLabel2)
                                .addComponent(jLabel3))))
                    .addGroup(fondoLayout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addComponent(lbIcon, javax.swing.GroupLayout.PREFERRED_SIZE, 51, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 537, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(fondo, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(fondo, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnGuardarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGuardarActionPerformed
        // TODO add your handling code here:
        if(!txtNombre.getText().isEmpty()
                && !txtTelefono.getText().isEmpty()
                && comboTipoContacto.getSelectedIndex()>0){
            guardar();
        }else{
            JOptionPane.showMessageDialog(rootPane, "Faltan datos");
        }
    }//GEN-LAST:event_btnGuardarActionPerformed

    private void btnFiltrarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnFiltrarActionPerformed
        // TODO add your handling code here:
        if(comboTipoContacto.getSelectedIndex()>0){
            filtar();
        }else{
            mostrarInfo();
        }
    }//GEN-LAST:event_btnFiltrarActionPerformed

    private void tableContactosMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_tableContactosMouseClicked
        // TODO add your handling code here:
        int filaSeleccionada;
        filaSeleccionada = tableContactos.rowAtPoint(evt.getPoint());
        contactoSeleccionado = listaContactos.get(filaSeleccionada).getId();
        txtNombre.setText(listaContactos.get(filaSeleccionada).getNombre());
        txtTelefono.setText(listaContactos.get(filaSeleccionada).getTelefono());
        for (int i = 0; i < listaTipoContacto.size(); i++) {
            if(listaTipoContacto.get(i).getDescripcion().equals(listaContactos.get(filaSeleccionada).getTipoContacto())){
                comboTipoContacto.setSelectedIndex(i+1);
            }
            
        }
        bandera = true;
        btnGuardar.setEnabled(!bandera);
        btnActualizar.setEnabled(bandera);
    }//GEN-LAST:event_tableContactosMouseClicked

    private void btnActualizarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnActualizarActionPerformed
        // TODO add your handling code here:
        if(!txtNombre.getText().isEmpty()
                && !txtTelefono.getText().isEmpty()
                && comboTipoContacto.getSelectedIndex()>0){
            //guardar();
            actualizar();
            btnGuardar.setEnabled(!bandera);
            btnActualizar.setEnabled(bandera);
        }else{
            JOptionPane.showMessageDialog(rootPane, "Faltan datos");
        }
    }//GEN-LAST:event_btnActualizarActionPerformed

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
            java.util.logging.Logger.getLogger(FrmDirectorio.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(FrmDirectorio.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(FrmDirectorio.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(FrmDirectorio.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new FrmDirectorio().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnActualizar;
    private javax.swing.JButton btnFiltrar;
    private javax.swing.JButton btnGuardar;
    private javax.swing.JComboBox<String> comboTipoContacto;
    private javax.swing.JPanel fondo;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable1;
    private javax.swing.JLabel lbIcon;
    private javax.swing.JTable tableContactos;
    private javax.swing.JTextField txtNombre;
    private javax.swing.JTextField txtTelefono;
    // End of variables declaration//GEN-END:variables
}
