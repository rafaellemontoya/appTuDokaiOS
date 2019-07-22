//
//  AgregarRemisionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class AgregarRemisionVC: UIViewController {
    
    var reporteEnvio: ReporteEnvio?

    @IBOutlet weak var numeroRemisionTF: UITextField!
    
    @IBAction func continuarBTN(_ sender: Any) {
        if (numeroRemisionTF.text == ""){
            let alert = UIAlertController(title: "No puedes agregar un número de remisión vacío", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //regreso a la pantalla anterior
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.reporteEnvio!.setNumeroRemision(numeroRemision: numeroRemisionTF.text!)
            let alert = UIAlertController(title: "Número de remisión agregado con éxito", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                //regreso a la pantalla anterior
                self.performSegue(withIdentifier: "menuPrincipalSegue", sender: self)
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelarBTN(_ sender: Any) {
        _=self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "menuPrincipalSegue"){
            
        }
    }
    

  

}
