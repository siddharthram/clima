//
//  WeatherData.swift
//  Clima
//
//  Created by Siddharth Ram on 4/16/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: Array<Weather  >
}


struct Main: Decodable {
    let temp: Double
    let pressure: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
