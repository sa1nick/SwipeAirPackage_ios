//
//  SwipeAirPackageApp.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 23/06/25.
//

import SwiftUI
import SwiftData

@main
struct SwipeAirPackageApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            UIKitOnboardingView()  ✅ Show UIKit onboarding screen
//            WelcomeScreenBridgeView()
//            SignUpScreenBridgeView()
//            UIKitEnterOTPBridge()
            LoginScreenBridgeView()
            
        }
        .modelContainer(sharedModelContainer)
    }
}
