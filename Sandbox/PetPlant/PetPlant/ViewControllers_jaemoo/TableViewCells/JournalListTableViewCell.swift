//
//  JournalListTableViewCell.swift
//  PetPlant
//
//  Created by JaemooJung on 2021/01/13.
//

import UIKit

class JournalListTableViewCell: UITableViewCell {

    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var jounalContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
