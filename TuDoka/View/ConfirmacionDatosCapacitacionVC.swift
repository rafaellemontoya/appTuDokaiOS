//
//  ConfirmacionDatosCapacitacionVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ConfirmacionDatosCapacitacionVC: UIViewController {
    
    
    var reporte: ReporteCapacitacion?
    
    @IBOutlet weak var nombreClienteTF: UILabel!
    
    @IBOutlet weak var numeroClienteTF: UILabel!
    
    @IBOutlet weak var nombreProyectoLB: UILabel!
    
    @IBOutlet weak var numeroProyectoLB: UILabel!
    
    @IBOutlet weak var nombreCurso: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        nombreCurso.text = reporte?.getNombreCurso()
        nombreClienteTF.text = reporte?.getCliente().nombre
        
        numeroClienteTF.text = reporte?.getCliente().numero
        nombreProyectoLB.text = reporte?.getProyecto().nombre
        numeroProyectoLB.text = reporte?.getProyecto().numero
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //cCreo una variable para inicializar
        if(segue.identifier == "itemsCapacitacionSegue"){
            let receiverVC = segue.destination as! ItemsCapacitacionVC
            receiverVC.reporte = self.reporte!
        }
        
        
        
    }
    
    
}
