//
//  tableTableViewCell.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/18/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit

class tableTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var city: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImg.layer.cornerRadius = self.profileImg.bounds.height / 2
        profileImg.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
