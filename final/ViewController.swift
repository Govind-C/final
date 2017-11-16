//
//  ViewController.swift
//  final
//
//  Created by Govind Cacciatore on 17/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUid: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in // listener to check if users signed in
            if let user = user {
                self.goToFeedVC()
            }
        }

    }
    
    
    

    func goToCreateUserVC(){
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
    
    func goToFeedVC(){
        performSegue(withIdentifier: "ToFeed", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){ // save information into variabes
        if segue.identifier == "SignUp" {
            if let destination = segue.destination as? UserVC {
                if userUid != nil {
                destination.userUid = userUid
                }
                if emailField.text != nil {
                destination.emailField = emailField.text
                }
                if passwordField.text != nil {
                    destination.passwordField = passwordField.text
                }
            }
        }
    }
    
    @IBAction func singInTapped(_ sender: Any){ // existing user login in or new user to create
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion:{(user,error) in
                if error == nil {
                    if let user = user{
                        self.userUid = user.uid // passing the user uid
                        self.goToFeedVC()
                    }
                    }else{
                        self.goToCreateUserVC()
                        print("not going to signup")
                }
            });
        }
    }
}

