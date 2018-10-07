//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 9/26/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation



class User: NSObject {
    var name: String?
    var screenName: String
    var id: Int64
    var profileURL: URL
    var bannerURL: URL?
    var userDescription: String?
    var tweetCount: Int?
    var following: Int?
    var followers: Int?
    
    
    var dictionary: [String: Any]?
    
    private static var _current: User?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as! String
        id = dictionary["id"] as! Int64
        profileURL = URL(string: dictionary["profile_image_url_https"] as! String)!
        if !(dictionary["profile_banner_url"] == nil) {
            bannerURL = URL(string: dictionary["profile_banner_url"] as! String)!
        } else {
            bannerURL = URL(string: "nil")!
        }
        userDescription = dictionary["description"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
        
        
    }
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }

}
