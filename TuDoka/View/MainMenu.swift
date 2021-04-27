//
//  MainMenu.swift
//  TuDoka
//
//  Created by Rafael Montoya on 6/26/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import Firebase

class MainMenu: UIViewController {
    
    var nombreUsuario: String = "";
    @IBAction func cerrarSesion(_ sender: Any) {
           let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "logoutSG", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func cambiarIdioma(_ sender: Any) {
        print(LocalizationSystem.sharedInstance.getLanguage())
        if(LocalizationSystem.sharedInstance.getLanguage() != "pt"){
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "pt")
            viewDidLoad()
        }else{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            viewDidLoad()
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true

        
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.hidesBackButton = true
        
    }
    

 

}
