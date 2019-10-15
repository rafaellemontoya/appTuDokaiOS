//
//  ItemsSeguimientoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsSeguimientoVC: UIViewController ,UINavigationControllerDelegate, UITextViewDelegate {
    
    var reporte: ReporteSeguimiento?
    var itemSeleccionado: ActividadCapacitacion?
    
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    @IBOutlet weak var descripcionActividad: UITextView!
    
    @IBAction func nuevaFotoBtn(_ sender: Any) {
        imageSource()
    }
    
    @IBOutlet weak var fotoSeleccionadaIV: UIImageView!
    
  
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
        
        if (descripcionActividad.text! != "" && fotoSeleccionadaIV.image != nil){
            itemSeleccionado = ActividadCapacitacion()
            itemSeleccionado!.setDescripcion(descripcion: descripcionActividad.text!)
            reporte?.setItems(item: itemSeleccionado!)
            itemSeleccionado?.addPhoto(foto: fotoSeleccionadaIV.image!)
            performSegue(withIdentifier: "itemsSeguimientoSegue", sender: self)
        }else{
            
                print("error")
                let alert = UIAlertController(title: "Da click en 'Nueva foto para continuar'", message: "", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                           NSLog("The \"OK\" alert occured.")
                           //regreso a la pantalla anterior
                       }))
                       
                       self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegarTF()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        if (segue.identifier == "itemsSeguimientoSegue"){
            let receiverVC = segue.destination as! ResumenSeguimientoViewController
            receiverVC.reporte = self.reporte!
        }
    }
    func delegarTF(){
        self.descripcionActividad.delegate = self
        
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        descripcionActividad.resignFirstResponder()
        
        self.view.endEditing(true)
        return true
    }
    /* Updated for Swift 4 */
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            descripcionActividad.resignFirstResponder()
            return false
        }
        return true
    }

    
    
}
extension ItemsSeguimientoVC: UIImagePickerControllerDelegate{
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
