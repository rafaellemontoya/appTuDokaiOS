//
//  ReporteSeguimiento.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
class ReporteSeguimiento {
    private var idReporte: String
    private var cliente: Cliente
    private var proyecto: Proyecto
    private var items: [ActividadCapacitacion] = []
    private var idUsuario: String
    private var pais: String
    var nombreUsuario: String
    var emailUsuario: String
    init(){
        pais = ""
        idReporte = ""
        idUsuario = ""
        emailUsuario = "usuario@email.com"
        nombreUsuario = "Nombre Usuario"
        cliente = Cliente()
        proyecto = Proyecto()
        
    }
    func setProyecto(proyecto: Proyecto){
        self.proyecto = proyecto
    }
    func setCliente (cliente: Cliente){
        self.cliente = cliente
    }
    
    func getCliente()-> Cliente{
        
        return cliente
    }
    
    func getProyecto() -> Proyecto{
        return proyecto
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
        return idUsuario
    }
    

    func setPais(pais: String){
        self.pais = pais
    }
    func getPais() -> String{
        return pais
    }
    func setIdReporte(idReporte: String){
        self.idReporte = idReporte
    }
    func getIdReporte()->String{
        return idReporte
    }
}
