/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Tables;

/**
 *
 * @author aguil
 */
public class OtherTable {
    public enum cliente_telefono{
        idCliente,
        idTelefono
    }
    
    public enum clase_clasificacion{
        idClase,
        clasificacion
    }
    
    public enum certificacion_clasificacion{
        idCertificacion,
        clasificacion
    }
    
    public enum historial_hospital{
        idCliente,
        idHistorial,
        hospital
    }
    
    public enum cliente_sesion{
        idCliente,
        idClase,
        idSesion
    }
    
    public enum instructor_certificacion{
        idInstructor,
        idCertificacion,
        validez,
        fechaCertificacion
    }
}
