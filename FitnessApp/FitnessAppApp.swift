//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by YuriyFpc on 22.12.2021.
//

import SwiftUI
import Firebase

@main
struct FitnessAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        debugPrint("configure firebase")
        FirebaseApp.configure()
        return true
    }
}
