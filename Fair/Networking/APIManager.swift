//
//  APIManager.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/7/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Moya

final class APIManager {
    static let sharedInstance = APIManager()
    private init() {}

    func makes(with state: State, success:(@escaping ([Make]) -> Void), failure: (@escaping(String) -> Void), sampleData: Data? = nil) {
        let stubClosure: (APIService) -> Moya.StubBehavior = sampleData != nil ? MoyaProvider.immediatelyStub : MoyaProvider.neverStub
        let provider = MoyaProvider<APIService>(stubClosure: stubClosure)
        provider.request(.makes(state: state, sampleData: sampleData)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let response = try JSONDecoder().decode(MakesAPIResponse.self, from: data)
                    success(response.makes)
                } catch {
                    failure(error.localizedDescription)
                }
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }

    func overview(with make: String, model: String, year: String, success:(@escaping (String) -> Void), failure: (@escaping(String) -> Void)) {
        let provider = MoyaProvider<APIService>()
        provider.request(.overview(make: make, model: model, year: year)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let response = try JSONDecoder().decode(OverviewAPIResponse.self, from: data)
                    success(response.description)
                    return
                } catch {
                    failure(error.localizedDescription)
                    return
                }
            case let .failure(error):
                failure(error.localizedDescription)
                return
            }
        }
    }

    func articles(with make: String, model: String, year: String, success:(@escaping ([Article]) -> Void), failure: (@escaping(String) -> Void)) {
        let provider = MoyaProvider<APIService>()
        provider.request(.articles(make: make, model: model, year: year)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                do {
                    let response = try JSONDecoder().decode([Article?].self, from: data)
                    let filtered = response.flatMap { $0 }
                    success(filtered)
                    return
                } catch {
                    failure(error.localizedDescription)
                    return
                }
            case let .failure(error):
                failure(error.localizedDescription)
                return
            }
        }
    }
}
