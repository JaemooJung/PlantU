//
//  AddPlantViewController.swift
//  PetPlant_Prototype
//
//  Created by JaemooJung on 2021/01/05.
//

import UIKit

class AddPlantViewController: UIViewController {
    @IBOutlet weak var newPlantName: UITextField!
    @IBOutlet weak var newPlantSpecies: UITextField!
    @IBOutlet weak var newPlantBirthday: UIDatePicker!
    @IBOutlet weak var newPlantLastWateredDate: UIDatePicker!
    @IBOutlet weak var newPlantWaterInterval: UITextField!
    @IBOutlet weak var newPlantWaterAlarm: UISwitch!
    @IBOutlet weak var newPlantProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var newPlant = Plant()
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    @IBAction func newPlantSubmit(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let name = newPlantName.text {
            newPlant.plantName = name
        }
        if let species = newPlantSpecies.text {
            newPlant.species = species
        }
        newPlant.birthDate = dateFormatter.string(from: newPlantBirthday.date)
        newPlant.wateredDate = dateFormatter.string(from: newPlantLastWateredDate.date)
        if let waterInterval = newPlantWaterInterval.text {
            newPlant.waterInterval = Int(waterInterval)
        }
        newPlant.isWaterAlarmOn = newPlantWaterAlarm.isOn
        if let profileImage = newPlantProfileImage.image {
            newPlant.profilePhoto = profileImage
        }
        
        newPlant.registeredDate = dateFormatter.string(from: Date())
        
        print(newPlant)
        
    }
    
    //??????1: DB??? Swift Data ??????????????? ?????? ?????? ???????
    //??????2: ??????????????? ????????? ?????????...? ????????????????????????????????????
    //??????3:
    

}
