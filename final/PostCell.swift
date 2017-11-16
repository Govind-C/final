//
//  PostCell.swift
//  final
//
//  Created by Govind Cacciatore on 21/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class PostCell: UITableViewCell {
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    var userPostKey: FIRDatabaseReference!
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(post: Post, img: UIImage?  = nil, userImg: UIImage? = nil){ // creates cell when called
        self.post = post
        self.likesLbl.text = "\(post.likes)"    // number of likes
        self.username.text = post.username  // username of poster
        
        if img != nil{
            self.postImg.image = img    // posted image
        }
        else{
            let ref = FIRStorage.storage().reference(forURL: post.postImg)
            ref.data(withMaxSize: 10 * 10000, completion: {(data,error) in
                if error != nil {
                    print(error)
                }
                else{
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                            self.postImg.image = img
                        }
                    }
                }
            })
        }
        
        
        if userImg != nil{  // display picture
            self.postImg.image = userImg
        }
        else{
            let ref = FIRStorage.storage().reference(forURL: post.userImg)
            ref.data(withMaxSize: 100000000, completion: {(data,error) in
                if error != nil {
                    print("couldnt load image")
                }
                else{
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                            self.userImg.image = img
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func liked(_ sender: Any) {
        
        print("im crashing in liked")
        
        let likeRef = FIRDatabase.database().reference().child("users").child(currentUser!).child("likes").child(post.postKey)
        
        likeRef.observeSingleEvent(of: .value, with:  { (snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                
                self.post.adjustLikes(addlike: true)
                
                likeRef.setValue(true)
                
            } else {
                
                self.post.adjustLikes(addlike: false)
                
                likeRef.removeValue()
            }
        })
    }

}
