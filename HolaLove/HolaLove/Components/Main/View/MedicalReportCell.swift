//
//  MedicalReportCell.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//
import UIKit

class MedicalReportCell: UITableViewCell {

    @IBOutlet weak var PetImage: UIImageView!
    @IBOutlet weak var PetName: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
