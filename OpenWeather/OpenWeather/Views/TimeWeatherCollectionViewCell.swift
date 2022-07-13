//
//  TimeWeatherCollectionViewCell.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 12.07.2022.
//

import UIKit

final class TimeWeatherCollectionViewCell: UICollectionViewCell {
    static let reuseID = "TimeWeatherCollectionViewCellReuseID"
    var timeLabel = UILabel(text: "Now", fontSize: 15, color: UIColor.white, bold: true)
    var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var temperatureLabel = UILabel(text: "15˚", fontSize: 18, color: UIColor.white, bold: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImage)
        contentView.addSubview(temperatureLabel)
        let constraints = [
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: weatherImage.topAnchor, constant: -3),

            weatherImage.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 3),
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -3),

            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 3),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
