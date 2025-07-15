//
//  VerifySignUpOtpResponse.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 05/07/25.
//

import Foundation

struct SendAndVerifyOtpResponse: Codable {
    let status: Bool
    let message: String?
    let result: String?
}
