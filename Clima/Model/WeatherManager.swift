//
//  WeatherManager.swift
//  Clima
//
//  Created by Harting, R.P.G. (Rob) on 16/08/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=51ff17cfaf34423b5c9832e3b6c54cdb&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        perFormRequest(urlString: urlString)
    }
    
    func perFormRequest(urlString: String) {
        //1. Create a URL
        
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task (with a closure - anonymous function )
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    
}
