//
//  AnalysisVC.swift
//  MigraneHelp
//
//  Created by philips on 13/11/21.
//

import Foundation
import UIKit

class AnalysisVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var issueTitlee: UILabel!
    @IBOutlet weak var issueDescription: UILabel!
    @IBOutlet weak var triggerDesc: UILabel!
    @IBOutlet weak var triggerTitle: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var therapyView: UIView!
    var prediction: [Int64 : Double] = [:]
    var issue: String = "migraine"
    var isLocalNotif: Bool = false
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        migraineProbLabel.text = "Migraine Risk!"
        setUI()
        addTapGuestures()
    }
    @IBOutlet weak var predictionView: UIView!
    @IBOutlet weak var migraineProbLabel: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Dashboard"
        configIssue()
        configTriggers()
        view.layoutSubviews()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        predictionView.addShadow()
        view3.addShadow()
        view4.addShadow()
        view5.addShadow()

    }
    func setUI() {
//        predictionView.layer.cornerRadius = 6.0
//        view3.layer.cornerRadius = 6.0
//        view4.layer.cornerRadius = 6.0
//        view5.layer.cornerRadius = 6.0
    }
    func configTriggers() {
      // predictionView.isHidden = true
        therapyView.isHidden = true
        let pred: Double = prediction[1]!*100.0
        predictionLabel.text =  "You have a medium risk(" + String(describing:  pred.rounded(toPlaces: 2)) +  "%) of getting a migraine in the next 24 hours.\n Tap to manage your triggers and reduce the risk of encountering a migraine"
        }

   func configIssue() {
    issueDescription.text = "Oh no, you seem to have a migraine with aura. Since you get them more than 4 times a month, it is recommended to try preventive therapy. Click to know more "
    issueTitlee.text = "Migraine with Aura"
        switch issue {
        case "migraine":
            issueDescription.text = "Oh no, you seem to have a migraine with aura.\n \nSince you get them more than 4 times a month, it is recommended to try preventive therapy. Click to know more "
            issueTitlee.text = "Migraine with Aura"
        case "tension":
            issueDescription.text = "Oh no, you seem to have a tension headache"
            issueTitlee.text = "Tension headache"

        case "cluster":
            issueDescription.text = "Oh no, you seem to have a cluster headache"
            issueTitlee.text = "Cluster headache"
        default:
            break
        }
    }
    internal func addTapGuestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.launcgTriggerDetails))
        self.view5.addGestureRecognizer(tap)
        self.view5.isUserInteractionEnabled = true

        let therapyTap = UITapGestureRecognizer(target: self, action: #selector(self.launchTherapy))
        self.therapyView.addGestureRecognizer(therapyTap)
        self.therapyView.isUserInteractionEnabled = true

        let predictionTap = UITapGestureRecognizer(target: self, action: #selector(self.launchPrevention))
        self.predictionView.addGestureRecognizer(predictionTap)
        self.predictionView.isUserInteractionEnabled = true

        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.launchTriggers))
        self.view4.addGestureRecognizer(tap4)
        self.view4.isUserInteractionEnabled = true
    }

    @objc func launchTriggers() {
         let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
         guard let yourVC = storyboard.instantiateViewController(withIdentifier: "SymptomsViewController")
                 as? SymptomsViewController else { return }
        yourVC.userInputView = 3
        yourVC.provider = SymptomsDataProvider()
        yourVC.analysisVC = self
        self.navigationController?.pushViewController(yourVC, animated: true)
    }

    @objc func launcgTriggerDetails() {
        // let condition = classifyHeadache()
         let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
         guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "TriggerDateTableViewController")
                 as? TriggerDateTableViewController else { return }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    @objc func launchTherapy() {
        let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "TriggerManagementDetailVC")
                as? TriggerManagementDetailVC else { return }
        
       self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    @objc func launchPrevention() {
        let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "TriggerManagementVC")
                as? TriggerManagementVC else { return }

       self.navigationController?.pushViewController(detailsVC, animated: true)
    }

}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIView {
    func addViewShadow() {
        layer.cornerRadius = 6.0
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.gray.cgColor
//        layer.masksToBounds = true
//        let color = UIColor.gray.cgColor
//        layer.shadowColor = color
//        layer.shadowRadius = 2.0
//        layer.shadowOpacity = 1.0
//        layer.shadowOffset = .zero
//        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
}
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
