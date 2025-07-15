//
//  Untitled.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import Foundation

final class AuthService {
    static let shared = AuthService()

    private init() {}
    typealias EmptyBody = [String: String]

    func signup(request: SignupRequest, completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        APIService.shared.postRequest(endpoint: APIEndpoint.signup.rawValue, body: request, completion: completion)
    }
    
    func sendAndVerifyOtp(request: SendAndVerifyOtpRequest, completion: @escaping (Result<SendAndVerifyOtpResponse, Error>) -> Void) {
        var urlComponents = URLComponents(string: APIEndpoint.sendAndVerifyOtp.rawValue)!
        var queryItems = [URLQueryItem(name: "emailOrContact", value: request.emailOrContact)]
        
        if let otp = request.otp {
            queryItems.append(URLQueryItem(name: "OTP", value: otp))
        }

        urlComponents.queryItems = queryItems

        let fullUrl = urlComponents.string ?? APIEndpoint.sendAndVerifyOtp.rawValue
        APIService.shared.postRequest(endpoint: fullUrl, body: nil as EmptyBody?, completion: completion)
    }


}
