//
//  AddStudentViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/16/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Photos


class AddStudentViewController: UIViewController {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fNametxt: UITextField!
    @IBOutlet weak var lNametxt: UITextField!
    @IBOutlet weak var teltxt: UITextField!
    @IBOutlet weak var fbUrltxt: UITextField!
    @IBOutlet weak var cityNametxt: UITextField!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    var downloadImageUrl: String = ""
    var imageOriginal: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //btn Save
        btnSave.layer.borderWidth = 1.0
        btnSave.layer.borderColor = UIColor.white.cgColor
        btnSave.layer.cornerRadius = self.btnSave.bounds.height / 2
        //end btn Save
        
        //btn Clear
        btnClear.layer.borderWidth = 1.0
        btnClear.layer.borderColor = UIColor.white.cgColor
        btnClear.layer.cornerRadius = self.btnClear.bounds.height / 2
        //end btn Clear
    
        //Add image picker
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        //end adding image picker
        
        //self.profileImg.image = UIImage.init(named: "logo")
        
        //image View Config
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(imageTap)
        tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        //end Image View Config
    }
    
    @IBAction func saveData(_ sender: Any) {
        //self.uploadImageStore()
//        if let image = profileImg.image {
//            self.uploadProfileImage(image){ url in
//  uploadProfileImage
//            }
//        }
        //1. Upload Image
     
        //2. Save User Data
        //3. Dismiss
       
        self.uploadImage()
        
    }
    
    @objc func openImagePicker(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
   
    
    func uploadImage(){
        

       let storageRef = Storage.storage().reference()
        
        
        // Data in memory
        guard let data = self.profileImg.image!.jpegData(compressionQuality: 0.75) else {return}
         let image: UIImage = self.profileImg.image!
        print("Image Data : \(image)")
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/\(imageOriginal)")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
           guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            
            print("Meta Data : \(metadata)")
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            let url = riversRef.downloadURL { (url, error) in
                
                self.downloadImageUrl = (url?.absoluteString)!
                guard let downloadURL = url else {
                    
                    print("Error Img :\(error)")
                    return
                }
                
                print("Download URL \(downloadURL)")
            }
            
            print("URL : \(self.downloadImageUrl)")
        }
        
        

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

extension AddStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            print("Image Name : \(imgName)")
            self.imageOriginal = imgName
            let imgExtension = imgUrl.pathExtension
            print("Image Name : \(imgExtension)")
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImg.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        //print("information : " info)
        
    }
}