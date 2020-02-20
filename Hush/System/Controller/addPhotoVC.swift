//
//  addPhotoVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class addPhotoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lbl_description: UILabel!
    var imagePicker = UIImagePickerController()
    
    var selectImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl_description.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        imagePicker.delegate = self
    }
    
    func openCamera()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FacedetectorVC") as! FacedetectorVC
        self.navigationController?.pushViewController(vc, animated: true)

//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
//        {
//            imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            imagePicker.allowsEditing = true
//            imagePicker.cameraDevice = .front
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//        else
//        {
//            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Provide a context for the actions.", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take a photo", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Camera Roll", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        /*If you want work actionsheet on ipad
        then you have to use popoverPresentationController to present the actionsheet,
        otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func click_skip(_ sender: UIButton) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //for swift below 4.2
    //func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //    picker.dismiss(animated: true, completion: nil)
    //    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    //    pickImageCallback?(image)
    //}

    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        self.selectImage = image
        
        picker.dismiss(animated: true) {
            if picker.sourceType == .camera {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FaceDetection_NewVC") as! FaceDetection_NewVC
//                vc.selectImage = self.selectImage
//                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "editImageVc") as! editImageVc
                vc.selectImage = self.selectImage
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
//        pickImageCallback?(image)
    }

}
