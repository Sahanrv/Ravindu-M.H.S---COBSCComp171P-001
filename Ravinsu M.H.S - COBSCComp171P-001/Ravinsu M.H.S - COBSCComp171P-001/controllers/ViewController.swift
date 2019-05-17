//
//  ViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/16/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imgMain: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //btn logIn
        btnLogIn.layer.borderWidth = 1.0
        btnLogIn.layer.borderColor = UIColor.white.cgColor
        btnLogIn.layer.cornerRadius = self.btnLogIn.bounds.height / 2
        //end btn logIn

        //btn signUp
        btnSignUp.layer.borderWidth = 1.0
        btnSignUp.layer.borderColor = UIColor.white.cgColor
        btnSignUp.layer.cornerRadius = self.btnSignUp.bounds.height / 2
        //end btn signUp
        
        //add image to the image view
        self.imgMain.image = UIImage.init(named: "logo")
        //end image view
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

