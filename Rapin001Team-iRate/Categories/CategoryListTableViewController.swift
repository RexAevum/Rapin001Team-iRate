//
//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Team/Individual Project - iRate
//  DUE: Saturday 08/01/2020 //

import UIKit
import CoreData

class CategoryListTableViewController: UITableViewController {
    
    
    //seting up coredata
    var allCategories: [Category] = []
    let localAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var sortAsce = true
    var currentCategory: Category? = nil
    var isNewCategory = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        let context = localAppDelegate.persistentContainer.viewContext
        allCategories = getData(context: context) as! [Category]
        tableView.reloadData()
    }
    
    //MARK:- getData
    //function will retrieve all data from the DB and store it in the local variable
    func getData(context: NSManagedObjectContext?) -> [Any]? {
        let context = localAppDelegate.persistentContainer.viewContext
        
        //define custom fetch predicate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        
        //let fetchPreditcate = NSPredicate(format: "title == \(searchBarInput)")
        let sort = NSSortDescriptor(key: #keyPath(Category.catgoryName), ascending: sortAsce)
        // add the predicate and sort to fetch request
        //fetchRequest.predicate = fetchPreditcate
        fetchRequest.sortDescriptors = [sort]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed")
        }
        return []
    }
    
    //MARK:- Button Actions
    
    @IBAction func addNewCategoryButton(_ sender: UIBarButtonItem) {
        //FIXME - add code to add a new review to DB and update the rows
        let context = localAppDelegate.persistentContainer.viewContext
        let category = Category(context: context)
        category.catgoryName = "New Item"
        category.categoryDescription = "A Custom Review Category"
        category.categoryID = nil
        category.ownedByUser = nil
        category.contains = []

        
        
        //save the context
        localAppDelegate.saveContext()
        isNewCategory = true
        
        //segue
        performSegue(withIdentifier: "showCategorySegue", sender: category)
        
    }
    //Function will allow for sorting the array in a ascending and descending order
    @IBAction func toggleSortOrderButton(_ sender: UIBarButtonItem) {
        
        if sortAsce{
            sortAsce = false
            sender.title = "Desc"
        }else{
            sortAsce = true
            sender.title = "Asce"
        }
        allCategories = getData(context: localAppDelegate.persistentContainer.viewContext) as! [Category]
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCategories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableCell
        let current: Category? = allCategories[indexPath.row]
        
        cell.name.text = current?.catgoryName
        cell.categoryDescription.text = current?.categoryDescription
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actions = UIContextualAction(style: .destructive, title: "Delete", handler: {(actions, view, completionHandler)  -> () in
            let context = self.localAppDelegate.persistentContainer.viewContext
            // Delete the row from the data source and update table
            //remove review from allReviews
            let category = self.allCategories.remove(at: indexPath.row)
            //remove review from context store
            context.delete(category)
            //perform the update
            self.localAppDelegate.saveContext()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        })
        return UISwipeActionsConfiguration(actions: [actions])
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "showCategorySegue"?:
            let destin = segue.destination as! CategoryDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            
            if isNewCategory{
                isNewCategory = false
                destin.currentCategory = sender as! Category
            }else{
                destin.currentCategory = allCategories[index!]
            }
        default:
            print("Unknown segue when on \(self)")
        }
        
    }
    

}
