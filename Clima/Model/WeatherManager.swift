//
//  WeatherManager.swift
//  Clima
//
//  Created by Harting, R.P.G. (Rob) on 16/08/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

// by convention define the protocol - delegate in the same file as the class that is going to use it
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=51ff17cfaf34423b5c9832e3b6c54cdb&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        perFormRequest(with: urlString)
    }
    
    func perFormRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task (with a closure {} - anonymous function )
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        // via Delegate Design Pattern with WeatherViewController as delegate
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}
