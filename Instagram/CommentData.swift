//
//  CommentData.swift
//  Instagram
//
//  Created by AkihiroWatanabe on 2016/06/17.
//  Copyright © 2016年 Akihiro Watanabe. All rights reserved.
//

//このクラスは使わない

import Foundation

class CommentData: NSObject {
    
    var commentUserName: String?
    var commentTextContent: String?
    
    init(commentUser: String, commentText: String){
        
        commentUserName = commentUser
        commentTextContent = commentText
        
    }
    
    
    
}
