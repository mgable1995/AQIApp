//
//  Colors.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import UIKit

extension UIColor {
    
    // MARK: - App Colors
    static let background = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    
    // MARK: - AQI Index coded colors
    static let customGreen = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1.0) /// Good
    static let customYellow = UIColor(red: 255/255, green: 235/255, blue: 59/255, alpha: 1.0) /// Moderate
    static let customOrange = UIColor(red: 255/165, green: 0/255, blue: 0/255, alpha: 1.0) /// UnhealthySensitive
    static let customRed = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0) /// Unhealthy
    static let customPurple = UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0) /// Very Unhealthy
    static let customDarkRed = UIColor(red: 139/255, green: 0/255, blue: 0/255, alpha: 1.0) /// Hazardous
}

