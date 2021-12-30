//
//  MainViewController+UISetting.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/19.
//

import Foundation
import UIKit

extension MainViewController {

    func setMainViewUI() {
        // Collection View Settings
        let cellXScale: CGFloat = 0.75
        let cellYScale: CGFloat = 0.7
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellXScale)
        let cellHeight = floor(screenSize.height * cellYScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        let layout = mainPlantCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        mainPlantCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY * 0.85, right: insetX)
        layout.sectionInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY * 0.875, right: insetX)
        layout.minimumLineSpacing = insetX * 2
        
        
        // Logo Settings
        
        let logoLabel = UILabel()
        logoLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        logoLabel.center = CGPoint(x: insetX + 100, y: insetY - 35)
        logoLabel.textAlignment = .left
        logoLabel.text = "PlantU"
        logoLabel.font = .systemFont(ofSize: 36, weight: .semibold)
        logoLabel.textColor = hexStringToUIColor(hex: "3E5412")
        self.view.addSubview(logoLabel)
    
    }

    
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.plants?.count != 0 {
            return self.plants!.count
        } else {
            return self.plants!.count + 1
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if self.plants?.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlantPlaceHolderCell", for: indexPath)
            
            return cell
        } else {
            let plant = plants![indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPlantCollectionViewCell", for: indexPath) as! MainPlantCollectionViewCell
            
            //값 입력
            cell.plantNameLabel.text = plant.plantName
            cell.plantSpeciesLabel.text = plant.species
            cell.plantBirthDayLabel.text = dateToStringYYYYMMDD(date: plant.birthDate!)
            if let profileImageURL = plant.profilePhotoURL {
                cell.plantProfileImage.image = ImageFileManager.shared.getSavedImage(named: profileImageURL)
            } else {
                cell.plantProfileImage.image = UIImage(named: "plantPhotoPlaceholder.jpg")
            }
            
            if let waterInterval = plant.waterInterval {
                
                if let intWaterInterval = Int(waterInterval) {
                let waterDate = dayAfter(daysToAdd: intWaterInterval, from: plant.lastWateredDate!)
                let waterDday = daysBetween(firstDate: Date(), secondDate: waterDate)
            
                    switch Int(waterDday)! {
                    case 0:
                        cell.plantWaterDdayLabel.text = "D-Day"
                    case 1...:
                        cell.plantWaterDdayLabel.text = "D-\(waterDday)"
                    case _ where Int(waterDday)! < 0:
                        cell.plantWaterDdayLabel.text = "D+\(Int(waterDday)!.magnitude)"
                    default:
                        cell.plantWaterDdayLabel.text = nil
                    }
                    
                } else {
                    cell.plantWaterDdayLabel.text = nil
                }
                
            } else {
                cell.plantWaterDdayLabel.text = nil
            }
            
            
            //정보 Label 색상 설정
            cell.plantNameLabel.textColor = hexStringToUIColor(hex: "3E5412")
            cell.plantSpeciesLabel.textColor = hexStringToUIColor(hex: "838E74")
            cell.plantBirthDayLabel.textColor = hexStringToUIColor(hex: "838E74")
            cell.plantWaterDdayLabel.textColor = hexStringToUIColor(hex: "838E74")
            //cell.plantEditButton.tintColor = hexStringToUIColor(hex: "F0BF8A")
            
            //크기 설정
     
            
            
            //그림자
            
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 3, height: 3)
            cell.layer.shadowRadius = 4
            cell.layer.shadowOpacity = 0.1
            cell.layer.masksToBounds = false
            
            return cell
            
        }
        
       
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.plants?.count != 0 {
            performSegue(withIdentifier: "ShowJournalList", sender: self.plants![indexPath.row]._id)
        } else {
            performSegue(withIdentifier: "ShowAddPlantTableView", sender: nil)
            
        }
        
        
    }
    
    
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//            let layout = self.mainPlantCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        var index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//       // let roundedIndex = round(index)
//
//        if velocity.x > 0 {
//            index = CGFloat(Int(ceil(index)))
//                } else if velocity.x < 0 {
//                    index = CGFloat(Int(floor(index)))
//                } else {
//                    index = CGFloat(Int(round(index)))
//                }
//
//
//
//        offset = CGPoint(x: index * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//
//        targetContentOffset.pointee = offset
//
//    }
//

}
