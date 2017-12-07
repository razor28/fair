//
//  APIService.swift
//  Fair
//
//  Created by Dastan Tashimbetov on 12/7/17.
//  Copyright © 2017 Dastan. All rights reserved.
//

import Foundation
import Moya

enum APIService {
    case makes(state: State)
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .makes:
            return URL(string: "https://api.edmunds.com/api/vehicle/v2")!
        }
    }

    var path: String { return "/makes" }

    var method: Moya.Method { return .get }

    var task: Task {
        var parameters = ["fmt": "json",
                          "api_key": Key.apiKey()]
        switch self {
        case .makes(let state):
            guard state != .all else { return .requestParameters(parameters: parameters, encoding: URLEncoding.default) }
            parameters["state"] = state.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data { return Data() }

    var headers: [String: String]? { return nil }

}
