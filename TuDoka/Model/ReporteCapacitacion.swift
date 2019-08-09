//
//  ReporteCapacitacion.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation


class ReporteCapacitacion{
    private var idReporte: String
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var nombreCurso: String?
    private var items: [ActividadCapacitacion] = []
    private var idUsuario: String?
    private var pais: String?
    var nombreUsuario: String
    var emailUsuario: String
    
    init(){
        idReporte = ""
        emailUsuario = "usuario@email.com"
        nombreUsuario = "Nombre Usuario"
    }
    func setProyecto(proyecto: Proyecto){
        self.proyecto = proyecto
    }
    func setCliente (cliente: Cliente){
        self.cliente = cliente
    }
    
    func getCliente()-> Cliente{
        guard let clienteTmp = cliente else {
            return Cliente()
        }
        return clienteTmp
    }
    
    func getProyecto() -> Proyecto{
        return proyecto!
    }
    func setItems(item: ActividadCapacitacion){
        self.items.append(item)
    }
    func getItems() -> [ActividadCapacitacion]{
        return items
    }
    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }
    func getIdUsuario() -> String{
        return idUsuario!
    }
    
    func setNombreCurso(nombreCurso: String){
        self.nombreCurso = nombreCurso
    }
    func getNombreCurso() -> String{
        return nombreCurso!
    }
    func setPais(pais: String){
        self.pais = pais
    }
    func getPais() -> String{
        return pais!
    }
    func setIdReporte(idReporte: String){
        self.idReporte = idReporte
    }
    func getIdReporte()->String{
        return idReporte
    }
    func eliminarItem(id: Int){
        
        self.items.remove(at: id)
        
    }
}
