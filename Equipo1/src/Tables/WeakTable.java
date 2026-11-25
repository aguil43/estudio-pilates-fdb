/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Tables;

/**
 *
 * @author aguil
 */
public class WeakTable {
    public enum historial_medico{
        idCliente,
        id,
        descripcion,
        fechaUltimaAct,
        prNom,
        sgNom,
        apPat,
        apMat
    }

    public enum visita{
        idCliente,
        id,
        fechaVisita,
        duracion
    }

    public enum reservacion{
        idCliente,
        id,
        fechaReserva,
        horaInicio,
        horaFin,
        idClienteGenerador,
        idGeneradora,
        idSucursal,
        num
    }

    public enum sala{
        idSucursal,
        num,
        estado,
        fechaUltimoUso
    }

    public enum mantenimiento{
        idMaquina,
        folio,
        fechaMantenimiento,
        horaInicio,
        horaFin
    }

    public enum playlist{
        idSucursal,
        id,
        nombre,
        cantidadCanciones,
        fechaReproduccion
    }

    public enum sesion{
        idClase,
        id,
        fecha,
        numAsistentes
    }
}
