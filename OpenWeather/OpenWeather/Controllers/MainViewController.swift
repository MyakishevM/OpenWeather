//
//  ViewController.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    private lazy var mainView = MainScreenView()
    private lazy var weatherView = WeatherCollectionView()
    private let locationManager = CLLocationManager()
    private var viewModel: WeatherViewModel?
    private var lottie = WeatherLottie()
    let fetchWeatherData = FetchWeatherData()
    var currentLocation: CLLocation?
    var dailyWeather = [Daily]()
    var hourlyWeather = [Current]()
    var currentWeather: Current?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupConstraints()
        weatherView.collectionView?.delegate = self
        weatherView.collectionView?.dataSource = self
        viewModel = WeatherViewModel()
        viewModel?.updateDelegate = self
        viewModel?.getDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
}

private extension MainViewController {
    func setupConstraints() {
        lottie.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottie)
        view.addSubview(mainView)
        view.addSubview(weatherView)
        let constraints = [
            lottie.topAnchor.constraint(equalTo: view.topAnchor),
            lottie.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lottie.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lottie.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 10),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: weatherView.topAnchor,
                                             constant: -10),
            
            weatherView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 10),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: 15),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -15),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return hourlyWeather.count
        case 1: return dailyWeather.count
        default: return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //TODO: Сделать закат и рассвет
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeWeatherCollectionViewCell.reuseID,
                                                                for: indexPath) as? TimeWeatherCollectionViewCell
            else { return UICollectionViewCell() }
            let currentHourlyWeather = hourlyWeather[indexPath.row]
            cell.configure(from: currentHourlyWeather)
            if indexPath.row == 0 {
                cell.timeLabel.text = "Now"
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCollectionViewCell.reuseID,
                                                                for: indexPath) as? DaysWeatherCollectionViewCell
            else { return UICollectionViewCell() }
            let currentDailyWeather = dailyWeather[indexPath.row]
            cell.configure(from: currentDailyWeather)
            if indexPath.row == 0 {
                cell.dayLabel.text = "Today"
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: WeatherCollectionView.timeHeaderId,
                                                                         for: indexPath) as! HeaderReusableView
            header.label.text = dailyWeather.first?.weather?.first?.weatherDescription?.capitalized
            return header
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: WeatherCollectionView.dayHeaderId,
                                                                         for: indexPath)
            return header
        default:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: WeatherCollectionView.dayHeaderId,
                                                                         for: indexPath)
            return header
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestWeatherLocation() {
        guard let currentLocation = currentLocation else { return }
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        print("LOCATION \(lat) . \(long)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherLocation()
        }
    }
}

extension MainViewController: WeatherUpdateDelegate {
    func updateElements() {
        guard let daily = viewModel?.dataSource?.daily,
        let hourly = viewModel?.dataSource?.hourly,
        let current = viewModel?.dataSource?.current,
        let mainTemp = viewModel?.dataSource?.current?.temp,
        let minTemp = viewModel?.dataSource?.daily?.first?.temp.min,
        let maxTemp = viewModel?.dataSource?.daily?.first?.temp.max,
        let description = viewModel?.dataSource?.daily?.first?.weather?.first?.main else { return }
        dailyWeather = daily
        hourlyWeather = hourly
        currentWeather = current
        DispatchQueue.main.async {
            self.mainView.cityLabel.text = self.viewModel?.dataSource?.timezone
            self.mainView.temperatureLabel.text = String(describing: Int(mainTemp))
            self.mainView.minTemperatureLabel.text =  "L: \(String(describing: Int(minTemp)))˚"
            self.mainView.maxTemperatureLabel.text = "H: \(String(describing: Int(maxTemp)))˚"
            self.mainView.descriptionLabel.text = description
            self.weatherView.collectionView?.reloadData()
            switch self.mainView.descriptionLabel.text {
            case "Snow":
                self.lottie.setupAnimations(filename: "snowly")
            case "Clear":
                self.lottie.setupAnimations(filename: "summer")
            case "Cloud":
                self.lottie.setupAnimations(filename: "cloudly")
            default:
                self.lottie.setupAnimations(filename: "cloudly")
            }
        }
    }
    
    
}



