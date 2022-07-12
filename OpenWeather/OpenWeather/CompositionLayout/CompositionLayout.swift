//
//  CompositionLayout.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection in

        switch sectionNumber {
        case 0:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets.trailing = 8
            item.contentInsets.leading = 8

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15),
                                                   heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(20)),
                      elementKind: MainScreenView.weatherHeaderID, alignment: .topLeading)
            ]
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets.leading = 5
            section.contentInsets.bottom = 10
            return section

        case 1:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.1))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(400))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
//            section.boundarySupplementaryItems = [
//                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
//                                        heightDimension: .absolute(30)),
//                      elementKind: MainScreenView.weatherForecasHeaderID, alignment: .topLeading)
//            ]
            section.contentInsets.top = 10
            return section
        default :
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(50)),
                      elementKind: MainScreenView.weatherHeaderID, alignment: .topLeading)
            ]
            return section
        }
    }
}
