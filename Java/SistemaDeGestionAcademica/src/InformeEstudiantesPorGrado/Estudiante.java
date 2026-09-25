/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package InformeEstudiantesPorGrado;

/**
 *
 * @author Usuario
 */
public class Estudiante {
    private String nombreEstudiante;
    private String gradoEstudiante;

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

    public void setGradoEstudiante(String gradoEstudiante) {
        this.gradoEstudiante = gradoEstudiante;
    }
    
    
    
}
