//
//  ItemsDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsDevolucionVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var reporteDevolucion: ReporteDevolucion?
    var itemsArray: [Item] = []
    var itemSeleccionado: Item?
    
    
    @IBOutlet weak var nombrePiezaDevolucionTV: UITableView!
    
    
    
    @IBOutlet weak var codigoPiezaTV: UITableView!
    
    
    @IBOutlet weak var nombrePiezaTF: UITextField!
    
    
    @IBAction func nombrePiezaTFTouch(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaDevolucionTV.isHidden = false;
    }
    
    @IBAction func nombrePiezaTFEdit(_ sender: Any) {
        print(nombrePiezaTF.text)
        codigoPiezaTV.isHidden = true;
        nombrePiezaDevolucionTV.isHidden = false;
    }
    
    
    @IBOutlet weak var codigoPiezaTF: UITextField!
    
    @IBAction func codigoPiezaTFTouch(_ sender: Any) {
        codigoPiezaTV.isHidden = false;
        nombrePiezaDevolucionTV.isHidden = true;
    }
    
    @IBAction func codigoPiezaTFEdit(_ sender: Any) {
        print(nombrePiezaTF.text)
        codigoPiezaTV.isHidden = false;
        nombrePiezaDevolucionTV.isHidden = true;
    }
    
    
    @IBOutlet weak var unidadesTF: UITextField!
    
    
    
    @IBAction func continuarBTN(_ sender: Any) {
        if (unidadesTF.text == ""){
            print("error")
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesTF.text!)! )
            reporteDevolucion!.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "fotoItemDevolucionSegue", sender: self)
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = OptionDevolucionTableViewCell()
        switch tableView {
        case self.nombrePiezaDevolucionTV:
            cell = nombrePiezaDevolucionTV.dequeueReusableCell(withIdentifier: "optionNombrePieza") as! OptionDevolucionTableViewCell
            cell.agregarCelda(name: self.itemsArray[indexPath.row].getNombre())
            break;
        case self.codigoPiezaTV:
            cell = codigoPiezaTV.dequeueReusableCell(withIdentifier: "optionCodigoPieza") as! OptionDevolucionTableViewCell
            cell.agregarCelda(name: self.itemsArray[indexPath.row].getCodigo())
            break;
            
        default:
            cell = OptionDevolucionTableViewCell()
            break;
        }
        
        
        
        return cell;
    }
    
    //funcion cuando se da click a una celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        //Cliente seleccionado
        if (tableView == self.nombrePiezaDevolucionTV || tableView == self.codigoPiezaTV){
            self.nombrePiezaDevolucionTV.isHidden = true;
            self.codigoPiezaTV.isHidden = true;
            nombrePiezaTF.text = self.itemsArray[indexPath.row].getNombre()
            codigoPiezaTF.text = self.itemsArray[indexPath.row].getCodigo()
            
            self.itemSeleccionado = itemsArray[indexPath.row];
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfo()
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaDevolucionTV.delegate = self
        nombrePiezaDevolucionTV.dataSource = self
    }
    
    func getInfo(){
        FirebaseDBManager.dbInstance.obtenerItems(){
            (respuesta, respuestaArray) in
            if(respuesta){
                self.itemsArray = respuestaArray!
                self.nombrePiezaDevolucionTV.reloadData()
                self.codigoPiezaTV.reloadData()
                
            }else{
                print("Error obteniendo documentos ")
            }
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fotoItemDevolucionSegue"){
            let receiverVC = segue.destination as! FotosItemDevolucionVC
            receiverVC.reporteDevolucion = self.reporteDevolucion!
        }
    }
    
    

}
