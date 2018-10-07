//
//  TweetDetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 10/4/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timePassedLabel: UILabel!
    
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var retweet: UIButton!
    @IBOutlet weak var like: UIButton!
    
    var tweet: Tweet!
    
    @IBAction func retweetButton(_ sender: Any) {
        if(!(tweet.retweeted!)){
            let image = UIImage(named: "retweet-icon-green")
            
            retweet.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully retweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCountLabel.text = String(count)
                    self.retweetCount.text = String(count)
                }
            }
        } else {
            let image = UIImage(named: "retweet-icon")
            
            retweet.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = false
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unretweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCountLabel.text = String(count)
                    self.retweetCount.text = String(count)
                }
            }
        }
    }
    @IBAction func likeButton(_ sender: Any) {
        if(!(tweet.favorited!)){
            let image = UIImage(named: "favor-icon-red")
            
            like.setImage(image, for: UIControlState.normal)
            
            tweet.favorited = true
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCountLabel.text = String(count)
                    self.likeCount.text = String(count)
                }
            }
        } else {
            let image = UIImage(named: "favor-icon")
            
            like.setImage(image, for: UIControlState.normal)
            
            tweet.favorited = false
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unfavorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCountLabel.text = String(count)
                    self.likeCount.text = String(count)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.af_setImage(withURL: (tweet.user.profileURL))
        usernameLabel.text = tweet.user.name
        screenNameLabel.text = "@\(tweet.user.screenName )"
        messageLabel.text = tweet.text
        dateLabel.text = tweet.createdAtString
        
        if let favorite = tweet.favoriteCount {
            favoriteCountLabel.text = String(favorite)
            likeCount.text = String(favorite)
        } else {
            favoriteCountLabel.text = String(0)
            likeCount.text = String(0)
        }
        if let retweet = tweet.retweetCount {
            retweetCountLabel.text = String(retweet)
            retweetCount.text = String(retweet)
        } else {
            retweetCountLabel.text = String(0)
            retweetCount.text = String(0)
        }
        
        if let tweetTime = tweet.tweetSince {
            timePassedLabel.text = tweetTime.timeAgo()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "replySegue" {
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.tweet = tweet
        }
    }
    

}
