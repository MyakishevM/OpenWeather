//
//  MainScreenView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

final class MainScreenView: UIView {
    private var cityLabel = UILabel(text: "City", fontSize: 25, color: UIColor.white, bold: true)
    private var temperatureLabel = UILabel(text: "17", fontSize: 70, color: UIColor.white, bold: false)
    private var gradusLabel = UILabel(text: "˚", fontSize: 80, color: UIColor.white, bold: true)
    private var descriptionLabel = UILabel(text: "showers", fontSize: 20, color: UIColor.white, bold: true)
    private var maxTemperatureLabel = UILabel(text: "H:18˚", fontSize: 20, color: UIColor.white, bold: true)
    private var minTemperatureLabel = UILabel(text: "L:12˚", fontSize: 20, color: UIColor.white, bold: true)
    private var collectionView: UICollectionView?
    static let timeWeatherHeaderID = "timeWeatherHeaderID"
    static let dayWeatherHeaderID = "dayWeatherHeaderID"
    let timeHeaderId = "timeHeaderId"
    let dayHeaderId = "dayHeaderId"
    let fetchWeaherData = FetchWeatherData()
    var weatherDTO: WeatherDataModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        fetchData(city: "Moscow")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainScreenView {
    func setupConstraints() {
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
        addSubview(gradusLabel)
        
        let minMaxTempStack = UIStackView(views: [maxTemperatureLabel, minTemperatureLabel],
                                          axis: .horizontal,
                                          spacing: 5,
                                          alignment: .fill,
                                          distribution: .fillEqually)
        addSubview(minMaxTempStack)
        guard let collectionView = collectionView else { return }
        let constraints = [
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            gradusLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            gradusLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            gradusLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor),
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
                                                    constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -30),
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
        collection.register(HeaderReusableView.self, forSupplementaryViewOfKind: MainScreenView.timeWeatherHeaderID, withReuseIdentifier: timeHeaderId)
        collection.register(DaysWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DaysWeatherCollectionViewCell.reuseID)
        collection.register(SecondHeaderReusableView.self, forSupplementaryViewOfKind: MainScreenView.dayWeatherHeaderID, withReuseIdentifier: dayHeaderId)
//        collection.register(BackGroundReusableView.self, forSupplementaryViewOfKind: , withReuseIdentifier: bgSectionId)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        
    }
    
    func fetchData(city: String) {
        self.fetchWeaherData.fetchWeather(city: city) { (response) in
            guard let response = response else { return }
            self.weatherDTO = response
            print(self.weatherDTO as Any)
      
        }
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
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: timeHeaderId,
                                                                         for: indexPath)
            return header
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: dayHeaderId,
                                                                         for: indexPath)
            return header
        default:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: dayHeaderId,
                                                                         for: indexPath)
            return header
        }
        
    }
}
