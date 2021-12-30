//
//  ViewController.swift
//  PetPlant
//
//  Created by JaemooJung on 2021/01/13.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var plants:[Plant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        homeTableView.dataSource = self
        homeTableView.delegate = self
        fetchPlant()
    }
    
    //Fetch from CoreData
    func fetchPlant() {
        do {
            let request = Plant.fetchRequest() as NSFetchRequest<Plant>
            
            self.plants = try context.fetch(request)
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
            print("데이터 로드 완료")
        } catch {
            print("데이터 로드 중 오류 발생")
        }
    }


    //unwindSegue
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
    }
    
    
    
    
}




extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        let plant = self.plants![indexPath.row]

        cell.plantNameLabel.text = plant.plantName
        cell.plantBirthDateLabel.text = dateToStringYYYYMMDD(date: plant.birthDate!)
        cell.plantSpeciesLabel.text = plant.species
        
        if let profilePhotoName = plant.profilePhotoURL {
            if let image: UIImage = ImageFileManager.shared.getSavedImage(named: profilePhotoName) {
                cell.plantProfileImageView.image = image
            }
        }
        print("Cell RETURNED")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowJournals", sender: self.plants![indexPath.row])
    }
    

    
    
    
}
