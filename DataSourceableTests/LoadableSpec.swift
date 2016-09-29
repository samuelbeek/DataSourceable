//
//  LoadableDataSourceTests.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

@testable import DataSourceable
import Quick
import Nimble

private enum DataSourcableError: Error {
    case fail
}

class LoadingDataSource: Loadable {
    var fixtureData: [Int]
    var state: State<[Int],Error> = .empty
    func loadData(_ completion: @escaping (Result<[Int],Error>) -> Void) {
        DispatchQueue.global().async {
            completion(Result.success(self.fixtureData))
        }
    }
    init(fixtureData: [Int]) {
        self.fixtureData = fixtureData
    }
}

class FailingDataSource: LoadingDataSource {
    
    override func loadData(_ completion: @escaping (Result<[Int],Error>) -> Void) {
        completion(Result.failure(DataSourcableError.fail))
    }
    
}

extension State: Equatable {}

public func ==<D,E>(lhs: State<D,E>, rhs: State<D,E>) -> Bool {
    switch (lhs,rhs) {
    case (.empty,.empty): return true
    case (.loading,.loading): return true
    case (.ready,.ready): return true
    case (.Error,.Error): return true
    default: return false
    }
}


class LoadableSpec: QuickSpec {
    override func spec() {
        describe("Loadable") {
            var loading: LoadingDataSource!
            context("succeeding") {
                beforeEach {
                    loading = LoadingDataSource(fixtureData: [1,3,4])
                }

                it("reloads the fixture data") {
                    loading.reload({})
                    expect(loading.data).toEventually(equal(loading.fixtureData))
                }
            }
            
            context("failing") {
                beforeEach {
                    loading = FailingDataSource(fixtureData: [1,3,4])
                }
                it("moves to the error state") {
                    loading.reload({
                    })
                    let errorState: State<[Int],Error> = .Error(DataSourcableError.fail,nil)
                    expect(loading.state).toEventually(equal(errorState))
                }
            }
            
        }
    }
}
