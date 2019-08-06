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
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    
    func obtenerClientes (completion: @escaping (Bool, [Cliente]?)-> Void ){
        var clientesArray: [Cliente] = []
        db.collection("clients").getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let cliente = Cliente(key: "", nombre: "", numero: "", pais: "")
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
                    
                    clientesArray.append(cliente)
                    
                }
                completion(true, clientesArray)
                
            }
            
        }
    }
    
    func obtenerItems (completion: @escaping (Bool, [Item]?)-> Void ){
        var itemArray: [Item] = []
        db.collection("clients").getDocuments(){(querySnapshot, err) in
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
    
    func obtenerProyectos (idCliente: String, completion: @escaping (Bool, [Proyecto]?)-> Void ){
        var array: [Proyecto] = []
        db.collection("projects").getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error obteniendo documentos \(err)")
                completion(false, nil)
            }else{
                
                for document in querySnapshot!.documents{
                    let item = Proyecto(key: "", nombre: "", numero: "", pais: "", keyCliente: idCliente)
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
        ref?.setData(["unidades": item.getUnidades()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
    }
}
    func guardarFotosItemsReporteDevolucion(item: String, idReporte: String,url: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesDevolucion").document(idReporte).collection("items").document(item).collection("fotos").addDocument(data: ["url" : url]){ err in
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
        
        db.collection("reportesDevolucion").document(idReporte).updateData(["fotoDocumentoDevolucion" : reporte.getUrlfotoDocumentoDevolucion(),
                                                                         "fotoLicencia": reporte.getUrlfotoLicencia(),
                                                                         "fotoPlaca": reporte.getUrlfotoPlaca(),
                                                                         "fotoTracto": reporte.getUrlfotoTracto()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
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
        ref?.setData(["unidades": item.getUnidades()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    func guardarFotosItemsReporteEnvio(item: String, idReporte: String,url: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesEnvio").document(idReporte).collection("items").document(item).collection("fotos").addDocument(data: ["url" : url]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    func guardarFotosTransporteEnvio(reporte: ReporteEnvio, idReporte: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesEnvio").document(idReporte).updateData([
                                                                            "fotoLicencia": reporte.getUrlfotoLicencia(),
                                                                            "fotoPlaca": reporte.getUrlfotoPlaca(),
                                                                            "fotoTracto": reporte.getUrlfotoTracto()]){ err in
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
                      "descripcion": item.getDescripcionDano()]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    func guardarFotosItemsReporteDano(item: String, idReporte: String,url: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesDano").document(idReporte).collection("items").document(item).collection("fotos").addDocument(data: ["url" : url]){ err in
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
        ref = db.collection("reportesCapacitacion").document(idReporte).collection("actividades").addDocument(data: ["descripcion": actividad.getDescripcion()])
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
    func guardarFotosItemsReporteCapacitacion(item: String, idReporte: String,url: String, completion: @escaping (Bool?)-> Void ){
        
        db.collection("reportesCapacitacion").document(idReporte).collection("actividades").document(item).collection("fotos").addDocument(data: ["url" : url]){ err in
            if let err = err {
                print("Error updating document: \(err)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    
    
}
