//
//  ViewController.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/09.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    @IBOutlet weak var plantTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // 테이블뷰에 뿌려질 데이터
    var items:[Plant]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        whereIsMySQLite()
        
        plantTableView.dataSource = self
        plantTableView.delegate = self
        fetchPlant()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdatePlant" {
            let vc = segue.destination as! UpdatePlantViewController
            vc.plantToUpdate = (sender as! Plant)
        }
    }
    

    
    
    func fetchPlant() {
        //CoreData에서 데이터 가져오기
        do {
            
            let request = Plant.fetchRequest() as NSFetchRequest<Plant>
            
            // 데이터를 필터링하려면...
//            var plantNameForFilter = "White"
//            let pred = NSPredicate(format: "plantName CONTAINS %@", plantNameForFilter)
//            request.predicate = pred
            
            // 데이터를 정렬하려면...
//            let sort = NSSortDescriptor(key: "registeredDate", ascending: false)
//            request.sortDescriptors = [sort] //어레이로 집어넣는 이유: 여러개를 지정해서 정렬 기준을 여러개 붙일 수 있음!!
//
            self.items = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.plantTableView.reloadData()
            }
            print("데이터 로드 완료")
            
        }
        catch {
            print("데이터를 가져오는 중에 에러가 생겼습니다!")
        }
    }
    
    //unwindSegue를 사용하려면 만들어줘야함!
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {

    }
    
    func whereIsMySQLite() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding

        print(path ?? "Not found")
    }
    
    
}


//테이블 뷰 그리기
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! PlantCellTableViewCell
        
        //라벨 텍스트 설정
        let plant = self.items![indexPath.row]
        cell.plantNameLabel.text = plant.plantName
        cell.speciesLabel.text = plant.species
        cell.birthDateLabel.text = dateToStringYYYYMMDD(date: plant.birthDate!)
        cell.registeredDateLabel.text = dateToStringYYYYMMDD(date: plant.registeredDate!)
        cell.waterIntervalLabel.text = "\(plant.waterInterval)"
        cell.lastWateredDateLabel.text = dateToStringYYYYMMDD(date: plant.lastWateredDate!)
        
        return cell
    }
    
    // 데이터 업데이트
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "UpdatePlant", sender: self.items![indexPath.row])
    }
    
    
    
    // 슬라이드해서 데이터 삭제하는 기능 추가
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       //swipe 액션 만들기
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            
            //지울 식물 설정
            let plantToRemove = self.items![indexPath.row]
            
            // 식물 지우기
            self.context.delete(plantToRemove)
            
           // 지운 데이터 다시 저장
            do {
                try self.context.save()
            }
            catch {
                print("삭제 후 저장 실패!")
            }
            // 테이블뷰 업데이트
            self.fetchPlant()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
