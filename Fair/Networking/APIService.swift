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
    case makes(state: State, sampleData: Data?)
    case overview(make: String, model: String, year: String)
}

extension APIService: TargetType {
    var baseURL: URL {
        switch self {
        case .makes:
            return URL(string: "https://api.edmunds.com/api/vehicle/v2")!
        case .overview:
            return URL(string: "https://api.edmunds.com/api/editorial/v2")!
        }
    }

    var path: String {
        switch self {
        case .makes:
            return "/makes"
        case .overview(let make, let model, let year):
            return "/" + make + "/" + model + "/" + year
        }
    }

    var method: Moya.Method { return .get }

    var task: Task {
        var parameters = ["fmt": "json",
                          "api_key": Key.apiKey()]
        switch self {
        case .makes(let state, _):
            guard state != .all else { return .requestParameters(parameters: parameters, encoding: URLEncoding.default) }
            parameters["state"] = state.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .overview:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .makes(_, let sampleData):
            return sampleData ?? Data()
        case .overview:
            return Data()
        }
    }

    var headers: [String: String]? { return nil }

}
