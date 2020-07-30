//
//  ReviewListTableViewController.swift
//  Rapin001Team-iRate
//
//  Created by Rolans Apinis on 7/28/20.
//  Copyright © 2020 Rolans Apinis. All rights reserved.
//

import UIKit
import CoreData

class ReviewListTableViewController: UITableViewController, UISearchBarDelegate {
    
    //store
    
    lazy var allReviews: [Review] = []
    
    var localAppDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        localAppDelegate = UIApplication.shared.delegate as! AppDelegate
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let context = localAppDelegate.persistentContainer.viewContext
        allReviews = getData(context: context) as! [Review]
        tableView.reloadData()
    }

    //getData - function will retrieve all data from the DB and store it in the local variable
    func getData(context: NSManagedObjectContext) -> [Any]? {
        let context = localAppDelegate.persistentContainer.viewContext
        do {
            return try context.fetch(Review.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        return []
    }
    
    //MARK:- Button Actions

    @IBAction func addNewReviewButton(_ sender: UIBarButtonItem) {
        //FIXME - add code to add a new review to DB and update the rows
        let context = localAppDelegate.persistentContainer.viewContext
        let review = Review(context: context)
        review.title = "New Item"
        review.category = "None" as NSObject
        review.ownedByUser = UUID()
        review.rating = "None"
        review.reviewID = UUID()
        review.website = nil
        
        //save the context
        localAppDelegate.saveContext()
        
        //update table
        tableView.reloadData()
    }
    
    //MARK:- Search Bar
    @IBOutlet weak var reviewSearchBar: UISearchBar!
    
    //What to do when search bar is selected
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    //perform search for the given title
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        //FIXME - add code to take text and exectue search based on title
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return allReviews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableCell
        
        let current = allReviews[indexPath.row]
        
        cell.title.text = current.title
        cell.category.text = current.category as? String
        cell.score.text = current.rating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = localAppDelegate.persistentContainer.viewContext
        if editingStyle == .delete {
            // Delete the row from the data source and update table
            //remove review from allReviews
            let review = allReviews.remove(at: indexPath.row)
            //remove review from context store
            context.delete(review)
            //perform the update
            localAppDelegate.saveContext()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveReview(from: fromIndexPath.row, to: to.row)

    }
    
    func moveReview(from: Int, to: Int) -> () {
        //store the from review
        let temp = allReviews[from]
        
        //override from with to
        allReviews[from] = allReviews[to]
        allReviews[to] = temp
        
        //update context
        let context = localAppDelegate.persistentContainer.viewContext
        //context.
        localAppDelegate.saveContext()
    }

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
        case "showReviewSegue"?:
            let destin = segue.destination as! ReviewDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            
            destin.currentReview = allReviews[index!]
            
        default:
            fatalError("Unknown segue when on \(self)")
        }
        
    }
    
 

}
