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
        
        if (licenciaIV.image == UIImage(named: "vacio") || placaDelanteraIV.image == UIImage(named: "vacio") ||
            placaTraseraIV.image == UIImage(named: "vacio") || tractoTraseroIV.image == UIImage(named: "vacio") ||
            tractoLateral1IV.image == UIImage(named: "vacio") || tractoLateral2IV.image == UIImage(named: "vacio") ){
            let alert = UIAlertController(title: "¡Error!", message: "Agrega todas las fotos para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //regreso a la pantalla anterior
                
                
                
            }))
            
          
                
            
        self.present(alert, animated: true, completion: nil)
        }else{
            
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
        
    }
    
    
    /* Image View*/
    @IBOutlet weak var licenciaIV: UIImageView!
    
    @IBOutlet weak var placaDelanteraIV: UIImageView!
    
    @IBOutlet weak var placaTraseraIV: UIImageView!
    
    @IBOutlet weak var tractoTraseroIV: UIImageView!
    
    @IBOutlet weak var tractoLateral1IV: UIImageView!
    
    @IBOutlet weak var tractoLateral2IV: UIImageView!
    
    
    
    /* Button*/
    @IBAction func licenciaBTN(_ sender: UIButton) {
        btnSeleccionado = "licencia"
        imageSource()
    }
    

    @IBAction func placaDelanteraBtn(_ sender: Any) {
        btnSeleccionado = "placaDelantera"
        imageSource()
    }
    
    @IBAction func placaTraseraBtn(_ sender: Any) {
        btnSeleccionado = "placaTrasera"
        imageSource()
    }
    
    @IBAction func tractoTraseroBtn(_ sender: Any) {
        btnSeleccionado = "tractoTrasero"
        imageSource()
    }
    
    @IBAction func tractoLateral1Btn(_ sender: Any) {
        btnSeleccionado = "tractoLateral1"
        imageSource()
    }
    
    @IBAction func tractoLateral2Btn(_ sender: Any) {
        btnSeleccionado = "tractoLateral2"
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
        case "licencia":
            self.reporte!.fotoLicencia = selectedImage
            licenciaIV.contentMode = .scaleAspectFit
            self.licenciaIV.image = selectedImage
            break
        case "placaDelantera":
            self.reporte!.fotoPlacaDelantera = selectedImage
            placaDelanteraIV.contentMode = .scaleAspectFit
            self.placaDelanteraIV.image = selectedImage
            break
        case "placaTrasera":
            self.reporte!.fotoPlacaTrasera = selectedImage
            placaTraseraIV.contentMode = .scaleAspectFit
            self.placaTraseraIV.image = selectedImage
            break
        case "tractoTrasero":
            self.reporte!.fotoTractoTrasera = selectedImage
            tractoTraseroIV.contentMode = .scaleAspectFit
            self.tractoTraseroIV.image = selectedImage
            break
        case "tractoLateral1":
            self.reporte!.fotoTractoLateral1 = selectedImage
            tractoLateral1IV.contentMode = .scaleAspectFit
            self.tractoLateral1IV.image = selectedImage
            break
        case "tractoLateral2":
            self.reporte!.fotoTractoLateral2 = selectedImage
            tractoLateral2IV.contentMode = .scaleAspectFit
            self.tractoLateral2IV.image = selectedImage
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
                                                
                                                //licencia
                                                self.subirFotosTransporte(item: (self.reporte?.fotoLicencia)!, idReporte: idReporte){
                                                    (respuesta, url) in
                                                    if(respuesta){
                                                        self.reporte?.urlFotoLicencia = url!
                                                        
                                                        FirebaseDBManager.dbInstance.guardarFotosTransporteEnvio(reporte: self.reporte!, idReporte: idReporte){
                                                            (respuesta) in
                                                            if(respuesta!){
                                                                self.guardarItems(items: (self.reporte?.getItems())!, idReporte: idReporte)
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
                                self.performSegue(withIdentifier: "menuPrincipalSegue", sender: self)
                                
                                
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
    
    
}
