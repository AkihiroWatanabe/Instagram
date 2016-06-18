//
//  PostData.swift
//  Instagram
//
//  Created by AkihiroWatanabe on 2016/06/14.
//  Copyright © 2016年 Akihiro Watanabe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {

    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    //var comments: [CommentData] = []
    var commentUser:[String] = []
    var commentText:[String] = []
    
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = valueDictionary["name"] as? String
        
        caption = valueDictionary["caption"] as? String
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in likes {
            if likeId == myId {
                isLiked = true
                break
            }
        }
        
//        if let comments = valueDictionary["comments"] as? [CommentData] {
//        
//            self.comments = comments
//        }
        
        if let commentUser = valueDictionary["commentUser"] as? [String] {
            self.commentUser = commentUser
        }

        if let commentText = valueDictionary["commentText"] as? [String] {
            self.commentText = commentText
        }

        
        
        self.date = NSDate(timeIntervalSinceReferenceDate: valueDictionary["time"] as! NSTimeInterval)
        
        
    }
    
    
}
