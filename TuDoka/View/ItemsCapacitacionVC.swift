//
//  ItemsCapacitacionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsCapacitacionVC: UIViewController {

    var reporte: ReporteCapacitacion?
     var itemSeleccionado: ActividadCapacitacion?
    @IBOutlet weak var descripcionActividad: UITextView!
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        if (descripcionActividad.text! != ""){
            itemSeleccionado = ActividadCapacitacion()
            itemSeleccionado!.setDescripcion(descripcion: descripcionActividad.text!)
            reporte?.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "fotosCapacitacionSegue", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fotosCapacitacionSegue"){
            let receiverVC = segue.destination as! FotosCapacitacionVC
            receiverVC.reporte = self.reporte!
        }
    }
    

    
}
