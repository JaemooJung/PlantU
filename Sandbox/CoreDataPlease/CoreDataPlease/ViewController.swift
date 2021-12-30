//
//  ViewController.swift
//  CoreDataPlease
//
//  Created by JaemooJung on 2021/01/09.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Plant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchPlant()

    }
    
    func fetchPlant() {
        
        do {
            self.items = try context.fetch(Plant.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        catch {
            
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        // 팝업창 만들기
        let alert = UIAlertController(title: "Add Plant", message: "What is the name of plant?", preferredStyle: .alert)
        alert.addTextField()
        
        // 버튼 만들기
        let submitButton = UIAlertAction(title: "Add", style: .default) {
            (action) in
            
            // 팝업창에 텍스트필드 추가
            let textField = alert.textFields![0]
            
            let newPlant = Plant(context: self.context)
            newPlant.plantName = textField.text
            
            // 저장하기
            do {
                try self.context.save()
            } catch {
                print("error while saving data")
            }
            
            // 다시 불러오기
            self.fetchPlant()
        }
        
        // 버튼 추가
        alert.addAction(submitButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택된 식물
        let plant = self.items![indexPath.row]
        //팝업창 만들기
        let alert = UIAlertController(title: "Edit Plant", message: "Edit plant:", preferredStyle: .alert)
        alert.addTextField()

        let textField = alert.textFields![0]
        textField.text = plant.plantName
        
        // 저장버튼만들기
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            
            //알러트에서 텍스트필드 가져오기
            let textField = alert.textFields![0]
            
            // 식물 이름 바꿔주기
            plant.plantName = textField.text
            
            //바꾼 내용 저장
            do {
                try self.context.save()
            }
            catch {
                
            }
            
            self.fetchPlant()
            
        }
        
        alert.addAction(saveButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHander) in
            
            let plantToRemove = self.items![indexPath.row]
            
            self.context.delete(plantToRemove)
            
            do {
                try self.context.save()
            } catch {
                
            }
            self.fetchPlant()
        }
    
        return UISwipeActionsConfiguration(actions: [action])

    }

}

 
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath)
        
        let plant = self.items![indexPath.row]
        
        cell.textLabel?.text = plant.plantName
        
        return cell
    }

    
    
}

