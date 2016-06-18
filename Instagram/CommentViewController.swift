//
//  CommentViewController.swift
//  Instagram
//
//  Created by AkihiroWatanabe on 2016/06/17.
//  Copyright © 2016年 Akihiro Watanabe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {

    var commentPostData:PostData?
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBAction func hundlePostButton(sender: UIBarButtonItem) {
        
        // NSUserDfaultsから表示名を取得する
        let ud = NSUserDefaults.standardUserDefaults()
        let commentName = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        //let comment = CommentData(commentUser: commentName, commentText: commentTextView.text)
        //print(comment.commentTextContent!)
        //print(comment.commentUserName!)
        //commentPostData!.comments.append(comment)
        commentPostData!.commentUser.append(commentName)
        commentPostData!.commentText.append(commentTextView.text)
        
        let imageString = commentPostData!.imageString
        let name = commentPostData!.name
        let caption = commentPostData!.caption
        let time = (commentPostData!.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
        let likes = commentPostData!.likes
        let commentUser = commentPostData!.commentUser
        let commentText = commentPostData!.commentText
        
        // 辞書を作成してFirebaseに保存する
        let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes, "commentUser": commentUser, "commentText": commentText]
        let postRef = FIRDatabase.database().reference().child(CommonConst.PostPATH)
        postRef.child(commentPostData!.id!).setValue(post)
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        commentTextView.text = ""
        

    }
    
    
    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
        print("うぃるでぃすあぴあー")
        
            
        }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
