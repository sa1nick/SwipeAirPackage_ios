//
//  SignupRequest.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import Foundation

struct SignupRequest: Codable {
    let emailOrMobile: String
    let password: String
    let confirmPassword: String
}
