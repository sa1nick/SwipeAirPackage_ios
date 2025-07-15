//
//  UIKitOnboardingView.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 28/06/25.
//

import SwiftUI

struct UIKitOnboardingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
