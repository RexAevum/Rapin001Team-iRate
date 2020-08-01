//
//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Team/Individual Project - iRate
//  DUE: Saturday 08/01/2020 //

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    //Mark:- variables
    //text fields
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //shared
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //local
    var askForPassword: Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        askForPassword = appDelegate.askForPassword
        print("set ask for password as " + ((askForPassword.description)) + "\n")
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if you are not asked to
        if (!askForPassword){
            performSegue(withIdentifier: "logInSegue", sender: Any?.self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "logInSegue"?:
            print("hello")
        default:
            print("Failed to log in at \(self)")
        }
    }
    
    //MARK:- Text Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    //MARK:- Log In Button
    @IBAction func logIn(_ sender: UIButton) {
        /* for debuging
        print("\(userNameField.text)")
        print("\(appDelegate.user?.userName)")
        print("\(passwordField.text)")
        print("\(appDelegate.user?.password)")
        */
        
        let userName:String! = userNameField.text?.lowercased()
        let userNameCheck: String! = appDelegate.user?.userName?.lowercased()
        let password: String! = passwordField.text?.lowercased()
        let passwordCheck: String! = appDelegate.user?.password?.lowercased()
       
        if (userName == userNameCheck){
            if (password == passwordCheck){
                print("logged in user")
                performSegue(withIdentifier: "logInSegue", sender: Any?.self)
            }else{
                let notification = UIAlertAction(title: "OK", style: .default, handler: nil)
                let control = UIAlertController(title: "Alert", message: "User not found", preferredStyle: .alert)
                control.addAction(notification)
                present(control, animated: true, completion: nil)
            }
        }
    }
    
    

}
