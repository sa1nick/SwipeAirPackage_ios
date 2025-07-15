    //
//  SignUpScreenBridgeView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 03/07/25.
//

import SwiftUI

struct SignUpScreenBridgeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let signupVC = SignUpContentViewController()
        return UINavigationController(rootViewController: signupVC)
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

