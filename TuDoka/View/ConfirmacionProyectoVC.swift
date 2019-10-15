//
//  ConfirmacionProyecto.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/15/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ConfirmacionProyectoVC: UIViewController {
    
    var reporteEnvio: ReporteEnvio?
    
    @IBOutlet weak var nombreCliente: UILabel!
    
    @IBOutlet weak var numeroCliente: UILabel!
    
    @IBOutlet weak var nombreProyecto: UILabel!
    
    @IBOutlet weak var numeroProyecto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
    }
    

    func loadData(){
        nombreCliente.text = self.reporteEnvio!.getCliente().nombre
        numeroCliente.text = self.reporteEnvio!.getCliente().numero
        
        nombreProyecto.text = self.reporteEnvio!.getProyecto().nombre
        numeroProyecto.text = self.reporteEnvio!.getProyecto().numero
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        //cCreo una variable para inicializar
        if(segue.identifier == "itemsSegue"){
            let receiverVC = segue.destination as! ItemsVC
            receiverVC.reporteEnvio = self.reporteEnvio!
        }
        
        
        
    }
    

}
