//
//  AddhomeworkViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/26/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit

class AddhomeworkViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text: String = ""
    var homeworkViewCon: HomeworkViewController!
  
    override func viewDidLoad() {
        super.viewDidLoad()

          textView.text = text
        // Do any additional setup after loading the view.
    }
    
    func setText(t: String){
        text = t
        if isViewLoaded {
            textView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeworkViewCon.newRowdded = textView.text!
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
