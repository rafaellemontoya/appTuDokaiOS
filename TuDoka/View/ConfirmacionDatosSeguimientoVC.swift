//
//  ConfirmacionDatosSeguimientoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 8/1/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ConfirmacionDatosSeguimientoVC: UIViewController {
    
    
    var reporte: ReporteSeguimiento?
    
    @IBOutlet weak var nombreClienteTF: UILabel!
    
    @IBOutlet weak var numeroClienteTF: UILabel!
    
    @IBOutlet weak var nombreProyectoLB: UILabel!
    
    @IBOutlet weak var numeroProyectoLB: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        nombreClienteTF.text = reporte?.getCliente().nombre
        
        numeroClienteTF.text = reporte?.getCliente().numero
        nombreProyectoLB.text = reporte?.getProyecto().nombre
        numeroProyectoLB.text = reporte?.getProyecto().numero
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //cCreo una variable para inicializar
        if(segue.identifier == "itemsSeguimientoSegue"){
            let receiverVC = segue.destination as! ItemsSeguimientoVC
            receiverVC.reporte = self.reporte!
        }
        
        
        
    }
    
    
}
