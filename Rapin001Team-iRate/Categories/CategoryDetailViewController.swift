//
//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Team/Individual Project - iRate
//  DUE: Saturday 08/01/2020 //

import UIKit
import CoreData

class CategoryDetailViewController: UIViewController, UITextFieldDelegate {
    
    //fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    //var
    var currentCategory: Category!
    let localAppDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentCategory != nil{
            nameField.text = currentCategory.catgoryName
            descriptionField.text = currentCategory.categoryDescription
            
        }else{
            let newCategory = Category(context: localAppDelegate.persistentContainer.viewContext)
            newCategory.catgoryName = "New Category Name"
            newCategory.categoryDescription = "Add Description"
            newCategory.categoryID = nil
            newCategory.ownedByUser = nil
            newCategory.contains = []
            
            localAppDelegate.saveContext()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //asighn updated variables
        currentCategory.catgoryName = nameField.text
        currentCategory.categoryDescription = descriptionField.text
        
        localAppDelegate.saveContext()
    }
    
    //MARK:- Button actions
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "showAllSegue"?:
            let destination = segue.destination as! ReviewListTableViewController
            
            destination.searchByCategory = true
            destination.searchStringForcategory = (currentCategory.catgoryName?.capitalized)!
           // destination.getData(context: localAppDelegate.persistentContainer.viewContext)
        default:
            print("Failed with unkown segue in \(self)")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField{
            let temp = nameField.text
            nameField.text = temp?.capitalized
        }
        textField.resignFirstResponder()
        return true
    }

}
