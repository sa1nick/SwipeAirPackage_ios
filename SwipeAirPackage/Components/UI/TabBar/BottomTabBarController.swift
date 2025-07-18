//
//  BottomTabBarController.swift
//  SwipeAirPackage
//
//  Created by apple on 15/07/25.
//

import UIKit
import SwiftUI

class BottomTabBarController: UITabBarController {

    enum TabBarItemType: CaseIterable {
        case home, services, activity, tools, profile

        var title: String {
            switch self {
            case .home: return "Home"
            case .services: return "Services"
            case .activity: return "Activity"
            case .tools: return "Tools"
            case .profile: return "Profile"
            }
        }

        var icon: UIImage? {
            switch self {
            case .home: return UIImage(named: "homeIcon")
            case .services: return UIImage(named: "servicesIcon")
            case .activity: return UIImage(named: "activityIcon")
            case .tools: return UIImage(named: "toolsIcon")
            case .profile: return UIImage(named: "profileIcon")
            }
        }

        func viewController() -> UIViewController {
            switch self {
            case .home:
                // Directly create and return UIHostingController with HomeScreenBridgeView
                let controller = UIHostingController(rootView: HomeScreenBridgeView())
                controller.tabBarItem = UITabBarItem(title: title, image: icon, tag: 0)
                return controller

            case .services, .activity, .tools, .profile:
                let placeholderView = Text("\(self.title) Screen")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)

                let controller = UIHostingController(rootView: placeholderView)
                controller.tabBarItem = UITabBarItem(title: title, image: icon, tag: 0)
                return controller
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set SwiftUI-hosted view controllers directly
        viewControllers = TabBarItemType.allCases.map { $0.viewController() }

        tabBar.tintColor = UIColor(named: "purple680172") ?? .systemPurple
        tabBar.unselectedItemTintColor = UIColor(named: "grey505050") ?? .lightGray
        tabBar.backgroundColor = .white
    }
}
