//
//  CollectionViewDataSourceProxy.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 29/12/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

open class CollectionViewDataSourceProxy: NSObject, UICollectionViewDataSource {
    open let dataSource: CollectionViewDataSource
    
    public init(dataSource: CollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSectionsInCollectionView(collectionView)
    }

    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, atIndexPath: indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAtIndexPath: indexPath)
    }
    open func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        return dataSource.collectionView(collectionView, moveItemAtIndexPath: sourceIndexPath, toIndexPath: destinationIndexPath)
    }
}
