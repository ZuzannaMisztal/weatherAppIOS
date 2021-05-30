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
    
    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Warszawa", "Tokio", "Rio"])
    
    private let woeIds: Array = ["523920","1118370", "455825"]
    
//    @Published private(set) var model: WeatherModel = WeatherModel(cities: ["Tokio", "Rio", "Moskwa", "Denver", "Nairobi", "Lizbona", "Helsinki", "Bogota", "Berlin", "Oslo"])
    
//    @Published var woeId: String = "1118370"
    @Published var message: String = "(user message)"
    
    init() {
        fetcher = MetaWeatherFetcher()
        for woeId in woeIds {
            print("ID = \(woeId)")
            Just(woeId)
                .map { value -> MetaWeatherResponse in
                    fetchWeather(forId: value)
                }
                .sink { value in
                    print(value)
                }
                .store(in: &cancellables)
        }
    }
    
    var records: Array<WeatherModel.WeatherRecord> {
        model.records
    }
    
    func fetchWeather(forId woeId: String) {
        fetcher.forecast(forId: woeId)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
                print(value)
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
