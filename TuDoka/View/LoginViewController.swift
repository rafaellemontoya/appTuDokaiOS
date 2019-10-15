//
//  LoginViewController.swift
//  TuDoka
//
//  Created by Rafael Montoya on 9/26/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var usuarioTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBAction func continuarBTN(_ sender: Any) {
        var email = usuarioTF!.text
        var password = passwordTF!.text
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                 
                 if let error = error {
                     print(error)
                     UIApplication.shared.endIgnoringInteractionEvents()
                     
                     var titulo="Error"
                     if(error.localizedDescription == "The password is invalid or the user does not have a password."){
                         titulo="Contraseña incorrecta"
                         
                         
                     }else if(error.localizedDescription == "The email address is badly formatted."){
                         titulo="El email no es válido"
                         
                     }else if(error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."){
                         titulo="Usuario no encontrado"
        
                     }
                     
                     
                     
                 }
                 else if let user = user {
                    
                    
                    
                    self.performSegue(withIdentifier: "sesionIniciadaS", sender: self)
                     
                     
                 }
             }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        delegarTF()
        
        if((Auth.auth().currentUser?.uid) != nil){
            performSegue(withIdentifier: "sesionIniciadaS", sender: self)
        }
    }
    

       func delegarTF(){
         self.usuarioTF.delegate = self
         self.passwordTF.delegate = self;
         }
     @objc func dismissKeyboard() {
         //Causes the view (or one of its embedded text fields) to resign the first responder status.
         view.endEditing(true)
     }
     
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
         usuarioTF.resignFirstResponder()
         passwordTF.resignFirstResponder()
         self.view.endEditing(true)
         return true
     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Atrás"
        navigationItem.backBarButtonItem = backItem
    }

}
