//
//  ProfileResponse.swift
//  be.friendbook.ios
//
//  Created by Kasper Cools on 09/12/2016.
//  Copyright © 2016 Kasper Cools. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable{
    var username: String?
    var surname: String?
    var name: String?
    
    init() {
        
    }
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        surname <- map["surname"]
        name <- map["name"]
    }
}
