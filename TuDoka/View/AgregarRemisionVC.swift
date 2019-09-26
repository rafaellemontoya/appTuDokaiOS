//
//  AgregarRemisionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class AgregarRemisionVC: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {

    
    
    var reporte: ReporteEnvio?
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var tableViewFotos: UITableView!
    
    

    @IBOutlet weak var numeroRemisionTF: UITextField!
    
    
    
    @IBAction func agregarRemisionBTN(_ sender: Any) {
        if (numeroRemisionTF.text == ""){
            let alert = UIAlertController(title: "No puedes agregar un número de remisión vacío", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //regreso a la pantalla anterior
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            reporte?.listaRemision.append(numeroRemisionTF.text!)
            self.tableViewFotos.reloadData()
            numeroRemisionTF.text = ""
        }
        
    }
    
    
    @IBAction func continuarBTN(_ sender: Any) {
       
            //Guardar info
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            
            self.activityIndicator.color=UIColor.black
            self.activityIndicator.backgroundColor = UIColor.red
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            //Guardar info
            FirebaseDBManager.dbInstance.guardarReporteEnvio(reporte: self.reporte!){
                (respuesta, referencia) in
                if(respuesta){
                    self.reporte?.setIdReporte(idReporte: referencia!.documentID)
                    self.guardarInfoTransporte(idReporte: (referencia?.documentID)!)
                }
            }
            
            
           
    }
    
    @IBAction func cancelarBTN(_ sender: Any) {
        _=self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewFotos.dataSource = self
        tableViewFotos.delegate = self
        delegarTF()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "enviarCorreosEnvioS"){
            let receiver = segue.destination as! EnviarCorreoEnvioViewController
            receiver.reporte = self.reporte!
        }
    }
    func eliminarItem(cell: RemisionTableViewCell){
        guard let indexPath = self.tableViewFotos.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar este item?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            self.reporte!.listaRemision.remove (at: indexPath.row)
            self.tableViewFotos.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.reporte?.listaRemision.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewFotos.dequeueReusableCell(withIdentifier: "cellR") as! RemisionTableViewCell
        cell.agregarRemision = self
        
        cell.agregarCelda(value:  (self.reporte!.listaRemision [indexPath.row]))
        
        
        
        
        return cell
    }
    func guardarInfoTransporte(idReporte: String){
        
        //placa trasera
        subirFotosTransporte(item: (self.reporte?.fotoPlacaTrasera)!, idReporte: idReporte){
            (respuesta, url) in
            if(respuesta){
                self.reporte?.urlFotoPlacaTrasera = url!
                
                //Placa delantera
                self.subirFotosTransporte(item: (self.reporte?.fotoPlacaDelantera)!, idReporte: idReporte){
                    (respuesta, url) in
                    if(respuesta){
                        self.reporte?.urlFotoPlacaDelantera = url!
                        
                        //tracto trasera
                        self.subirFotosTransporte(item: (self.reporte?.fotoTractoTrasera)!, idReporte: idReporte){
                            (respuesta, url) in
                            if(respuesta){
                                self.reporte?.urlFotoTractoTrasera = url!
                                
                                //Tracto lateral 1
                                self.subirFotosTransporte(item: (self.reporte?.fotoTractoLateral1)!, idReporte: idReporte){
                                    (respuesta, url) in
                                    if(respuesta){
                                        self.reporte?.urlFotoTractoLateral1 = url!
                                        
                                        //tracto lateral 2
                                        self.subirFotosTransporte(item: (self.reporte?.fotoTractoLateral2)!, idReporte: idReporte){
                                            (respuesta, url) in
                                            if(respuesta){
                                                self.reporte?.urlFotoTractoLateral2 = url!
                                                
                                                //licencia
                                                self.subirFotosTransporte(item: (self.reporte?.fotoLicencia)!, idReporte: idReporte){
                                                    (respuesta, url) in
                                                    if(respuesta){
                                                        self.reporte?.urlFotoLicencia = url!
                                                        
                                                        FirebaseDBManager.dbInstance.guardarFotosTransporteEnvio(reporte: self.reporte!, idReporte: idReporte){
                                                            (respuesta) in
                                                            if(respuesta!){
                                                                
                                                                //Listas de carga
                                                                self.guardarListasCarga(items: self.reporte!.listaCarga, idReporte: idReporte){
                                                                    (respuesta) in
                                                                    if(respuesta){
                                                                        self.guardarRemision(remisiones: self.reporte!.listaRemision, idReporte: idReporte)
                                                                        self.guardarItems(items: (self.reporte?.getItems())!, idReporte: idReporte)
                                                                    }else{
                                                                        
                                                                    }
                                                                }
                                                                
                                                            }//error al guardar fotos en bd
                                                        }// actualizar en bd
                                                        
                                                    }//error licencia
                                                }
                                            }//error lateral 2
                                        }
                                        
                                    }//error lateral 1
                                }
                                
                            }//error tracto trasera
                        }
                    }//error placa delantera
                }
            }//Errror subir placa trasera
        }
        
    }
    func guardarRemision(remisiones: [String], idReporte: String){
        
        for item in remisiones{
            //subo fotos
            
            
            
            FirebaseDBManager.dbInstance.guardarRemisionesEnvio(remision: item, idReporte: idReporte){
                (respuesta) in
                
            }
            
        }
        
        
    }
    
    func guardarItems(items: [Item], idReporte: String){
        var flag = 0;
        for item in items{
            //subo fotos
            self.subirFotos(item: item.getPhotos(), idReporte: idReporte, idItem: item.getKey()){
                (respuesta, url) in
                if(respuesta){
                    item.addUrl(url: url)
                    
                    FirebaseDBManager.dbInstance.guardarItemsReporteEnvio(item: item, idReporte: idReporte){
                        (respuesta) in
                        flag+=1;
                        if(flag == items.count){
                            UIApplication.shared.endIgnoringInteractionEvents()
                            self.activityIndicator.stopAnimating()
                            let alert = UIAlertController(title: "¡Reporte creado exitosamente!", message: "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                                //regreso a la pantalla anterior
                                self.performSegue(withIdentifier: "enviarCorreosEnvioS", sender: self)
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }//flag
                    }
                    
                }else{
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "¡Error al crear el reporte!", message: "Revisa tu conexión a internet e intentalo nuevamente", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                        //regreso a la pantalla anterior
                        
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        }
    }
    func guardarListasCarga(items: [UIImage], idReporte: String,completion: @escaping (Bool)-> Void ){
        var flag = 0;
        for item in items{
            //subo fotos
            self.subirFotos(item: item, idReporte: idReporte, idItem: ""){
                (respuesta, url) in
                if(respuesta){
                    self.reporte!.urlListaCarga.append(url)
                    
                    FirebaseDBManager.dbInstance.guardarDocumentosCargaEnvio(url: url, idReporte: idReporte){
                        (respuesta) in
                        flag+=1;
                        if(flag == items.count){
                            
                            completion(true)
                        }//flag
                    }
                    
                }else{
                    completion(false)
                    
                }
            }
        }
    }
    
    func subirFotos(item: UIImage, idReporte: String, idItem: String,completion: @escaping (Bool, String)-> Void ){
        
        
        
        StorageManager.dbInstance.subirFoto(idUsuario: (self.reporte?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
            (respuesta, url) in
            if (respuesta){
                //actualizar fotos en bd
                completion(true, url!)
                
            }else{
                completion(false, "")
                
            }//error al subir foto
        }
        
        
    }
    
    func subirFotosTransporte(item: UIImage, idReporte: String,completion: @escaping (Bool,String?)-> Void ){
        
        StorageManager.dbInstance.subirFoto(idUsuario: (self.reporte?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
            (respuesta, url) in
            if (respuesta){
                //actualizar fotos en bd
                
                completion(true, url)
            }else{
                completion(false,nil)
            }//error al subir fotos transporte
        }
        
        
        
    }
    
    func delegarTF(){
        self.numeroRemisionTF.delegate = self
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        numeroRemisionTF.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

}
