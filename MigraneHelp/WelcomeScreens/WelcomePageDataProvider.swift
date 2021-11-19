//
//  WelcomePageDataProvider.swift
//  WelcomeScreens
//
//  Created by Gurleen Kaur on 08/11/21.
//

import Foundation
protocol WelcomePageDataProviderType {
    func getData(fileName: String, bundle: Bundle) -> [AppTourModel]
}

struct AppTourResponse: Decodable {
    let appTour: [AppTourModel]

    enum CodingKeys: String, CodingKey {
        case appTour = "AppTour"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appTour = try container.decode([AppTourModel].self, forKey: .appTour)
    }
}

struct AppTourModel: Decodable {
    let descriptionText: String
    let backgroundImage: String
}

class WelcomePageDataProvider: WelcomePageDataProviderType {
    private func loadJson(filename fileName: String, bundle: Bundle) -> [AppTourModel]? {
        if let url = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(AppTourResponse.self, from: data)
                return jsonData.appTour
            } catch {
//                PHLog.info("error:\(error)")
            }
        }
        return nil
    }

    private func localContentApptour() -> [AppTourModel] {
        let data = [
            AppTourModel(descriptionText: "Welcome to Alleviate!",
                         backgroundImage: "appTour1"),
            AppTourModel(descriptionText: "Understand your triggers...",
                         backgroundImage: "appTour2"),
            AppTourModel(descriptionText: "Manage your migraines",
                         backgroundImage: "appTour3")
        ]
        return data
    }
    private func localContentApptourForSingleScreen() -> [AppTourModel] {
        let data = [
            AppTourModel(descriptionText: "OB_ACTION_TIPS_BETTER_BRUSH",
                                backgroundImage: "appTour1")
               ]
               return data
    }

    func localContentApptourForScreens(fileName: String) -> [AppTourModel] {
        if fileName.contains("SingleScreen") {
            return localContentApptourForSingleScreen()
        }
        return localContentApptour()
    }
    func getData(fileName: String, bundle: Bundle) -> [AppTourModel] {
        loadJson(filename: fileName, bundle: bundle) ?? localContentApptour()
    }
}
