//
//  CollectionViewDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public protocol CollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath)
}

public extension CollectionViewDataSource {
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "", for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: IndexPath) -> Bool {
        return false
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath) {
    }
}

public extension CollectionViewDataSource where Self: Sectionable {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
}

public extension CollectionViewDataSource where Self: Sectionable, Self: CollectionViewCellProviding, Self.CollectionViewCellType.ItemType == Self.Section.Data.Element {
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = reuseIdentifier(forIndexPath: indexPath)
        guard let item = item(atIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let cell = cell as? CollectionViewCellType, let view = collectionView as? CollectionViewCellType.ContainingViewType {
            cell.configure(forItem: item, inView: view)
        }
        return cell
    }
}
