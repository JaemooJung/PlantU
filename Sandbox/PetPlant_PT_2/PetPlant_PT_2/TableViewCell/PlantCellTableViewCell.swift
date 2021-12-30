//
//  PlantCellTableViewCell.swift
//  PetPlant_PT_2
//
//  Created by JaemooJung on 2021/01/09.
//

import UIKit

class PlantCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var registeredDateLabel: UILabel!
    @IBOutlet weak var lastWateredDateLabel: UILabel!
    @IBOutlet weak var waterIntervalLabel: UILabel!
    @IBOutlet weak var profilePhotoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
