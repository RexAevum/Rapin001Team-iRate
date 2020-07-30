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
    
    // store
    var currentReview: Review!
    let del = UIApplication.shared.delegate as! AppDelegate
    
    //Outlet for photo
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var updatePhoto: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //get object form DB
       /*
        let context = del.persistentContainer.viewContext
        currentReview = Review(context: context)
        */
        
        //assign to text fields retrieved values
        titleField.text = currentReview.title
        categoryField.text = currentReview.category as? String
        ratingField.text = currentReview.rating
        website.text = currentReview.website as? String
        notesField.text = currentReview.notes
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        currentReview.title = titleField.text
        currentReview.category = (categoryField.text! as NSString)
        currentReview.rating = categoryField.text
        let url = URL(string: website.text!)
        currentReview.website = url as NSObject?
        currentReview.notes = notesField.text
        
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
