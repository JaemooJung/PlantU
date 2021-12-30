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
    @IBOutlet weak var emotionalStateImageView: UIImageView!
    
    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var journalContentLabel: UILabel!
    
    @IBOutlet weak var journalPlantCareCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJournal()
        renderJournalDetail()
        
        journalPlantCareCollectionView.dataSource = self
        journalPlantCareCollectionView.delegate = self

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
        
        switch getEmotionalStateOfThisJournal(journal: journal) {
        case "기쁨":
            emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "FEAD01"))
            emotionalStateLabel.text = "기쁨"
        case "평온":
            emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "458A33"))
            emotionalStateLabel.text = "평온"
        case "걱정":
            emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "68228A"))
            emotionalStateLabel.text = "걱정"
        case "슬픔":
            emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "0076BA"))
            emotionalStateLabel.text = "슬픔"
        case "분노":
            emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "B51700"))
            emotionalStateLabel.text = "분노"
        default:
            emotionalStateImageView.tintColor = .gray
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


//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
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

extension JournalDetailTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantCareContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let plantCare = plantCareContents[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantCareDetailCollectionViewCell", for: indexPath) as! PlantCareDetailCollectionViewCell
        
        cell.plantCareName.text = plantCare
        
        return cell
        
    }
    
    
    
    
}
