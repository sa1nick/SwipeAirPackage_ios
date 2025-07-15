	//
//  LoginScreen.swift
//  SwipeAirPackage
//
//  Created by apple on 08/07/25.
//

import UIKit

struct LoginScreen {
    let titleText: String
    let subtitleText: String
    let emailToggleText: String
    let otpButtonText: String
    let passwordButtonText: String
    let signupPromptText: String
    let signupActionText: String

    static let mock = LoginScreen(
        titleText: "Welcome Back",
        subtitleText: "Login to continue your journey with us",
        emailToggleText: "Use Email Instead",
        otpButtonText: "Send OTP",
        passwordButtonText: "Login with Password",
        signupPromptText: "New to Swipe Air?",
        signupActionText: "Signup"
    )
}
