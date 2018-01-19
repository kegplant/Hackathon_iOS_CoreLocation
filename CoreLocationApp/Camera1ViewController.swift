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

class Camera1ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takePicture(_sender: Any){
        
        let imagePickerController = UIImagePickerController()
        
        let  actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: . actionSheet)
        
        
        //activates camera
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                print("camera is activated")
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("camera is down")
            }
        }))
        //activates photo library
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            print("photo library is available")
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        
        
        //allows user to select cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        //allows
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            //image object...use the
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imageView.image = image
            print ("i have the photo now")
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }

        override func viewDidLoad() {
            super.viewDidLoad()

    // Do any additional setup after loading the view.
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()


        // Dispose of any resources that can be recreated.
            }
    

    }


