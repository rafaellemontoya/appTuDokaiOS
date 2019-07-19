//
//  ItemsVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/16/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var reporteEnvio: ReporteEnvio?
    var itemsArray: [Item] = []
    var itemSeleccionado: Item?
    
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
    
    
    @IBAction func btnContinuar(_ sender: Any) {
        
        if (unidadesItemTF.text == ""){
            print("error")
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesItemTF.text!)! )
            reporteEnvio!.setItems(item: itemSeleccionado!)
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

        getInfo()
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaTV.delegate = self
        nombrePiezaTV.dataSource = self
    }
    
    func getInfo(){
        self.itemsArray.append(Item(key: "keyItem1", nombre: "NombreItem1", codigo: "codigo item1", pais: "MX"))
        self.itemsArray.append(Item(key: "keyItem2", nombre: "NombreItem2", codigo: "codigo item2", pais: "MX"))
        self.itemsArray.append(Item(key: "keyItem3", nombre: "NombreItem3", codigo: "codigo item3", pais: "MX"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resumenFotosSegue"){
            let receiverVC = segue.destination as! ResumenFotosVC
            receiverVC.reporteEnvio = self.reporteEnvio!
        }
    }

    

}
