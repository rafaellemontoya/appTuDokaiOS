//
//  ItemsVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/16/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsVC: UIViewController,UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate {
    
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
    
    
    @IBAction func CodigoItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = false;
        nombrePiezaTV.isHidden = true;
    }
    
    @IBAction func unidadesItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
    }
    @IBAction func nuevaFoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
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
        
        if (unidadesItemTF.text == ""){
            print("error")
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesItemTF.text!)! )
            itemSeleccionado!.addPhoto(foto: fotoSeleccionada.image!)
            reporteEnvio!.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "resumenItemsEnvio", sender: self)
        }
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
        itemSeleccionado = Item(key: "", nombre: "", codigo: "", pais: "")
        getInfo()
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaTV.delegate = self
        nombrePiezaTV.dataSource = self
    }
    
    func getInfo(){
        FirebaseDBManager.dbInstance.obtenerItems(){
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
        if (segue.identifier == "resumenItemsEnvio"){
            let receiverVC = segue.destination as! ResumenItemsVC
            receiverVC.reporteEnvio = self.reporteEnvio!
        }
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
