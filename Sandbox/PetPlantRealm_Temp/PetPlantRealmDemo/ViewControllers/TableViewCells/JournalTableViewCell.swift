//
//  JournalTableViewCell.swift
//  PetPlantRealmDemo
//
//  Created by JaemooJung on 2021/01/16.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var journalTitleTextLabel: UILabel!
    @IBOutlet weak var journalContentTextLabel: UILabel!
    @IBOutlet weak var emotionalStateTextLabel: UILabel!
    @IBOutlet weak var emotionalStateImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
