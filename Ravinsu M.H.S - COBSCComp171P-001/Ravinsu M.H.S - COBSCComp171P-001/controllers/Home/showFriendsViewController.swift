//
//  showFriendsViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/20/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Kingfisher

class showFriendsViewController: UIViewController {

    @IBOutlet weak var studentImg: UIImageView!
    @IBOutlet weak var studenfName: UILabel!
    var studentInfo : Student!
    @IBOutlet weak var studentlName: UILabel!
    @IBOutlet weak var studentPhoneNumber: UILabel!
    @IBOutlet weak var studentFbProfile: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.studentImg.layer.cornerRadius = self.studentImg.bounds.height / 2
        studentImg.clipsToBounds = true
        
        self.studenfName.text! = studentInfo.fName + " " + studentInfo.lName
//        self.studentlName.text! = studentInfo.lName
        self.studentPhoneNumber.text! = String(studentInfo.phoneNumber!)
        self.studentFbProfile.text! = studentInfo.fbUrl
        let url = URL(string: studentInfo.profUrl)
        studentImg.kf.setImage(with: url)
        // Do any additional setup after loading the view.
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
