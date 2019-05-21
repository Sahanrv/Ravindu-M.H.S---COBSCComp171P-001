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
    @IBOutlet weak var studentName: UILabel!
    var studentInfo : Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentName.text = studentInfo.fName + " " + studentInfo.lName
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
