//
//  ReporteDevolucion.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/29/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import UIKit

class ReporteDevolucion {
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var items: [Item] = []
    private var fotoLicencia: UIImage?
    private var fotoPlaca: UIImage?
    private var fotoTracto: UIImage?
    private var fotoDocumentoDevolucion: UIImage?
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
    func setFotoLicencia(fotoLicencia: UIImage){
        self.fotoLicencia = fotoLicencia
    }
    func getFotoLicencia() -> UIImage{
        return fotoLicencia!
    }
    func setFotoDocumentoDevolucion(fotoDocumentoDevolucion: UIImage){
        self.fotoDocumentoDevolucion = fotoDocumentoDevolucion
    }
    func getFotoDocumentoDevolucion() -> UIImage{
        return fotoDocumentoDevolucion!
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
    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }
    func getIdUsuario() -> String{
        return idUsuario!
    }
    
    
}
