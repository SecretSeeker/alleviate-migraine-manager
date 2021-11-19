//
//  TriggerManagementDetailVC.swift
//  MigraneHelp
//
//  Created by Aishwarya on 16/11/21.
//

import Foundation
import UIKit

class TriggerManagementDetailVC : UIViewController {

    @IBOutlet weak var yes: UIButton!
    @IBOutlet weak var qHeight: NSLayoutConstraint!
    @IBOutlet weak var cHeight: NSLayoutConstraint!
    @IBOutlet weak var nonMedView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var questionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Manage your migraine"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        qHeight.constant = 135.0
        cHeight.constant = 0.0
        checkView.isHidden  = true
        questionView.isHidden = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nonMedView.layer.cornerRadius = 6.0
        checkView.layer.cornerRadius = 6.0
        questionView.layer.cornerRadius = 6.0

        nonMedView.addShadow()
        checkView.addShadow()
        questionView.addShadow()
    }

    @IBAction func yesTapped(_ sender: Any) {
        qHeight.constant = 0
        cHeight.constant = 160.0
        checkView.isHidden  = false
        questionView.isHidden = true

    }


}
extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.cornerRadius = 6.0

        updateShadow()
    }
    func updateShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds,cornerRadius: 6).cgPath
    }
}
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "check")! as UIImage
    let uncheckedImage = UIImage(named: "uncheck")! as UIImage

    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
