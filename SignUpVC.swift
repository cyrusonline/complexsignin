//
//  SignUpVC.swift
//  complexSignup
//
//  Created by Cyrus Chan on 14/1/2017.
//  Copyright © 2017 ckmobile.com. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var chooseUsername: UIButton!
    
    var databaseReference = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func chooseUsernameTapped(_ sender: Any) {
        chooseUsername.isEnabled = false
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if error != nil {
                self.errorMessage.text = error?.localizedDescription
            }
            else{
                
                self.errorMessage.text = "Register Success"
                FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!, completion: { (user, error) in
                    self.databaseReference.child("users").child(user!.uid).child("email").setValue(self.email.text!)
                    self.performSegue(withIdentifier: "UserNameSegue", sender: nil)
                })
            }
        })
    }
}
