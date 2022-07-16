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
    var currentLocation: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backImage")!)
        view.addSubview(mainView)
        view.addSubview(weatherView)
        setupConstraints()
        weatherView.collectionView?.delegate = self
        weatherView.collectionView?.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
}

private extension MainViewController {
    func setupConstraints() {
        let constraints = [
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
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 10
        default: return 1
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeWeatherCollectionViewCell.reuseID, for: indexPath) as? TimeWeatherCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DaysWeatherCollectionViewCell.reuseID, for: indexPath) as? DaysWeatherCollectionViewCell
            else { return UICollectionViewCell() }
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
                                                                         for: indexPath)
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
