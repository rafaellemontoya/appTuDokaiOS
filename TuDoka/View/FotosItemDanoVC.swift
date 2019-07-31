//
//  FotosItemDanoVC.swift
//  TuDoka
//
//  Created by Rafael Montoya on 7/30/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit

class FotosItemDanoVC:  UIViewController, UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate {
    
    var reporte: ReporteDano?
    var imagePicker: UIImagePickerController!
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    @IBOutlet weak var nombreItemLB: UILabel!
    
    @IBOutlet weak var codigoItemLB: UILabel!
    
    
    @IBOutlet weak var descripcionDanoTF: UITextView!
    
    
    @IBAction func nuevaFotoBTN(_ sender: Any) {
        imageSource()
    }
    
    
    @IBOutlet weak var tableViewFotos: UITableView!
    
    @IBAction func continuarBTN(_ sender: Any) {
        let alert = UIAlertController(title: "¡Item agregado correctamente!", message: "¿Quiéres agregar un nuevo item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Agregar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.performSegue(withIdentifier: "agregarItemDanoSegue", sender: self)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Continuar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.performSegue(withIdentifier: "resumenItemsDanoSegue", sender: self)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imageSource(){
        let alert = UIAlertController(title: "¿Quiéres tomar una nueva foto o seleccionar de tu galería?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Tomar foto", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.selectImageFrom(.camera)
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Seleccionar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.selectImageFrom(.photoLibrary)
            
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (reporte!.getItems().last?.getPhotos().count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewFotos.dequeueReusableCell(withIdentifier: "photoCell") as! FotosTableViewCell
        cell.fotosItemDano = self
        cell.agregarCelda(image: (self.reporte!.getItems().last?.getPhotos()[indexPath.row])!)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFotos.delegate = self
        tableViewFotos.dataSource = self
        
        nombreItemLB.text = reporte!.getItems().last?.getNombre()
        codigoItemLB.text = reporte!.getItems().last?.getCodigo()
        descripcionDanoTF.text = reporte!.getItems().last?.getDescripcionDano()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "agregarItemDanoSegue"){
            let receiver = segue.destination as! ItemsDanoVC
            receiver.reporte = self.reporte!
        }else if(segue.identifier == "resumenItemsDanoSegue"){
            let receiver = segue.destination as! ResumenItemsDanoVC
            receiver.reporte = self.reporte!
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
    func eliminarFoto(cell: FotosTableViewCell){
        guard let indexPath = self.tableViewFotos.indexPath(for: cell) else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let alert = UIAlertController(title: "¿Estás seguro de elimar esta foto?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Eliminar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            self.reporte!.getItems().last?.eliminarFoto(foto: indexPath.row)
            self.tableViewFotos.reloadData()
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            //regreso a la pantalla anterior
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}

extension FotosItemDanoVC: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        print ("hola desde extension")
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        self.reporte!.getItems().last?.addPhoto(foto: selectedImage)
        tableViewFotos.reloadData()
        //imagenCamara.image = SharedControladores.shared.resize(selectedImage)
        
    }
    
}
