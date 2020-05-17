//
//  EditImage.swift
//  TuDoka
//
//  Created by Oscar de los Rios on 10/18/19.
//  Copyright © 2019 M y T Desarrollo de Software. All rights reserved.
//

import UIKit
import SwiftyDraw

protocol PassBackImageDelegate {
    func setEditedImage(newImage: UIImage, destination: String)
}

class EditImage: UIViewController, SwiftyDrawViewDelegate {
    @IBOutlet weak var BackgroundIV: UIImageView!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    var delegate: PassBackImageDelegate?
    var drawView: SwiftyDrawView!
    var backgroundImage: UIImage?
    var newImage: UIImage!
    var dest: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView = SwiftyDrawView(frame: self.view.frame)
        drawView.brush.color = .red
        drawView.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0)

        self.view.addSubview(drawView)
        
        if (backgroundImage != nil) {
            BackgroundIV.image = backgroundImage!
        }
    }
    
    @IBAction func save(_ sender: Any) {
        newImage = image(with: self.view)
        delegate?.setEditedImage(newImage: newImage, destination: dest)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func swiftyDraw(shouldBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) -> Bool {
        return true;
    }
    
    func swiftyDraw(didBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(isDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(didFinishDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    func swiftyDraw(didCancelDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        
    }
    
    @IBAction func undo(_ sender: Any) {
        if (!drawView.canUndo){
            return
        }
        
        drawView.undo()
    }
    
    @IBAction func redo(_ sender: Any) {
        if (!drawView.canRedo) {
            return
        }
        
        drawView.redo()
    }
}
