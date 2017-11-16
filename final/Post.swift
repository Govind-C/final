//
//  Posts.swift
//  final
//
//  Created by Govind Cacciatore on 21/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

// data incapsilation

class Post{ // store data for out posts
    private var _username: String!
    private var _userImg: String!   // location of image
    private var _postImg: String!
    private var _likes: Int!
    private var _postKey: String!   // how we identify the post
    private var _postRef: FIRDatabaseReference!
    
/// Getters
    var username: String{
        return _username
    }
    
    var userImg: String{
        return _userImg
    }
    
    var postImg: String{
        get{
            return _postImg
        } set{
            _postImg = newValue
        }
    }
    
    var likes: Int{
        return _likes
    }

    var postKey: String{
        return _postKey
    }
    
    init(imgUrl: String, likes: Int, username: String, userImg: String){ // initialiser
        _likes = likes
        _postImg = imgUrl
        _username = username
        _userImg = userImg
        
    }
    
    
    init(postKey: String, postData: Dictionary<String, AnyObject>){ // database
        _postKey = postKey
        
        if let username = postData["username"] as? String{
            _username = username
        }
        if let userImg = postData["userImg"] as? String{
            _userImg = userImg
        }
        if let postImg = postData["imageUrl"] as? String{
            _postImg = postImg
        }
        if let likes = postData["likes"] as? Int{
            _likes = likes
        }
        
        _postRef = FIRDatabase.database().reference().child("posts").child(_postKey)
    }
    
    func adjustLikes(addlike: Bool) {
        if addlike {
            _likes = likes + 1
        } else if _likes > 0 {
            _likes = likes - 1
        }
        else{
            _likes = likes
        }
        _postRef.child("likes").setValue(_likes)
    }
    
}
