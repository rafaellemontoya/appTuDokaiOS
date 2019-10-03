//
//  ItemsDanoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsDanoVC: UIViewController,UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    var reporte: ReporteDano?
    var itemsArray: [Item] = []
    var tipoDanoArray: [TipoDano] = []
    var itemSeleccionado: Item?
    var tipoDanoSeleccionado: TipoDano?
    var imagePicker: UIImagePickerController!
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    @IBOutlet weak var codigoPiezaTV: UITableView!
    
    @IBOutlet weak var tipoDanoTV: UITableView!
    
    @IBOutlet weak var nombrePiezaTV: UITableView!
    
    @IBOutlet weak var nombreItemTF: UITextField!
    
    @IBOutlet weak var codigoItemF: UITextField!
    
    @IBOutlet weak var unidadesItemTF: UITextField!
    
    @IBOutlet weak var itemDanoIV: UIImageView!
    
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
    @IBAction func nombreItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = false;
        tipoDanoTV.isHidden = true;
        
    }
    
    
    @IBAction func CodigoItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = false;
        nombrePiezaTV.isHidden = true;
        tipoDanoTV.isHidden = true;
    }
    
    @IBAction func unidadesItemEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
        tipoDanoTV.isHidden = true;
    }
    
    @IBOutlet weak var tipoDanoTF: UITextField!
    
    @IBAction func tipoDanoTouch(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
        tipoDanoTV.isHidden = false;
        getInfo(busquedaParam: tipoDanoTF.text!)
    }
    
    @IBAction func tipoDanoEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
        tipoDanoTV.isHidden = false;
        
    }
    
    @IBAction func nombreChanged(_ sender: Any) {
        getInfo(busquedaParam: nombreItemTF.text!)
    }
    
    
    
    
    
    @IBAction func btnContinuar(_ sender: Any) {
        
        if (unidadesItemTF.text == "" || itemDanoIV.image == nil ){
            print("error")
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesItemTF.text!)! )
            
            itemSeleccionado!.setTipoDano(tipoDano: tipoDanoSeleccionado!)
            itemSeleccionado!.addPhoto(foto: itemDanoIV.image!)
            reporte!.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "resumenItemsDano", sender: self)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case self.nombrePiezaTV:
            return itemsArray.count
        case self.codigoPiezaTV:
            return itemsArray.count
        case self.tipoDanoTV:
            return tipoDanoArray.count
            
        default:
            return 0
        }
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
        case self.tipoDanoTV:
            cell = tipoDanoTV.dequeueReusableCell(withIdentifier: "optionCodigoPieza") as! OptionTableViewCell
            cell.agregarCelda(name: self.tipoDanoArray[indexPath.row].tipoDano)
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
        
        //Tipo daño
        if (tableView == self.tipoDanoTV || tableView == self.tipoDanoTV){
            self.nombrePiezaTV.isHidden = true;
            self.codigoPiezaTV.isHidden = true;
            self.tipoDanoTV.isHidden = true;
            
            tipoDanoTF.text = self.tipoDanoArray[indexPath.row].tipoDano
            
            self.tipoDanoSeleccionado = tipoDanoArray[indexPath.row];
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfo(busquedaParam: "")
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaTV.delegate = self
        nombrePiezaTV.dataSource = self
        
        tipoDanoTV.delegate = self
        tipoDanoTV.dataSource = self
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
        FirebaseDBManager.dbInstance.obtenerDescripcionDano(busquedaParam:busquedaParam){
            (respuesta, arrayRespuesta) in
            if(respuesta){
                self.tipoDanoArray = arrayRespuesta!
            }else{
                self.tipoDanoArray = []
            }
            self.tipoDanoTV.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resumenItemsDano"){
            let receiverVC = segue.destination as! ResumenItemsDanoVC
            receiverVC.reporte = self.reporte!
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
extension ItemsDanoVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print ("hola desde extension")
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        
        itemDanoIV.image = selectedImage
        itemDanoIV.contentMode = .scaleAspectFit
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
        
        
    }
    
}
