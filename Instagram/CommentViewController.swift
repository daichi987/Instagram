//
//  CommentViewController.swift
//  Instagram
//
//  Created by Mika on 2019/07/06.
//  Copyright © 2019 daichi987. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextField!
    
    var postArray: [PostData] = []
    var row:Int = 0
    
    @IBAction func handleCommentPost(_ sender: Any) {
        if let comment = commentTextField.text {
            
            let postData = postArray[row]
            
            // コメントが入力されていない時はHUDを出して何もしない
            if comment.isEmpty {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }
            
            if let uid = Auth.auth().currentUser?.uid {
                if postData.comments.count != 0 {
                    postData.comments["uid"]!.append(uid)
                    postData.comments["comment"]!.append(comment)
                } else {
                    postData.comments["uid"] = [uid]
                    postData.comments["comment"] = [comment]
                }
            }
            
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            let comments = ["comments": postData.comments]
            
            postRef.updateChildValues(comments)
            
            // HUDで完了を知らせる
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        }
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
