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
    
    private let woeIds: Array = ["523920","1118370", "455825", "2122265", "2391279", "1528488", "742676", "565346", "368148", "638242", "862592"]
    
    
//    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Tokio", "Rio", "Moskwa", "Denver", "Nairobi", "Lizbona", "Helsinki", "Bogota", "Berlin", "Oslo"])
    
    
    init() {
        fetcher = MetaWeatherFetcher()
        model = WeatherModel()
        for woeId in woeIds {
            print("ID = \(woeId)")
            Just(woeId)
                .sink ( receiveValue: fetchWeather(forId:))
                .store(in: &cancellables)
        }
    }
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func fetchWeather(forId woeId: String) {
        fetcher.forecast(forId: woeId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
                self.model.records.append(WeatherModel.WeatherRecord(response: value))
            })
            .store(in: &cancellables)
    }
    
    func refresh(woeId: String) {
        objectWillChange.send()
        fetcher.forecast(forId: woeId)
            .receive(on: RunLoop.main)
            .map { value in
                WeatherModel.WeatherRecord(response: value)
            }
            .sink(receiveCompletion: { completion in
                print("Refresh completion \(completion)")
            }, receiveValue: { value in
                self.model.refresh(woeId: woeId, newValue: value)
            })
            .store(in: &cancellables)
    }
    
    func nextParam(record: WeatherModel.WeatherRecord) {
        objectWillChange.send()
        model.nextParam(record: record)
    }
}
