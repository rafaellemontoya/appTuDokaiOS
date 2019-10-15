//
//  ConfirmacionDatosDanoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ConfirmacionDatosDanoVC: UIViewController {


    var reporteDano: ReporteDano?
    
    @IBOutlet weak var nombreClienteTF: UILabel!
    
    @IBOutlet weak var numeroClienteTF: UILabel!
    
    @IBOutlet weak var nombreProyectoLB: UILabel!
    
    @IBOutlet weak var numeroProyectoLB: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nombreClienteTF.text = reporteDano?.getCliente().nombre
        
        numeroClienteTF.text = reporteDano?.getCliente().numero
        nombreProyectoLB.text = reporteDano?.getProyecto().nombre
        numeroProyectoLB.text = reporteDano?.getProyecto().numero
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        //cCreo una variable para inicializar
        if(segue.identifier == "itemsDanoSegue"){
            let receiverVC = segue.destination as! ItemsDanoVC
            receiverVC.reporte = self.reporteDano!
        }
        
        
        
    }


}
