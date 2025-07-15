//
//  EnterOTPScreen.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import UIKit

struct EnterOTPScreen {
    let titleText: String
    let subtitleText: String
    let notReceivedOtpText: String
    let resendText: String
    let buttonText: String

    static let mock = EnterOTPScreen(
        titleText: "Enter 4 - Digit OTP",
        subtitleText: "We sent a verification code to your registered mobile number",
        notReceivedOtpText: "Didn't receive code?",
        resendText: "Resend Code",
        buttonText: "Continue"
    )
}
