//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import Foundation

struct WeatherModel {
    
    var records = Array<WeatherRecord>()
    
    init(cities: Array<String>) {
        for city in cities {
            records.append(WeatherRecord(city: city))
        }
    }
    
    struct WeatherRecord: Identifiable, Equatable {
        static func == (lhs: WeatherModel.WeatherRecord, rhs: WeatherModel.WeatherRecord) -> Bool {
            return lhs.cityName == rhs.cityName
        }
        
        var id: UUID = UUID()
        var cityName: String
        var weatherState: String = "sunny"
        var parameterNr: Int = 0
        var parameters =  Array<(String, Float)>()
        
        init(city: String) {
            cityName = city
            parameters.append(("Temperature", Float.random(in: -10.0...30.0)))
            parameters.append(("Humidity", Float.random(in: 0.0...100.0)))
            parameters.append(("Wind Speed", Float.random(in: 0.0...100.0)))
            parameters.append(("Wind Direction", Float.random(in: 0.0..<360.0)))
        }
    }
    
    mutating func refresh(record: WeatherRecord) {
        print("before")
        if let ind = records.firstIndex(of: record) {
            print("ind \(ind)")
            records[ind as Int].parameters[0].1 = Float.random(in: -10.0...30.0)
            print(records[ind as Int].parameters[0].1)
        }
    }
    
    mutating func nextParam(record: WeatherRecord) {
        if let ind = records.firstIndex(of: record) {
            records[ind as Int].parameterNr = (records[ind as Int].parameterNr + 1) % 4;
        }
    }
    
}
