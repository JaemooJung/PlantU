//
//  _RelationshipDemo_ViewController.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/10.
//

import UIKit
import CoreData

class _RelationshipDemo_ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func relationDemo() {
        let somePlant = Plant(context: context)
        somePlant.plantName = "Cooool"
        
        
        let journal_day1 = Journal(context: context)
        journal_day1.plant = somePlant
        
        somePlant.addToJournals(journal_day1)
        
        try! context.save()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
