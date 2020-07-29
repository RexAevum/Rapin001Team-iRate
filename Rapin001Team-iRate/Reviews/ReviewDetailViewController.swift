//
//  ReviewDetailViewController.swift
//  Rapin001Team-iRate
//
//  Created by Rolans Apinis on 7/28/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit

class ReviewDetailViewController: UIViewController, UITextFieldDelegate {

    //IBOutlets
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var ratingField: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var notesField: UITextView!
    
    //Outlet for photo
    @IBOutlet weak var picture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITextField Delegate
    
    //Deleget for what to do when eturn is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        view.endEditing(true)
        return true
    }
    
    //Delegate for what to do when a text field is pressed - open keyboard
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    //MARK:- Image View
    
    @IBAction func updatePhotoButton(_ sender: UIButton) {
        //add code to chenge photo for UIImageView
        //reference older project for camera view implementatation
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
