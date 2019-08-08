//
//  ItemsSeguimientoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ItemsSeguimientoVC: UIViewController {
    
    var reporte: ReporteSeguimiento?
    var itemSeleccionado: ActividadCapacitacion?
    @IBOutlet weak var descripcionActividad: UITextView!
    
    @IBAction func continuarBTN(_ sender: Any) {
        
        if (descripcionActividad.text! != ""){
            itemSeleccionado = ActividadCapacitacion()
            itemSeleccionado!.setDescripcion(descripcion: descripcionActividad.text!)
            reporte?.setItems(item: itemSeleccionado!)
            performSegue(withIdentifier: "fotosSeguimientoSegue", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fotosSeguimientoSegue"){
            let receiverVC = segue.destination as! ResumenSeguimientoViewController
            receiverVC.reporte = self.reporte!
        }
    }
    
    
    
}
