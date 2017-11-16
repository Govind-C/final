//
//  LinkVC.swift
//  final
//
//  Created by Govind Cacciatore on 23/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class LinkVC: UIViewController{
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func linkClicked(sender: AnyObject) {
        openUrl(urlStr: "https://www.bodybuilding.com/fun/likness25.htm")
    }
    
    @IBAction func linkClicked1(sender: AnyObject) {
        openUrl(urlStr: "https://www.reddit.com/r/Fitness/")
    }
    
    @IBAction func linkClicked2(sender: AnyObject) {
        openUrl(urlStr: "https://www.myprotein.com/home.dept")
    }
    
    func openUrl(urlStr:String!) {
        
        if let url = NSURL(string:urlStr) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func SignOutPressed(_ sender: AnyObject) {
        
        try! FIRAuth.auth()?.signOut()
        //KeychainWrapper.standard.removeObject(forKey: "uid")
        dismiss(animated: true, completion: nil)
    }

    
}
