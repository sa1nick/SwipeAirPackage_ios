import SwiftUI
import SwiftData
import GoogleMaps

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

    init() {
        GMSServices.provideAPIKey("AIzaSyC7sLa9HK9IB5cZgYAHoglAwzoL66iDcu0")
    }

    var body: some Scene {
        WindowGroup {
            UIKitBottomTabBarBridge()
//            WelcomeScreenBridgeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
