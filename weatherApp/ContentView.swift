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
        ScrollView(.vertical) { //dzięki temu można przewija listę miast
            VStack {
                ForEach(weatherModelView.records) { rec in
                    WeatherItemView(record: rec, weatherModelView: weatherModelView)
                }
            }
        }
    }
}

struct WeatherItemView: View {
    var record: WeatherModel.WeatherRecord
    var weatherModelView: WeatherModelView
    let cornerRadius = CGFloat(25.0)
    let height = CGFloat(70)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke()
                .frame(height: height) //stala wysokośc dla każdej komórki
            GeometryReader { geometry in
                HStack {
                    Text(record.weatherIcon()).font(.system(size: 0.9 * geometry.size.height))
                    VStack (alignment: .leading){ //Wyrównuje nazwę miasta i parametr do lewej strony
                        Text(record.cityName)
                        Text("\(record.currentParameter): \(record.currentParameterValue(), specifier: "%.1f")").font(.caption).onTapGesture {
                            weatherModelView.nextParam(record: record)
                        }
                    }
                    .frame(height: 0.9 * geometry.size.height, alignment: .center)
                    Text("🔄").font(.largeTitle).onTapGesture {
                        weatherModelView.refresh(record: record)
                    }
                    .frame(alignment: .trailing)
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
