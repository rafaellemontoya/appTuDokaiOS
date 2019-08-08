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
    private var idReporte: String
    private var cliente: Cliente
    private var proyecto: Proyecto
    private var numeroRemision: String
    private var items: [Item] = []
    var fotoLicencia: UIImage?
    var fotoPlacaDelantera: UIImage?
    var fotoPlacaTrasera: UIImage?
    var fotoTractoLateral1: UIImage?
    var fotoTractoLateral2: UIImage?
    var fotoTractoTrasera: UIImage?
    private var idUsuario: String
    private var pais: String
    var urlFotoLicencia: String
    var urlFotoPlacaDelantera: String
    var urlFotoPlacaTrasera: String
    var urlFotoTractoLateral1: String
    var urlFotoTractoLateral2: String
    var urlFotoTractoTrasera: String
    
    init() {
        idReporte = ""
        numeroRemision = ""
        cliente = Cliente()
        proyecto = Proyecto()
        numeroRemision = ""
        items = []
        idUsuario = ""
        pais = ""
        urlFotoLicencia = ""
        urlFotoPlacaDelantera = ""
        urlFotoPlacaTrasera = ""
        urlFotoTractoLateral1 = ""
        urlFotoTractoLateral2 = ""
        urlFotoTractoTrasera = ""
        
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
    
    
    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }
    func getIdUsuario() -> String{
        return idUsuario
    }
    func setPais(idPais: String){
        self.pais = idPais
    }
    func getIdPais() -> String{
        return pais
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
