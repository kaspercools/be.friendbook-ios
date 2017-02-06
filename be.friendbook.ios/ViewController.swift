//
//  ViewController.swift
//  be.friendbook.ios
//
//  Created by Kasper Cools on 09/12/2016.
//  Copyright © 2016 Kasper Cools. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    let profiles:[Profile] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //link tableview to controllers
        self.tableview.dataSource=self;
        self.tableview.delegate=self;
        
        // Do any additional setup after loading the view, typically from a nib.

        Alamofire.request("http://api.friendbook.local:8080/be.vives.friendbook.api/api/profiles").responseArray { (response: DataResponse<[Profile]>) in
                let profileArray = response.result.value
            print(response.result)
            if let profileArray = profileArray{
               
                for profile in profileArray{
                    print(profile.username)
                    self.title=profile.username
                }
                
                self.tableview.reloadData()
            }

            
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = profiles[indexPath.row]
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        cell.textLabel?.text = element.surname
        
        // Returning the cell
        return cell
    }
    
}
