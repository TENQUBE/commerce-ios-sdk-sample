//
//  AppDelegate.swift
//  CommerceSdkSample
//
//  Created by Samyeol Kim on 2023/03/14.
//

import UIKit
import Commerce

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var scrapService: ScrapService?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initSdk()
        
        return true
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

    func initSdk() {
        let layer = "dev"
        let logger = true
        let demoApiKey = "Nrcoz4wo1Z8mvEuyZzcFt3QUu3cCKpjC4TtijITZ"
        
        do {
            scrapService = try ServiceBuilder()
                .setApiKey(demoApiKey)
                .setLayer(layer)
                .setLogger(logger)
                .build()
            
            scrapService?.initialize(completion: { err in
                print(err)
            })
        } catch {
            print(error)
        }
    }
}

