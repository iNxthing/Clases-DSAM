/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sistemadegestionacademica;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Usuario
 */
public class Estudiante {
    private String nombreEstudiante;
    private String gradoEstudiante;
    private List<Notas> notas = new ArrayList<>();
    

    public Estudiante(String nombreEstudiante, String gradoEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
        this.gradoEstudiante = gradoEstudiante;
    }

    public String getNombreEstudiante() {
        return nombreEstudiante;
    }

    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }

    public String getGradoEstudiante() {
        return gradoEstudiante;
    }
    
    public List<Notas> getNotas(){
        return notas;
    }

    public void setGradoEstudiante(String gradoEstudiante) {
        this.gradoEstudiante = gradoEstudiante;
    }
    
    
    public void agregarNota(String asignatura,String periodo,double valor){
        notas.add(new Notas(asignatura,periodo,valor));
        
    }
    
    public double calcularPromedio(){
        double suma = 0;
        if(notas.isEmpty()){
            return 0;
        }else{
            
            for (Notas n : notas) {
                suma +=n.getValor();
                
            }
        }
        return suma/notas.size();
    }
    
    public boolean aprobo(double notaMinima){
        return calcularPromedio() >=notaMinima;
    }
    
    
}
