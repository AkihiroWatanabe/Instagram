//
//  LoginViewController.swift
//  Instagram
//
//  Created by AkihiroWatanabe on 2016/06/07.
//  Copyright © 2016年 Akihiro Watanabe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD
class LoginViewController: UIViewController {


    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    // ログインボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleLoginButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            
            // アドレスとパスワード名のいずれかでも入力されていない時は何もしない
            if address.characters.isEmpty || password.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("表示名を入力して下さい")
                return
            }
            
            FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                if error != nil {
                    print(error)
                } else {
                    // Firebaseからログインしたユーザの表示名を取得してNSUserDefaultsに保存する
                    if let displayName = user?.displayName {
                        self.setDisplayName(displayName)
                    }
                    
                    // 画面を閉じる
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    // アカウント作成ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCreateAcountButton(sender: AnyObject) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text,
            let displayName = displayNameTextField.text {
                // アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
                if address.characters.isEmpty || password.characters.isEmpty
                    || displayName.characters.isEmpty {
                        
                        return
                }
                
                FIRAuth.auth()?.createUserWithEmail(address, password: password) { user, error in
                    if error != nil {
                        print(error)
                    } else {
                        // ユーザーを作成できたらそのままログインする
                        FIRAuth.auth()?.signInWithEmail(address, password: password) { user, error in
                            if error != nil {
                                print(error)
                            } else {
                                if let user = user {
                                    // Firebaseに表示名を保存する
                                    let request = user.profileChangeRequest()
                                    request.displayName = displayName
                                    request.commitChangesWithCompletion() { error in
                                        if error != nil {
                                            print(error)
                                        } else {
                                            // NSUserDefaultsに表示名を保存する
                                            self.setDisplayName(displayName)
                                            
                                            // 画面を閉じる
                                            self.dismissViewControllerAnimated(true, completion: nil)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
    
    // NSUserDefaultsに表示名を保存する
    func setDisplayName(name: String) {
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setValue(name, forKey: CommonConst.DisplayNameKey)
        ud.synchronize()
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
