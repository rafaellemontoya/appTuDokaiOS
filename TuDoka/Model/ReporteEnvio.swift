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
    init() {
        
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
}
