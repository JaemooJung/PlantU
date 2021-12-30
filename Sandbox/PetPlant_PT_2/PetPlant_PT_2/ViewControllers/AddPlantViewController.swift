//
//  AddPlantViewController.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/09.
//

import UIKit
import CoreData

class AddPlantViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var plantNameTextField: UITextField!
    @IBOutlet weak var plantSpeciesTextField: UITextField!
    @IBOutlet weak var plantBirthDayDatePicker: UIDatePicker!
    @IBOutlet weak var plantLastWateredDateDatePicker: UIDatePicker!
    @IBOutlet weak var plantWaterIntervalTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addPlant(_ sender: Any) {
        
        // 새로운 Plant 인스턴스 만들기
        let newPlant = Plant(context: self.context)
        
        // 인스턴스에 각각의 값 저장
        newPlant.plantName = plantNameTextField.text
        newPlant.species = plantSpeciesTextField.text
        newPlant.birthDate = plantBirthDayDatePicker.date
        newPlant.registeredDate = Date()
        newPlant.lastWateredDate = plantLastWateredDateDatePicker.date
        
        if let a = plantWaterIntervalTextField.text {
            if let b = Int16(a) {
                newPlant.waterInterval = b
            }
        }
        
        // 인스턴스를 CoreData에 저장
        do {
            try self.context.save()
            print("데이터 저장 완료")
        }
        catch {
            print("새로운 데이터를 저장하는 중에 에러가 발생했습니다!")
        }
        

        
    }
    

    
    // 모달이 내려갈 때 메인에 있는 테이블 뷰 재설정
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainVC = segue.destination as? ViewController
        mainVC?.fetchPlant()
    }


}
