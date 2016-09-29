//
//  LoadableDataSource.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public enum Result<Value, E> {
    case success(Value)
    case failure(E)
}

public protocol Loadable: class {
    associatedtype Data : EmptyCheckable
    var state: State<Data,Error> { get set }
    func loadData(_ completion: @escaping(Result<Data,Error>) -> Void)
}

public extension Loadable {
    func reload(_ completion: @escaping () -> Void) {
        state = state.toLoading()
        loadData { result in
            switch result {
            case .success(let data):
                self.state = self.state.toReady(data)
            case .failure(let error):
                self.state = self.state.toError(error)
            }
            completion()
        }
    }
    
    var data: Data? {
        return state.data
    }
}
