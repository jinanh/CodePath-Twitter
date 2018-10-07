//
//  ReplyViewController.swift
//  twitter_alamofire_demo
//
//  Created by Ka Lee on 10/6/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var replyScreenName: UILabel!
    
    var tweet: Tweet!
    
    @IBAction func replyButton(_ sender: Any) {
        var replyTweet: [String: Any] = [:]
        replyTweet["text"] = "@" + tweet.user.screenName + " " + self.replyTextView.text!
        replyTweet["id"] = tweet.id
        
        APIManager.shared.replyTweet(with: replyTweet){(tweet, error) in
            if let error = error{
                print("Error composing Tweet: \(error.localizedDescription)")
            }else if tweet != nil {
                print("Reply Tweet Successfully!")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.af_setImage(withURL: (User.current?.profileURL)!)
        replyScreenName.text = "@\(tweet.user.screenName)"
        
        replyTextView.delegate = self
        replyTextView.isEditable = true
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "TwitterLogoBlue")
        imageView.image = image
        
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        
        navigationItem.titleView = imageView
        
        replyTextView.text = "Tweet your reply"
        replyTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if replyTextView.textColor == UIColor.lightGray {
            replyTextView.text = nil
            replyTextView.textColor = UIColor.white
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        wordCountLabel.text = String(characterLimit - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
