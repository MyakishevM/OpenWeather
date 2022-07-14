//
//  HeaderReusableView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 12.07.2022.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
    let label = UILabel(text: "Rainy conditions tonight", fontSize: 15, color: UIColor.white, bold: false)
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(label)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 7).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true
    }
}

final class SecondHeaderReusableView: UICollectionReusableView {
    let label = UILabel(text: "10-DAY FORECAST", fontSize: 15, color: UIColor.gray, bold: false)
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true
    }
}


final class RoundedBackgroundView: UICollectionReusableView {
static let reuseID = "RoundedBackgroundView"
    private var insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)

        NSLayoutConstraint.activate([
            insetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: insetView.trailingAnchor),
            insetView.topAnchor.constraint(equalTo: topAnchor),
            insetView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
