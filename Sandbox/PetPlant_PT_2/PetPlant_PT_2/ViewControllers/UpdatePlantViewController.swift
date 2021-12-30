//
//  UpdatePlantViewController.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/09.
//

import UIKit
import CoreData

class UpdatePlantViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var plantToUpdate = Plant()
    
    
    @IBOutlet weak var updatedPlantNameTextField: UITextField!
    @IBOutlet weak var updatedPlantSpeciesTextField: UITextField!
    @IBOutlet weak var updatedBirthDayDatePicker: UIDatePicker!
    @IBOutlet weak var updatedLastWateredDateDatePicker: UIDatePicker!
    @IBOutlet weak var updatedWaterIntervalTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatedPlantNameTextField.text = plantToUpdate.plantName
        updatedPlantSpeciesTextField.text = plantToUpdate.species
        updatedBirthDayDatePicker.date = plantToUpdate.birthDate ?? Date()
        updatedLastWateredDateDatePicker.date = plantToUpdate.lastWateredDate ?? Date()
        updatedWaterIntervalTextField.text = "\(plantToUpdate.waterInterval)"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updatePlant(_ sender: Any) {
        
        plantToUpdate.plantName = updatedPlantNameTextField.text
        plantToUpdate.species = updatedPlantSpeciesTextField.text
        plantToUpdate.birthDate = updatedBirthDayDatePicker.date
        plantToUpdate.lastWateredDate = updatedLastWateredDateDatePicker.date
        
        if let a = updatedWaterIntervalTextField.text {
            if let b = Int16(a) {
                plantToUpdate.waterInterval = b
            }
        }
        
        // 다시 저장하기

        do {
            try self.context.save()
        }
        catch {
            print("업데이트 실패!!")
        }
        
    }
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC = segue.destination as? ViewController
        mainVC?.fetchPlant()
    }
 

}
