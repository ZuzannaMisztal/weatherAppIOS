//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import Foundation

var weatherStates = ["Clear": "☀️", "Light Cloud": "🌤", "Heavy Cloud": "☁️", "Showers": "🌦", "Light Rain": "🌧", "Heavy Rain": "🌧", "Thunderstorm": "🌩", "Hail": "🌨", "Sleet": "🌨", "Snow": "❄️"]

struct WeatherModel {
    
    var records = Array<WeatherRecord>()
    
    
//    init(cities: Array<String>) {
//        for city in cities {
//            records.append(WeatherRecord(cityName: city))
//        }
//    }
    
    struct WeatherRecord: Identifiable, Equatable {
        
        var id: UUID = UUID()
        var cityName: String
//        var weatherState: String = weatherStates.randomElement()!.key
//        var temperature: Float = Float.random(in: -10.0...30.0)
//        var humidity: Float = Float.random(in: 0.0...100.0)
//        var windSpeed: Float = Float.random(in: 0.0...100.0)
//        var windDirection: Float = Float.random(in: 0.0..<360.0)
        var currentParameter: String = "Temperature"
        var weatherState: String
        var temperature: Float
        var humidity: Float
        var windSpeed: Float
        var windDirection:Float
        
        init(response: MetaWeatherResponse){
            cityName = response.title
            weatherState = response.consolidatedWeather[0].weatherStateName
            temperature = Float(response.consolidatedWeather[0].theTemp)
            humidity = Float(response.consolidatedWeather[0].humidity)
            windSpeed = Float(response.consolidatedWeather[0].windSpeed)
            windDirection = Float(response.consolidatedWeather[0].windDirection)
        }
        
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
