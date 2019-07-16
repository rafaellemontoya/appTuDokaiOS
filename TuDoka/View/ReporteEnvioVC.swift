//
//  ReporteEnvioVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 6/26/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ReporteEnvioVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var tableNombreCliente: UITableView!
    
    @IBOutlet weak var tableNumeroCliente: UITableView!
    
    @IBOutlet weak var tableNombreProyecto: UITableView!
    
    @IBOutlet weak var tableNumeroProyecto: UITableView!
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var numeroClienteTF: UITextField!
    
    @IBOutlet weak var nombreProyectoTF: UITextField!
    
    @IBOutlet weak var numeroProyectoTF: UITextField!
    //Nombre proyecto
    @IBAction func nombreProyectoEdit(_ sender: Any) {
        tableNombreCliente.isHidden = true
        tableNumeroCliente.isHidden = true
        tableNumeroProyecto.isHidden = true
        tableNombreProyecto.isHidden = false
        
    }
    
    @IBAction func nombreProyectoChanged(_ sender: Any) {
        print(nombreProyectoTF.text)
    }
    //Numero proyecto
    
    @IBAction func numeroProyectoEdit(_ sender: Any) {
        tableNombreCliente.isHidden = true
        tableNumeroCliente.isHidden = true
        tableNumeroProyecto.isHidden = false
        tableNombreProyecto.isHidden = true
    }
    
    @IBAction func numeroProyectoChanged(_ sender: Any) {
        print(numeroProyectoTF.text)
    }
    
    
    //Numero cliente
    @IBAction func numeroClienteEdit(_ sender: Any) {
        tableNombreCliente.isHidden = true
        tableNumeroCliente.isHidden = false
        tableNumeroProyecto.isHidden = true
        self.tableNombreProyecto.isHidden = true;
    }
    
    @IBAction func numeroClienteChanged(_ sender: Any) {
        print(numeroClienteTF.text)
    }
    
    //nombre cliente
    @IBAction func nombreClienteEdit(_ sender: Any) {
        self.tableNombreCliente.isHidden = false
        self.tableNumeroCliente.isHidden = true
        self.tableNumeroProyecto.isHidden = true
        self.tableNombreProyecto.isHidden = true;
    }
    
    
    @IBAction func nombreClienteChanged(_ sender: Any) {
        print(textField.text)
    }
    
    
    
   
    
    
    private var clientesArray: [Cliente] = []
    private var proyectosArray: [Proyecto] = []
    private var reporteEnvio: ReporteEnvio?;
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientesArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OptionTableViewCell()
        switch tableView {
        case self.tableNombreCliente:
            cell = tableNombreCliente.dequeueReusableCell(withIdentifier: "option") as! OptionTableViewCell
            cell.agregarCelda(name: self.clientesArray[indexPath.row].nombre)
            break;
        case self.tableNumeroCliente:
            cell = tableNumeroCliente.dequeueReusableCell(withIdentifier: "optionNumeroCliente") as! OptionTableViewCell
            cell.agregarCelda(name: self.clientesArray[indexPath.row].numero)
            break;
        case self.tableNombreProyecto:
            cell = tableNombreProyecto.dequeueReusableCell(withIdentifier: "optionNombreProyecto") as! OptionTableViewCell
            cell.agregarCelda(name: self.proyectosArray[indexPath.row].nombre)
            break;
        case self.tableNumeroProyecto:
            cell = tableNumeroProyecto.dequeueReusableCell(withIdentifier: "optionNumeroProyecto") as! OptionTableViewCell
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
        if (tableView == self.tableNombreCliente || tableView == self.tableNumeroCliente){
            self.tableNombreCliente.isHidden = true;
            self.tableNumeroCliente.isHidden = true;
            textField.text = self.clientesArray[indexPath.row].nombre
            numeroClienteTF.text = self.clientesArray[indexPath.row].numero
            
            reporteEnvio!.setCliente(cliente: self.clientesArray[indexPath.row])
            getInfoProyectos(keyCliente: clientesArray[indexPath.row].key)
            
        }else if(tableView == self.tableNombreProyecto || tableView == self.tableNumeroProyecto){
            //Proyecto seleccionado
            
            self.tableNumeroProyecto.isHidden = true;
            self.tableNombreProyecto.isHidden = true;
            nombreProyectoTF.text = self.proyectosArray[indexPath.row].nombre
            numeroProyectoTF.text = self.proyectosArray[indexPath.row].numero
            reporteEnvio!.setProyecto(proyecto: proyectosArray[indexPath.row])
        }
        
        

        
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reporteEnvio = ReporteEnvio()

        getInfoClientes()
        getInfoProyectos(keyCliente: "")
        
        
        
    }
    

    func getInfoClientes(){
        
        self.clientesArray.append( Cliente(key: "key", nombre: "Tec de monterrey", numero: "129", pais: "MX"))
        
        tableNombreCliente.reloadData()
        tableNumeroCliente.reloadData()
    }
    
    func getInfoProyectos(keyCliente: String){
        if (keyCliente == ""){
            self.proyectosArray.append(Proyecto(key: "keyProyecto", nombre: "NAICM", numero: "12313", pais: "MX", keyCliente: "4321"))
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }else{
            self.proyectosArray.append(Proyecto(key: "keyProyectoTec", nombre: "Nueva unidad", numero: "334", pais: "MX", keyCliente: "key"))
        }
        
        tableNombreProyecto.reloadData()
        tableNumeroProyecto.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //cCreo una variable para inicializar
        if(segue.identifier == "confirmacionProyecto"){
            let receiverVC = segue.destination as! ConfirmacionProyectoVC
            receiverVC.reporteEnvio = self.reporteEnvio!
        }
        
        
        
    }
  

}
