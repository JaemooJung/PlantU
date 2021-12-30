//
//  WriteJournalTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/16.
//

import UIKit
import RealmSwift

class WriteJournalTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var plantPriamryKey:String = ""
    let realm = try! Realm()
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var emotionalStateCollection: [UISwitch]!
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalContentTextView: UITextView!
    @IBOutlet var plantCareCollection: [UISwitch]!
    @IBOutlet weak var journalPhotoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = dateToStringYYYYMMDD(date: Date())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //카메라로 찍어서 넣기
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
            
        }
        
        //라이브러리에서 선택하기
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage  else { return }
        journalPhotoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    func makeEmotionalState() -> EmotionalState {
        let newEmotionalState = EmotionalState()
        newEmotionalState.joyful = emotionalStateCollection[0].isOn
        newEmotionalState.calm = emotionalStateCollection[1].isOn
        newEmotionalState.anxious = emotionalStateCollection[2].isOn
        newEmotionalState.sad = emotionalStateCollection[3].isOn
        newEmotionalState.angry = emotionalStateCollection[4].isOn
        newEmotionalState.emotionDate = Date()
        print(newEmotionalState)
        return newEmotionalState
    }
    
    func makePlantCare() -> PlantCare {
        let newPlantCare = PlantCare()
        newPlantCare.careDate = Date()
        newPlantCare.watering = plantCareCollection[0].isOn
        newPlantCare.nutrition = plantCareCollection[1].isOn
        newPlantCare.pruning = plantCareCollection[2].isOn
        newPlantCare.changeLocation = plantCareCollection[3].isOn
        newPlantCare.repotting = plantCareCollection[4].isOn
        
        print(newPlantCare)
        return newPlantCare
        
    }
    
    
    
    func saveNewJournal() {
        print("Start Saving")
        let plantOfThisJournal = realm.object(ofType: Plant.self, forPrimaryKey: plantPriamryKey)
        let newJournal = Journal()
        
        newJournal._id = UUID().uuidString
        newJournal.writtenDate = Date()
        newJournal.journalTitle = journalTitleTextField.text
        newJournal.journalContent = journalContentTextView.text
        newJournal.emotionalState = makeEmotionalState()
        newJournal.plantCare = makePlantCare()
        
        if let journalPhoto = journalPhotoImageView.image {
            let uniqueFileName = "IMG\(UUID().uuidString).jpeg"
            ImageFileManager.shared.saveImage(image: journalPhoto, name: uniqueFileName) { onSuccess in
                print("Save Image OnSuccess: \(onSuccess)")
            }
            newJournal.journalPhotoURL = uniqueFileName
        }
        
        
        realm.beginWrite()
        realm.add(newJournal)
        plantOfThisJournal!.journals.append(newJournal)
        try! realm.commitWrite()
        print("일기 저장 완료")

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveNewJournal()
        let journalListVC = segue.destination as? JournalTableViewController
        journalListVC?.fetchJournal()
    }
    
    
    
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

    
    

}
