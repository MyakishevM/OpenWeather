//
//  InfoWeatherViewCell.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 22.07.2022.
//

import UIKit

final class InfoWeatherViewCell: UICollectionViewCell {
    static let reuseID = "InfoWeatherViewCellReuseId"

    let headerLabel = UILabel(text: "Teeest", fontSize: 10, color: .gray, bold: false)
    let weatherValue = UILabel(text: "20˚", fontSize: 25, color: .white, bold: true)
    let descriptionLabel = UILabel(text: "adasd", fontSize: 15, color: .white, bold: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .blue.withAlphaComponent(0.05)
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.09).cgColor
        contentView.layer.cornerRadius = 15
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuteSunrise(header: String, sunrise: Int, sunset: Int) {
        headerLabel.text = header
        weatherValue.text = DateHelper.formatDateFromIntToString(sunrise)
        descriptionLabel.text = "SUNSET \(DateHelper.formatDateFromIntToString(sunset))"
    }

    func configureValue<T: Comparable>(header: String, value: T, with weatherParam: WeatherParameter) {
        headerLabel.text = header
        var additionalSign = ""
        switch weatherParam {
        case .feelsLike:
            additionalSign = "˚"
        case .wind:
            additionalSign = " km/h"
        case .humidity:
            additionalSign = "%"
        case .visibility:
            let valueToKM = value as? Int ?? 1 / 1000
            additionalSign = " km"
        }
        weatherValue.text = "\(String(describing: value))\(additionalSign)"
        descriptionLabel.text = nil
    }

  private func setupConstraints() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(weatherValue)
      contentView.addSubview(descriptionLabel)
      weatherValue.textAlignment = .left
        let constraints = [
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            headerLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            headerLabel.bottomAnchor.constraint(equalTo: weatherValue.topAnchor),

            weatherValue.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            weatherValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            weatherValue.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            weatherValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            weatherValue.bottomAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.topAnchor, constant: 60),

//            descriptionLabel.topAnchor.constraint(equalTo: weatherValue.bottomAnchor, constant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            descriptionLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

enum WeatherParameter {
    case feelsLike
    case wind
    case humidity
    case visibility
}
