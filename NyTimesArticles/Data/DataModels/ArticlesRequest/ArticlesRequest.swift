//
//  ArticlesRequest.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

public struct ArticlesRequest: APIRequest {
    public var method = HTTPMethod.get
    public var endPoint = APIConstants.Endpoint.mostViewedArticles
    public var parameters: Dictionary<String, Any>
    
    public init() {
        parameters = [
            "api-key": "EYb31frLb6uxcMh4LFFHimQVXSs6A2a6"
        ]
    }
}
