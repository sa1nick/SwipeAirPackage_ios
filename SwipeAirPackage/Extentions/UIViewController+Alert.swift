//
//  UIViewController+Alert.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 05/07/25.
//

import UIKit

extension UIViewController {
    /// Shows a simple alert with a title and message
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
