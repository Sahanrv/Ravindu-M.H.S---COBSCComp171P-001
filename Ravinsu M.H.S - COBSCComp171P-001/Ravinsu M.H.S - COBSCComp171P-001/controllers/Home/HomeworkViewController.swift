//
//  HomeworkViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/24/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController {

    @IBOutlet weak var homeWork: UITextView!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var save: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Edit in btn properties
        edit.layer.borderWidth = 1.0
        edit.layer.borderColor = UIColor.white.cgColor
        edit.layer.cornerRadius = self.edit.bounds.height / 2
        edit.backgroundColor = UIColor.blue
        //End of edit button
        
        //Save in btn properties
        save.layer.borderWidth = 1.0
        save.layer.borderColor = UIColor.white.cgColor
        save.layer.cornerRadius = self.save.bounds.height / 2
        save.backgroundColor = UIColor.gray
        self.save.isEnabled = false
        //Save of edit button
        
       //Text properties
        self.homeWork.isEditable = false
        self.homeWork.backgroundColor = UIColor.lightGray
        //End of text properties
        
        let dataview = UserDefaults.standard.object(forKey: "mywork")
        
        if let datashow = dataview as? String {
            self.homeWork.text! = datashow       }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func EditData(_ sender: Any) {
        self.save.backgroundColor = UIColor.blue
        self.save.isEnabled = true
        
        self.homeWork.isEditable = true
        self.homeWork.backgroundColor = UIColor.white
        
        edit.backgroundColor = UIColor.gray
        self.edit.isEnabled = false
    }
    
    @IBAction func SaveData(_ sender: Any) {
         UserDefaults.standard.set(self.homeWork.text!, forKey: "mywork")
        
        self.save.backgroundColor = UIColor.gray
        self.save.isEnabled = false
        
        self.homeWork.isEditable = false
        
        self.homeWork.backgroundColor = UIColor.lightGray
        self.edit.isEnabled = true
        self.edit.backgroundColor = UIColor.blue
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
