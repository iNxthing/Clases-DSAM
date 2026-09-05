/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package consumomensual;

/**
 *
 * @author CBN
 */
public class ConsumoMensual {

    /**
     * @param args the command line arguments
     */
    public double Calculo(double consumo, double tarifa, int estrato, String tipo){
        double ValorTarifa;
        
        if (estrato == 1 && tipo.equals("Residencial")){
            tarifa  = tarifa *1;
        }else if (estrato == 2 && tipo.equals("Residencial")){
            tarifa  = tarifa *1.01;
        }else if (estrato == 3 && tipo.equals("Residencial")){
            tarifa  = tarifa *1.02;
        }else if (estrato == 4 && tipo.equals("Residencial")){
            tarifa  = tarifa *1.03;
        }else if (estrato == 5 && tipo.equals("Residencial")){
            tarifa  = tarifa *1.04;
        }else if (estrato == 6 && tipo.equals("Residencial")){
            tarifa  = tarifa *1.05;
            
        }else if (estrato == 1 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.06;
        }else if (estrato == 2 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.07;
        }else if (estrato == 3 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.08;
        }else if (estrato == 4 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.09;
        }else if (estrato == 5 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.1;
        }else if (estrato == 1 && tipo.equals("Comercial")){
            tarifa  = tarifa *1.2;
            
        }else if (estrato == 1 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.3;
        }else if (estrato == 2 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.4;
        }else if (estrato == 3 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.5;
        }else if (estrato == 4 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.6;
        }else if (estrato == 5 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.7;
        }else if (estrato == 6 && tipo.equals("Industrial")){
            tarifa  = tarifa *1.8;
        }
        
        ValorTarifa = (consumo*000.1) * tarifa;
        
        return ValorTarifa;
    }
    
}


