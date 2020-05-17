//
//  ViewController.swift
//  TuDoka
//
//  Created by Rafael Montoya on 6/26/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import Firebase

class InicioVC: UIViewController {

    @IBAction func continuar(_ sender: Any) {
        performSegue(withIdentifier: "session", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let firebaseAuth = Auth.auth()
//
//
//        if (Auth.auth().currentUser != nil){
//            DispatchQueue.main.asyncAfter(deadline:.now() + 5.0, execute: {
//               self.performSegue(withIdentifier: "session", sender: self)
//            })
//
//        }else{
//            DispatchQueue.main.asyncAfter(deadline:.now() + 5.0, execute: {
//               self.performSegue(withIdentifier: "noSesion", sender: self)
//            })
////            performSegue(withIdentifier: "noSesion", sender: self)
//        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let firebaseAuth = Auth.auth()
        
         DispatchQueue.main.asyncAfter(deadline:.now() + 3.0, execute: {
            self.performSegue(withIdentifier: "session", sender: self)
         })
         
    }
    //TODO CHECAR SESION
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
        
        
        if (segue.identifier == "session"){
        
            
            
        }else if (segue.identifier == "noSesion"){
            
            
        }
        //
    }
    
    


}

