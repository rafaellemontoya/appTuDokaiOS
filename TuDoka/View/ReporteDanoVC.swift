//
//  ReporteDanoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ReporteDanoVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    private var clientesArray: [Cliente] = []
    private var proyectosArray: [Proyecto] = []
    private var reporteDano: ReporteDano?
    
    
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
        performSegue(withIdentifier: "confirmacionProyectoDanoSegue", sender: self)
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
            
            reporteDano!.setCliente(cliente: self.clientesArray[indexPath.row])
            getInfoProyectos(keyCliente: clientesArray[indexPath.row].key)
            
        }else if(tableView == self.nombreProyectoDanoTV || tableView == self.numeroProyectoTV){
            //Proyecto seleccionado
            
            self.nombreProyectoDanoTV.isHidden = true;
            self.numeroProyectoTV.isHidden = true;
            nombreProyectoTF.text = self.proyectosArray[indexPath.row].nombre
            numeroProyectoTF.text = self.proyectosArray[indexPath.row].numero
            reporteDano!.setProyecto(proyecto: proyectosArray[indexPath.row])
        }
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reporteDano = ReporteDano()
        
        getInfoClientes()
        getInfoProyectos(keyCliente: "")
        
        
        
    }
    
    
    func getInfoClientes(){
        
        self.clientesArray.append( Cliente(key: "key", nombre: "Tec de monterrey", numero: "129", pais: "MX"))
        
        nombreClienteTV.reloadData()
        numeroClienteDanoTV.reloadData()
    }
    
    func getInfoProyectos(keyCliente: String){
        if (keyCliente == ""){
            self.proyectosArray.append(Proyecto(key: "keyProyecto", nombre: "NAICM", numero: "12313", pais: "MX", keyCliente: "4321"))
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }else{
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }
        
        nombreProyectoDanoTV.reloadData()
        numeroProyectoTV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if( self.reporteDano?.getCliente().key != ""){
            if(segue.identifier == "confirmacionProyectoDanoSegue"){
                let receiverVC = segue.destination as! ConfirmacionDatosDanoVC
                receiverVC.reporteDano = self.reporteDano
            }
        }else{
            print("Error")
        }
    
        
        
    }
    
    
    
}