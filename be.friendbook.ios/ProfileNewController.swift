//
//  ProfileNewController.swift
//  be.friendbook.ios
//
//  Created by Kasper Cools on 22/12/2016.
//  Copyright © 2016 Kasper Cools. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class ProfileNewController: FormViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        form = Section("New profile")
            <<< TextRow("txtUsername"){ row in
                row.title = "Username"
                row.placeholder = "Provide a username"
                row.add(rule: RuleRequired())
                row.add(rule: RuleMinLength(minLength: 5))
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< TextRow("txtForename"){ row in
                row.title = "Forename"
                row.placeholder = "Provide a forename"
                row.add(rule: RuleRequired())
                row.add(rule: RuleMinLength(minLength: 5))
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            <<< TextRow("txtLastname"){
                $0.title = "Lastname"
                $0.placeholder = "Provide a lastname"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleMinLength(minLength: 5))
                
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            +++ Section("Actions")
            <<< ButtonRow("Save Profile") { (row: ButtonRow) in
                row.title = row.tag
                }
                .onCellSelection({ (cell, row) in
                    //get form values
                    //get username
                    let txtUsername:TextRow? = self.form.rowBy(tag: "txtUsername")
                    let txtForename:TextRow? = self.form.rowBy(tag: "txtForename")
                    let txtLastname:TextRow? = self.form.rowBy(tag: "txtLastname")
                    
                    self.form.validate()
                    
                    if((txtUsername?.isValid)! && (txtForename?.isValid)! && (txtLastname?.isValid)!){
                        // do keep in mind that is not the conventional way of creating ios apps. this is just a dirty sample app!
                        
                        print("the form is valid, post data and go back!")
                        //post data to server..
                        //create profile instance
                        let profile = Profile()
                        profile.username = txtUsername?.value
                        profile.name = txtForename?.value
                        profile.surname = txtLastname?.value
                        
                        //send profile instance to server
                        ProfileService().createProfile(profile: profile)
                        
                        
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        //show a dirty popup message!
                        let alert = UIAlertController(title: "Hell no!", message: "The form is not valid! Please review your info!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                })
    }
}
