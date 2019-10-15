//
//  DatosTransporteDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/29/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class DatosTransporteDevolucionVC: UIViewController,UINavigationControllerDelegate  {
    
    var reporte: ReporteDevolucion?
    var imagePicker: UIImagePickerController!
    var btnSeleccionado: String?
    
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    
    /* Image View*/
    @IBOutlet weak var licenciaIV: UIImageView!
    
    @IBOutlet weak var placaDelanteraIV: UIImageView!
    
    @IBOutlet weak var placaTraseraIV: UIImageView!
    
    @IBOutlet weak var tractoTraseroIV: UIImageView!
    
    @IBOutlet weak var tractoLateral1IV: UIImageView!
    
    @IBOutlet weak var tractoLateral2IV: UIImageView!
    
    @IBOutlet weak var documentoDevolucionIV: UIImageView!
    
    
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
    
    @IBAction func documentoDevolucionBtn(_ sender: Any) {
        btnSeleccionado = "documentoDevolucion"
        imageSource()
    }
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        if (licenciaIV.image == UIImage(named: "vacio") || placaDelanteraIV.image == UIImage(named: "vacio") ||
            placaTraseraIV.image == UIImage(named: "vacio") || tractoTraseroIV.image == UIImage(named: "vacio") ||
            tractoLateral1IV.image == UIImage(named: "vacio") || tractoLateral2IV.image == UIImage(named: "vacio")
            || tractoTraseroIV.image == UIImage(named: "vacio")){
            let alert = UIAlertController(title: "¡Error!", message: "Agrega todas las fotos para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                
            }))
            
            
            
            
            self.present(alert, animated: true, completion: nil)
        }else{
        
        
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
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        if (segue.identifier == "agregarItemDevolucionSegue"){
            let receiver = segue.destination as! ItemsDevolucionVC
            receiver.reporte = self.reporte!
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
        case "documentoDevolucion":
            self.reporte!.fotoDocumentoDevolucion = selectedImage
            documentoDevolucionIV.contentMode = .scaleAspectFit
            self.documentoDevolucionIV.image = selectedImage
            break
        default:
            return
        
        }
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
