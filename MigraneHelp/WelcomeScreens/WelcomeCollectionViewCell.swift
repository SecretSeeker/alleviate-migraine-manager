//
//  WelcomeCollectionViewCell.swift
//  WelcomeScreens
//
//  Created by Gurleen Kaur on 08/11/21.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!

    func setCellDetails(_ model: AppTourModel) {
        descriptionLabel.text = model.descriptionText
       descriptionLabel.textColor = .black
        backgroundImage.image = UIImage(named: model.backgroundImage)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        backgroundImage.image = nil
        accessibilityLabel = nil
    }
}
