//
//  UserNameVC.swift
//  complexSignup
//
//  Created by Cyrus Chan on 15/1/2017.
//  Copyright © 2017 ckmobile.com. All rights reserved.
//

import UIKit
import Firebase

class UserNameVC: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    
    @IBOutlet weak var username: UITextField!
 
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var takeMission: UIButton!
    
    var databaseReference = FIRDatabase.database().reference()
    var user = FIRAuth.auth()?.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func takeMissionTapped(_ sender: Any) {
        let userName = self.databaseReference.child("username").child(self.username.text!).observe(.value, with: { (snapshot:FIRDataSnapshot) in
            if(!snapshot.exists()){
                self.databaseReference.child("users").child((self.user?.uid)!).child("username").setValue(self.username.text!.lowercased())
                self.databaseReference.child("users").child((self.user?.uid)!).child("fullname").setValue(self.fullname.text!.capitalized)
                self.databaseReference.child("usernames").child(self.username.text!.lowercased()).setValue(self.user?.uid)
                self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
                
                                
            }else{
                self.errorMessage.text = "Username already exists"
            }
        })
    }
}
