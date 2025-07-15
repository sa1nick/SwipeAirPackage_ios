//
//  WelcomeScreenBridgeView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 02/07/25.
//

import SwiftUI

struct WelcomeScreenBridgeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return WelcomeContentViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
