//
//  ViewController.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var mainView = MainScreenView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
//        UIColor(patternImage: UIImage(named: "backImage")!)
        
        view.addSubview(mainView)
        setupConstraints()
    }
}

private extension MainViewController {
    func setupConstraints() {
        let constraints = [
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: 10),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
