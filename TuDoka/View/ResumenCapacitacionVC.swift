//
//  ResumenCapacitacionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ResumenCapacitacionVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    var reporte: ReporteCapacitacion?
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var fotosTV: UITableView!
    
    @IBAction func nuevoItemBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "nuevoItemSegue", sender: self)
    }
    
    @IBAction func finalizarBTN(_ sender: Any) {
        
        let alert = UIAlertController(title: "¿Estás seguro de querer terminar el reporte?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            //Guardar info
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            
            self.activityIndicator.color=UIColor.black
            self.activityIndicator.backgroundColor = UIColor.red
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            
            //Guardar info
            FirebaseDBManager.dbInstance.guardarReporteCapacitacion(reporte: self.reporte!){
                (respuesta, referencia) in
                if(respuesta){
                    self.reporte?.setIdReporte(idReporte: referencia!.documentID)
                    self.guardarActividades(items: (self.reporte?.getItems())!, idReporte: referencia!.documentID)
                }
            }

            
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = fotosTV.dequeueReusableCell(withIdentifier: "celdaItem") as! FotosResumenTableViewCell
        cell.resumenCapacitacion = self
        
        cell.agregarCelda(image:  (self.reporte!.getItems()[indexPath.section].getPhotos()))
        
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reporte!.getItems().count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerResumenCell") as! HeaderResumenItemsTableViewCell
        cell.agregarHeader(item: self.reporte!.getItems()[section])
        
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
        if(segue.identifier == "enviarCorreosCapacitacionSegue"){
            let receiver = segue.destination as! EnviarCorreosCapacitacionVC
            receiver.reporte = self.reporte!
        }
        else if ( segue.identifier == "nuevoItemSegue"){
            let receiver = segue.destination as! ItemsCapacitacionVC
            receiver.reporte = self.reporte!
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
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar este item?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            self.reporte!.eliminarItem (id: indexPath.section)
            self.fotosTV.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    func guardarActividades(items: [ActividadCapacitacion], idReporte: String){
        var flag = 0;
        for item in items{
            //subo fotos
            self.subirFotos(item: item.getPhotos(), idReporte: idReporte){
                (respuesta, url) in
                if(respuesta){
                    item.setUrlFotos(urls: url)
                    FirebaseDBManager.dbInstance.guardarItemsReporteCapacitacion(actividad: item, idReporte: idReporte){
                        (respuesta, referencia) in
                        
                        flag+=1;
                        if(flag == items.count){
                            UIApplication.shared.endIgnoringInteractionEvents()
                            self.activityIndicator.stopAnimating()
                            let alert = UIAlertController(title: "¡Reporte creado exitosamente!", message: "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                                //regreso a la pantalla anterior
                                self.performSegue(withIdentifier: "enviarCorreosCapacitacionSegue", sender: self)
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        
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
    func subirFotos(item: UIImage, idReporte: String,completion: @escaping (Bool, String)-> Void ){
        
        StorageManager.dbInstance.subirFoto(idUsuario: (self.reporte?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
            (respuesta, url) in
            if (respuesta){
                completion(true, url!)
                
            }else{
                completion(false, "")
            }
        }
        
    }
    
}

