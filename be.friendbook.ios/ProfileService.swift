//
//  ProfileService.swift
//  be.friendbook.ios
//
//  Created by Kasper Cools on 22/12/2016.
//  Copyright © 2016 Kasper Cools. All rights reserved.
//

import Foundation

import Alamofire

class ProfileService{
    @discardableResult
    func getProfiles(completionHandler:@escaping (_ result:[Profile])->Void)->[Profile]{
        Alamofire.request("http://api.friendbook.local:8080/be.friendbook.api/api/profiles").responseArray { (response: DataResponse<[Profile]>) in
            let profileArray = response.result.value
            
            if let profileArray = profileArray {
                completionHandler(profileArray)
            }
        }
        return []
    }
    
    @discardableResult
    func createProfile(profile:Profile)->Void{
        Alamofire.request("http://api.friendbook.local:8080/be.friendbook.api/api/profiles", method:.put, parameters:profile.toJSON(), encoding:JSONEncoding.default).responseJSON{
            response in
            debugPrint(response)
        }
        
    }
    
    
}
