//
//  ViewController.swift
//  Rapin001Team-iRate
//
//  Created by Rolans Apinis on 7/27/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITextFieldDelegate {
    
    //fields
    //ImageViews for profile pic
    @IBOutlet weak var profilePic: UIImageView!
    
    //Text Fields user can modify
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //actions
    @IBAction func updatePicture(_ sender: Any) {
    }
    
    //toggel for asking password - might not implement due to time constraints
    @IBAction func stayLoggedIn(_ sender: UISwitch) {
    }
    
    //variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
}

