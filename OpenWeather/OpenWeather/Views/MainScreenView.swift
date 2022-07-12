//
//  MainScreenView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

class MainScreenView: UIView {
    static let weatherHeaderID = "weatherHeaderID"
    static let weatherForecasHeaderID = "weatherForecasHeaderID"
    let headerId = "headerId"
    let forecastHeaderId = "forecastHeaderId"
    private var weatherLabel = UILabel(text: "City")
    private var temperatureLabel = UILabel(text: "temp˚")
    private var descriptionLabel = UILabel(text: "showers")
    private var maxTemperatureLabel = UILabel(text: "maxTemp˚")
    private var minTemperatureLabel = UILabel(text: "minTemp˚")
    private var collectionView: UICollectionView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
        backgroundColor = .systemMint
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainScreenView {
    func setupConstraints() {
        addSubview(weatherLabel)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)

        let minMaxTempStack = UIStackView(views: [maxTemperatureLabel, minTemperatureLabel],
                                          axis: .horizontal,
                                          spacing: 5,
                                          alignment: .fill,
                                          distribution: .fillEqually)
        addSubview(minMaxTempStack)
        guard let collectionView = collectionView else { return }
        let constraints = [
            weatherLabel.topAnchor.constraint(equalTo: topAnchor),
            weatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor,
                                                 constant: -5),

            temperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 5),
            temperatureLabel.centerXAnchor.constraint(equalTo: weatherLabel.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor,
                                                     constant: -5),

            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,
                                                  constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: minMaxTempStack.topAnchor,
                                                     constant: -5),

            minMaxTempStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                                 constant: 5),
            minMaxTempStack.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor),
            minMaxTempStack.bottomAnchor.constraint(equalTo: collectionView.topAnchor,
                                                    constant: -25),

            collectionView.topAnchor.constraint(equalTo: minMaxTempStack.bottomAnchor,
                                                constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                   constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let collection = collectionView else {
            return
        }
        collection.register(TimeWeatherCollectionViewCell.self, forCellWithReuseIdentifier: TimeWeatherCollectionViewCell.reuseID)
        collection.register(HeaderReusableView.self, forSupplementaryViewOfKind: MainScreenView.weatherHeaderID, withReuseIdentifier: headerId)
        collection.register(DaysWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DaysWeatherCollectionViewCell.reuseID)
        //        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: MainScreenView.weatherForecasHeaderID, withReuseIdentifier: forecastHeaderId)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        collection.backgroundColor = .red


    }
}

extension MainScreenView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 27
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: headerId,
                                                                     for: indexPath)
        return header
    }
}
