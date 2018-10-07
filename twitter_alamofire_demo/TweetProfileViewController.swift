//
//  TweetProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 10/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Foundation

class TweetProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var tweetsCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var followersCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        bannerImageView.af_setImage(withURL: (user?.bannerURL)!)
        profileImageView.af_setImage(withURL: (user?.profileURL)!)
        
        usernameLabel.text = user?.name
        screenNameLabel.text = "@\(user?.screenName ?? "")"
        descriptionLabel.text = user?.userDescription
        
        if let tweets = user?.tweetCount {
            tweetsCount.text = String(tweets)
        } else {
            tweetsCount.text = String(0)
        }
        if let following = user?.following {
            followingCount.text = String(following)
        } else {
            followingCount.text = String(0)
        }
        if let followers = user?.followers {
            followersCount.text = String(followers)
        } else {
            followersCount.text = String(0)
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "TwitterLogoBlue")
        imageView.image = image
        
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        
        navigationItem.titleView = imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
