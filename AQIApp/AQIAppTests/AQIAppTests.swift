//
//  AQIAppTests.swift
//  AQIAppTests
//
//  Created by Michael Gable on 6/24/24.
//

import XCTest
@testable import AQIApp

class AQIAppTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockDelegate: MockHomeViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
        mockDelegate = MockHomeViewModelDelegate()
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testAQIDataCount() {
        // Given
        let aqiData = AQIData(aqi: 50, city: City(name: "TestCity", geo: [40.7128, -74.0060]), forecast: Forecast(daily: Daily(pm25: [])))
        viewModel.aqiData = aqiData
        viewModel.dailyAQI = (yesterday: ForecastItem(avg: 10, day: "2024-06-23"), today: ForecastItem(avg: 20, day: "2024-06-24"), tomorrow: ForecastItem(avg: 30, day: "2024-06-25"))
        
        // When
        let count = viewModel.getAQIDataCount()
        
        // Then
        XCTAssertEqual(count, 3)
    }
    
    func testGetAQIDataForIndex() {
        // Given
        let aqiData = AQIData(aqi: 50, city: City(name: "TestCity", geo: [40.7128, -74.0060]), forecast: Forecast(daily: Daily(pm25: [])))
        viewModel.aqiData = aqiData
        viewModel.dailyAQI = (yesterday: ForecastItem(avg: 10, day: "2024-06-23"), today: ForecastItem(avg: 20, day: "2024-06-24"), tomorrow: ForecastItem(avg: 30, day: "2024-06-25"))
        
        // When
        let yesterdayData = viewModel.getAQIData(for: 0)
        let todayData = viewModel.getAQIData(for: 1)
        let tomorrowData = viewModel.getAQIData(for: 2)
        
        // Then
        XCTAssertEqual(yesterdayData?.avg, 10)
        XCTAssertEqual(todayData?.avg, 20)
        XCTAssertEqual(tomorrowData?.avg, 30)
    }
    
    func testGetFormattedDate() {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // When
        let yesterdayDate = viewModel.getFormattedDate(for: 0)
        let todayDate = viewModel.getFormattedDate(for: 1)
        let tomorrowDate = viewModel.getFormattedDate(for: 2)
        
        // Then
        XCTAssertEqual(yesterdayDate, dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!))
        XCTAssertEqual(todayDate, dateFormatter.string(from: Date()))
        XCTAssertEqual(tomorrowDate, dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date())!))
    }
}

// MARK: - Mock Delegate
class MockHomeViewModelDelegate: HomeViewModelDelegate {
    var didUpdateAQIDataCalled = false
    var didFailWithErrorCalled = false
    
    func didUpdateAQIData(_ viewModel: HomeViewModel) {
        didUpdateAQIDataCalled = true
    }
    
    func didFailWithError(_ viewModel: HomeViewModel, error: Error) {
        didFailWithErrorCalled = true
    }
}
