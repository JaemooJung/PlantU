//
//  EditJournalTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/18.
//

import UIKit
import RealmSwift

class EditJournalTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var journalToEditPrimaryKey = ""
    var journalToEdit = Journal()
    let realm = try! Realm()
    var isjournalPhotoEdited = false
    var isDeletingJournal = false
    
    let emotionalStateButtonImage = UIImage(named: "leaf")
    
    @IBOutlet weak var journalDateLabel: UILabel!
    @IBOutlet var emotionalStateCollection: [EmotionalStateButton]!
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalContentTextView: UITextView!
    @IBOutlet var plantCareSwitchCollection: [UISwitch]!
    @IBOutlet weak var journalPhotoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(journalToEditPrimaryKey)
        
        setEmotionalButtonColor(button: emotionalStateCollection[0], color: .clear)
        setEmotionalButtonColor(button: emotionalStateCollection[1], color: .clear)
        setEmotionalButtonColor(button: emotionalStateCollection[2], color: .clear)
        setEmotionalButtonColor(button: emotionalStateCollection[3], color: .clear)
        setEmotionalButtonColor(button: emotionalStateCollection[4], color: .clear)
        
        
        fetchJournalToEdit()
        showCurrentJournalDetail()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func fetchJournalToEdit() {
        journalToEdit = realm.object(ofType: Journal.self, forPrimaryKey: journalToEditPrimaryKey)!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let journalListTVC = segue.destination as! JournalTableViewController
        if isDeletingJournal {
            deleteJournal()
        } else {
            editJournal()
        }
        journalListTVC.fetchJournal()
    }
    
    
    @IBAction func editJournalPhotoButtonTapped(_ sender: Any) {
        
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
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func deleteJournalButtonTapped(_ sender: Any) {
        isDeletingJournal = true
        performSegue(withIdentifier: "UnwindToJournalList", sender: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage  else { return }
        journalPhotoImageView.image = selectedImage
        isjournalPhotoEdited = true
        dismiss(animated: true, completion: nil)
    }
        
    
    func showCurrentJournalDetail() {
        journalDateLabel.text = dateToStringYYYYMMDD(date: journalToEdit.writtenDate!)
        journalTitleTextField.text = journalToEdit.journalTitle
        journalContentTextView.text = journalToEdit.journalContent
        if let journalPhotoURL = journalToEdit.journalPhotoURL {
            journalPhotoImageView.image = ImageFileManager.shared.getSavedImage(named: journalPhotoURL)
        }
        
        let emotionState = journalToEdit.emotionalState
        if emotionState!.joyful {
            emotionalStateCollection[0].status = true
        } else if emotionState!.calm {
            emotionalStateCollection[1].status = true
        } else if emotionState!.anxious {
            emotionalStateCollection[2].status = true
        } else if emotionState!.sad {
            emotionalStateCollection[3].status = true
        } else if emotionState!.angry {
            emotionalStateCollection[4].status = true
        }
        
        let plantCare = journalToEdit.plantCare
        if plantCare!.watering {
            plantCareSwitchCollection[0].isOn = true
        }
        if plantCare!.nutrition {
            plantCareSwitchCollection[1].isOn = true
        }
        if plantCare!.pruning {
            plantCareSwitchCollection[2].isOn = true
        }
        if plantCare!.changeLocation {
            plantCareSwitchCollection[3].isOn = true
        }
        if plantCare!.repotting {
            plantCareSwitchCollection[4].isOn = true
        }
        
    }
    
    
    func deleteJournal() {
        realm.beginWrite()
        realm.delete(journalToEdit.emotionalState!)
        realm.delete(journalToEdit.plantCare!)
        realm.delete(journalToEdit)
        try! realm.commitWrite()
    }
    
    
    func editJournal() {
        
        realm.beginWrite()
        
        journalToEdit.journalTitle = journalTitleTextField.text
        journalToEdit.journalContent = journalContentTextView.text
        
        if journalPhotoImageView.image != nil && isjournalPhotoEdited {
            ImageFileManager.shared.deleteImage(named: journalToEdit.journalPhotoURL!) { onSuccess in
                print("Image Delete onSuccess= \(onSuccess)")
            }
            let uniqueFileName = "IMG\(UUID().uuidString).jpeg"
            ImageFileManager.shared.saveImage(image: journalPhotoImageView.image!, name: uniqueFileName) { onSuccess in
                print("Save Image OnSuccess: \(onSuccess)")
            }
            journalToEdit.journalPhotoURL = uniqueFileName
            }
        
        editEmotionalState(emotionalState: journalToEdit.emotionalState!)
        editPlantCare(plantCare: journalToEdit.plantCare!)
        
        try! realm.commitWrite()
        print("일기 수정 완료")
        }
        
        
    func editEmotionalState(emotionalState: EmotionalState) {
        emotionalState.joyful = emotionalStateCollection[0].status
        emotionalState.calm = emotionalStateCollection[1].status
        emotionalState.anxious = emotionalStateCollection[2].status
        emotionalState.sad = emotionalStateCollection[3].status
        emotionalState.angry = emotionalStateCollection[4].status
    }
    
    func editPlantCare(plantCare:PlantCare){
        plantCare.watering = plantCareSwitchCollection[0].isOn
        plantCare.nutrition = plantCareSwitchCollection[1].isOn
        plantCare.pruning = plantCareSwitchCollection[2].isOn
        plantCare.changeLocation = plantCareSwitchCollection[3].isOn
        plantCare.repotting = plantCareSwitchCollection[4].isOn
        
    }
    
    
    @IBAction func joyfulButtonTouched(_ sender: EmotionalStateButton) {
        if sender.status == true {
            emotionalStateCollection[1].status = false
            emotionalStateCollection[2].status = false
            emotionalStateCollection[3].status = false
            emotionalStateCollection[4].status = false
        }
    }
    @IBAction func calmButtonTouched(_ sender: EmotionalStateButton) {
        if sender.status == true{
            emotionalStateCollection[0].status = false
            emotionalStateCollection[2].status = false
            emotionalStateCollection[3].status = false
            emotionalStateCollection[4].status = false
        }
    }
    @IBAction func anxiousButtonToched(_ sender: EmotionalStateButton) {
        if sender.status == true{
            emotionalStateCollection[0].status = false
            emotionalStateCollection[1].status = false
            emotionalStateCollection[3].status = false
            emotionalStateCollection[4].status = false
        }
    }
    @IBAction func sadButtonTouched(_ sender: EmotionalStateButton) {
        if sender.status == true {
            emotionalStateCollection[0].status = false
            emotionalStateCollection[1].status = false
            emotionalStateCollection[2].status = false
            emotionalStateCollection[4].status = false
        }
    }
    @IBAction func angryButtonTouched(_ sender: EmotionalStateButton) {
        if sender.status == true {
            emotionalStateCollection[0].status = false
            emotionalStateCollection[1].status = false
            emotionalStateCollection[2].status = false
            emotionalStateCollection[3].status = false
        }
    }
    
    func setEmotionalButtonColor(button: EmotionalStateButton, color: UIColor) {
        
        button.onImage? = (emotionalStateButtonImage?.withTintColor(color, renderingMode: .alwaysTemplate))!
        
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
