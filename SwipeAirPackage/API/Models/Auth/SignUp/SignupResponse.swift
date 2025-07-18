//
//  SignupResponse.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import Foundation

struct SignupResponse: Codable {
    let isSuccess: Bool
    let notification: String?
    let result: SignupResult?
    let appName: String?
}

struct SignupResult: Codable {
    let referalCode: String
}
