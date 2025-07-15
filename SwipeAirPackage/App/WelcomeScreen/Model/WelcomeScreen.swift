//
//  WelcomeScreen.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 01/07/25.
//

import UIKit

struct WelcomeScreen {
    let logoImage: UIImage
    let backgroundImage: UIImage
    let metaIcon: UIImage
    let appleIcon: UIImage
    let googleIcon: UIImage
    let titleText: String
    let subtitleText: String

    static let mock = WelcomeScreen(
        logoImage: UIImage(named: "SwipeAirLogo") ?? UIImage(),
        backgroundImage: UIImage(named: "welcomeBg") ?? UIImage(),
        metaIcon: UIImage(named: "metaIcon") ?? UIImage(),
        appleIcon: UIImage(named: "appleIcon") ?? UIImage(),
        googleIcon: UIImage(named: "googleIcon") ?? UIImage(),
        titleText: "Welcome! Get 50% off\nYour First order",
        subtitleText: "1000s of essentials in as fast as 15 minutes"
    )
}
