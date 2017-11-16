//
//  UserVC.swift
//  final
//
//  Created by Govind Cacciatore on 18/04/2017.
//  Copyright © 2017 Govind Cacciatore. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class UserVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImagePicker: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var completeSignInBtn: UIButton!
    
    var userUid: String!
    var emailField: String!
    var passwordField: String!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func keychain(){
        KeychainWrapper.standard.set(userUid, forKey: "uid")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            userImagePicker.image = image
            imageSelected = true
        }
        else
        {
            print("No image selected")
        }
        imagePicker.dismiss(animated: true, completion : nil)
    }
    
    func setUpUser(img: String){ //  image is a string points to reference, URL of photo
        let userData = [    // data posting to the server
            "username": username!,
            "userImg": img
        ]
        keychain()
        let setLocation = FIRDatabase.database().reference().child("users").child(userUid) // location of data
        setLocation.setValue(userData) // uploading user data
    }
    
    func uploadImg() { // upload user information
        if usernameField.text == nil{
            print("must have username")
            completeSignInBtn.isEnabled = false // disable the button
        }
        else{
            username = usernameField.text // if username field filled
            completeSignInBtn.isEnabled = true
        }
        guard let img = userImagePicker.image, imageSelected == true else{
            print("Image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "img/jpeg"
            
            FIRStorage.storage().reference().child(imgUid).put(imgData, metadata: metadata){ (metadata,error) in
                if error != nil{
                    print("Did not upload")
                }
                else{
                    print("Uploaded")
                    let downloadURl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURl {
                        self.setUpUser(img: url) // proceed to post data function
                    }
                }
            }
        }
    }
    

    @IBAction func completeAccount(_ sender:Any){ // once button is pressed
        FIRAuth.auth()?.createUser(withEmail:  emailField, password: passwordField, completion: {(user, error) in // coming from viewcontroller
            if error != nil{
                print(error)
            }
            else{
                if let user = user {
                self.userUid = user.uid
                }
            }
            self.uploadImg() // once authenticated upload photo
        })
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedImagePicker(_ sender: Any){
        present(imagePicker,  animated: true, completion: nil)
    }
   
}
