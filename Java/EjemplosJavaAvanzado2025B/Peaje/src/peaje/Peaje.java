/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package peaje;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 *
 * @author cymaniatico
 */
public class Peaje {

   private String placa;
   private String tipo;
   private String fecha;
   private int valorCobrado;

    public Peaje(String placa, String tipo, int valorCobrado) {
        this.placa = placa;
        this.tipo = tipo;
        this.valorCobrado = valorCobrado;
        fecha = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss")
                .format(Calendar.getInstance().getTime());
    }

    public String getPlaca() {
        return placa;
    }

    public String getTipo() {
        return tipo;
    }

    public String getFecha() {
        return fecha;
    }

    public int getValorCobrado() {
        return valorCobrado;
    }
   
   
    
}
