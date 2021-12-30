//
//  AddPlantTableViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/15.
//

import UIKit
import RealmSwift

class AddPlantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

    let realm = try! Realm()
    
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var plantSpeciesTextField: UITextField!
    @IBOutlet weak var plantBirthDayDatePicker: UIDatePicker!
    @IBOutlet weak var plantLastWateredDatePicker: UIDatePicker!
    @IBOutlet weak var plantWaterAlarmOnSwitch: UISwitch!
    @IBOutlet weak var plantWaterAlarmTimePicker: UIDatePicker!
    @IBOutlet weak var plantWaterIntervalTextField: UITextField!
    @IBOutlet weak var plantProfileImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        plantBirthDayDatePicker.maximumDate = Date()
        plantLastWateredDatePicker.maximumDate = Date()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func onClickWaterAlarmSwitch(_ sender: UISwitch) {
        
        if !sender.isOn {
            plantWaterAlarmTimePicker.isEnabled = false
        } else {
            plantWaterAlarmTimePicker.isEnabled = true
        }
        
    }
    
    
    
    

    @IBAction func addProfilePhotoTapped(_ sender: UIButton) {
        
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
        guard let selectedImage = info[.originalImage] as? UIImage  else { return}
        plantProfileImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
  
    func saveNewPlant() {
        print("Start Saving")
        
        let newPlant = Plant()
        newPlant._id = UUID().uuidString
        newPlant.plantName = plantNameTextField.text
        newPlant.species = plantSpeciesTextField.text
        newPlant.birthDate = plantBirthDayDatePicker.date
        newPlant.registeredDate = Date()
        newPlant.lastWateredDate = plantLastWateredDatePicker.date
        if plantWaterAlarmOnSwitch.isOn {
            newPlant.isWaterAlarmOn = true
            newPlant.waterAlarmTime = plantWaterAlarmTimePicker.date
        } else {
            newPlant.isWaterAlarmOn = false
        }
        newPlant.waterInterval = plantWaterIntervalTextField.text
    

        if plantProfileImageView.image != nil {
            let uniqueFileName = "IMG\(UUID().uuidString).jpeg"

            ImageFileManager.shared.saveImage(image: plantProfileImageView.image!, name: uniqueFileName) { onSuccess in
                print("Save Image OnSuccess: \(onSuccess)")
            }
            newPlant.profilePhotoURL = uniqueFileName
        }

        if newPlant.waterInterval == "" {
            newPlant.isWaterAlarmOn = false
        }

        realm.beginWrite()
        realm.add(newPlant)
        try! realm.commitWrite()
        print("식물 저장 완료")
        print("\(newPlant)")
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard !plantNameTextField.text!.isEmpty else {
            showAlert(title: "이름을 지어주세요!", message: "동반자에게 이름을 지어주세요!")
            return
        }
        
        if !plantWaterIntervalTextField.text!.isEmpty {
            guard Int(plantWaterIntervalTextField.text ?? "") != nil else {
                showAlert(title: "물주기 간격에는 숫자만", message: "물주기 간격에는 숫자만 입력해주세요!")
                return
            }
        }
        
        saveNewPlant()
        
        performSegue(withIdentifier: "UnwindToMain", sender: nil)
        
    }
    
 
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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

    
 


}
