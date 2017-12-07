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

    func makes(with state: State, success:(@escaping ([Make]) -> Void), failure: (@escaping(String) -> Void)) {
        let provider = MoyaProvider<APIService>()
        provider.request(.makes(state: state)) { result in
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
}
