//
//  ReporteDano.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class ReporteDano{
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var items: [Item] = []
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
    func setItems(item: Item){
        self.items.append(item)
    }
    func getItems() -> [Item]{
        return items
    }
    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }
    func getIdUsuario() -> String{
        return idUsuario!
    }
}
