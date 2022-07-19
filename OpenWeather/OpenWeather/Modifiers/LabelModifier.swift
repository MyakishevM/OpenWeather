//
//  LabelModifier.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, fontSize: CGFloat) {
        self.init(frame: CGRect())
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        tintColor = .white
    }
    convenience init(text: String, fontSize: CGFloat, color: UIColor, bold: Bool) {
        self.init(frame: CGRect())
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = color
        if bold {
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        tintColor = .white
    }
}



