//
//  PopularCollectionViewCell.swift
//  21002
//
//  Created by kms on 2021/10/02.
//

import UIKit
import FloatRatingView

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reserveBtn: UIButton!
    @IBOutlet weak var floatView: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImage()
    }
    
    fileprivate func setImage() {
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        
        reserveBtn.layer.cornerRadius = 2
        reserveBtn.layer.borderWidth = 2
        reserveBtn.layer.borderColor = UIColor.black.cgColor

        floatView.backgroundColor = .clear
        floatView.contentMode = .scaleAspectFit
        floatView.type = .floatRatings
    }

}
