/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package peaje;

/**
 *
 * @author cymaniatico
 */
public class Vehiculos {
    int id;
    String tipoVehiculo;
    
    public Vehiculos(int id, String tipoVehiculo){
        this.id = id;
        this.tipoVehiculo = tipoVehiculo;
    }
    public int getId() {
        return id;
    }
    public String getTipoVehiculo(){
        return tipoVehiculo;
    }
    
    
}
