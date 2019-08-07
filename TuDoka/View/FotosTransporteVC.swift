//
//  FotosTransporteVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/19/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class FotosTransporteVC: UIViewController,UINavigationControllerDelegate {
    
    var reporte: ReporteEnvio?
    var imagePicker: UIImagePickerController!
    var btnSeleccionado: String?
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    @IBAction func continuarBTN(_ sender: Any) {
        let alert = UIAlertController(title: "¿Quiéres agregar un número de remisión?", message: "Puedes agregarlo más tarde", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Agregar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.performSegue(withIdentifier: "agregarRemisionSegue", sender: self)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Finalizar reporte", comment: "Default action"), style: .default, handler: { _ in
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
            FirebaseDBManager.dbInstance.guardarReporteEnvio(reporte: self.reporte!){
                (respuesta, referencia) in
                if(respuesta){
                    self.reporte?.setIdReporte(idReporte: referencia!.documentID)
                    self.guardarInfoTransporte(idReporte: (referencia?.documentID)!)
                }
            }
            
      
           // self.performSegue(withIdentifier: "menuPrincipalSegue", sender: self)
            
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBOutlet weak var licenciaIV: UIImageView!
    
    
    @IBAction func licenciaBTN(_ sender: UIButton) {
        btnSeleccionado = "fotoLicencia"
        imageSource()
        
        
    }
    
    
    
    @IBOutlet weak var placaIV: UIImageView!
    
    @IBAction func placaBTN(_ sender: Any) {
        btnSeleccionado = "fotoPlaca"
        imageSource()
    }
    
    @IBOutlet weak var tractoIV: UIImageView!
    
    @IBAction func tractoBTN(_ sender: Any) {
        btnSeleccionado = "fotoTracto"
        imageSource()
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imageSource(){
        let alert = UIAlertController(title: "¿Quiéres tomar una nueva foto o seleccionar de tu galería?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Tomar foto", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.selectImageFrom(.camera)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Seleccionar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.selectImageFrom(.photoLibrary)
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "agregarRemisionSegue"){
            let receiver = segue.destination as! AgregarRemisionVC
            receiver.reporteEnvio = self.reporte!
        }else if (segue.identifier == "menuPrincipalSegue"){
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}

extension FotosTransporteVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print ("hola desde extension")
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        //self.reporteEnvio!.getItems().last?.addPhoto(foto: selectedImage)
        switch btnSeleccionado {
        case "fotoLicencia":
            self.reporte!.fotoLicencia = selectedImage
            licenciaIV.contentMode = .scaleAspectFit
            self.licenciaIV.image = selectedImage
            break
        case "fotoPlacaTrasera":
            self.reporte!.fotoPlacaTrasera = selectedImage
            placaIV.contentMode = .scaleAspectFit
            self.placaIV.image = selectedImage
            break
        case "fotoTractoTrasera":
            self.reporte!.fotoTractoTrasera = selectedImage
            tractoIV.contentMode = .scaleAspectFit
            self.tractoIV.image = selectedImage
            break
        case "fotoTractoLateral1":
            
            break
        default:
            return
        }
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
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
                                                
                                                        FirebaseDBManager.dbInstance.guardarFotosTransporteEnvio(reporte: self.reporte!, idReporte: idReporte){
                                                            (respuesta) in
                                                            if(respuesta!){
                                                                self.guardarItems(items: (self.reporte?.getItems())!, idReporte: idReporte)
                                                            }
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
    func guardarItems(items: [Item], idReporte: String){
        var flag = 0;
        for item in items{ 
            FirebaseDBManager.dbInstance.guardarItemsReporteEnvio(item: item, idReporte: idReporte){
                (respuesta) in
                //subo fotos
                self.subirFotos(items: item.getPhotos(), idReporte: idReporte, idItem: item.getKey()){
                    (respuesta) in
                    if(respuesta!){
                        flag+=1;
                        if(flag == items.count){
                            UIApplication.shared.endIgnoringInteractionEvents()
                            self.activityIndicator.stopAnimating()
                            let alert = UIAlertController(title: "¡Reporte creado exitosamente!", message: "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("The \"OK\" alert occured.")
                                //regreso a la pantalla anterior
                                self.performSegue(withIdentifier: "menuPrincipalSegue", sender: self)
                                
                                
                            }))
                            self.present(alert, animated: true, completion: nil)
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
                    }//Error al subir
                }
            }
        }
    }
    func subirFotos(items: [UIImage], idReporte: String, idItem: String,completion: @escaping (Bool?)-> Void ){
        var flag = 0;
        for item in items{
            
            StorageManager.dbInstance.subirFoto(idUsuario: (self.reporte?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
                (respuesta, url) in
                if (respuesta){
                    //actualizar fotos en bd
                    FirebaseDBManager.dbInstance.guardarFotosItemsReporteEnvio(item: idItem, idReporte: idReporte, url: url!){
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
        
        
        
        StorageManager.dbInstance.subirFoto(idUsuario: (self.reporte?.getIdUsuario())!, idReporte: idReporte, imagen: StorageManager.dbInstance.resize(item)){
            (respuesta, url) in
            if (respuesta){
                //actualizar fotos en bd
                
                completion(true, url)
            }
        }
        
        
        
    }
    
    
}
