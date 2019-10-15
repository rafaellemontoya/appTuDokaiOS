//
//  NumerosDevolucionViewController.swift
//  TuDoka
//
//  Created by Rafael Montoya on 9/19/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class NumerosDevolucionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    
    
    
    var reporte: ReporteDevolucion?
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var tableViewFotos: UITableView!
    
    
    
    @IBOutlet weak var numeroRemisionTF: UITextField!
    
    
    
    @IBAction func agregarRemisionBTN(_ sender: Any) {
        if (numeroRemisionTF.text == ""){
            let alert = UIAlertController(title: "No puedes agregar un número de remisión vacío", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //regreso a la pantalla anterior
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            reporte?.listaRemision.append(numeroRemisionTF.text!)
            self.tableViewFotos.reloadData()
            numeroRemisionTF.text = ""
        }
        
    }
    
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        performSegue(withIdentifier: "fotosTransporteSegue", sender: self)
        
        
        
    }
    
    @IBAction func cancelarBTN(_ sender: Any) {
        _=self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewFotos.backgroundColor = UIColor.white
        tableViewFotos.dataSource = self
        tableViewFotos.delegate = self
        delegarTF()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        if (segue.identifier == "fotosTransporteSegue"){
            let receiver = segue.destination as! DatosTransporteDevolucionVC
            receiver.reporte = self.reporte!
        }
    }
    func eliminarItem(cell: RemisionTableViewCell){
        guard let indexPath = self.tableViewFotos.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar este item?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            self.reporte!.listaRemision.remove (at: indexPath.row)
            self.tableViewFotos.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.reporte?.listaRemision.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewFotos.dequeueReusableCell(withIdentifier: "cellR") as! RemisionTableViewCell
        cell.numerosDevolucion = self
        
        cell.agregarCelda(value:  (self.reporte!.listaRemision [indexPath.row]))
        
        
        
        
        return cell
    }
    
    
    func delegarTF(){
        self.numeroRemisionTF.delegate = self
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        numeroRemisionTF.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
}
