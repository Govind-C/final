//
//  YVC.swift
//  final
//
//  Created by Govind Cacciatore on 23/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import Foundation

import UIKit
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class YVC: UIViewController{
    
    
    @IBOutlet var videoView1: UIWebView!
    @IBOutlet var videoView2: UIWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        videoView1.allowsInlineMediaPlayback = true
        
        videoView1.loadHTMLString("<iframe width=\(videoView1.frame.width)\" height=\(videoView1.frame.height)\" src=\"https://www.youtube.com/embed/-4qRntuXBSc?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        
        videoView2.allowsInlineMediaPlayback = true
        
        videoView2.loadHTMLString("<iframe width=\(videoView2.frame.width)\" height=\(videoView2.frame.height)\" src=\"https://www.youtube.com/embed/Dy28eq2PjcM?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignOutPressed(_ sender: AnyObject) {
        
        try! FIRAuth.auth()?.signOut()
        //KeychainWrapper.standard.removeObject(forKey: "uid")
        dismiss(animated: true, completion: nil)
    }
    
    
}
