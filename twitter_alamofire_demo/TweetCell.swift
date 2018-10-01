//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 9/27/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screenName: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var favoriteCount: UILabel!
    
    @IBOutlet weak var retweetCount: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var tweet: Tweet!{
        didSet{
            usernameLabel.text = tweet.user?.name
            screenName.text = "@\(tweet.user!.screenName ?? "") \(tweet.createdAtString!)"
            tweetTextLabel.text = tweet.text
            if let favorite = tweet.favoriteCount {
                favoriteCount.text = String(favorite)
            } else {
                favoriteCount.text = String(0)
            }
            if let retweet = tweet.retweetCount {
                retweetCount.text = String(retweet)
            } else {
                retweetCount.text = String(0)
            }
            
            userImageView.af_setImage(withURL: (tweet.user?.profileURL)!)
        }
    }
    
    @IBAction func Favorite(_ sender: Any) {
        if(!(tweet.favorited!)){
            let image = UIImage(named: "favor-icon-red")
            favoriteButton.setImage(image, for: UIControlState.normal)
            tweet.favorited = true
            APIManager.shared.favorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully favorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCount.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "favor-icon")
            favoriteButton.setImage(image, for: UIControlState.normal)
            tweet.favorited = false
            APIManager.shared.unfavorite(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unfavorited the following Tweet")
                    let count = ntweet.favoriteCount!
                    self.favoriteCount.text = String(count)
                }
            }
        }
    }
    
    @IBAction func Retweet(_ sender: Any) {
        if(!(tweet.retweeted!)){
            let image = UIImage(named: "retweet-icon-green")
            retweetButton.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = true
            APIManager.shared.retweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully retweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCount.text = String(count)
                }
            }
        }else {
            let image = UIImage(named: "retweet-icon")
            retweetButton.setImage(image, for: UIControlState.normal)
            
            tweet.retweeted = false
            APIManager.shared.unretweet(tweet) { (ntweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweet tweet: \(error.localizedDescription)")
                } else if let ntweet = ntweet {
                    print("Successfully unretweet the following Tweet")
                    let count = ntweet.retweetCount!
                    self.retweetCount.text = String(count)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
