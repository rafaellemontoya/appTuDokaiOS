//
//  ReporteEnvio.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/15/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation

class ReporteEnvio{
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var numeroRemision: String
    private var items: [Item] = []
    init() {
        numeroRemision = ""
    }
    func setProyecto(proyecto: Proyecto){
        self.proyecto = proyecto
    }
    func setCliente (cliente: Cliente){
        self.cliente = cliente
    }
    
    func getCliente()-> Cliente{
        return cliente!
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
    func setNumeroRemision(numeroRemision: String){
        self.numeroRemision = numeroRemision
    }
    func getNumeroRemision()-> String{
        return numeroRemision
    }
}
