//
//  ViewController.swift
//  MyWeather
//
//  Created by Hanna Putiprawan on 1/8/21.
//

import UIKit
import CoreLocation

// Location: Core location
// TableView: List to show weather in the up coming day
// Custom Cell with a CollectionView: Horizontal view of hourly forecast for the current day
// API / Request: Get the data

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet var table: UITableView!
    
    var models = [DailyWeather]()

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation? // capture current coordinate
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CustomCell 1: horizontal scrolling for hourly forecast
        // CustomCell 2: vertical cell that show current weather high/low temp
        // Register 2 cells; order of registering cell doesn't matter
        table.register(HourlyTableViewCell.nib(),
                       forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(),
                       forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        
        table.delegate = self
        table.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    // Tables
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.config(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // allow location access when in use
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first // default location
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        
        // Make sure currentLocation is not nil
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=alerts,minutely&appid=575606feecc3aa1ca745bf14f73c9d99"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            // Validation: get the data back with no error
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            // Convert data to models/ some objects
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("Error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            // Update UI
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }).resume()
    }
    
}


// Codable convert JSON data to object; needs to match Json key and the actual return type

struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Float
    let feels_like: Float
    let pressure: Int
    let humidity: Int
    let dew_point: Float
    let uvi: Float?
    let clouds: Int
    let visibility: Int
    let wind_speed: Float
    let wind_deg: Int
    let weather: [Weather]
}

struct HourlyWeather: Codable {
    let dt: Int
    let temp: Float
    let feels_like: Float
    let pressure: Int
    let humidity: Int
    let dew_point: Float
    let uvi: Float?
    let clouds: Int
    let visibility: Int
    let wind_speed: Float
    let wind_deg: Int
    let weather: [Weather]
    let pop: Float
}

struct DailyWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Temp
    let feels_like: FeelsLike
    let pressure: Int
    let humidity: Int
    let dew_point: Float
    let wind_speed: Float
    let wind_deg: Int
    let weather: [Weather]
    let clouds: Int
    let pop: Float
    let uvi: Float?
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct FeelsLike: Codable {
    let day: Float
    let night: Float
    let eve: Float
    let morn: Float
}
