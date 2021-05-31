//
//  WeatherModelView.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import Foundation
import Combine

class WeatherModelView: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let fetcher: MetaWeatherFetcher
    
//    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warszawa", "Tokio", "Rio"])
    
    @Published private(set) var model: WeatherModel
    
    private let woeIds: Array = ["523920","1118370", "455825"]
    
    @Published var records: [WeatherModel.WeatherRecord] = []
    
//    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Tokio", "Rio", "Moskwa", "Denver", "Nairobi", "Lizbona", "Helsinki", "Bogota", "Berlin", "Oslo"])
    
//    @Published var woeId: String = "1118370"
    
    init() {
        fetcher = MetaWeatherFetcher()
        model = WeatherModel()
        for woeId in woeIds {
            print("ID = \(woeId)")
            Just(woeId)
//                .map { value in
//                    return fetchWeather(forId: value)
//                }
                .sink ( receiveValue: fetchWeather(forId:))
                .store(in: &cancellables)
        }
        model.records = records
    }
    
//    var records: Array<WeatherModel.WeatherRecord> {
//        model.records
//    }
    
    func fetchWeather(forId woeId: String) {
        fetcher.forecast(forId: woeId)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
                self.records.append(WeatherModel.WeatherRecord(response: value))
            })
            .store(in: &cancellables)
    }
    
    func refresh(record: WeatherModel.WeatherRecord) {
        objectWillChange.send()
        model.refresh(record: record)
    }
    
    func nextParam(record: WeatherModel.WeatherRecord) {
        objectWillChange.send()
        model.nextParam(record: record)
    }
}
