//
//  weatherAppApp.swift
//  weatherApp
//
//  Created by Użytkownik Gość on 22/05/2021.
//

import SwiftUI

@main
struct weatherAppApp: App {
    var weatherModelView = WeatherModelView()
    var body: some Scene {
        WindowGroup {
            ContentView(weatherModelView: weatherModelView)
        }
    }
}
