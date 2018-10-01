//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 9/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation



class User {
    var name: String?
    var screenName: String?
    var id: Int64
    var profileURL: URL
    
    static var current: User?

    init(dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        id = dictionary["id"] as! Int64
        profileURL = URL(string: dictionary["profile_image_url_https"] as! String)!
        
    }

}
