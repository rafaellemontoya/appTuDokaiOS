//
//  FirebaseDBManager.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirebaseDBManager{
    var db: Firestore!
    static let dbInstance = FirebaseDBManager()
    var nombreReporteBD: String;
    
    private init(){
        
        let settings = FirestoreSettings()
        nombreReporteBD = "";
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        
        // [END setup]
        db = Firestore.firestore()
    }
    
    func obtenerClientes (busquedaParam: String, completion: @escaping (Bool, [Cliente]?)-> Void ){
        let clientsRef = db.collection("clients")
        var clientesArray2: [Cliente] = []
        clientsRef.whereField("nombreBusqueda", isGreaterThan: busquedaParam).getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let cliente = Cliente()
                    if let nombreCliente = document.data()["nombre"]as? String{
                        cliente.nombre = nombreCliente
                    }
                    if let numeroCliente = document.data()["numero"]as? String{
                        cliente.numero = numeroCliente
                    }
                    if let paisCliente = document.data()["pais"]as? String{
                        cliente.pais = paisCliente
                    }
                    cliente.key = document.documentID
                    
                    clientesArray2.append(cliente)
                    
                }
                completion(true, clientesArray2)
                
            }
            
        }

    }
    
    func obtenerItems (busquedaParam: String, completion: @escaping (Bool, [Item]?)-> Void ){
        var itemArray: [Item] = []
        
        db.collection("material").whereField("nombreBusqueda", isGreaterThan: busquedaParam).getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let item = Item(key: "", nombre: "", codigo: "", pais: "")
                    if let nombreItem = document.data()["descripcion"]as? String{
                        item.setNombre(nombre: nombreItem)
                    }
                    if let codigoItem = document.data()["codigo"]as? String{
                        item.setCodigo(codigo: codigoItem)
                    }
                    if let paisItem = document.data()["pais"]as? String{
                        item.setPais( pais: paisItem)
                    }
                    item.setKey(key: document.documentID)
                    
                    itemArray.append(item)
                    
                }
                completion(true, itemArray)
                
            }
            
        }
    }
    
    func obtenerDescripcionDano (busquedaParam: String, completion: @escaping (Bool, [TipoDano]?)-> Void ){
        var itemArray: [TipoDano] = []
        db.collection("damage").whereField("nombreBusqueda", isGreaterThan: busquedaParam).getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let item = TipoDano()
                    if let clasificacionEquipo = document.data()["clasificacionEquipo"]as? String{
                        item.clasificacionEquipo = clasificacionEquipo
                    }
                    if let tipoDano = document.data()["tipoDano"]as? String{
                        item.tipoDano = tipoDano
                    }
                    if let paisItem = document.data()["pais"]as? String{
                        item.pais = paisItem
                    }
                    item.key = document.documentID
                    
                    itemArray.append(item)
                    
                }
                completion(true, itemArray)
                
            }
            
        }
    }
    
    func obtenerProyectos (busquedaParam: String, idCliente: String, completion: @escaping (Bool, [Proyecto]?)-> Void ){
        var array: [Proyecto] = []
        db.collection("projects").whereField("nombreBusqueda", isGreaterThan: busquedaParam).getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let item = Proyecto()
                    if let nombreCliente = document.data()["nombre"]as? String{
                        item.nombre = nombreCliente
                    }
                    if let numeroCliente = document.data()["numero"]as? String{
                        item.numero = numeroCliente
                    }
                    if let paisCliente = document.data()["pais"]as? String{
                        item.pais = paisCliente
                    }
                    item.key = document.documentID
                    item.keyCliente = idCliente
                    array.append(item)
                    
                }
                completion(true, array)
                
            }
            
        }
    }
    
    /*** FUNCIONES GUARDADO DE DEVOLUCION **/
    func guardarReporteDevolucion(reporte: ReporteDevolucion, completion: @escaping (Bool, DocumentReference?)-> Void ){
        
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDevolucion").addDocument(data:[
            "cliente": reporte.getCliente().key,
            "proyecto": reporte.getProyecto().key,
            "fechaCreacion": NSDate().timeIntervalSince1970,
            "idUsuario": reporte.getIdUsuario(),
            "pais": reporte.getPais()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true, ref)
                
                
            }

    }
}
    func guardarItemsReporteDevolucion(item: Item, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDevolucion").document(idReporte).collection("items").document(item.getKey())
        ref?.setData(["unidades": item.getUnidades(),
                      "foto": item.getUrl()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
    }
}
    
    
    func guardarFotosTransporteDevolucion(reporte: ReporteDevolucion, idReporte: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesDevolucion").document(idReporte).updateData([
                                                                         "fotoLicencia": reporte.urlFotoLicencia,
                                                                         "fotoPlacaDelantera": reporte.urlFotoPlacaDelantera,
                                                                         "fotoPlacaTrasera": reporte.urlFotoPlacaTrasera,
                                                                         "fotoTractoTrasera": reporte.urlFotoTractoTrasera,
                                                                         "fotoTractoLateral1": reporte.urlFotoTractoLateral1,
                                                                         "fotoTractoLateral2": reporte.urlFotoTractoLateral2
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    func guardarRemisionesDevolucion(remision: String, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDevolucion").document(idReporte).collection("numeroDevolucion").addDocument(data: [
            
            "remision": remision
            
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
                
                
            }
            
        }
    }
    
    func guardarDocumentosCargaDevolucion(url: String, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDevolucion").document(idReporte).collection("documentosCliente").addDocument(data: [
            
            "foto": url
            
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
                
                
            }
            
        }
    }
    
    
    /*** FUNCIONES GUARDADO DE ENVIO **/
    
    func guardarReporteEnvio(reporte: ReporteEnvio, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesEnvio").addDocument(data: [
                                                                     
            "cliente": reporte.getCliente().key,
            "proyecto": reporte.getProyecto().key,
            "fechaCreacion": NSDate().timeIntervalSince1970,
            "idUsuario": reporte.getIdUsuario(),
            "pais": reporte.getIdPais()
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true, ref)
                
                
            }
            
        }
    }
    func guardarItemsReporteEnvio(item: Item, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesEnvio").document(idReporte).collection("items").document(item.getKey())
        ref?.setData(["unidades": item.getUnidades(),
                      "foto": item.getUrl()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    
    func guardarRemisionesEnvio(remision: String, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesEnvio").document(idReporte).collection("remisiones").addDocument(data: [
            
            "remision": remision
            
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
                
                
            }
            
        }
    }
    
    func guardarDocumentosCargaEnvio(url: String, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesEnvio").document(idReporte).collection("documentosCarga").addDocument(data: [
            
            "foto": url
            
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true)
                
                
            }
            
        }
    }
    
    
    func guardarFotosTransporteEnvio(reporte: ReporteEnvio, idReporte: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesEnvio").document(idReporte).updateData([
            "fotoLicencia": reporte.urlFotoLicencia,
            "fotoPlacaDelantera": reporte.urlFotoPlacaDelantera,
            "fotoPlacaTrasera": reporte.urlFotoPlacaTrasera,
            "fotoTractoTrasera": reporte.urlFotoTractoTrasera,
            "fotoTractoLateral1": reporte.urlFotoTractoLateral1,
            "fotoTractoLateral2": reporte.urlFotoTractoLateral2]){ err in
                                                                                if let err = err {
                                                                                    print("Error updating document: \(err)")
                                                                                    completion(false)
                                                                                } else {
                                                                                    print("Document successfully updated")
                                                                                    completion(true)
                                                                                }
        }
    }
    /*** FUNCIONES GUARDADO DE DAÑO **/
    
    func guardarReporteDano(reporte: ReporteDano, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDano").addDocument(data: [
            
            "cliente": reporte.getCliente().key,
            "proyecto": reporte.getProyecto().key,
            "fechaCreacion": NSDate().timeIntervalSince1970,
            "idUsuario": reporte.getIdUsuario(),
            "pais": reporte.getPais()
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true, ref)
                
                
            }
            
        }
    }
    func guardarItemsReporteDano(item: Item, idReporte: String, completion: @escaping (Bool?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesDano").document(idReporte).collection("items").document(item.getKey())
        ref?.setData(["unidades": item.getUnidades(),
                      "tipoDano": item.getTipoDano().key,
                      "foto": item.getUrl()
            
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }

    
    
    /*** FUNCIONES GUARDADO DE CAPACITACION **/
    
    func guardarReporteCapacitacion(reporte: ReporteCapacitacion, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesCapacitacion").addDocument(data: [
            
            "cliente": reporte.getCliente().key,
            "proyecto": reporte.getProyecto().key,
            "fechaCreacion": NSDate().timeIntervalSince1970,
            "idUsuario": reporte.getIdUsuario(),
            "nombreCurso": reporte.getNombreCurso(),
            "pais": reporte.getPais()
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true, ref)
                
                
            }
            
        }
    }
    func guardarItemsReporteCapacitacion(actividad: ActividadCapacitacion, idReporte: String, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesCapacitacion").document(idReporte).collection("actividades").addDocument(data: [
            "descripcion": actividad.getDescripcion(),
            "foto": actividad.getUrlFoto()])
        { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                            completion(false, nil)
                        } else {
                            print("Document successfully updated")
                            completion(true, ref)
                        }
        }
    }
    
    
    
    
    /*** FUNCIONES GUARDADO DE SEGUIMIENTO **/
    
    func guardarReporteSeguimiento(reporte: ReporteSeguimiento, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesSeguimiento").addDocument(data: [
            
            "cliente": reporte.getCliente().key,
            "proyecto": reporte.getProyecto().key,
            "fechaCreacion": NSDate().timeIntervalSince1970,
            "idUsuario": reporte.getIdUsuario(),
            "pais": reporte.getPais()
            ]
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(false, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(true, ref)
                
                
            }
            
        }
    }
    func guardarItemsReporteSeguimiento(actividad: ActividadCapacitacion, idReporte: String, completion: @escaping (Bool, DocumentReference?)-> Void ){
        var ref: DocumentReference? = nil
        ref = db.collection("reportesSeguimiento").document(idReporte).collection("actividades").addDocument(data: [
            "descripcion": actividad.getDescripcion(),
            "foto": actividad.getUrlFoto()])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false, nil)
            } else {
                print("Document successfully updated")
                completion(true, ref)
            }
        }
    }
    
    
    
}
