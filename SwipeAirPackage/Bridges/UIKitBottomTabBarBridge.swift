//
//  UIKitBottomTabBarBridge.swift
//  SwipeAirPackage
//
//  Created by apple on 15/07/25.
//

import SwiftUI

struct UIKitBottomTabBarBridge: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> BottomTabBarController {
        return BottomTabBarController()
    }

    func updateUIViewController(_ uiViewController: BottomTabBarController, context: Context) {
        // No-op
    }
}
