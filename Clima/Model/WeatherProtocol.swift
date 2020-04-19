//
//  WeatherProtocol.swift
//  Clima
//
//  Created by Siddharth Ram on 4/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error:Error)
}
