//
//  ProfileviewController.swift
//  be.friendbook.ios
//
//  Created by Kasper Cools on 10/12/2016.
//  Copyright © 2016 Kasper Cools. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ProfileviewController: UITableViewController{
    var profiles: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfiles(sender: self)
        //init pull down
        self.refreshControl = UIRefreshControl();
        self.refreshControl?.backgroundColor=UIColor.purple;
        self.refreshControl?.tintColor=UIColor.white;
        self.refreshControl?.addTarget(self, action: #selector(self.getProfiles), for: UIControlEvents.valueChanged);
    }
    
    func getProfiles(sender:AnyObject){
        
        ProfileService().getProfiles(){
            (result:[Profile]) in
            
            self.profiles=result;
            self.tableView.reloadData()
            if(self.refreshControl != nil){
                self.changeLastUpdateDate();
                self.refreshControl?.endRefreshing();
            }
        }
    }
    
    func changeLastUpdateDate(){
        let formatter = DateFormatter();
        formatter.dateFormat = "dd MMMM, HH:mm:ss";
        let title = String.init(format: "Last update: %@", formatter.string(from: Date()));
        let attrDic = [NSForegroundColorAttributeName:UIColor.white];
        let attributeTitle = NSAttributedString(string: title, attributes: attrDic);
        self.refreshControl?.attributedTitle=attributeTitle;
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(self.profiles.count>0){
            self.tableView.separatorStyle=UITableViewCellSeparatorStyle.singleLine;
            return 1;
        }else{
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height));
            messageLabel.text = "No profiles available at this moment. Please pull down to refresh.";
            messageLabel.numberOfLines=0;
            messageLabel.textAlignment=NSTextAlignment.center;
            messageLabel.font=UIFont.init(name: "Palatino-Italic", size: 20);
            messageLabel.sizeToFit();
            
            self.tableView.backgroundView=messageLabel;
            self.tableView.separatorStyle=UITableViewCellSeparatorStyle.none;
        }
        
        return 0;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profiles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text=self.profiles[indexPath.row].name
        cell.detailTextLabel?.text=self.profiles[indexPath.row].username
        return cell;
    }
}
