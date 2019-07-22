//
//  FotosTransporteVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/19/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class FotosTransporteVC: UIViewController,UINavigationControllerDelegate {
    
    var reporteEnvio: ReporteEnvio?
    var imagePicker: UIImagePickerController!
    var btnSeleccionado: String?
    
    
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
            //regreso a la pantalla anterior
            //Guardar info
            
            self.performSegue(withIdentifier: "menuPrincipalSegue", sender: self)
            
            
            
            
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
            receiver.reporteEnvio = self.reporteEnvio!
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
            self.reporteEnvio!.setFotoLicencia(fotoLicencia: selectedImage)
            licenciaIV.contentMode = .scaleAspectFit
            self.licenciaIV.image = selectedImage
            break
        case "fotoPlaca":
            self.reporteEnvio!.setFotoPlaca(fotoPlaca: selectedImage)
            placaIV.contentMode = .scaleAspectFit
            self.placaIV.image = selectedImage
            break
        case "fotoTracto":
            self.reporteEnvio!.setFotoTracto(fotoTracto: selectedImage)
            tractoIV.contentMode = .scaleAspectFit
            self.tractoIV.image = selectedImage
            break
        default:
            return
        }
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
