/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Enum.java to edit this template
 */
package Tables;

/**
 *
 * @author aguil
 */
public class StrongTable {
    public enum persona{
        id,
        prNom,
        sgNom,
        apPat,
        apMat,
        fechaNacimiento
    }

    public enum membresia{
        id,
        tipo,
        costoMensual
    }

    public enum sucursal{
        id,
        nombreSucursal,
        calle,
        num,
        col,
        cp,
        cd
    }

    public enum maquina{
        id,
        modelo,
        marca,
        idSucursal,
        numSala
    }

    public enum clase{
        id,
        nombre,
        horario,
        idInstructor
    }

    public enum certificacion{
        id,
        nombre
    }

    public enum cliente{
        idPersona,
        fechaRegistro,
        idMembresia,
        duracion,
        fechaAdquisicion,
        idReferente
    }

    public enum empleado{
        idPersona,
        fechaContrato,
        idSupervisor
    }

    public enum instructor{
        idPersona,
        telefono,
        correo,
        horario
    }

    public enum recepcionista{
        idPersona,
        turno,
        correo,
        idSucursal
    }
}
