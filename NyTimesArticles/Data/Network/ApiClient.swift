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
        static let mockUrlString = "https://74486c29-fc71-4673-9be3-3352689e3571.mock.pstmn.io"
        static let mockUrl = URL(string: mockUrlString)
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
        
        //        return send(apiRequest: apiRequest, mock: true)
        //            .asObservable()
        //            .retry { (error) -> Observable<Token> in
        //                return self.commonRetryWhen(error: error)
        //            }
    }
    
    public func send(apiRequest: APIRequest, mock: Bool = false, completion: @escaping APIClientCompletion){
        
        let url = self.getFullURL(for: apiRequest, mock: mock)
        let headers = self.getHeaders(for: apiRequest)
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL)); 
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.rawValue
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: apiRequest.parameters, options: [])
            urlRequest.httpBody = jsonData
            urlRequest.allHTTPHeaderFields = headers
        } catch {
            print("Error serializing JSON:", error)
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed)); return
            }
            completion(.success(APIResponse<Data?>(statusCode: httpResponse.statusCode, body: data)))
        }
        task.resume()
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
    private var baseURL: String {
        return "https://api.nytimes.com"
    }
    
    private func getFullURL(for request: APIRequest, mock: Bool) -> String {
        
        let baseURL = mock ? Constants.mockUrlString : baseURL
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
}
