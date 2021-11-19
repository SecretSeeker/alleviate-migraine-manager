//
//  SymptomsDataProvider.swift
//  MigraneHelp
//
//  Created by Bharath G on 11/3/21.
//

import UIKit
struct SymptomsModel {
    var symptom: String = ""
    var id: String = ""
    var title: String = ""
    var imageLink: String = ""
    var isSelected: Bool = false
}

struct SymptomCategory {
    var symptom : [SymptomsModel] = []
    var id: String = ""
    var title: String = ""
    var multiSelect = false
}
class SymptomsDataProvider: NSObject {
//    var locationsymptomDetails: [String : [[String:String]]] = ["location" : [["id": "oneside", "title": "One Side", "imageLink" : ""],
//        ["id":"twoside", "title": "Two Side", "imageLink" : ""],
//    ["id":"backhead","title": "Back Of Head", "imageLink" : ""],
//    ["id":"behindeyes", "title": "Behind Eyes", "imageLink" : ""]]]
//    var painIntensitysymptomDetails: [String : [[String:String]]] = ["intensityOfPain" : [["id": "low", "title": "Low", "imageLink" : ""],
//        ["id":"medium", "title": "Medium", "imageLink" : ""],
//    ["id":"high","title": "High", "imageLink" : ""]]]
//    var kindOfPainDetails: [String : [[String:String]]] = ["kindofPain" : [["id": "throbbing", "title": "Throbbing", "imageLink" : ""],
//        ["id":"constantpain", "title": "Constant pain", "imageLink" : ""]]]
//    var nauseaDetails: [String : [[String:String]]] = ["nausea" : [["id": "yes", "title": "Yes", "imageLink" : ""],
//        ["id":"no", "title": "No", "imageLink" : ""]]]
//    var lightSensitivityDetails: [String : [[String:String]]] = ["lightSensivity" : [["id": "yes", "title": "Yes", "imageLink" : ""],
//        ["id":"no", "title": "No", "imageLink" : ""]]]
//    var soundSensivityDetails: [String : [[String:String]]] = ["soundSensivity" : [["id": "yes", "title": "Yes", "imageLink" : ""],
//        ["id":"no", "title": "No", "imageLink" : ""]]]
//    var stiffnessDetails: [String : [[String:String]]] = ["stiffness" : [["id": "yes", "title": "Yes", "imageLink" : ""],
//        ["id":"no", "title": "No", "imageLink" : ""]]]


//    func refreshsymptomsData() -> [[String: [SymptomsModel]]] {
//        symptomsDataArray.removeAll()
//        var symptomDetails = [locationsymptomDetails, painIntensitysymptomDetails,kindOfPainDetails,lightSensitivityDetails,soundSensivityDetails,stiffnessDetails]
//        for eachItem in symptomDetails {
//            var symptomsArray :[SymptomsModel] = []
//            let symptom = eachItem
//            let key = symptom.keys
//            for eachtype in symptom[key] {
//                symptomsDataArray.append(SymptomsModel(id: eachItem["id"] ?? "", title: eachItem["title"] ?? "", imageLink: eachItem["imageLink"] ?? "", isSelected: false))
//            }
//        }
//        return symptomsDataArray
//    }

    var selectedSymptomsArray: [SymptomsModel] = []

    var symptomsDataArray: [SymptomCategory] = []
    var migraneDataArray: [SymptomCategory] = []
    var migraneTriggersArray: [SymptomCategory] = []

