//
//  UIKitEnterOTPBridge.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

// UIKitEnterOTPBridge.swift
import SwiftUI

struct UIKitEnterOTPBridge: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return EnterOTPViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
