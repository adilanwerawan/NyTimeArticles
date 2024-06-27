//
//  ApiClient.swift
//  NyTimesArticles
//
//  Created by Adil Anwer on 25/06/2024.
//

import Foundation

public typealias APIClientCompletion = (APIResult<Data?>) -> Void

public protocol APIClientProtocol {
    func sendRequest(apiRequest: APIRequest, completion: @escaping APIClientCompletion)
    func sendRequestMock(apiRequest: APIRequest, completion: @escaping APIClientCompletion)
}

public class APIClient: APIClientProtocol {
    struct Constants {
        static let timeout: Double = 300
    }
    
    public var session = URLSession.shared
    
    
    public init() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Constants.timeout
        sessionConfig.timeoutIntervalForResource = Constants.timeout
        session = URLSession(configuration: sessionConfig)
    }
    
    public func sendRequest(apiRequest: APIRequest, completion: @escaping APIClientCompletion) {
        
        self.send(apiRequest: apiRequest, mock: false, completion: completion)
    }
    
    
    public func sendRequestMock(apiRequest: APIRequest, completion: @escaping APIClientCompletion){
        
        self.send(apiRequest: apiRequest, mock: true, completion: completion)
    }
    
    public func send(apiRequest: APIRequest, mock: Bool = false, completion: @escaping APIClientCompletion){
        
        let urlStr = self.getFullURL(for: apiRequest, mock: mock)
        
        if !mock{
            let headers = self.getHeaders(for: apiRequest)
            
            guard var urlComps = URLComponents(string: urlStr) else {
                completion(.failure(.invalidURL));
                return
            }
            
            var queryItems:[URLQueryItem] = []
            
            for item in apiRequest.parameters{
                queryItems.append(URLQueryItem(name: item.key, value: item.value as? String))
            }
            
            urlComps.queryItems = queryItems
            let url = urlComps.url!
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = apiRequest.method.rawValue
            
            urlRequest.allHTTPHeaderFields = headers
            loadRequest(urlRequest: urlRequest, completion: completion)
        } else {
            #if DEBUG
            guard let url = URL(string: urlStr) else { return }
            let urlRequest = URLRequest(url: url)
            loadRequest(urlRequest: urlRequest, completion: completion)
            #endif
        }
    }
}

public struct APIResponse<Body:Codable> {
    let statusCode: Int
    let body: Body
}

extension APIResponse where Body == Data? {
    func decode<BodyType: Decodable>(to type: BodyType.Type) throws -> APIResponse<BodyType> {
        guard let data = body else {
            throw APIError.decodingFailure
        }
        let decodedJSON = try JSONDecoder().decode(BodyType.self, from: data)
        return APIResponse<BodyType>(statusCode: self.statusCode,
                                     body: decodedJSON)
    }
}

public enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailure
}

public enum APIResult<Body:Codable> {
    case success(APIResponse<Body>)
    case failure(APIError)
}

// MARK: Helpers

extension APIClient {
    
    private func loadRequest(urlRequest:URLRequest, completion: @escaping APIClientCompletion){
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed)); return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
    }
    
    private var baseURL: String {
        return "https://api.nytimes.com"
    }
    
    private func getFullURL(for request: APIRequest, mock: Bool) -> String {
        
        let baseURL = mock ? self.loadJsonURL(filename: "articles-mock") : baseURL
        return baseURL + request.endPoint
    }
    
    private func getHeaders(for request: APIRequest, token: String? = nil) -> [String: String]  {
        let commonHeaders: Dictionary<String, String> = [
            "Authorization" : "",
            "Accept" : "application/json",
            "X-Requested-With" : "XMLHttpRequest"
        ]
        return commonHeaders
    }
    
    private func loadJsonURL(filename fileName: String) -> String {
        #if DEBUG
        var url = ""
        if let urlPath = Bundle.main.url(forResource: fileName, withExtension: "json") {
            url = urlPath.absoluteString
            
        }
        return url
        #endif
    }
}
