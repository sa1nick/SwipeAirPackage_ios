//
//  HomeScreenBridgeView.swift
//  SwipeAirPackage
//
//  Created by apple on 17/07/25.
//

import SwiftUI

struct HomeScreenBridgeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let loginVC = HomeContentViewController()
        return UINavigationController(rootViewController: loginVC)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No-op for now
    }
}
