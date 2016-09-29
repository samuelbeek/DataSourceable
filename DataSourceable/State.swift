//
//  State.swift
//  DataSourceable
//
//  Created by Niels van Hoorn on 13/10/15.
//  Copyright © 2015 Zeker Waar. All rights reserved.
//

public enum State<D : EmptyCheckable,E> {
    case empty
    case loading(D?)
    case ready(D)
    case Error(E,D?)
    
    public func toLoading() -> State {
        switch self {
        case .ready(let oldData):
            return .loading(oldData)
        default:
            return .loading(nil)
        }
    }
    
    public func toError(_ error:E) -> State {
        switch self {
        case .loading(let oldData):
            return .Error(error,oldData)
        default:
            assert(false, "Invalid state transition to .Error from other than .Loading")
            return self
        }
    }
    
    public func toReady(_ data: D) -> State {
        switch self {
        case .loading:
            if data.isEmpty {
                return .empty
            } else {
                return .ready(data)
            }
        default:
            assert(false, "Invalid state transition to .Ready from other than .Loading")
            return self
        }
    }
    
    public var data: D? {
        switch self {
        case .empty:
            return nil
        case .ready(let data):
            return data
        case .loading(let data):
            return data
        case .Error(_, let data):
            return data
        }
    }
    
    public var error: E? {
        switch self {
        case .Error(let error, _):
            return error
        default:
            return nil
        }
    }
}
