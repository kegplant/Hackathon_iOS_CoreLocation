//
//  Camera1ViewController.swift
//  CoreLocationApp
//
//  Created by Lilian Tashiro on 1/18/18.
//  Copyright © 2018 Song. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import ImagePicker


class Camera1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerDelegate{

 
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    lazy var button: UIButton = self.makeButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(
            NSLayoutConstraint(item: button, attribute: .centerX,
                               relatedBy: .equal, toItem: view,
                               attribute: .centerX, multiplier: 1,
                               constant: 0))
        
        view.addConstraint(
            NSLayoutConstraint(item: button, attribute: .centerY,
                               relatedBy: .equal, toItem: view,
                               attribute: .centerY, multiplier: 1,
                               constant: 0))
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
//        button.setTitle("TAKE A PICTURE OF THE OTHER CAR.", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)
        
        return button
    }
    
@objc func buttonTouched(button: UIButton) {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.recordLocation = false
        config.allowVideoSelection = true
        
        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerDelegate
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("displaying images")
        
        imageView.image=images[0]
        imageView2.image=images[1]

        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

