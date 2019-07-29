//
//  ReporteDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/29/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ReporteDevolucionVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    //Nombre Cliente
    
    @IBOutlet weak var nombreClienteTV: UITableView!
    
    
    @IBOutlet weak var nombreClienteTF: UITextField!
    
    @IBAction func nombreClienteEdit(_ sender: Any) {
        print(nombreClienteTF.text)
        self.nombreClienteTV.isHidden = false
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = true;
    }
    
    
    @IBAction func nombreClienteTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = false
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = true;
    }
    
    
    
    //Numero Cliente
    
    @IBOutlet weak var numeroClienteTV: UITableView!
    
    @IBOutlet weak var numeroClienteTF: UITextField!
    
    
    @IBAction func numeroClienteEdit(_ sender: Any) {
        print(numeroClienteTF.text)
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = false
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = true;
    }
    
    @IBAction func numeroClenteTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = false
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = true;
    }
    
    
    
    //Nombre proyecto
    
    @IBOutlet weak var nombreProyectoTV: UITableView!
    
    
    @IBOutlet weak var nombreProyectoTF: UITextField!
    
    @IBAction func nombreProyectoEdit(_ sender: Any) {
        print (nombreProyectoTF.text)
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = false;
    }
    
    @IBAction func nombreProyectoTouch(_ sender: Any) {
        
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = true
        self.nombreProyectoTV.isHidden = false;
    }
    
    
    
    //Numero proyecto
    @IBOutlet weak var numeroProyectoTV: UITableView!
    
    @IBOutlet weak var numeroProyectoTf: UITextField!
    
    @IBAction func numeroProyectoChanged(_ sender: Any) {
        print(numeroProyectoTf.text)
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = false
        self.nombreProyectoTV.isHidden = true;
    }
    
    @IBAction func NumeroProyectoTouch(_ sender: Any) {
        self.nombreClienteTV.isHidden = true
        self.numeroClienteTV.isHidden = true
        self.numeroProyectoTV.isHidden = false
        self.nombreProyectoTV.isHidden = true;
        
    }
    
    
    
    
    private var clientesArray: [Cliente] = []
    private var proyectosArray: [Proyecto] = []
    private var reporteDevolucion: ReporteDevolucion?
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
        case self.numeroClienteTV:
            cell = numeroClienteTV.dequeueReusableCell(withIdentifier: "optionNumeroCliente") as! OptionTableViewCell
            cell.agregarCelda(name: self.clientesArray[indexPath.row].numero)
            break;
        case self.nombreProyectoTV:
            cell = nombreProyectoTV.dequeueReusableCell(withIdentifier: "optionNombreProyecto") as! OptionTableViewCell
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
        if (tableView == self.nombreClienteTV || tableView == self.numeroClienteTV){
            self.nombreClienteTV.isHidden = true;
            self.numeroClienteTV.isHidden = true;
            nombreClienteTF.text = self.clientesArray[indexPath.row].nombre
            numeroClienteTF.text = self.clientesArray[indexPath.row].numero
            
            reporteDevolucion!.setCliente(cliente: self.clientesArray[indexPath.row])
            getInfoProyectos(keyCliente: clientesArray[indexPath.row].key)
            
        }else if(tableView == self.nombreProyectoTV || tableView == self.numeroProyectoTV){
            //Proyecto seleccionado
            
            self.nombreProyectoTV.isHidden = true;
            self.numeroProyectoTV.isHidden = true;
            nombreProyectoTF.text = self.proyectosArray[indexPath.row].nombre
            numeroProyectoTf.text = self.proyectosArray[indexPath.row].numero
            reporteDevolucion!.setProyecto(proyecto: proyectosArray[indexPath.row])
        }
        
        
        
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reporteDevolucion = ReporteDevolucion()
        
        getInfoClientes()
        getInfoProyectos(keyCliente: "")
        
        
        
    }
    
    
    func getInfoClientes(){
        
        self.clientesArray.append( Cliente(key: "key", nombre: "Tec de monterrey", numero: "129", pais: "MX"))
        
        nombreClienteTV.reloadData()
        numeroClienteTV.reloadData()
    }
    
    func getInfoProyectos(keyCliente: String){
        if (keyCliente == ""){
            self.proyectosArray.append(Proyecto(key: "keyProyecto", nombre: "NAICM", numero: "12313", pais: "MX", keyCliente: "4321"))
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }else{
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }
        
        nombreProyectoTV.reloadData()
        numeroProyectoTV.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        if( self.reporteDevolucion?.getCliente().key != ""){
            if(segue.identifier == "confirmacionProyectoDevolucion"){
                let receiverVC = segue.destination as! ConfirmacionDatosDevolucionVC
                receiverVC.reporteDevolucion = self.reporteDevolucion
            }
        }else{
            print("Error")
        }
        
        
        
//        if(self.reporteEnvio?.getCliente().key != nil || self.reporteEnvio?.getProyecto().key != nil)
//        {
//            if(segue.identifier == "confirmacionProyecto"){
//                let receiverVC = segue.destination as! ConfirmacionProyectoVC
//                receiverVC.reporteEnvio = self.reporteEnvio!
//            }
//        }else{
//            print("proyecto vacío")
//        }
        
        
        
        
        
    }
    


}
