//
//  ItemsDanoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsDanoVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var reporte: ReporteDano?
    var itemsArray: [Item] = []
    var tipoDanoArray: [TipoDano] = []
    var itemSeleccionado: Item?
    var tipoDanoSeleccionado: TipoDano?
    
    @IBOutlet weak var codigoPiezaTV: UITableView!
    
    @IBOutlet weak var tipoDanoTV: UITableView!
    
    @IBOutlet weak var nombrePiezaTV: UITableView!
    
    @IBOutlet weak var nombreItemTF: UITextField!
    
    @IBOutlet weak var codigoItemF: UITextField!
    
    @IBOutlet weak var unidadesItemTF: UITextField!
    
    
    @IBOutlet weak var descripcionDanoTF: UITextView!
    
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
    }
    
    @IBAction func tipoDanoEdit(_ sender: Any) {
        codigoPiezaTV.isHidden = true;
        nombrePiezaTV.isHidden = true;
        tipoDanoTV.isHidden = false;
    }
    
    
    
    @IBAction func btnContinuar(_ sender: Any) {
        
        if (unidadesItemTF.text == "" || descripcionDanoTF.text == ""){
            print("error")
        }else{
            itemSeleccionado!.setUnidades(unidades: Int (unidadesItemTF.text!)! )
            itemSeleccionado!.setDescripcionDano(descripcion: descripcionDanoTF.text!)
            itemSeleccionado!.setTipoDano(tipoDano: tipoDanoSeleccionado!)
            
            reporte!.setItems(item: itemSeleccionado!)
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
        
        getInfo()
        codigoPiezaTV.delegate = self
        codigoPiezaTV.dataSource = self
        nombrePiezaTV.delegate = self
        nombrePiezaTV.dataSource = self
        
        tipoDanoTV.delegate = self
        tipoDanoTV.dataSource = self
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
        FirebaseDBManager.dbInstance.obtenerDescripcionDano(){
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
        if (segue.identifier == "fotosDanoSegue"){
            let receiverVC = segue.destination as! ResumenItemsDanoVC
            receiverVC.reporte = self.reporte!
        }
    }
    
    
    
}
