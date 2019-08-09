//
//  ItemsCapacitacionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsCapacitacionVC: UIViewController,UINavigationControllerDelegate {

    var reporte: ReporteCapacitacion?
     var itemSeleccionado: ActividadCapacitacion?
    
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    @IBOutlet weak var descripcionActividad: UITextView!
    
    @IBOutlet weak var fotoSeleccionadaIV: UIImageView!
    
    @IBAction func nuevaFotoBtn(_ sender: Any) {
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
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        if (descripcionActividad.text! != ""){
            itemSeleccionado = ActividadCapacitacion()
            itemSeleccionado!.setDescripcion(descripcion: descripcionActividad.text!)
            reporte?.setItems(item: itemSeleccionado!)
            itemSeleccionado?.addPhoto(foto: fotoSeleccionadaIV.image!)
            performSegue(withIdentifier: "itemsCapacitacionSegue", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "itemsCapacitacionSegue"){
            let receiverVC = segue.destination as! ResumenCapacitacionVC
            receiverVC.reporte = self.reporte!
        }
    }
    

    
}
extension ItemsCapacitacionVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print ("hola desde extension")
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        
        fotoSeleccionadaIV.image = selectedImage
        fotoSeleccionadaIV.contentMode = .scaleAspectFit
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
