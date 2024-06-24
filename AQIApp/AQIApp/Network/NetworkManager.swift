//
//  NetworkManager.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import Foundation
import CoreLocation

class AQINetworkManager {
    
    private let apiKey = "4c7612b7c4bd10f98fa118457f1f58996426086d"
    
    func fetchAQI(for city: String) async throws -> AQIData {
        let urlString = "https://api.waqi.info/feed/\(city)/?token=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(AQIResponse.self, from: data)
            guard response.status == "ok" else {
                throw URLError(.badServerResponse)
            }
            return response.data
        } catch {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Failed to decode JSON:", json)
            }
            throw error
        }
    }
    
    func fetchAQI(for latitude: Double, longitude: Double) async throws -> AQIData {
        let urlString = "https://api.waqi.info/feed/geo:\(latitude);\(longitude)/?token=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(AQIResponse.self, from: data)
            guard response.status == "ok" else {
                throw URLError(.badServerResponse)
            }
            return response.data
        } catch {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Failed to decode JSON:", json)
            }
            throw error
        }
    }
}


