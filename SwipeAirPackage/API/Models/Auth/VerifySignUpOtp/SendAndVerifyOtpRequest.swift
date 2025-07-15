//
//  VerifySignUpOtpRquest.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 05/07/25.
//

import Foundation

struct SendAndVerifyOtpRequest: Codable {
    let emailOrContact: String
    let otp: String?
}
