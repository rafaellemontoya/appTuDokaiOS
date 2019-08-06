//
//  ResumenItemsDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ResumenItemsDevolucionVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    var reporteDevolucion: ReporteDevolucion?
    
    @IBOutlet weak var fotosTV: UITableView!
    
    
    @IBAction func finalizarBTN(_ sender: Any) {
        
        let alert = UIAlertController(title: "¿Estás seguro de querer terminar el reporte?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            //Guardar info
            
            FirebaseDBManager.dbInstance.guardarReporteDevolucion(reporte: self.reporteDevolucion!){
                (respuesta, referencia) in
                if(respuesta){
                    self.reporteDevolucion?.setIdReporte(idReporte: referencia!.documentID)
                    self.guardarInfoTransporte(idReporte: (referencia?.documentID)!)
                    }
                }
   
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reporteDevolucion!.getItems()[section].getPhotos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = fotosTV.dequeueReusableCell(withIdentifier: "celdaItem") as! FotosResumenTableViewCell
        cell.resumenItemsDevolucion = self
        
        cell.agregarCelda(image:  (self.reporteDevolucion!.getItems()[indexPath.section].getPhotos()[indexPath.row]))
        
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reporteDevolucion!.getItems().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerResumenCell") as! HeaderResumenItemsTableViewCell
        cell.agregarHeader(item: self.reporteDevolucion!.getItems()[section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerResumenCell")
        return cell?.bounds.height ?? 44
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        fotosTV.dataSource = self
        fotosTV.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fotosTransporteSegue"){
//            let receiver = segue.destination as! FotosTransporteVC
//            receiver.reporteDevolucion = self.reporteDevolucion!
        }
    }
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    func perfomZoomInForStartingImageView(startingImageView: UIImageView){
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.black
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow{
            
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            
            
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            let height = startingFrame!.height / startingFrame!.width * keyWindow.frame.width
            UIView.animate(withDuration: 0.5) {
                self.blackBackgroundView!.alpha = 1
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
                
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer)  {
        
        
        if let zoomOutImageView = tapGesture.view{
            
            UIView.animate(withDuration: 0.5, animations: {
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }) { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            }
            
        }
        
        
    }
    func eliminarFoto(cell: FotosResumenTableViewCell){
        guard let indexPath = self.fotosTV.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar esta foto?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.reporteDevolucion!.getItems()[indexPath.section].eliminarFoto(foto: indexPath.row)
            self.fotosTV.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func guardarInfoTransporte(idReporte: String){
        subirFotosTransporte(item: (self.reporteDevolucion?.getFotoPlaca())!, idReporte: idReporte){
            (respuesta, url) in
            if(respuesta){
                self.reporteDevolucion?.setUrlfotoPlaca(url: url!)
                
                self.subirFotosTransporte(item: (self.reporteDevolucion?.getFotoTracto())!, idReporte: idReporte){
                    (respuesta, url) in
                    if(respuesta){
                        self.reporteDevolucion?.seturlfotoTracto(url: url!)
                        
                        self.subirFotosTransporte(item: (self.reporteDevolucion?.getFotoLicencia())!, idReporte: idReporte){
                            (respuesta, url) in
                            if(respuesta){
                                self.reporteDevolucion?.setUrlfotoLicencia(url: url!)
                                
                                self.subirFotosTransporte(item: (self.reporteDevolucion?.getFotoDocumentoDevolucion())!, idReporte: idReporte){
                                    (respuesta, url) in
                                    if(respuesta){
                                        self.reporteDevolucion?.setUrlfotoDocumentoDevolucion(url: url!)
                                        FirebaseDBManager.dbInstance.guardarFotosTransporteDevolucion(reporte: self.reporteDevolucion!, idReporte: idReporte){
                                            (respuesta) in
                                            if(respuesta!){
                                                self.guardarItems(items: (self.reporteDevolucion?.getItems())!, idReporte: idReporte)
                                            }
                                        }
                                        
                                        
                                    }//error subir Documento
                                }
                                
                            }//error subir licencia
                        }
                    }//error subir tracto
                }
            }//Errror subir placa
        }
        subirFotosTransporte(item: (self.reporteDevolucion?.getFotoPlaca())!, idReporte: idReporte){
            (respuesta, url) in
            if(respuesta){
                self.reporteDevolucion?.setUrlfotoPlaca(url: url!)
                
                
            }
        }
    }
    func guardarItems(items: [Item], idReporte: String){
        var flag = 0;
        for item in items{
            FirebaseDBManager.dbInstance.guardarItemsReporteDevolucion(item: item, idReporte: idReporte){
                (respuesta) in
                //subo fotos
                self.subirFotos(items: item.getPhotos(), idReporte: idReporte, idItem: item.getKey()){
                    (respuesta) in
                    if(respuesta!){
                        flag+=1;
                        if(flag == items.count){
                            let alert = UIAlertController(title: "¡Reporte creado exitosamente!", message: "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                                //regreso a la pantalla anterior
                                self.performSegue(withIdentifier: "menuPrincipalDevolucionSegue", sender: self)
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                    }
                }
            }
        }
    }
    func subirFotos(items: [UIImage], idReporte: String, idItem: String,completion: @escaping (Bool?)-> Void ){
        var flag = 0;
        for item in items{
            
            StorageManager.dbInstance.subirFoto(idUsuario: (self.reporteDevolucion?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
                (respuesta, url) in
                if (respuesta){
                    //actualizar fotos en bd
                    FirebaseDBManager.dbInstance.guardarFotosItemsReporteDevolucion(item: idItem, idReporte: idReporte, url: url!){
                        (respuestaGuardar) in
                        if (respuestaGuardar!){
                            flag+=1
                            if(flag == items.count){
                                completion(true)
                            }
                            
                        }
                    }
                }
            }

        }//for
    
    }
    
    func subirFotosTransporte(item: UIImage, idReporte: String,completion: @escaping (Bool,String?)-> Void ){
        
        
            
            StorageManager.dbInstance.subirFoto(idUsuario: (self.reporteDevolucion?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
                (respuesta, url) in
                if (respuesta){
                    //actualizar fotos en bd
                    
                   completion(true, url)
                }
            }
            
        
        
    }
    
    
}

