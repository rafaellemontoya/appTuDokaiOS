//
//  ConfirmacionDatosDevolucionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/29/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ConfirmacionDatosDevolucionVC: UIViewController {
    
    var reporteDevolucion: ReporteDevolucion?

    @IBOutlet weak var nombreClienteTF: UILabel!
    
    @IBOutlet weak var numeroClienteTF: UILabel!
    
    @IBOutlet weak var nombreProyectoLB: UILabel!
    
    @IBOutlet weak var numeroProyectoLB: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nombreClienteTF.text = reporteDevolucion?.getCliente().nombre
        
        numeroClienteTF.text = reporteDevolucion?.getCliente().numero
        nombreProyectoLB.text = reporteDevolucion?.getProyecto().nombre
        numeroProyectoLB.text = reporteDevolucion?.getProyecto().numero
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        //cCreo una variable para inicializar
        if(segue.identifier == "documentosClienteS"){
            let receiverVC = segue.destination as! DocumentoClienteViewController
            receiverVC.reporte = self.reporteDevolucion!
        }
        
        
        
    }


}
