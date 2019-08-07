//
//  ResumenItemsVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class ResumenItemsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    var reporteEnvio: ReporteEnvio?
    
    
    
    @IBOutlet weak var tableViewFotos: UITableView!
    
    
    @IBAction func continuarBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "¿Estás seguro de querer continuar?", message: "No podrás agregar items ni fotos en este reporte", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continuar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior

            self.performSegue(withIdentifier: "fotosTransporteSegue", sender: self)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reporteEnvio!.getItems()[section].getPhotos().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableViewFotos.dequeueReusableCell(withIdentifier: "celdaItem") as! FotosResumenTableViewCell
            cell.resumenItems = self
      
            cell.agregarCelda(image:  (self.reporteEnvio!.getItems()[indexPath.section].getPhotos()[indexPath.row]))
        
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reporteEnvio!.getItems().count
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerResumenCell") as! HeaderResumenItemsTableViewCell
        cell.agregarHeader(item: self.reporteEnvio!.getItems()[section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerResumenCell")
        return cell?.bounds.height ?? 44
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        tableViewFotos.dataSource = self
        tableViewFotos.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "fotosTransporteSegue"){
            let receiver = segue.destination as! FotosTransporteVC
            receiver.reporte = self.reporteEnvio!
        }
    }
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    func perfomZoomInForStartingImageView(startingImageView: UIImageView){
        
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, to: nil)
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = UIColor.black
        zoomingImageView.image = startingImageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut)))
        
        if let keyWindow = UIApplication.shared.keyWindow{
            
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            
            
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            let height = startingFrame!.height / startingFrame!.width * keyWindow.frame.width
            UIView.animate(withDuration: 0.5) {
                self.blackBackgroundView!.alpha = 1
                zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                zoomingImageView.center = keyWindow.center
                
                
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer)  {
        
        
        if let zoomOutImageView = tapGesture.view{
            
            UIView.animate(withDuration: 0.5, animations: {
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
            }) { (completed: Bool) in
                zoomOutImageView.removeFromSuperview()
            }
            
        }
        
        
    }
    func eliminarFoto(cell: FotosResumenTableViewCell){
        guard let indexPath = self.tableViewFotos.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar esta foto?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.reporteEnvio!.getItems()[indexPath.section].eliminarFoto(foto: indexPath.row)
            self.tableViewFotos.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

