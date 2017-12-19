//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by Kenichi Kaneda on 2017/12/15.
//  Copyright © 2017年 kkanedagh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class PostCommentViewController: UIViewController {
    
    var postData: PostData? = nil
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func handleCommentButton(_ sender: Any) {
        if let commentData = commentTextField.text {
            
            // コメントが入力されていない時はHUDを出して何もしない
            if (commentData.characters.isEmpty) {
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }
        
            //自分自身の表示名取得
            let user = Auth.auth().currentUser
            let displayName = user?.displayName
        
            //Firebaseに反映する文字列生成
            let insertCommentData = displayName! + ":" + commentData
        
            //コメントを配列に追加
            postData?.comment.append(insertCommentData)
        
            //該当のidに対して処理
            let postRef = Database.database().reference().child(Const.PostPath).child((postData?.id!)!)
            let comment = ["comment": postData?.comment]
        
            //Firebaseに反映
            postRef.updateChildValues(comment)
            
            // HUDで完了を知らせる
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
        
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
