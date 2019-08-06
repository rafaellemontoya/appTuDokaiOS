//
//  ReporteSeguimiento.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
class ReporteSeguimiento {
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var nombreCurso: String?
    private var items: [ActividadCapacitacion] = []
    private var idUsuario: String?
    
    init(){
        
    }
    func setProyecto(proyecto: Proyecto){
        self.proyecto = proyecto
    }
    func setCliente (cliente: Cliente){
        self.cliente = cliente
    }
    
    func getCliente()-> Cliente{
        guard let clienteTmp = cliente else {
            return Cliente(key: "", nombre: "", numero: "", pais: "")
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
    
}
