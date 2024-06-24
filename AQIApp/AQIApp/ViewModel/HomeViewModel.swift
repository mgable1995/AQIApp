//
//  HomeViewModel.swift
//  AQIApp
//
//  Created by Michael Gable on 6/23/24.
//

import Foundation
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func didUpdateAQIData(_ viewModel: HomeViewModel)
    func didFailWithError(_ viewModel: HomeViewModel, error: Error)
}

class HomeViewModel {
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    var aqiData: AQIData?
    var dailyAQI: (yesterday: ForecastItem?, today: ForecastItem?, tomorrow: ForecastItem?)
    private var networkManager = AQINetworkManager()
    
    func getAQIDataCount() -> Int {
        return 3 // Yesterday, Today, Tomorrow
    }
    
    func getAQIData(for index: Int) -> ForecastItem? {
        switch index {
        case 0:
            return dailyAQI.yesterday
        case 1:
            return dailyAQI.today
        case 2:
            return dailyAQI.tomorrow
        default:
            return nil
        }
    }
    
    // MARK: - Fetch Requests
    func fetchAQI(for city: String) {
        Task {
            do {
                let data = try await networkManager.fetchAQI(for: city)
                self.aqiData = data
                self.dailyAQI = getAQIForDays(aqiData: data)
                delegate?.didUpdateAQIData(self)
            } catch {
                delegate?.didFailWithError(self, error: error)
            }
        }
    }
    
    func fetchAQI(for coordinates: CLLocationCoordinate2D) {
        Task {
            do {
                let data = try await networkManager.fetchAQI(for: coordinates.latitude, longitude: coordinates.longitude)
                self.aqiData = data
                self.dailyAQI = getAQIForDays(aqiData: data)
                delegate?.didUpdateAQIData(self)
            } catch {
                delegate?.didFailWithError(self, error: error)
            }
        }
    }
    
    // MARK: - Helper Methods
    func getAQIForDays(aqiData: AQIData) -> (yesterday: ForecastItem?, today: ForecastItem?, tomorrow: ForecastItem?) {
        let today = Date()
        let calendar = Calendar.current
        
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
              let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) else {
            return (nil, nil, nil)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let yesterdayString = dateFormatter.string(from: yesterday)
        let todayString = dateFormatter.string(from: today)
        let tomorrowString = dateFormatter.string(from: tomorrow)
        
        let dailyPM25 = aqiData.forecast?.daily.pm25 ?? []
        
        let yesterdayAQI = dailyPM25.first { $0.day == yesterdayString }
        let todayAQI = dailyPM25.first { $0.day == todayString }
        let tomorrowAQI = dailyPM25.first { $0.day == tomorrowString }
        
        return (yesterdayAQI, todayAQI, tomorrowAQI)
    }
    
    func getFormattedDate(for index: Int) -> String {
        let calendar = Calendar.current
        let today = Date()
        let date: Date
        
        switch index {
        case 0:
            date = calendar.date(byAdding: .day, value: -1, to: today) ?? today
        case 1:
            date = today
        case 2:
            date = calendar.date(byAdding: .day, value: 1, to: today) ?? today
        default:
            date = today
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
