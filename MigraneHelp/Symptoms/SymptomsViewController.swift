//
//  SymptomsViewController.swift
//  MigraneHelp
//
//  Created by Bharath G on 11/3/21.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderlabel: UILabel!
}

class SymptomsViewController: UIViewController {
    @IBOutlet weak internal var collectionView: UICollectionView!
    @IBOutlet weak internal var proceedButton: UIButton!
    var provider: SymptomsDataProvider!
    var dataArray: [SymptomCategory] = []
    var location = ""
    var kindofPain = ""
    var nausea = ""
    var lightSensivity = ""
    var soundSensivity = ""
    var stiffness = ""
    var intensityOfPain = ""
    var cameFromDashboard = false
    @IBOutlet weak var titleLabel: UILabel!
    var userInputView = 1
    var analysisVC: AnalysisVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = provider.refreshDataArray(userInputView)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if userInputView == 2 {
            titleLabel.text = "Our classification algorithm has determined you have symptoms of a migraine. Please give further information."

        } else if userInputView == 3 {
            titleLabel.isHidden = false
            titleLabel.text = "Please update the most common triggers of your migraine"//"Have you encountered any of these triggers in the last 24h?"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.topItem?.title = "Know Your Headache"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SymptomsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }

    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let data = dataArray[section]

        return data.symptom.count
    }

    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataArray[indexPath.section].multiSelect {
            dataArray[indexPath.section].symptom[indexPath.row].isSelected = !dataArray[indexPath.section].symptom[indexPath.row].isSelected
        } else {
            for index in 0..<dataArray[indexPath.section].symptom.count {
                dataArray[indexPath.section].symptom[index].isSelected = (index == indexPath.row)
            }
        }
        collectionView.reloadData()
    }
    internal func collectionView(_
        collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SymptomsCollectionCell", for: indexPath)
            as? SymptomsCollectionCell ?? SymptomsCollectionCell()
        let data = dataArray[indexPath.section].symptom
        cell.configureCell(data[indexPath.row])
        return cell
    }

    
    internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader{
            let title = dataArray[indexPath.section].title
            sectionHeader.sectionHeaderlabel.text = title
            //sectionHeader.sectionHeaderlabel.textColor = .black
            return sectionHeader
        }
        return UICollectionReusableView()
    }

    func isMigraine(symptoms: [SymptomsModel]) -> Bool {
        for symptom in symptoms {
            switch symptom.symptom {
            case "location":
                location =  symptom.id
            case "kindofPain":
                kindofPain = symptom.id
            case "nausea":
                nausea =  symptom.id
            case "lightSensivity":
                lightSensivity = symptom.id
            case "soundSensivity":
                soundSensivity = symptom.id
            case "stiffness":
                stiffness = symptom.id
            case "intensityOfPain":
                intensityOfPain = symptom.id
            default:
                break
            }
        }
        return (location == "1" || location == "2") && kindofPain == "1"

    }

    func  classifyHeadache() -> String {
        if location == "2" {
            return "tension"
        }
        if location == "4" {
            return "cluster"
        }
        return ""
    }
    @IBAction private func buttonTapped(_ sender: Any) {
        var selectedSymtoms: [SymptomsModel] = []
        for eachSymptom in dataArray {
            for eachItem in eachSymptom.symptom {
                if eachItem.isSelected {
                    selectedSymtoms.append(eachItem)
                }
            }
        }

        provider.selectedSymptomsArray.append(contentsOf: selectedSymtoms)
        print(provider.selectedSymptomsArray)

        if userInputView == 1 {
           if isMigraine(symptoms: selectedSymtoms)  {
                launchSyptomsScreen()
           } else {
            //classify
            let condition = classifyHeadache()
            let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
            guard let analysisVC = storyboard.instantiateViewController(withIdentifier: "AnalysisVC")
                    as? AnalysisVC else { return }
            analysisVC.issue = condition
            self.navigationController?.pushViewController(analysisVC, animated: true)

           }
        } else if userInputView  == 2 {
            launchSyptomsScreen()
            
            //launch Dashboard
        } else {
            let symptomArray: [String] =  selectedSymtoms.map({$0.title})
            let dateStr = getDateFormatterToUseForDateString().string(from: Date())
            let currentTrigger = [dateStr : symptomArray]
            if let symptomsInfo = UserDefaults.standard.object(forKey: "Symptoms") {
                var info = symptomsInfo as! [[String: [String]]]
                info.append(currentTrigger)
                UserDefaults.standard.set(info, forKey: "Symptoms")
            } else {
                UserDefaults.standard.set([currentTrigger], forKey: "Symptoms")
            }

            let predictor = MigraineClassifyPred77()
            let result = try! predictor.prediction(prophylaxis: 1.0, stress: 1.0, oversleeping: 0, lack_of_sleep: 1, Exercise: 0, physical_fatigue: 0, menstruation: 0, emotional_change: 0, Weather: 1, sunlight: 0, noise: 0, ilighting: 0, drinking: 0, meals: 0, caffiene: 1, Travel: 0)
            if cameFromDashboard && analysisVC != nil {
                analysisVC.issue = "migraine"
                analysisVC.prediction = result.migraineProbability
                self.navigationController?.popViewController(animated: true)
            }
           // let condition = classifyHeadache()
            let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
            guard let analysisVC = storyboard.instantiateViewController(withIdentifier: "AnalysisVC")
                    as? AnalysisVC else { return }
            analysisVC.issue = "migraine"

            analysisVC.prediction = result.migraineProbability
            self.navigationController?.pushViewController(analysisVC, animated: true)
        }
    }

    func getDateFormatterToUseForDateString() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }
    func launchSyptomsScreen() {
        let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
        guard let symptomsViewController = storyboard.instantiateViewController(withIdentifier:
            "SymptomsViewController") as? SymptomsViewController else {
            return
        }
        symptomsViewController.provider = self.provider
        symptomsViewController.userInputView = self.userInputView + 1
        self.navigationController?.pushViewController(symptomsViewController, animated: true)
    }
}
