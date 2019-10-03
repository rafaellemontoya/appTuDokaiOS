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
        
        let firebaseAuth = Auth.auth()
       
        
        if (Auth.auth().currentUser != nil){
            performSegue(withIdentifier: "session", sender: self)
        }else{
            performSegue(withIdentifier: "noSesion", sender: self)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let firebaseAuth = Auth.auth()
        
         
         if (Auth.auth().currentUser != nil){
             performSegue(withIdentifier: "session", sender: self)
         }else{
             performSegue(withIdentifier: "noSesion", sender: self)
         }
    }
    //TODO CHECAR SESION
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if (segue.identifier == "session"){
        let receiverVC = segue.destination as! MainMenu
            
            
        }else if (segue.identifier == "noSesion"){
            
            
        }
        //
    }
    
    


}

