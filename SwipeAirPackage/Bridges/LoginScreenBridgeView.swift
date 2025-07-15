//
//  LoginScreenBridgeView.swift
//  SwipeAirPackage
//
//  Created by apple on 08/07/25.
//

import SwiftUI

struct LoginScreenBridgeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let loginVC = LoginContentViewController()
        return UINavigationController(rootViewController: loginVC)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No-op for now
    }
}
