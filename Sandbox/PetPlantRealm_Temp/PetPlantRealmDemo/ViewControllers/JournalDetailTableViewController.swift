//
//  JournalDetailTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/17.
//

import UIKit
import RealmSwift

class JournalDetailTableViewController: UITableViewController {

    var journalPrimaryKey = ""
    var journal = Journal()
    let realm = try! Realm()
    
    var plantCareContents:[String] = []
    
    
    @IBOutlet weak var journalDateLabel: UILabel!
    @IBOutlet weak var journalPhotoImageView: UIImageView!
    @IBOutlet weak var emotionalStateLabel: UILabel!
    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var journalContentLabel: UILabel!
    @IBOutlet weak var plantCareTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        plantCareTableView.dataSource = self
//        plantCareTableView.delegate = self
        
        fetchJournal()
        renderJournalDetail()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchJournal() {
        journal = realm.object(ofType: Journal.self, forPrimaryKey: journalPrimaryKey)!
    }
    
    func renderJournalDetail() {
        journalDateLabel.text = dateToStringYYYYMMDD(date: journal.writtenDate!)
        if let journalPhotoURL = journal.journalPhotoURL {
            journalPhotoImageView.image = ImageFileManager.shared.getSavedImage(named: journalPhotoURL)
        }
        emotionalStateLabel.text = getEmotionalStateOfThisJournal(journal: journal)
        journalTitleLabel.text = journal.journalTitle
        journalContentLabel.text = journal.journalContent
        plantCareContents = getPlantCaresOfThisJournal(journal: journal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEditJournalView" {
           let editJournalTVC = segue.destination as! EditJournalTableViewController
            editJournalTVC.journalToEditPrimaryKey = journalPrimaryKey
        }
    }

    

    // MARK: - Table view data source


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension JournalDetailTableViewController {
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.plantCareContents.count
//
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalDetailPlantCareTableViewCell", for: indexPath) as! JournalDetailPlantCareTableViewCell
//
//        cell.plantCareLabel.text = plantCareContents[indexPath.row]
//
//        return cell
//
//    }
//
//
//
//}
