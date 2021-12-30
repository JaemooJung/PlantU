//
//  practice.swift
//  PetPlantRealmDemo
//
//  Created by 조준현 on 2021/01/20.
//

import Foundation
import UIKit

func imageTintColorSettings() {
    let image = UIImage(named: "leaf.fill")?.withRenderingMode(.alwaysTemplate)
    btnBack.setImage(image, for: .normal)
    btnBack.tintColor = UIColor.white
}

