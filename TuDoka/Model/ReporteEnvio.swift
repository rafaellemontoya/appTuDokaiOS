//
//  ReporteEnvio.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/15/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class ReporteEnvio{
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var numeroRemision: String
    private var items: [Item] = []
    private var fotoLicencia: UIImage?
    private var fotoPlaca: UIImage?
    private var fotoTracto: UIImage?
    
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
    func setFotoLicencia(fotoLicencia: UIImage){
        self.fotoLicencia = fotoLicencia
    }
    func getFotoLicencia() -> UIImage{
        return fotoLicencia!
    }
    func setFotoPlaca(fotoPlaca: UIImage){
        self.fotoPlaca = fotoPlaca
    }
    func getFotoPlaca() -> UIImage{
        return fotoPlaca!
    }
    func setFotoTracto(fotoTracto: UIImage){
        self.fotoTracto = fotoTracto
    }
    func getFotoTracto() -> UIImage{
        return fotoTracto!
    }
    
    
    
    
}
