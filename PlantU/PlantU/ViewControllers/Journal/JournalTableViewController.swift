//
//  JournalTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/16.
//

import UIKit
import RealmSwift

class JournalTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var plantPrimaryKey:String?
    var plant: Plant?

    var journals:[Journal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchJournal()
        
        self.navigationItem.title = "\(plant!.plantName ?? "")의 이야기"
        

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // 식물의 Journal을 fetch해오는 함수
    // 이전 view에서 넘겨받은 식물의 PK로 DB에서 해당 식물에 저장된 일기 목록을 가져옴. 그 후 테이블뷰 리로드
    func fetchJournal() {
        let result = realm.object(ofType: Plant.self, forPrimaryKey: "\(plantPrimaryKey!)")
        plant = result
        self.journals = Array(result!.journals.sorted(byKeyPath: "writtenDate", ascending: false))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        //--for Debug
        print("일기 데이터 로드 완료")
        //print("일기 데이터 \(journals)")
        //-----------
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalTableViewCell", for: indexPath) as! JournalTableViewCell
        let journal = journals![indexPath.row]
        cell.dateTextLabel.text = dateToStringYYYYMMDD(date: journal.writtenDate!)
        
        if journal.journalTitle == "" {
            cell.journalTitleTextLabel.text = "\(dateToStringKr(date: journal.writtenDate!))일의 기록"
        } else {
            cell.journalTitleTextLabel.text = journal.journalTitle
        }
        
        cell.journalContentTextLabel.text = journal.journalContent
        
        switch getEmotionalStateOfThisJournal(journal: journal) {
        case "기쁨":
            cell.emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "FEAD01"))
        case "평온":
            cell.emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "458A33"))
        case "걱정":
            cell.emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "68228A"))
        case "슬픔":
            cell.emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "0076BA"))
        case "분노":
            cell.emotionalStateImageView.setImageColor(color: hexStringToUIColor(hex: "B51700"))
        default:
            cell.emotionalStateImageView.tintColor = .gray
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowJournalDetail", sender: self.journals![indexPath.row]._id)
    }
    
    @IBAction func unwindToJournalList(_ unwindSegue: UIStoryboardSegue) {

    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWriteJournal" {
        let writeJournalVC = segue.destination as! WriteJournalTableViewController
            writeJournalVC.plantPriamryKey = plantPrimaryKey!
        } else if segue.identifier == "ShowJournalDetail" {
            let journalDetailVC = segue.destination as! JournalDetailTableViewController
            journalDetailVC.journalPrimaryKey = sender as! String
        }
        
        
        
    }
    

}


extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
      }
}
