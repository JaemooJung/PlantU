//
//  AddPlantViewController.swift
//  PetPlant
//
//  Created by JaemooJung on 2021/01/13.
//

import UIKit
import CoreData

class AddPlantViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var plantSpeciesTextField: UITextField!
    @IBOutlet weak var plantBirthDatePicker: UIDatePicker!
    @IBOutlet weak var lastWateredDatePicker: UIDatePicker!
    @IBOutlet weak var plantWaterIntervalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //프로필 사진 추가 액션
    @IBAction func addProfileImage(_ sender: UIButton) {
        
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
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // 저장
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        let newPlant = Plant(context: self.context)
        
        newPlant.plantName = plantNameTextField.text
        newPlant.species = plantSpeciesTextField.text
        newPlant.birthDate = plantBirthDatePicker.date
        newPlant.registeredDate = Date()
        newPlant.lastWateredDate = lastWateredDatePicker.date
        newPlant.waterInterval = plantWaterIntervalTextField.text
        
        //이미지 저장
        
        if profileImage.image != nil {
            let uniqueFileName = "\(ProcessInfo.processInfo.globallyUniqueString).jpeg"
            
            ImageFileManager.shared.saveImage(image: profileImage.image!, name: uniqueFileName) { [weak self] onSuccess in
                print("saveImage onSuccess: \(onSuccess)")
                
            }
            newPlant.profilePhotoURL = uniqueFileName
            
        }
        
        do {
            try self.context.save()
            print("데이터 저장 완료")
        } catch {
            print("데이터 저장 실패")
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let homeVC = segue.destination as? HomeViewController
        homeVC?.fetchPlant()
    }
    

}
