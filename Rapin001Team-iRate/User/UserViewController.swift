//
//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Team/Individual Project - iRate
//  DUE: Saturday 08/01/2020 //

import UIKit
import CoreData


class UserViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //fields
    //ImageViews for profile pic
    @IBOutlet weak var profilePic: UIImageView!
    
    //Text Fields user can modify
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var toggleLogIn: UISwitch!
    var toggleState: Bool = Bool()
    
    //CoreData
    let localAppDelegate = UIApplication.shared.delegate as! AppDelegate
    var currentUser: User!
    
    
    //toggel for asking password - might not implement due to time constraints
    @IBAction func stayLoggedIn(_ sender: UISwitch) {
        if (sender.isOn){
            localAppDelegate.askForPassword = false
            currentUser.askForPassword = false
            sender.setOn(false, animated: true)
        }else{
            localAppDelegate.askForPassword = true
            currentUser.askForPassword = true
            sender.setOn(true, animated: true)
        }
        localAppDelegate.saveContext()
    }
    
    //variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentUser = localAppDelegate.user!
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if ((currentUser.profileImage)) != nil{
            profilePic.image = UIImage(data: (currentUser.profileImage)!)
        }
        usernameField.text = currentUser.userName
        passwordField.text = currentUser.password
        toggleLogIn.setOn(currentUser.askForPassword, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currentUser.userName = usernameField.text
        currentUser.password = passwordField.text
        currentUser.askForPassword = toggleLogIn.isOn
        localAppDelegate.askForPassword = toggleLogIn.isOn
        
        localAppDelegate.saveContext()
        
        
    }

    //MARK:- Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
    //MARK:- UImagePicker
    @IBAction func updatePhotoButton(_ sender: UIButton) {
        //add code to chenge photo for UIImageView
        //reference older project for camera view implementatation
        let imagePicker = UIImagePickerController()
        
        // select source type
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }else{
            imagePicker.sourceType = .photoLibrary
        }
        
        // have to import both UINavigationControllerDelegate and UIImagePickerControllerDelegate
        imagePicker.delegate = self
        
        //by calling present you are moving a view to be displayed, transition between views
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //convert image to binary data
        let pic: Data = UIImagePNGRepresentation(image)!
        
        //set the imageView as the selected image
        
        currentUser?.profileImage = pic
        
        localAppDelegate.saveContext()
        
        // need to dismiss once an image has been seleted
        
        dismiss(animated: true, completion: nil)
    }
    
}

