//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import Foundation

var weatherStates = ["clear": "☀️", "ligh cloud": "🌤", "heavy cloud": "☁️", "showers": "🌦", "light rain": "🌧", "heavy rain": "🌧", "thunderstorm": "🌩", "hail": "🌨", "sleet": "🌨", "snow": "❄️"]

struct WeatherModel {
    
    var records = Array<WeatherRecord>()
    
    
    init(cities: Array<String>) {
        for city in cities {
            records.append(WeatherRecord(cityName: city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable {
        
        var id: UUID = UUID()
        var cityName: String
        var weatherState: String = weatherStates.randomElement()!.key
        var temperature: Float = Float.random(in: -10.0...30.0)
        var humidity: Float = Float.random(in: 0.0...100.0)
        var windSpeed: Float = Float.random(in: 0.0...100.0)
        var windDirection: Float = Float.random(in: 0.0..<360.0)
        var currentParameter: String = "Temperature"
        
        func currentParameterValue() -> Float {
            switch self.currentParameter{
            case "Wind Direction":
                return self.windDirection
            case "Wind Speed":
                return self.windSpeed
            case "Humidity":
                return self.humidity
            case "Temperature":
                return self.temperature
            default:
                return -100
            }
        }
        
        func weatherIcon() -> String {
            return weatherStates[self.weatherState]!
        }
    }
    
    mutating func refresh(record: WeatherRecord) {
        if let ind = records.firstIndex(of: record) {
            records[ind as Int].temperature = Float.random(in: 0.0...100.0)
        }
    }
    
    mutating func nextParam(record: WeatherRecord) {
        if let ind = records.firstIndex(of: record) {
//            records[ind as Int].currer = (records[ind as Int].parameterNr + 1) % 4
            switch records[ind as Int].currentParameter{
            case "Wind Direction":
                records[ind as Int].currentParameter = "Temperature"
            case "Wind Speed":
                records[ind as Int].currentParameter = "Wind Direction"
            case "Humidity":
                records[ind as Int].currentParameter = "Wind Speed"
            case "Temperature":
                records[ind as Int].currentParameter = "Humidity"
            default:
                print("Something went wrong")
            }
        }
    }
    
}
