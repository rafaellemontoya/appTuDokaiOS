//
//  IntroduccionViewController.swift
//  TuDoka
//
//  Created by Doka Dev on 10/14/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class IntroduccionViewController: UIViewController {

    @IBAction func btnIniciarSesion(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }

    @IBAction func contacto(_ sender: Any) {
        guard let url = URL(string: "https://www.doka.com/mx/index") else { return }
        UIApplication.shared.open(url)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
