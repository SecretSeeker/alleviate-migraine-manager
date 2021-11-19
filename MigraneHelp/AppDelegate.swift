//
//  AppDelegate.swift
//  MigraneHelp
//
//  Created by Bharath G on 11/3/21.
//

import UIKit
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.scheduleNotification()

        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        if response.notification.request.identifier == "Local Notification" {
//            print("Handling notifications with the Local Notification Identifier")
//            guard let window = UIApplication.shared.windows.first else { return }
//            let storyboard = UIStoryboard(name: "UserEntires", bundle: nil)
//            let yourVC = storyboard.instantiateViewController(identifier: "SymptomsViewController") as! SymptomsViewController
//            yourVC.userInputView = 3
//            let navController = UINavigationController(rootViewController: yourVC)
//            navController.modalPresentationStyle = .fullScreen
//            // you can assign your vc directly or push it in navigation stack as follows:
//            window.rootViewController = navController
//            window.makeKeyAndVisible()
//        }
        completionHandler()
    }
    
    func scheduleNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Track your migraine"
        notificationContent.body = "Tap to know if you are at risk of a migraine"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = 1

        var date = DateComponents()
        date.hour = 16
        date.minute = 46
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)


        let notificationRequest = UNNotificationRequest(identifier: "Local Notification", content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error
            {
                let errorString = String(format: NSLocalizedString("Unable to Add Notification Request %@, %@", comment: ""), error as CVarArg, error.localizedDescription)
                print(errorString)
            }
        }
        
    
    }
}


