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
    private var cliente: Cliente?
    private var proyecto: Proyecto?
    private var numeroRemision: String
    private var items: [Item] = []
    private var fotoLicencia: UIImage?
    private var fotoPlaca: UIImage?
    private var fotoTracto: UIImage?
    private var idUsuario: String?
    private var pais: String?
    private var urlfotoLicencia: String?
    private var urlfotoPlaca: String?
    private var urlfotoTracto: String?
    
    init() {
        idReporte = ""
        numeroRemision = ""
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
    
    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }
    func getIdUsuario() -> String{
        return idUsuario!
    }
    func setPais(idPais: String){
        self.pais = idPais
    }
    func getIdPais() -> String{
        return pais!
    }
    func setUrlfotoLicencia(url: String){
        self.urlfotoLicencia = url
    }
    func getUrlfotoLicencia() -> String{
        return urlfotoLicencia!
    }
    func seturlfotoTracto(url: String){
        self.urlfotoTracto = url
    }
    func getUrlfotoTracto() -> String{
        return urlfotoTracto!
    }
    func setUrlfotoPlaca(url: String){
        self.urlfotoPlaca = url
    }
    func getUrlfotoPlaca() -> String{
        return urlfotoPlaca!
    }
    func setIdReporte(idReporte: String){
        self.idReporte = idReporte
    }
    func getIdReporte()->String{
        return idReporte
    }
  
    
    
}
