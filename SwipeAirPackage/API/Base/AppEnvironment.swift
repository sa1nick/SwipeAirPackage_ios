//
//  AppEnvironment.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

enum AppEnvironment {
    case dev
    case prod
}

let currentEnvironment: AppEnvironment = .dev

var baseURL: String {
    switch currentEnvironment {
    case .dev:
        return APIConstants.devBaseURL
    case .prod:
        return APIConstants.prodBaseURL
    }
}
