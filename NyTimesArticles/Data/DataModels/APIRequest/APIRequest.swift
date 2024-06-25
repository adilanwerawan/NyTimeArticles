//
//  APIRequest.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

public protocol APIRequest {
    var method: HTTPMethod { get }
    var endPoint: String { get }
    var parameters: Dictionary<String, Any> { get }
    var headersParameters: [String: String] { get }
}

extension APIRequest {
    public var headersParameters: [String: String] {
        return [:]
    }
}
