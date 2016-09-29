//
//  CollectionViewDataSourceableSpec.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 21/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

import UIKit
import DataSourceable
import Quick
import Nimble

struct SimpleCollectionViewDataSource: CollectionViewDataSourceable {
    typealias ItemType = UIColor
    var sections: [[UIColor]]? = [[.red, .blue, .green],[.black, .white],[.yellow,.purple,.orange,.magenta]]

    func reuseIdentifier(forIndexPath indexPath: IndexPath) -> String {
        return "identifier"
    }
}

extension UICollectionViewCell: Configurable {
    public typealias ItemType = UIColor
    public func configure(forItem item: ItemType, inView: ContainingViewType) {
        contentView.backgroundColor = item
    }
}

extension SimpleCollectionViewDataSource: CollectionViewCellProviding {
    typealias CollectionViewCellType = UICollectionViewCell
}


class CollectionViewDataSourceableSpec: QuickSpec {
    override func spec() {
        describe("CollectionViewDataSourceable") {
            let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
            context("with a simple tableview data source") {
                let simpleDataSource = SimpleCollectionViewDataSource()
                let proxy = CollectionViewDataSourceProxy(dataSource: simpleDataSource)
                beforeEach {
                    collectionView.dataSource = proxy
                }
                describe("collectionView(collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int") {
                    it("should return 0 rows for section 0") {
                        expect(collectionView.dataSource!.collectionView(collectionView, numberOfItemsInSection: 0)).to(equal(3))
                    }
                }
                describe("numberOfSectionsInCollectionView") {
                    it("should return 0") {
                        expect(collectionView.dataSource!.numberOfSections!(in: collectionView)).to(equal(3))
                    }
                }
                
                describe("cellForItemAtIndexPath") {
                    it("should return the configured cell") {
                        for section in 0..<collectionView.dataSource!.numberOfSections!(in: collectionView) {
                            for row in 0..<collectionView.dataSource!.collectionView(collectionView, numberOfItemsInSection: section) {
                                let indexPath = IndexPath(row: row, section: section)
                                let cell = collectionView.dataSource!.collectionView(collectionView, cellForItemAt:indexPath)
                                expect(cell.contentView.backgroundColor).to(equal(simpleDataSource.sections![section][row]))
                            }
                        }
                    }
                    it("should return an unconfigured cell for a non-existing indexpath") {
                        let cell = collectionView.dataSource!.collectionView(collectionView, cellForItemAt:(IndexPath(row: 6, section: 6)))
                        expect(cell.contentView.backgroundColor).to(beNil())
                    }
                    
                }
            }
        }
        
    }
}
