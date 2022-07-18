//
//  WeatherCollectionView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 14.07.2022.
//

import UIKit

final class WeatherCollectionView: UIView {
    static let timeWeatherHeaderID = "timeWeatherHeaderID"
    static let dayWeatherHeaderID = "dayWeatherHeaderID"
    static  let timeHeaderId = "timeHeaderId"
    static let dayHeaderId = "dayHeaderId"
    var collectionView: UICollectionView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setupCollectionView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        guard let collection = collectionView else {
            return
        }
        collection.register(TimeWeatherCollectionViewCell.self, forCellWithReuseIdentifier: TimeWeatherCollectionViewCell.reuseID)
        collection.register(HeaderReusableView.self, forSupplementaryViewOfKind: WeatherCollectionView.timeWeatherHeaderID, withReuseIdentifier: WeatherCollectionView.timeHeaderId)
        collection.register(DaysWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DaysWeatherCollectionViewCell.reuseID)
        collection.register(SecondHeaderReusableView.self, forSupplementaryViewOfKind: WeatherCollectionView.dayWeatherHeaderID, withReuseIdentifier: WeatherCollectionView.dayHeaderId)
        collection.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collection)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
    }

    func setupConstraints() {

        guard let collectionView = collectionView else { return }
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }


}
