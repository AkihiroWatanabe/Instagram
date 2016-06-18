//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by AkihiroWatanabe on 2016/06/14.
//  Copyright © 2016年 Akihiro Watanabe. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    
    var postData: PostData!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        postImageView.image = postData.image
        captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(postData.date!)
        dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        if postData.commentUser != [] && postData.commentText != [] {
            let count = postData.commentUser.count-1
            for number in 0...count {
                
                if number == 0{
                    commentLabel.text = "コメント\(postData.commentUser.count)件\n" + postData.commentUser[number] + "：" + postData.commentText[number]
                } else {
                commentLabel.text = "\(commentLabel.text!)" + "\n" + postData.commentUser[number] + "：" + postData.commentText[number]
}
            }
        }else {commentLabel.text = ""}
        
        super.layoutSubviews()
    }
    
    
    
    
}
