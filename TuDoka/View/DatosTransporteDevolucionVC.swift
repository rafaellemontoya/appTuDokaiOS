//
//  DatosTransporteDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/29/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class DatosTransporteDevolucionVC: UIViewController,UINavigationControllerDelegate  {
    
    var reporteDevolucion: ReporteDevolucion?
    var imagePicker: UIImagePickerController!
    var btnSeleccionado: String?
    
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    @IBOutlet weak var fotoLicenciaIV: UIImageView!
    
    @IBOutlet weak var fotoPlacaIV: UIImageView!
    
    @IBOutlet weak var fotoTractoIV: UIImageView!
    
    @IBOutlet weak var fotoDocumentoDokaIV: UIImageView!
    
    
    @IBAction func fotoLicenciaBTN(_ sender: Any) {
        btnSeleccionado = "fotoLicencia"
        imageSource()
    }
    
    @IBAction func fotoPlacaBTN(_ sender: Any) {
        btnSeleccionado = "fotoPlaca"
        imageSource()
    }
    
    
    @IBAction func fotoTractoBTN(_ sender: Any) {
        btnSeleccionado = "fotoTracto"
        imageSource()
    }
    
    @IBAction func fotoDocumentoDokaBTN(_ sender: Any) {
        btnSeleccionado = "fotoDocumento"
        imageSource()
    }
    
    @IBAction func continuarBTN(_ sender: Any) {
        let alert = UIAlertController(title: "¿Estás seguro de querer continuar?", message: "NO podrás agregar estas fotos más adelante", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            
            
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continuar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            //Guardar info
            
            self.performSegue(withIdentifier: "agregarItemDevolucionSegue", sender: self)

            
        }))
        self.present(alert, animated: true, completion: nil)
        
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
        if (segue.identifier == "agregarItemDevolucionSegue"){
            let receiver = segue.destination as! ItemsDevolucionVC
            receiver.reporteDevolucion = self.reporteDevolucion!
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension DatosTransporteDevolucionVC: UIImagePickerControllerDelegate{
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
            self.reporteDevolucion!.setFotoLicencia(fotoLicencia: selectedImage)
            fotoLicenciaIV.contentMode = .scaleAspectFit
            self.fotoLicenciaIV.image = selectedImage
            break
        case "fotoPlaca":
            self.reporteDevolucion!.setFotoPlaca(fotoPlaca: selectedImage)
            fotoPlacaIV.contentMode = .scaleAspectFit
            self.fotoPlacaIV.image = selectedImage
            break
        case "fotoTracto":
            self.reporteDevolucion!.setFotoTracto(fotoTracto: selectedImage)
            fotoTractoIV.contentMode = .scaleAspectFit
            self.fotoTractoIV.image = selectedImage
            break
        case "fotoDocumento":
            self.reporteDevolucion!.setFotoDocumentoDevolucion(fotoDocumentoDevolucion: selectedImage)
            fotoDocumentoDokaIV.contentMode = .scaleAspectFit
            self.fotoDocumentoDokaIV.image = selectedImage
            break
        default:
            return
        }
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
