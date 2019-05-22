//
//  SignUpViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/22/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftyPickerPopover
import Photos



class SignUpViewController: UIViewController {

    @IBOutlet weak var profImgView: UIImageView!
    @IBOutlet weak var tapToPickImg: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confoPassword: UITextField!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var imagePicker:UIImagePickerController!
    var dbReference: DatabaseReference!
    var downloadImageUrl: String = ""
    var imageOriginal: String = ""
    var user: [User] = []
    
    //Temp user detail
    let uName: String = ""
    let uBod: String = ""
    let uAge: Int = 0
    let uProfImgUrl: String = ""
    let uEmail: String = ""
    let uPassword: String = ""
    //End of temp user details.
    
    //Property Observer
    var imagUrlSet = 0 {
        didSet{
            print("Did Set Setted : \(downloadImageUrl)")
            
            //self.signup()
        }
    }
    //End Property Oberver
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //img picker settings
        self.profImgView.layer.cornerRadius = self.profImgView.bounds.height / 2
        self.profImgView.clipsToBounds = true
        //ens image picker settings

        //Savein btn properties
        saveBtn.layer.borderWidth = 1.0
        saveBtn.layer.borderColor = UIColor.white.cgColor
        saveBtn.layer.cornerRadius = self.saveBtn.bounds.height / 2
        //End of save button
        
        //cancelbtn btn properties
        cancelbtn.layer.borderWidth = 1.0
        cancelbtn.layer.borderColor = UIColor.white.cgColor
        cancelbtn.layer.cornerRadius = self.cancelbtn.bounds.height / 2
        //End of cancelbtn button
        
        //Add image picker
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        //end adding image picker
        
        //image View Config
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profImgView.isUserInteractionEnabled = true
        profImgView.addGestureRecognizer(imageTap)
        tapToPickImg.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        //end Image View Config

        
        // Do any additional setup after loading the view.
    }
    
    @objc func openImagePicker(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pick(_ sender: Any) {
        // 6
        DatePickerPopover(title: "DatePicker")
            .setDoneButton(action: { _, selectedDate in self.setdate(date: selectedDate)})
            .appear(originView: sender as! UIView, baseViewController: self)
        
    }
    
    
    //Convert and get data from picker
    func setdate(date:Date){
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let bday = df.string(from: date)
        self.birthDate.text = bday
        
    }
   //End data getting
    
    @IBAction func saveData(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func cancelSignUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
import GoogleSignIn    }
    */

}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            print("Image Name : \(imgName)")
            self.imageOriginal = imgName
            let imgExtension = imgUrl.pathExtension
            print("Image Type : \(imgExtension)")
        }
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profImgView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        //print("information : " info)
        
    }
}
