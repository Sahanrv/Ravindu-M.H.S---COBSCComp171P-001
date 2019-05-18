//
//  HomeViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/18/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import Kingfisher

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
  

    @IBOutlet weak var studentTable: UITableView!
    
    var studentData: [Student] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.registerCell()
        self.getStudentList()
        self.studentTable.tableFooterView = UIView()
        
        studentTable.delegate = self
        studentTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        self.studentTable.register(UINib(nibName: "tableTableViewCell", bundle: nil), forCellReuseIdentifier: "tableTableViewCell")
        // self.tableView.register(singerViewCell.self, forCellReuseIdentifier: "singerViewCell")
    }
    
    
    func getStudentList() {
        //self.showActivity()
        
        self.ref.child("NIBMConnect/Students").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //let singersList = value!
            print(value!)
            var newstudent: [Student] = []
            
            if snapshot.childrenCount > 0 {
                for student in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let studentObject = student.value as? [String: AnyObject]
                    let student = Student(fName: studentObject!["fName"] as! String, lName: studentObject!["lName"] as! String, phoneNumber: studentObject!["phone"] as! Int, fbUrl: studentObject!["fbUrl"] as! String, city: studentObject!["city"] as! String, profUrl: studentObject!["imgUrl"] as! String)
                    
                    newstudent.append(student)
                }
            }
            self.studentData = newstudent
            
            print(self.studentData[0].fName)
            self.studentTable.reloadData()
            //self.hideActivity()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath ) as! tableTableViewCell
        
        let url = URL( string: self.studentData[indexPath.row].profUrl)
        cell.profileImg.kf.setImage(with: url)
        cell.studentName.text =  self.studentData[indexPath.row].fName + " " + self.studentData[indexPath.row].lName
        cell.city.text = self.studentData[indexPath.row].city
        
        
        return cell
        
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
