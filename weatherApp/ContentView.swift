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
    let scale = CGFloat(0.85)
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke()
                .frame(height: height) //stala wysokośc dla każdej komórki
                .padding(.leading, 2) //odstęp od lewej i prawej krawędzi
                .padding(.trailing, 2)
            GeometryReader { geometry in
                HStack {
                    Text(record.weatherIcon())
                        .font(.system(size: scale * geometry.size.height))
                        .padding(.leading, 3)
                    Spacer()
                    VStack (alignment: .leading){ //Wyrównuje nazwę miasta i parametr do lewej strony
                        Text(record.cityName)
                        Text("\(record.currentParameter): \(record.currentParameterValue(), specifier: "%.1f")").font(.caption).onTapGesture {
                            weatherModelView.nextParam(record: record)
                        }
                    }
                    Spacer()
                    Text("🔄").font(.largeTitle).onTapGesture {
                        weatherModelView.refresh(record: record)
                    }
                    Divider() //tu spelnia podobną rolę co padding .trailing na powyższym tekście
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
