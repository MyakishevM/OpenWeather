//
//  DaysWeatherCollectionViewCell.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 12.07.2022.
//

import UIKit

class DaysWeatherCollectionViewCell: UICollectionViewCell {
    static let reuseID = "DaysWeatherCollectionViewCellReuseID"
    var dayLabel = UILabel(text: "Now")
    var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var minTemperatureLabel = UILabel(text: "15˚")
    var maxTemperatureLabel = UILabel(text: "20˚")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(maxTemperatureLabel)
        let constraints = [
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: 5),
            dayLabel.trailingAnchor.constraint(equalTo: weatherImage.leadingAnchor,
                                               constant: -15),

            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor,
                                                  constant: 15),
            weatherImage.trailingAnchor.constraint(equalTo: minTemperatureLabel.leadingAnchor,
                                                  constant: -15),

            minTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor,
                                                        constant: 15),
            minTemperatureLabel.trailingAnchor.constraint(equalTo: maxTemperatureLabel.leadingAnchor,
                                                         constant: -100),

            maxTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor,
                                                        constant: 100),
            maxTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                         constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
