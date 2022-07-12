//
//  HeaderReusableView.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 12.07.2022.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
let label = UILabel(text: "Rainy conditions tonight")

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
