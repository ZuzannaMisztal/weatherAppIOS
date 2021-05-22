//
//  ContentView.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherModelView: WeatherModelView
    
    var body: some View {
        VStack {
            ForEach(weatherModelView.records) { rec in
                WeatherItemView(record: rec, weatherModelView: weatherModelView)
            }
        }
    }
}

struct WeatherItemView: View {
    var record: WeatherModel.WeatherRecord
    var weatherModelView: WeatherModelView
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke()
            HStack {
                Text("☀️").font(.largeTitle)
                VStack {
                    Text(record.cityName)
                    var parameter = record.parameters[record.parameterNr]
                    Text("\(parameter.0): \(record.parameters[record.parameterNr].1, specifier: "%.1f")℃").font(.caption).onTapGesture {
                        weatherModelView.nextParam(record: record)
                    }
                }
                Text("🔄").font(.largeTitle).onTapGesture {
                    print("here")
                    weatherModelView.refresh(record: record)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherModelView: WeatherModelView())
    }
}
