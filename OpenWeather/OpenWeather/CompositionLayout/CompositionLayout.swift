//
//  CompositionLayout.swift
//  OpenWeather
//
//  Created by Maxim Myakishev on 11.07.2022.
//

import UIKit

func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in

        switch sectionNumber {
        case 0:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15),
                                                   heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
         
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(20)),
                      elementKind: MainScreenView.timeWeatherHeaderID, alignment: .topLeading)
            ]
            section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
            //TODO: МАКСИМ должен сделать это
            section.decorationItems = [ NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseID) ]
            return section
            
        case 1:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.1))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(400))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                        heightDimension: .absolute(50)),
                      elementKind: MainScreenView.dayWeatherHeaderID, alignment: .topLeading)
            ]
            section.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
            section.decorationItems = [ NSCollectionLayoutDecorationItem.background(elementKind: RoundedBackgroundView.reuseID) ]
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
                                        heightDimension: .absolute(30)),
                      elementKind: MainScreenView.timeWeatherHeaderID, alignment: .topLeading)
            ]
           
            return section
        }
    }
    layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseID)
    return layout
}

