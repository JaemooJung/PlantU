//
//  ViewController.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/15.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //Realm 인스턴스 선언
    let realm = try! Realm()
    
    //테이블뷰에 뿌릴 식물의 Array선언
    var plants:[Plant]?

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainTableView.dataSource = self
        mainTableView.delegate = self
        fetchPlant()
        
        //Realm DB의 URL 프린트 -> 시뮬레이터에 저장된 DB에 접근해서 수정할 수 있음!!
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "No Realm URL")
        
    }
    
    // DB에서 식물 데이터를 가져온 후 선언해둔 plants Array에 넣어줌. 그 후 테이블뷰 데이터 리로드
    func fetchPlant() {
        let result = realm.objects(Plant.self).sorted(byKeyPath: "registeredDate", ascending: true)
        self.plants = Array(result)
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        // --for Debug
        print("데이터 로드 완료")
        //print(plants)
        // -----------
    }

    // unwindSegue 지점 잡아줌.
    @IBAction func unwindToMain(_ unwindSegue: UIStoryboardSegue) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 식물 별 일기를 보여주는 JournalTableView로 넘어갈 때 해당 식물의 PrimaryKey를 넘겨줌.
        // JournalTableView에서는 PK를 받아 식물의 일기를 fetch함.
        if segue.identifier == "ShowJournalList" {
            let journalListTVC = segue.destination as? JournalTableViewController
            journalListTVC?.plantPrimaryKey = sender as? String

        }
        if segue.identifier == "ShowEditPlantTableView" {
            let editPlantNavigation = segue.destination as! UINavigationController
            let editPlantTVC = editPlantNavigation.topViewController as! EditPlantTableViewController
            editPlantTVC.plantToEditPrimaryKey = sender as! String
        }
        
    }
    
    
    @IBAction func editPlantButtonTapped(_ sender: UIButton) {
        
        let currentCell = sender.superview?.superview?.superview
        let indexPath = mainTableView.indexPath(for: currentCell! as! UITableViewCell)
        let plantToEditPK =  self.plants![indexPath!.row]._id
        
        performSegue(withIdentifier: "ShowEditPlantTableView", sender: plantToEditPK)
        
    }
    
    

    
}



//______________extentsions____________________

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블뷰에 데이터를 뿌리는 부분 ------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.plants!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let plant = self.plants![indexPath.row]
        
        cell.plantNameLabel.text = plant.plantName
        cell.speciesLabel.text = plant.species
        cell.birthDateLabel.text = dateToStringYYYYMMDD(date: plant.birthDate!)
        
        if let profilePhotoURL = plant.profilePhotoURL {
            if let image: UIImage = ImageFileManager.shared.getSavedImage(named: profilePhotoURL) {
                cell.profileImageView.image = image
            }
        }
        
        //--for Debug ---------
        print("Cell Returned")
        //print(cell)
        //---------------------
        
        return cell
        
    }
    // ----------------------------------
    
    
    // segue를 실행할 때 선택한 Row에 있는 Plant의 PK를 sender로 넘김.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowJournalList", sender: self.plants![indexPath.row]._id)

    }
    


    
}