    func refreshDataArray(_ type: Int = 1)-> [SymptomCategory] {
        if type ==  2 {
            return refreshMigraneData()
        } else if type == 3 {
            return refreshMigraneTriggerData()
        } else {
            selectedSymptomsArray.removeAll()
            return refreshsymptomsData()
        }
    }
    func refreshsymptomsData() -> [SymptomCategory] {
        symptomsDataArray.removeAll()
        symptomsDataArray.append(createLocationSymptom())
        symptomsDataArray.append(createPainIntensitySymptom())
        symptomsDataArray.append(createkindOfPainSymptom())
        symptomsDataArray.append(createnauseaSymptom())
        symptomsDataArray.append(createlightSensitivitySymptom())
        symptomsDataArray.append(createSoundSensitivitySymptom())
        symptomsDataArray.append(createstiffnessSymptom())
        return symptomsDataArray
    }
    func createLocationSymptom() -> SymptomCategory{
        let symptomId = "location"
        let title = "Location"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"One Side",imageLink:"one_side",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"2",title:"Two Side",imageLink:"two_sides",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"3",title:"Back Of Head",imageLink:"back_of_head",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"4",title:"Behind Eyes",imageLink:"behind_eyes",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createPainIntensitySymptom() -> SymptomCategory{
        let symptomId = "intensityOfPain"
        let title = "Intensity of pain"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Low",imageLink:"low",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"2",title:"Medium",imageLink:"medium",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"3",title:"High",imageLink:"high",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createkindOfPainSymptom() -> SymptomCategory{
        let symptomId = "kindofPain"
        let title = "Kind of Pain"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Throbbing",imageLink:"throbbing",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"2",title:"Constant pain",imageLink:"constant",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createnauseaSymptom() -> SymptomCategory{
        let symptomId = "nausea"
        let title = "Nausea"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createlightSensitivitySymptom() -> SymptomCategory{
        let symptomId = "lightSensivity"
        let title = "Light Sensivity"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createSoundSensitivitySymptom() -> SymptomCategory{
        let symptomId = "soundSensivity"
        let title = "Sound Sensivity"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createstiffnessSymptom() -> SymptomCategory{
        let symptomId = "stiffness"
        let title = "Neck/head stiffness"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func refreshMigraneData() -> [SymptomCategory] {
        migraneDataArray.removeAll()
        migraneDataArray.append(createheadacheFrequencySymptom())
        migraneDataArray.append(createDizzinessSymptom())
        migraneDataArray.append(createTinnitusSymptom())
        migraneDataArray.append(createspeechProblemSymptom())
        return migraneDataArray
    }

    func createheadacheFrequencySymptom() -> SymptomCategory{
        let symptomId = "headacheFrequency"
        let title = "How many times/month do you get such attacks?"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Once",imageLink:"1",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"2",title:"Twice",imageLink:"2",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"3",title:"Thrice",imageLink:"3",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"4",title:"Four times",imageLink:"4",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"5",title:"Five times",imageLink:"5",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createDizzinessSymptom() -> SymptomCategory{
        let symptomId = "dizziness"
        let title = "Do you experience dizziness in your episodes?"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createTinnitusSymptom() -> SymptomCategory{
        let symptomId = "tinnitus"
        let title = "Do you experience a ringing sound during your migraines?"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func createspeechProblemSymptom() -> SymptomCategory{
        let symptomId = "speechProblem"
        let title = "Do you have problems with speech during your migraines?"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Yes",imageLink:"Yes",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"0",title:"No",imageLink:"No",isSelected: false)
        ]
        let symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        return symptom
    }

    func refreshMigraneTriggerData() -> [SymptomCategory] {
        migraneTriggersArray.removeAll()
        migraneTriggersArray.append(createMigraneTriggerSymptom())
        return migraneTriggersArray
    }

    func createMigraneTriggerSymptom() -> SymptomCategory{
        let symptomId = "migraneTriggers"
        let title = "Migrane Triggers"
        let options = [
            SymptomsModel(symptom:symptomId,id:"1",title:"Stress",imageLink:"Stress",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"2",title:"Excessive sleep",imageLink:"ExcessiveSleep",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"3",title:"Sleep deprivation",imageLink:"ExcessiveSleep",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"4",title:"Exercise",imageLink:"Excercise",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"5",title:"Fatigue",imageLink:"fatigue",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"6",title:"Hormonal changes",imageLink:"HormonalChanges",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"7",title:"Emotional changes",imageLink:"EmotionalChanges",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"8",title:"Weather changes",imageLink:"weatherChanges",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"9",title:"Sunlight",imageLink:"SunLight",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"10",title:"Noise",imageLink:"Noise",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"11",title:"Fasting",imageLink:"NotEating",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"12",title:"Overeating",imageLink:"OverEating",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"13",title:"Caffeine",imageLink:"Caffiene",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"15",title:"Alcohol",imageLink:"Alcohol",isSelected: false),
            SymptomsModel(symptom:symptomId,id:"16",title:"Traveling",imageLink:"travel",isSelected: false)
        ]
        var symptom = SymptomCategory(symptom: options, id: symptomId, title: title)
        symptom.multiSelect = true
        return symptom
    }

}


