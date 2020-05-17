//
//  EnviarCorreosVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/31/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class EnviarCorreosCapacitacionVC: UIViewController, UITextFieldDelegate {
    
    var  reporte: ReporteCapacitacion?
    
    var emails: [String] = []
    
    @IBOutlet weak var email1TF: UITextField!
    
    @IBOutlet weak var email2TF: UITextField!
    
    @IBOutlet weak var email3TF: UITextField!
    
    @IBAction func salir(_ sender: Any) {
        self.performSegue(withIdentifier: "menuPrincipalCapacitacionSegue", sender: self)
    }
    
    
    @IBAction func finalizarBTN(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "¿Estás seguro de querer enviar el reporte?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
//            UIApplication.shared.beginIgnoringInteractionEvents()
            //Guardar info)
            CustomLoader.instance.showLoaderView()
            
            //Enviar correos
            self.emails = []
            self.cargarEmails()
            
//            self.performSegue(withIdentifier: "menuPrincipalCapacitacionSegue", sender: self)
            
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegarTF()
        
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }


    func cargarEmails(){
        if(email1TF.text! != ""){
            emails.append(email1TF.text!)
        }
        if(email2TF.text! != ""){
            emails.append(email2TF.text!)
            
        }
        if(email3TF.text! != ""){
            emails.append(email3TF.text!)
        }
        self.enviarEmails()
    }
    
    func enviarEmails(){
        
        let session = URLSession.shared
        let url = URL(string: "https://www.themyt.com/reportedoka/reporteCapacitacion.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Powered by Swift!", forHTTPHeaderField: "X-Powered-By")
        
        struct PDF: Codable {
            let reporteId: String
            let items: [ActividadCapacitacion]
            let emails: [String]
            let nombreCurso: String
            let nombreUsuario: String
            let emailUsuario: String
            let nombreProyecto : String
            let numeroProyecto : String
            let nombreCliente: String
            let numeroCliente: String
            let usuario: String
            
        }
        
        // ...
        
        let pdf = PDF(reporteId: reporte!.getIdReporte(),
                      items: reporte!.getItems(),
                      emails: self.emails,
                      nombreCurso: self.reporte!.getNombreCurso(),
                      nombreUsuario: self.reporte!.nombreUsuario,
                      emailUsuario: self.reporte!.emailUsuario,
                      nombreProyecto: reporte!.getProyecto().nombre,
                      numeroProyecto: reporte!.getProyecto().numero,
                      nombreCliente: reporte!.getCliente().nombre,
                      numeroCliente: reporte!.getCliente().numero,
                      usuario: reporte!.getIdUsuario()
        )
        guard let uploadData = try? JSONEncoder().encode(pdf) else {
            return
        }
        
        
        let task = session.uploadTask(with: request, from: uploadData) { data, response, error in
            // Do something...
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print(dataString)
                DispatchQueue.main.async(execute: {
                    /// code goes here
                    self.emailsEnviados()
                })
            }
        }
        
        task.resume()
        
        
    }
    func emailsEnviados(){
        UIApplication.shared.endIgnoringInteractionEvents()
        CustomLoader.instance.hideLoaderView()
        
        let alert = UIAlertController(title: "Reporte enviado con éxito", message: "¿Quieres enviar a más personas?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Salir", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
            self.performSegue(withIdentifier: "menuPrincipalCapacitacionSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Enviar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            //Guardar info
            self.email1TF.text = ""
            self.email2TF.text = ""
            self.email3TF.text = ""
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        // dispatch to main thread to stop activity indicator
        
        
        
    }
    
    func delegarTF(){
        self.email1TF.delegate = self
        self.email2TF.delegate = self;
        self.email3TF.delegate = self
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email1TF.resignFirstResponder()
        email2TF.resignFirstResponder()
        email3TF.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

}
