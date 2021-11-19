//
//  SymptomsCollectionCell.swift
//  MigraneHelp
//
//  Created by Bharath G on 11/3/21.
//

import UIKit

class SymptomsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var optionid: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib called")
    }
    internal func configureCell(_ symptom: SymptomsModel) {
        title.text = symptom.title
        optionid = symptom.id
        productImageView.image = UIImage(named: symptom.imageLink)
        //containerView.backgroundColor = .blue
        containerView.addShadow()
      //  let image = productImageView.image!.withTintColor(.darkGray)
     //   productImageView.image = image

        title.textColor = .black
        contentView.addShadow()
        if symptom.isSelected {
            containerView.backgroundColor = .gray
        }else {
            containerView.backgroundColor = .white
        }
    }
}
