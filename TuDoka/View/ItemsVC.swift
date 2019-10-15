//
//  ItemsVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/16/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsVC: UIViewController,UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    var reporteEnvio: ReporteEnvio?
    var itemsArray: [Item] = []
    var itemSeleccionado: Item?
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    @IBOutlet weak var fotoSeleccionada: UIImageView!
    
    
    @IBOutlet weak var codigoPiezaTV: UITableView!
    
    
    @IBOutlet weak var nombrePiezaTV: UITableView!
    
    @IBOutlet weak var nombreItemTF: UITextField!
    
    @IBOutlet weak var codigoItemF: UITextField!
    
    @IBOutlet weak var unidadesItemTF: UITextField!
    
    
    @IBAction func nombreItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = false;
        
       
        
    }
    
    @IBAction func nombreItemChanged(_ sender: Any) {
        print(nombreItemTF.text!)
         getInfo(busquedaParam: nombreItemTF.text!)
    }
    
    @IBAction func CodigoItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = false;
        nombrePiezaTV.isHidden = true;
    }
    
    @IBAction func unidadesItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
    }
    @IBAction func nuevaFoto(_ sender: Any) {
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
    @IBAction func btnContinuar(_ sender: Any) {
        
        if (unidadesItemTF.text == ""||fotoSeleccionada.image == nil){
            print("error")
            let alert = UIAlertController(title: "Da click en 'Nueva foto para continuar'", message: "", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                       NSLog("The \"OK\" alert occured.")
                       //regreso a la pantalla anterior
                   }))
                   
                   self.present(alert, animated: true, completion: nil)
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesItemTF.text!)! )
            itemSeleccionado!.addPhoto(foto: fotoSeleccionada.image!)
            reporteEnvio!.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "resumenItemsEnvio", sender: self)
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OptionTableViewCell()
        switch tableView {
        case self.nombrePiezaTV:
            cell = nombrePiezaTV.dequeueReusableCell(withIdentifier: "optionNombrePieza") as! OptionTableViewCell
            cell.agregarCelda(name: self.itemsArray[indexPath.row].getNombre())
            break;
        case self.codigoPiezaTV:
            cell = codigoPiezaTV.dequeueReusableCell(withIdentifier: "optionCodigoPieza") as! OptionTableViewCell
            cell.agregarCelda(name: self.itemsArray[indexPath.row].getCodigo())
            break;
        
        default:
            cell = OptionTableViewCell()
            break;
        }
        
        
        
        return cell;
    }
    
    //funcion cuando se da click a una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        //Cliente seleccionado
        if (tableView == self.nombrePiezaTV || tableView == self.codigoPiezaTV){
            self.nombrePiezaTV.isHidden = true;
            self.codigoPiezaTV.isHidden = true;
            nombreItemTF.text = self.itemsArray[indexPath.row].getNombre()
            codigoItemF.text = self.itemsArray[indexPath.row].getCodigo()
            
            self.itemSeleccionado = itemsArray[indexPath.row];
            
            
        }

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegarTF()
        itemSeleccionado = Item(key: "", nombre: "", codigo: "", pais: "")
        getInfo(busquedaParam:"")
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaTV.delegate = self
        nombrePiezaTV.dataSource = self
    }
    
    func getInfo(busquedaParam: String){
        FirebaseDBManager.dbInstance.obtenerItems(busquedaParam:busquedaParam){
            (respuesta, arrayRespuesta) in
            if(respuesta){
                self.itemsArray = arrayRespuesta!
            }else{
                self.itemsArray = []
            }
            self.nombrePiezaTV.reloadData()
            self.codigoPiezaTV.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        if (segue.identifier == "resumenItemsEnvio"){
            let receiverVC = segue.destination as! ResumenItemsVC
            receiverVC.reporteEnvio = self.reporteEnvio!
        }
    }

    func delegarTF(){
        self.unidadesItemTF.delegate = self
        self.codigoItemF.delegate = self;
        self.nombreItemTF.delegate = self
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        unidadesItemTF.resignFirstResponder()
        codigoItemF.resignFirstResponder()
        nombreItemTF.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    


}
extension ItemsVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print ("hola desde extension")
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        
        fotoSeleccionada.image = selectedImage
        fotoSeleccionada.contentMode = .scaleAspectFit
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
