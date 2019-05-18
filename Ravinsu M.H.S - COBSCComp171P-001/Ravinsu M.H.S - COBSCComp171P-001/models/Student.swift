//
//  Students.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/18/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import Foundation

class Student{
    
    //let id: Int!
    let fName: String!
    let lName: String!
    let phoneNumber: Int!
    let fbUrl: String!
    let city: String!
    let profUrl: String!
    
    init(fName: String, lName: String, phoneNumber:Int!, fbUrl: String, city: String, profUrl: String){
        
       // self.id = id
        self.fName = fName
        self.lName = lName
        self.phoneNumber = phoneNumber
        self.fbUrl = fbUrl
        self.city = city
        self.profUrl = profUrl
        
    }
}
