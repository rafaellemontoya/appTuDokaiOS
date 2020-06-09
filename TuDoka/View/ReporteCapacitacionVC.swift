//
//  ReporteCapacitacionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import Firebase

class ReporteCapacitacionVC:  UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private var clientesArray: [Cliente] = []
    private var proyectosArray: [Proyecto] = []
    private var reporte: ReporteCapacitacion?
    
    @IBOutlet weak var nombreCursoTF: UITextField!
    
    @IBOutlet weak var nombreProyectoDanoTV: UITableView!
    
    @IBOutlet weak var numeroClienteDanoTV: UITableView!
    
    @IBOutlet weak var nombreClienteTV: UITableView!
    
    @IBOutlet weak var numeroProyectoTV: UITableView!
    
    
    @IBOutlet weak var nombreClienteTF: UITextField!
    
    @IBAction func nombreClienteEdit(_ sender: Any) {
        print(nombreClienteTF.text)
        self.nombreClienteTV.isHidden = false
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = true;
        getInfoClientes(busquedaParam: nombreClienteTF.text!)
    }
    
    @IBAction func nombreClienteTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = false
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = true;
    }
    
    @IBOutlet weak var numeroClienteTF: UITextField!
    
    @IBAction func numeroClienteEdit(_ sender: Any) {
        print(numeroClienteTF.text)
        
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = false
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = true;
    }
    
    @IBAction func numeroClienteTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = false
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = true;
    }
    
    
    
    @IBOutlet weak var nombreProyectoTF: UITextField!
    
    @IBAction func nombreProyectoEdit(_ sender: Any) {
        print(nombreProyectoTF.text)
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = false;
        getInfoProyectos(busquedaParam: nombreProyectoTF.text!, keyCliente: reporte!.getCliente().nombre)
    }
    
    @IBAction func nombreProyectoTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoDanoTV.isHidden = false;
    }
    
    
    @IBOutlet weak var numeroProyectoTF: UITextField!
    
    
    @IBAction func numeroProyectoEdit(_ sender: Any) {
        print(numeroProyectoTF.text)
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = false
        self.nombreProyectoDanoTV.isHidden = true;
    }
    @IBAction func numeroProyectoTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = true
        self.numeroClienteDanoTV.isHidden = true
        self.numeroProyectoTV.isHidden = false
        self.nombreProyectoDanoTV.isHidden = true;
    }
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        if(nombreCursoTF.text != ""){
            reporte?.setNombreCurso(nombreCurso: nombreCursoTF.text!)
            performSegue(withIdentifier: "confirmacionProyectoCapacitacionSegue", sender: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OptionTableViewCell()
        switch tableView {
        case self.nombreClienteTV:
            cell = nombreClienteTV.dequeueReusableCell(withIdentifier: "option") as! OptionTableViewCell
            cell.agregarCelda(name: self.clientesArray[indexPath.row].nombre)
            break;
        case self.numeroClienteDanoTV:
            cell = numeroClienteDanoTV.dequeueReusableCell(withIdentifier: "optionNumeroCliente") as! OptionTableViewCell
            cell.agregarCelda(name: self.clientesArray[indexPath.row].numero)
            break;
        case self.nombreProyectoDanoTV:
            cell = nombreProyectoDanoTV.dequeueReusableCell(withIdentifier: "optionNombreProyecto") as! OptionTableViewCell
            cell.agregarCelda(name: self.proyectosArray[indexPath.row].nombre)
            break;
        case self.numeroProyectoTV:
            cell = numeroProyectoTV.dequeueReusableCell(withIdentifier: "optionNumeroProyecto") as! OptionTableViewCell
            cell.agregarCelda(name: self.proyectosArray[indexPath.row].numero)
            break;
        default:
            cell = OptionTableViewCell()
            break;
        }
        
        
        
        return cell;
    }
    
    
    //funcion cuando se da click a una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.clientesArray[indexPath.row])
        
        //Cliente seleccionado
        if (tableView == self.nombreClienteTV || tableView == self.numeroClienteDanoTV){
            self.nombreClienteTV.isHidden = true;
            self.numeroClienteDanoTV.isHidden = true;
            nombreClienteTF.text = self.clientesArray[indexPath.row].nombre
            numeroClienteTF.text = self.clientesArray[indexPath.row].numero
            
            reporte!.setCliente(cliente: self.clientesArray[indexPath.row])
            getInfoProyectos(busquedaParam: "", keyCliente: clientesArray[indexPath.row].nombre)
            
        }else if(tableView == self.nombreProyectoDanoTV || tableView == self.numeroProyectoTV){
            //Proyecto seleccionado
            
            self.nombreProyectoDanoTV.isHidden = true;
            self.numeroProyectoTV.isHidden = true;
            nombreProyectoTF.text = self.proyectosArray[indexPath.row].nombre
            numeroProyectoTF.text = self.proyectosArray[indexPath.row].numero
            reporte!.setProyecto(proyecto: proyectosArray[indexPath.row])
        }
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        delegarTF()
        self.reporte = ReporteCapacitacion()
        reporte?.setPais(pais: "MX")
        reporte?.setIdUsuario(idUsuario: Auth.auth().currentUser!.uid )
        getInfoClientes(busquedaParam: "")
        getInfoProyectos(busquedaParam: "", keyCliente: "")
        getInfoUser()
        
        
    }
    
    
    
    func getInfoClientes(busquedaParam: String){
        
        FirebaseDBManager.dbInstance.obtenerClientes(busquedaParam: busquedaParam){
            (respuesta, clientesArray) in
            if(respuesta){
                self.clientesArray = clientesArray!
                self.nombreClienteTV.reloadData()
                self.numeroClienteDanoTV.reloadData()
            }else{
                print("Error obteniendo documentos ")
            }
            
            
        }
        
    }
    
    func getInfoProyectos(busquedaParam: String,keyCliente: String){
        FirebaseDBManager.dbInstance.obtenerProyectos(busquedaParam:busquedaParam, idCliente: "key"){
            (respuesta, respuestaArray) in
            if(respuesta){
                self.proyectosArray = respuestaArray!
                self.nombreProyectoDanoTV.reloadData()
                self.numeroProyectoTV.reloadData()
            }else{
                print("Error obteniendo documentos ")
            }
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let backItem = UIBarButtonItem()
//        backItem.title = "Atrás"
//        navigationItem.backBarButtonItem = backItem
        
        if( self.reporte?.getCliente().key != ""){
            if(segue.identifier == "confirmacionProyectoCapacitacionSegue"){
                let receiverVC = segue.destination as! ConfirmacionDatosCapacitacionVC
                receiverVC.reporte = self.reporte
            }
        }else{
            print("Error")
        }
        
        
        
    }
    func delegarTF(){
        self.nombreCursoTF.delegate = self
        self.nombreClienteTF.delegate = self
        self.numeroClienteTF.delegate = self;
        self.nombreProyectoTF.delegate = self
        self.numeroProyectoTF.delegate = self
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nombreCursoTF.resignFirstResponder()
        nombreClienteTF.resignFirstResponder()
        numeroClienteTF.resignFirstResponder()
        nombreProyectoTF.resignFirstResponder()
        numeroProyectoTF.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func getInfoUser(){
        
        FirebaseDBManager.dbInstance.obtenerInfoUser(){
            (respuesta, clientesArray) in
            if(respuesta){
                self.reporte?.nombreUsuario = clientesArray!
                
            }else{
                print("Error obteniendo documentos ")
            }
            
            
        }
        
    }
}
