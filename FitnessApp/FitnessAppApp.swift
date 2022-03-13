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
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                TabContainerView()
            } else {
                LandingView()
            }
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

final class AppState: ObservableObject {
    @Published private(set) var isLoggedIn = false
    
    private let userService = UserService()
    
    init() {
        userService
            .observeAuthChanges()
            .map { $0 != nil }
            .assign(to: &$isLoggedIn)
    }
}
