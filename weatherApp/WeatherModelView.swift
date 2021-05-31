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
    
    @Published var initRecords: [WeatherModel.WeatherRecord] = []
    
//    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Tokio", "Rio", "Moskwa", "Denver", "Nairobi", "Lizbona", "Helsinki", "Bogota", "Berlin", "Oslo"])
    
//    @Published var woeId: String = "1118370"
    
    init() {
        fetcher = MetaWeatherFetcher()
        model = WeatherModel()
        for woeId in woeIds {
            print("ID = \(woeId)")
            Just(woeId)
                .sink ( receiveValue: fetchWeather(forId:))
                .store(in: &cancellables)
        }
        model.records = initRecords
    }
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func fetchWeather(forId woeId: String) {
        fetcher.forecast(forId: woeId)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
                self.initRecords.append(WeatherModel.WeatherRecord(response: value))
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
