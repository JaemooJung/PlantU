//
//  MainTableViewCell.swift
//  PetPlant
//
//  Created by JaemooJung on 2021/01/13.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var plantProfileImageView: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantSpeciesLabel: UILabel!
    @IBOutlet weak var plantBirthDateLabel: UILabel!
    @IBOutlet weak var plantWaterDDayLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
