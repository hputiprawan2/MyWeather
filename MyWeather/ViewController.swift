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
    
    var models = [Weather]()
    
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
        super.viewDidAppear(true)
        setupLocation()
    }

    // Tables
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&appid=575606feecc3aa1ca745bf14f73c9d99"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            // Validation: get the data back with no error
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            // Convert data to models/ some objects
            // Update UI
        }
    }
}

struct Weather {
    
}
