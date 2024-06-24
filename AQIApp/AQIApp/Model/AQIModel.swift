//
//  AQIModel.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import UIKit

struct AQIResponse: Codable {
    let status: String
    let data: AQIData
}

struct AQIData: Codable {
    let aqi: Int
    let city: City
    let forecast: Forecast?
}

struct City: Codable {
    let name: String
    let geo: [Double]
}

struct Forecast: Codable {
    let daily: Daily
}

struct Daily: Codable {
    let pm25: [ForecastItem]
}

struct ForecastItem: Codable {
    let avg: Int
    let day: String
    var rating: AQIProperties {
        switch avg {
        case 0...50:
            return .good
        case 51...100:
            return .moderate
        case 101...150:
            return .unhealthySensitive
        case 151...200:
            return .unhealthy
        case 201...300:
            return .veryUnhealthy
        default:
            return .hazardous
        }
    }
}

/// Used for contextualizing data to the user
enum AQIProperties {
    case good
    case moderate
    case unhealthySensitive
    case unhealthy
    case veryUnhealthy
    case hazardous
    
    var title: String {
        switch self {
        case .good:
            return "Good"
        case .moderate:
            return "Moderate"
        case .unhealthySensitive:
            return "Unhealthy for Sensitive Groups"
        case .unhealthy:
            return "Unhealthy"
        case .veryUnhealthy:
            return "Very Unhealthy"
        case .hazardous:
            return "Hazardous"
        }
    }
    
    var indexColor: UIColor {
        switch self {
        case .good:
            return UIColor.customGreen
        case .moderate:
            return UIColor.customYellow
        case .unhealthySensitive:
            return UIColor.customOrange
        case .unhealthy:
            return UIColor.customRed
        case .veryUnhealthy:
            return UIColor.customPurple
        case .hazardous:
            return UIColor.customDarkRed
        }
    }
    
    var message: String {
        switch self {
        case .good:
            return "Air quality is good!"
        case .moderate:
            return "Air quality is acceptable. May be a moderate health concern for those unusually sensitive to air pollution."
        case .unhealthySensitive:
            return "Active children and adults, as well as those with respiratory illnesses should limit prolonged outdoor exertion."
        case .unhealthy:
            return "Active children and adults, as well as those with respiratory illnesses should avoid prolonged outdoor exertion. Everyone else, especially children, should limit prolonged outdoor exertion"
        case .veryUnhealthy:
            return "Active children and adults, as well as those with respiratory illnesses should avoid all outdoor exertion. Everyone else, especially children, should limit outdoor exertion."
        case .hazardous:
            return "Everyone should avoid all outdoor exertion."
        }
    }
}
