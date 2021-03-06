//
//  EditPlantTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/17.
//

import UIKit
import RealmSwift

class EditPlantTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var plantToEditPrimaryKey = ""
    var plantToEdit:Plant = Plant()
    
    var profileImageChanged:Bool = false
    var isDeleting:Bool = false
    
    let realm = try! Realm()
    
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var plantSpeciesTextField: UITextField!
    @IBOutlet weak var plantBirthDatePicker: UIDatePicker!
    @IBOutlet weak var plantLastWateredDatePicker: UIDatePicker!
    @IBOutlet weak var plantWaterIntervalTextField: UITextField!
    @IBOutlet weak var plantProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fetchPlantToEdit(PK: plantToEditPrimaryKey)
        showCurrentValues()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func fetchPlantToEdit(PK:String){
        plantToEdit = realm.object(ofType: Plant.self, forPrimaryKey: PK)!
    }
    
    func showCurrentValues() {
        plantNameTextField.text = plantToEdit.plantName
        plantSpeciesTextField.text = plantToEdit.species
        plantBirthDatePicker.date = plantToEdit.birthDate!
        plantLastWateredDatePicker.date = plantToEdit.lastWateredDate!
        plantWaterIntervalTextField.text = plantToEdit.waterInterval
        if let profilePhotoURL = plantToEdit.profilePhotoURL {
            plantProfileImageView.image = ImageFileManager.shared.getSavedImage(named: profilePhotoURL)
        }
        
        
    }
    
    func editPlant() {
        
        realm.beginWrite()
        
        plantToEdit.plantName = plantNameTextField.text
        plantToEdit.species = plantSpeciesTextField.text
        plantToEdit.birthDate = plantBirthDatePicker.date
        plantToEdit.lastWateredDate = plantLastWateredDatePicker.date
        plantToEdit.waterInterval = plantWaterIntervalTextField.text
        if plantProfileImageView.image != nil && profileImageChanged {
            
            ImageFileManager.shared.deleteImage(named: plantToEdit.profilePhotoURL!) { onSuccess in
                print("Image Delete onSuccess= \(onSuccess)")
            }
            
            let uniqueFileName = "IMG\(UUID().uuidString).jpeg"
            ImageFileManager.shared.saveImage(image: plantProfileImageView.image!, name: uniqueFileName) { onSuccess in
                print("Save Image OnSuccess: \(onSuccess)")
            }
            plantToEdit.profilePhotoURL = uniqueFileName
        }
        
        //ToDo
        //?????? ????????? ????????? ???????????? ????????? ???????????? ?????? ????????? ???.

        
        try! realm.commitWrite()
        print("?????? ?????? ??????")
    }
    
    func deletePlant() {
        realm.beginWrite()
        realm.delete(plantToEdit.journals)
        realm.delete(plantToEdit)
        try! realm.commitWrite()
    }
  
    @IBAction func editProfilePhoto(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        //???????????? ????????? ??????
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(cameraAction)
            
        }
        
        //????????????????????? ????????????
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage  else { return}
        plantProfileImageView.image = selectedImage
        profileImageChanged = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        isDeleting = true
        performSegue(withIdentifier: "UnwindToMain", sender: nil)
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if isDeleting == true {
            deletePlant()
        } else {
            editPlant()
        }
        
        let mainVC = segue.destination as? MainViewController
        mainVC?.fetchPlant()
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
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
