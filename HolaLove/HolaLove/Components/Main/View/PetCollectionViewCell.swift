//
//  PetCollectionViewCell.swift
//  HolaLove
//
//  Created by Apple on 27/12/2023.
//

import UIKit
import MaterialComponents

class PetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var petAvatarImage: UIImageView!
    @IBOutlet weak var addFavButton: UIButton!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    @IBOutlet weak var cellCardView: CardView!
    
    @IBAction func act_addFavorite(_ sender: Any) {
        
    }
}
