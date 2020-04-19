//
//  WeatherManager.swift
//  Clima
//
//  Created by Siddharth Ram on 4/16/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
   let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=45e927672a4335e0461cdb04eecfb28a&units=Imperial"
    var delegate: WeatherManagerDelegate?
  
    /*
    init (weatherDelegate: WeatherManagerDelegate) {
        delegate = weatherDelegate
    }
 */
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        print(urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                 }
                 if let safeData = data {
                     //let dataString = String(data: safeData, encoding: .utf8)
                    if let weather =  self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                 }
            }
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }

    }
    
    func handleResponse(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
    

}
