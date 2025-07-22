//
//  EnterLocationViewControllerWrapper.swift
//  SwipeAirPackage
//
//  Created by apple on 21/07/25.
//

import SwiftUI

struct EnterLocationViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> EnterLocationViewController {
        // Make sure the storyboard ID is set to "EnterLocationViewController"
        let storyboard = UIStoryboard(name: "EnterLocationScreen", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "EnterLocationViewController") as! EnterLocationViewController
    }

    func updateUIViewController(_ uiViewController: EnterLocationViewController, context: Context) {
        // Handle updates if needed
    }
}
