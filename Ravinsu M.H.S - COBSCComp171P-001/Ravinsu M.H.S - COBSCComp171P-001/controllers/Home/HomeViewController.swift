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
    var userData: [User] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load user data to user model
       // self.getViewUserData()
        
        //Initialized data refferencess
        ref = Database.database().reference()
        self.registerCell()
        self.getStudentList()
        self.studentTable.tableFooterView = UIView()
        
        studentTable.delegate = self
        studentTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    //call Registration
    func registerCell() {
        self.studentTable.register(UINib(nibName: "tableTableViewCell", bundle: nil), forCellReuseIdentifier: "tableTableViewCell")
        // self.tableView.register(singerViewCell.self, forCellReuseIdentifier: "singerViewCell")
    }
    //End of cell registration
    
    
    //Load student List
    func getStudentList() {
        //self.showActivity()
        
        self.ref.child("NIBMConnect/Students").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //let singersList = value!
           print(snapshot.children)
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
    //End Of loading student List
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath ) as! tableTableViewCell
        
        let url = URL( string: self.studentData[indexPath.row].profUrl)
        cell.profileImg.kf.setImage(with: url)
        cell.studentName.text =  self.studentData[indexPath.row].fName + " " + self.studentData[indexPath.row].lName
        cell.city.text = self.studentData[indexPath.row].city
        cell.phoneNumber = self.studentData[indexPath.row].phoneNumber
        cell.fbProfile = self.studentData[indexPath.row].fbUrl
        
        
        return cell
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showstudent" {
            let selectedIndex = sender as! Int
            let selectedStudent = self.studentData[selectedIndex]
            
            let destinationVC = segue.destination as! showFriendsViewController
            destinationVC.studentInfo = selectedStudent
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showstudent", sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Log out btn
    @IBAction func logOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            let alert = UIAlertController(title: "Login Error", message: signOutError.localizedDescription, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.navigationController?.dismiss(animated: true)
    }
    //End of log out btn
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
